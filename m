Received: from eggs.gnu.org ([2001:4830:134:3::10]:53935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhcdm-00082C-E6
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhcdh-0005VU-JT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:20:50 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:55577)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fhcdh-0005Uw-9j
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:20:45 -0400
Received: from player715.ha.ovh.net (unknown [10.109.159.159])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8C1C51E44A
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 17:20:43 +0200 (CEST)
References: <20180706090713.15712-1-clg@kaod.org>
	<20180706090713.15712-2-clg@kaod.org>
	<20180706153624.77494d28@bahia.lan>
	<20180720023839.GF18205@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <069ae30c-ee46-2851-dfa7-04b574fadd1d@kaod.org>
Date: Mon, 23 Jul 2018 17:20:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180720023839.GF18205@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/20/2018 04:38 AM, David Gibson wrote:
> On Fri, Jul 06, 2018 at 03:36:24PM +0200, Greg Kurz wrote:
>> On Fri,  6 Jul 2018 11:07:11 +0200
>> C=E9dric Le Goater <clg@kaod.org> wrote:
> [snip]
>>> +/*
>>> + * The register property of a VIO device is defined in livirt using =
a
>>> + * base number + 0x1000 increment and in QEMU by incrementing the ba=
se
>>> + * register number 0x71000000.
>>> + *
>>> + * The formula below tries to compute a unique index number from the
>>> + * register value that will be used to define the IRQ number of the
>>> + * VIO device. A maximum of 256 (0x100) VIO devices is covered.
>>> + *
>>> + * To minimize collisions, we define two distinct ranges depending o=
n
>>> + * the "reg" value definition:
>>> + *
>>> + *     [0x00 - 0x7f]    user/libvirt
>>> + *     [0x80 - 0xff]    QEMU VIO model
>>> + *
>>> + * Collisions will be detected when the IRQ is claimed.
>>> + */
>>> +static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
>>> +{
>>> +    if (reg >=3D SPAPR_VIO_REG_BASE) {
>>> +        return SPAPR_IRQ_VIO | (reg & 0x7f) | 0x80;
>>> +    } else {
>>> +        return SPAPR_IRQ_VIO | ((reg & 0x7f) ^ ((reg >> 12) & 0x7f))=
;
>>
>> Hmm... if you put a VIO net and two VIO vty in the domain XML, libvirt
>> will generate reg =3D=3D 0x1000 for the VIO net and reg =3D=3D 0x30001=
000 for the
>> second VIO vty... this will necessarily collide, won't it ?
>=20
> Ah, drat, yeah, this will still need some tweaking.
>=20
>> With a 256 VIO devices limit, libvirt can only add 255 devices since
>> the nvram is created by QEMU by default (libvirt can only change its
>> reg using -global).
>=20
> Note that the 256 limit is basically arbitrary.  I don't think it
> exists in the code now, but it should be way more than sufficient.
>=20
>> As David mentioned in another mail:
>>
>> 	VIO net devices start at reg=3D0x1000
>> 	VIO scsi devices start at reg=3D0x2000
>> 	VIO nvram devices start at reg=3D0x3000
>> 	VIO vty devices start at reg=3D0x30000000
>> 	    and increment by 0x1000 each type
>>
>>
>> The values for net, scsi and nvram overlap... which makes me wonder wh=
y
>> do we even care to have per-type base value !?!
>=20
> We don't, really, I'm not sure why it ended up like that.
>=20
>> Anyway, I don't think
>> it's important for what you're trying to achieve.
>>
>> Basically libvirt can generate regs in two distinct ranges:
>>
>> - one for scsi/net/nvram:
>>
>> smallest possible reg: 0x1000
>> largest possible reg: 0x2000 + 254 * 0x1000 =3D 0x100000
>>
>> ie, 254 scsi devices starting at 0x2000 and 1 nvram
>>
>> - one for vty=20
>>
>> smallest possible reg: 0x30000000
>> largest possible reg: 0x30000000 + 253 * 0x1000 =3D 0x300fd000
>>
>> ie, 254 vty devices
>>
>> Thinking about the bit shifting magic that is needed to convert
>> reg into a usable index makes my brain hurt, but I'll happily
>> review anything you propose :)
>=20
> Considering just the libvirt assigned addresses how about:
>=20
> 	if (reg >=3D 0x30000000)
> 		irq =3D VIO_BASE + 240 + (reg >> 12); // up to 16 vtys
> 	else
> 		irq =3D VIO_BASE + (reg >> 12);       // up to 238 others
>=20
> (+ some masking to enforce the limits).
>=20
> I think it's ok to overlap the "qemu" and "libvirt" ranges, since
> (with the exception of the nvram device) I don't see any natural way
> you'd get both schemes in use at once.  If the user overrides things,
> either on the qemu command line or in the libvirt XML to combine the
> two schemes, then we're back to "fix your own mess by manually
> allocating irqs as well".
>=20
> Note that the above formula doesn't use VIO_BASE+0 itself, so I think
> we can then factor in the qemu assigned devices with just a:
> 	irq ^=3D (reg & 0xff);

And what about the proposal below ? May be the QEMU/libvirt split could=20
be rebalanced to favor one or the other.=20

Thanks,

C.


+#define SPAPR_VIO_REG_BASE 0x71000000
+
+/*
+ * The register property of a VIO device is defined in livirt using a
+ * base number + 0x1000 increment and in QEMU by incrementing the base
+ * register number 0x71000000.
+ *
+ * The formula below tries to compute a unique index number from the
+ * register value that will be used to define the IRQ number of the
+ * VIO device. A maximum of 256 (0x100) VIO devices is covered.
+ *
+ * To minimize collisions, we define two distinct ranges depending on
+ * the "reg" value definition:
+ *
+ *     [0x00 - 0x7f]    user/libvirt
+ *     [0x80 - 0xff]    QEMU VIO model
+ *
+ * For the VIO devices with a user defined "reg", we extract bits
+ * [29-28] and [16-12] to compose an index on 7 bits. It should fit
+ * all libvirt usage.
+ *
+ * Collisions will be detected when the IRQ is claimed.
+ */
+static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
+{
+    if (reg >=3D SPAPR_VIO_REG_BASE) {
+        return SPAPR_IRQ_VIO | 0x80 | (reg & 0x7f);
+    } else {
+        return SPAPR_IRQ_VIO | (((reg >> 28) & 0x3) << 5) |
+            ((reg >> 12) & 0x1f);
+    }
+}
+
