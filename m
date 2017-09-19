Received: from eggs.gnu.org ([2001:4830:134:3::10]:36812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duJn1-0002zP-1k
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duJmw-0000Ii-Pk
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:46:19 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:40862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duJmw-0000Gs-GN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:46:14 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 5C4881518EB
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 16:46:11 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-5-clg@kaod.org> <20170919024417.GJ27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3ce4302f-87ec-9720-1adf-8a86b4d9b6d2@kaod.org>
Date: Tue, 19 Sep 2017 16:46:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170919024417.GJ27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/21] ppc/xive: provide a link to
 the sPAPR ICS object under XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/19/2017 04:44 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:18PM +0200, C=E9dric Le Goater wrote:
>> The sPAPR machine first starts with a XICS interrupt model and
>> depending on the guest capabilities, the XIVE exploitation mode is
>> negotiated during CAS. A reset should then be performed to rebuild the
>> device tree but the same IRQ numbers which were allocated by the
>> devices prior to reset, when the XICS model was operating, are still
>> in use.
>>
>> For this purpose, we need a common IRQ number allocator for both the
>> interrupt models: XICS legacy or XIVE exploitation. This is what the
>> ICSIRQState array of the XICS interrupt source is used for. It also
>> contains the LSI/MSI flag of an interrupt which will we need later on.
>>
>> So, let's provide a link to the sPAPR ICS object under XIVE to make
>> use of it.
>=20
> Blech, please don't.  The XIVE code absolutely shouldn't be
> referencing XICS objects, it's a recipe for trouble down the line.

Trouble I don't know. But it is a bit ugly and this is why this=20
patchset is still an RFC. =20

> If we have to have some sort of abstract "spapr interrupt source"
> object that could map to either an ICS irq, or a XIVE source then we
> can do that, but don't directly link XIVE and XICS.  *Especially* not
> new-in-terms-of-old like this, rather than old-in-terms-of-new.

I agree with what you are saying on a common interrupt source but=20
I just haven't found a way to do so yet. So I am trying to corner=20
the ugliness in obvious shortcuts. The purpose is to identify what
we need to support migration, hotplug, cas reset, etc.

So the current solution is practical to support CAS reset and more=20
important it does not break migration. We can't move an object or=20
parts of an object around without breaking the migration as my=20
recent changes on the xics icp have shown. =20

>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c        | 12 ++++++++++++
>>  include/hw/ppc/spapr_xive.h |  4 ++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 6d98528fae68..1681affb0848 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -56,6 +56,8 @@ void spapr_xive_reset(void *dev)
>>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
>>  {
>>      sPAPRXive *xive =3D SPAPR_XIVE(dev);
>> +    Object *obj;
>> +    Error *err =3D NULL;
>> =20
>>      if (!xive->nr_targets) {
>>          error_setg(errp, "Number of interrupt targets needs to be gre=
ater 0");
>> @@ -68,6 +70,16 @@ static void spapr_xive_realize(DeviceState *dev, Er=
ror **errp)
>>          return;
>>      }
>> =20
>> +    /* Retrieve SPAPR ICS source to share the IRQ number allocator */
>=20
> This really suggests we need to move the irq number allocator out of
> XICS and into the general spapr code.  Or get rid of it entirely
> (using a more static irq mapping) if possible.

I have some out of tree changes introducing a bitmap at the spapr
machine level. It is a nice cleanup of the spapr_ics_free() and=20
spapr_ics_alloc*() routines. But it is not migration friendly and=20
we still need to keep the ICSIRQState array, which also stores the=20
IRQ state LSI/MSI. I need to check if such a change would bring
some benefits for XIVE.

C.

>> +    obj =3D object_property_get_link(OBJECT(dev), "ics", &err);
>> +    if (!obj) {
>> +        error_setg(errp, "%s: required link 'ics' not found: %s",
>> +                   __func__, error_get_pretty(err));
>> +        return;
>> +    }
>> +
>> +    xive->ics =3D ICS_BASE(obj);
>> +
>>      /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte=
 */
>>      xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
>>      xive->sbe =3D g_malloc0(xive->sbe_size);
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index b17dd4f17b0b..29112589b37f 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -24,6 +24,7 @@
>>  typedef struct sPAPRXive sPAPRXive;
>>  typedef struct XiveIVE XiveIVE;
>>  typedef struct XiveEQ XiveEQ;
>> +typedef struct ICSState ICSState;
>> =20
>>  #define TYPE_SPAPR_XIVE "spapr-xive"
>>  #define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIV=
E)
>> @@ -35,6 +36,9 @@ struct sPAPRXive {
>>      uint32_t     nr_targets;
>>      uint32_t     nr_irqs;
>> =20
>> +    /* IRQ */
>> +    ICSState     *ics;  /* XICS source inherited from the SPAPR machi=
ne */
>> +
>>      /* XIVE internal tables */
>>      uint8_t      *sbe;
>>      uint32_t     sbe_size;
>=20
