Received: from eggs.gnu.org ([2001:4830:134:3::10]:51327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdXAS-0007sT-Vx
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdXAP-0000fC-09
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:04:52 -0500
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:36422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdXAO-0000dq-Ny
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:04:48 -0500
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 418B94798F
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 08:04:47 +0100 (CET)
References: <1486994957-20400-1-git-send-email-clg@kaod.org>
	<1486994957-20400-2-git-send-email-clg@kaod.org>
	<20170214050219.GH2169@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <32f762b6-0fc0-fd1f-d0f1-6265436c8274@kaod.org>
Date: Tue, 14 Feb 2017 08:04:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170214050219.GH2169@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] ppc/xics: remove set_nr_irqs() handler
 from XICSStateClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/14/2017 06:02 AM, David Gibson wrote:
> On Mon, Feb 13, 2017 at 03:09:16PM +0100, C=E9dric Le Goater wrote:
>> Today, the ICS (Interrupt Controller Source) object is created and
>> realized by the init and realize routines of the XICS object, but some
>> of the parameters are only known at the machine level.
>>
>> These parameters are passed from the sPAPR machine to the ICS object
>> in a rather convoluted way using property handlers and a class handler
>> of the XICS object. The number of irqs required to allocate the IRQ
>> state objects in the ICS realize routine is one of them.
>>
>> Let's simplify the process by creating the ICS object along with the
>> XICS object at the machine level and link the ICS into the XICS list
>> of ICSs at this level also. In the sPAPR machine, there is only a
>> single ICS but that will change with the PowerNV machine.
>>
>> Also, QOMify the creation of the objects and get rid of the
>> superfluous code.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> I like the basic idea here: while the ics and icp objects are pretty
> straightforward, the "xics" object has always been a bit of a hack,
> with logic that really belongs in the machine.
>=20
> But.. I don't think the approach here really works.  Specifically..
>=20
> [snip]
>> -static XICSState *try_create_xics(const char *type, int nr_servers,
>> -                                  int nr_irqs, Error **errp)
>> -{
>> -    Error *err =3D NULL;
>> -    DeviceState *dev;
>> +static XICSState *try_create_xics(const char *type, const char *type_=
ics,
>> +                                  int nr_servers, int nr_irqs, Error =
**errp)
>> +{
>> +    Error *err =3D NULL, *local_err =3D NULL;
>> +    XICSState *xics;
>> +    ICSState *ics =3D NULL;
>> +
>> +    xics =3D XICS_COMMON(object_new(type));
>> +    qdev_set_parent_bus(DEVICE(xics), sysbus_get_default());
>> +    object_property_set_int(OBJECT(xics), nr_servers, "nr_servers", &=
err);
>> +    object_property_set_bool(OBJECT(xics), true, "realized", &local_e=
rr);
>> +    error_propagate(&err, local_err);
>> +    if (err) {
>> +        goto error;
>> +    }
>> =20
>> -    dev =3D qdev_create(NULL, type);
>> -    qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
>> -    qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
>> -    object_property_set_bool(OBJECT(dev), true, "realized", &err);
>> +    ics =3D ICS_SIMPLE(object_new(type_ics));
>> +    object_property_add_child(OBJECT(xics), "ics", OBJECT(ics), NULL)=
;
>> +    object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
>> +    object_property_set_bool(OBJECT(ics), true, "realized", &local_er=
r);
>> +    error_propagate(&err, local_err);
>>      if (err) {
>> -        error_propagate(errp, err);
>> -        object_unparent(OBJECT(dev));
>> -        return NULL;
>> +        goto error;
>> +    }
>> +
>> +    ics->xics =3D xics;
>> +    QLIST_INSERT_HEAD(&xics->ics, ics, list);
>=20
> Poking into the ics and xics objects directly from the machine here
> violates abstraction even worse than the existing xics device does.
> In fact, avoiding that is basically why the xics device exists in the
> first place.

Well, currently, xics_set_nr_servers() also does a :

	icp->xics =3D xics;

So, I think we can live with it until we move the ICS and ICP objects=20
out of XICS ?

if this is the only worrisome problem in the patch, I can start the
series with a QOM Interface handler implemented at the machine level,=20
something like :=20

	void (*ics_insert)(ICSState *ics);

doing the insert above to hide the temporary hideousness. Is that ok ?=20

And, as you propose below, I think we can add the 'xics' link property=20
right now to get rid of :

	ic[ps]->xics =3D xics;

> I've thought about this a bit more, and I think I know how to solve
> this better now.
>
> I think that "xics" shouldn't be a concrete object at all, instead it
> should be a QOM interface, implemented by the machine type.  Both ICS
> and ICP would take a link property to find their xics.=20

yes.

> The xics
> interface would provide methods to return an ics object given an irq
> number and to return an icp object given a server number. This gives
> full control of the irq and server number spaces back to the machine
> type, which is really where it belongs.

Yes, I agree, we started talking about it a while ago :

    http://lists.nongnu.org/archive/html/qemu-ppc/2016-11/msg00056.html

and this is what this first series is trying to do. It prepares ground=20
by emptying the XICS object.=20

The next step is to move out :

    ICPState *ss;
    QLIST_HEAD(, ICSState) ics;

from XICSState to sPAPRMachineState I think. This is when the QOM=20
interfaces will come in play but we need to untangle the code slowly,=20
to understand what is being done (honestly, it is not that obvious). =20

As for xics->nr_servers, the only place where I still have doubts is=20
ics_simple_post_load(). It should be easier after more cleanups.

This is like mahjong, you need to start from the right piece :)

Thanks,
C.

=20
