Received: from eggs.gnu.org ([2001:4830:134:3::10]:57571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdeSr-0001y3-8z
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdeSo-0003Ql-5Q
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:52:21 -0500
Received: from mo4.mail-out.ovh.net ([178.32.228.4]:41376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdeSn-0003Ps-VY
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:52:18 -0500
Received: from player772.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 147874AFB3
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 15:52:14 +0100 (CET)
References: <1486994957-20400-1-git-send-email-clg@kaod.org>
	<1486994957-20400-2-git-send-email-clg@kaod.org>
	<20170214050219.GH2169@umbus.fritz.box>
	<32f762b6-0fc0-fd1f-d0f1-6265436c8274@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7cde2ccc-95cb-5ace-e50c-91095cc2c6b8@kaod.org>
Date: Tue, 14 Feb 2017 15:52:09 +0100
MIME-Version: 1.0
In-Reply-To: <32f762b6-0fc0-fd1f-d0f1-6265436c8274@kaod.org>
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

On 02/14/2017 08:04 AM, C=E9dric Le Goater wrote:
> On 02/14/2017 06:02 AM, David Gibson wrote:
>> On Mon, Feb 13, 2017 at 03:09:16PM +0100, C=E9dric Le Goater wrote:
>>> Today, the ICS (Interrupt Controller Source) object is created and
>>> realized by the init and realize routines of the XICS object, but som=
e
>>> of the parameters are only known at the machine level.
>>>
>>> These parameters are passed from the sPAPR machine to the ICS object
>>> in a rather convoluted way using property handlers and a class handle=
r
>>> of the XICS object. The number of irqs required to allocate the IRQ
>>> state objects in the ICS realize routine is one of them.
>>>
>>> Let's simplify the process by creating the ICS object along with the
>>> XICS object at the machine level and link the ICS into the XICS list
>>> of ICSs at this level also. In the sPAPR machine, there is only a
>>> single ICS but that will change with the PowerNV machine.
>>>
>>> Also, QOMify the creation of the objects and get rid of the
>>> superfluous code.
>>>
>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>
>> I like the basic idea here: while the ics and icp objects are pretty
>> straightforward, the "xics" object has always been a bit of a hack,
>> with logic that really belongs in the machine.
>>
>> But.. I don't think the approach here really works.  Specifically..
>>
>> [snip]
>>> -static XICSState *try_create_xics(const char *type, int nr_servers,
>>> -                                  int nr_irqs, Error **errp)
>>> -{
>>> -    Error *err =3D NULL;
>>> -    DeviceState *dev;
>>> +static XICSState *try_create_xics(const char *type, const char *type=
_ics,
>>> +                                  int nr_servers, int nr_irqs, Error=
 **errp)
>>> +{
>>> +    Error *err =3D NULL, *local_err =3D NULL;
>>> +    XICSState *xics;
>>> +    ICSState *ics =3D NULL;
>>> +
>>> +    xics =3D XICS_COMMON(object_new(type));
>>> +    qdev_set_parent_bus(DEVICE(xics), sysbus_get_default());
>>> +    object_property_set_int(OBJECT(xics), nr_servers, "nr_servers", =
&err);
>>> +    object_property_set_bool(OBJECT(xics), true, "realized", &local_=
err);
>>> +    error_propagate(&err, local_err);
>>> +    if (err) {
>>> +        goto error;
>>> +    }
>>> =20
>>> -    dev =3D qdev_create(NULL, type);
>>> -    qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
>>> -    qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
>>> -    object_property_set_bool(OBJECT(dev), true, "realized", &err);
>>> +    ics =3D ICS_SIMPLE(object_new(type_ics));
>>> +    object_property_add_child(OBJECT(xics), "ics", OBJECT(ics), NULL=
);
>>> +    object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
>>> +    object_property_set_bool(OBJECT(ics), true, "realized", &local_e=
rr);
>>> +    error_propagate(&err, local_err);
>>>      if (err) {
>>> -        error_propagate(errp, err);
>>> -        object_unparent(OBJECT(dev));
>>> -        return NULL;
>>> +        goto error;
>>> +    }
>>> +
>>> +    ics->xics =3D xics;
>>> +    QLIST_INSERT_HEAD(&xics->ics, ics, list);
>>
>> Poking into the ics and xics objects directly from the machine here
>> violates abstraction even worse than the existing xics device does.
>> In fact, avoiding that is basically why the xics device exists in the
>> first place.
>=20
> Well, currently, xics_set_nr_servers() also does a :
>=20
> 	icp->xics =3D xics;
>=20
> So, I think we can live with it until we move the ICS and ICP objects=20
> out of XICS ?
>=20
> if this is the only worrisome problem in the patch, I can start the
> series with a QOM Interface handler implemented at the machine level,=20
> something like :=20
>=20
> 	void (*ics_insert)(ICSState *ics);
>=20
> doing the insert above to hide the temporary hideousness. Is that ok ?=20

After some thought, I don't think this one is important. At the=20
machine level, it seems OK to me to insert an ICS in the XICS list.=20
I agree that XICS should disappear, but it is still there for the=20
moment.=20

> And, as you propose below, I think we can add the 'xics' link property=20
> right now to get rid of :
>=20
> 	ic[ps]->xics =3D xics;

I have a v2 ready adding the 'xics' link property but keeping the=20
QLIST_INSERT_HEAD() call in try_create_xics(). Do you think it is=20
worth sending as an initial cleanup :

 5 files changed, 96 insertions(+), 225 deletions(-)

or do you want the full picture to be addressed ?=20

Thanks,

C.=20
