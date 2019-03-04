Received: from eggs.gnu.org ([209.51.188.92]:36034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0tBZ-0004fA-OH
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0tBY-0004Aa-Rl
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:23:37 -0500
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-5-git-send-email-jjherne@linux.ibm.com>
	<cc6dcf27-e1cf-14de-e729-486e1995f6eb@redhat.com>
	<722772b9-bdf7-6a4e-16cb-21bfb54e70ac@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <08e8bc33-6239-644c-f75e-54f6f208e3ae@redhat.com>
Date: Mon, 4 Mar 2019 20:23:33 +0100
MIME-Version: 1.0
In-Reply-To: <722772b9-bdf7-6a4e-16cb-21bfb54e70ac@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 04/15] s390-bios: Extend
 find_dev() for non-virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jjherne@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 13/02/2019 14.59, Jason J. Herne wrote:
> On 2/11/19 11:38 AM, Thomas Huth wrote:
>> On 2019-01-29 14:29, Jason J. Herne wrote:
>>> We need a method for finding the subchannel of a dasd device. Let's
>>> modify find_dev to handle this since it mostly does what we need. Up =
to
>>> this point find_dev has been specific to only virtio devices.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 pc-bios/s390-ccw/main.c | 16 +++++++++++-----
>>> =C2=A0 1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>>> index 67df421..7e3f65e 100644
>>> --- a/pc-bios/s390-ccw/main.c
>>> +++ b/pc-bios/s390-ccw/main.c
>>> @@ -49,6 +49,12 @@ unsigned int get_loadparm_index(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return atoui(loadparm_str);
>>> =C2=A0 }
>>> =C2=A0 +/*
>>> + * Find the subchannel connected to the given device (dev_no) and
>>> fill in the
>>> + * subchannel information block (schib) with the connected
>>> subchannel's info.
>>> + * NOTE: The global variable blk_schid is updated to contain the
>>> subchannel
>>> + * information.
>>> + */
>>> =C2=A0 static bool find_dev(Schib *schib, int dev_no)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, r;
>>> @@ -62,15 +68,15 @@ static bool find_dev(Schib *schib, int dev_no)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!schib->pm=
cw.dnv) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!virtio_is_supported(=
blk_schid)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip net de=
vices since no IPLB is created and therefore no
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * no network bootlo=
ader has been loaded
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * network bootloade=
r has been loaded
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_get_device_typ=
e() =3D=3D VIRTIO_ID_NET && dev_no < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_is_supported(b=
lk_schid) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
irtio_get_device_type() =3D=3D VIRTIO_ID_NET && dev_no < 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((dev_no < =
0) || (schib->pmcw.dev =3D=3D dev_no)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>
>> Not sure whether this really works as expected? If dev_no is -1, this
>> used to return the first supported virtio device. Now it returns the
>> first device that could be found - but how are we sure that we can boo=
t
>> from that device?
>=20
> How could we ever be sure we could boot from the first virtio device?
> The dev_no=3D1 case means we don't know which device to boot from so we=
're
> guessing.=C2=A0 The only thing that is changing here is that we're allo=
wing
> non-virtio devices as well. We do this because we now support booting
> from a device type that is not virtio.

For example, this command line used to work fine in the past:

s390x-softmmu/qemu-system-s390x -enable-kvm -nographic \
  -device x-terminal3270 -device virtio-blk-ccw,drive=3Ddr1 \
  -drive if=3Dnone,id=3Ddr1,format=3Dqcow2,file=3Dguest.qcow2

With this patch applied, the guest is now not bootable anymore. So I'm
sorry, but you break setups here that worked fine in the past. Isn't
there an easy way to determine whether a device is a bootable block
device or not?

 Thomas
