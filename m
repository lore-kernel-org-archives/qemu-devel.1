Received: from eggs.gnu.org ([2001:4830:134:3::10]:47834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSJki-0000Qz-6Z
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSJke-0006zK-2p
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:08:44 -0400
References: <1528636325-4237-1-git-send-email-thuth@redhat.com>
	<3a7d6318-c827-3aa3-2799-7e383132beb3@de.ibm.com>
	<20180611112410.4e2eb406.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <13aab353-a21e-586d-53b2-27c8bd40fa32@redhat.com>
Date: Mon, 11 Jun 2018 12:08:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180611112410.4e2eb406.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Fix crash that occurs when
 -kernel is used with small images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 11.06.2018 11:24, Cornelia Huck wrote:
> On Mon, 11 Jun 2018 09:49:39 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> On 06/10/2018 03:12 PM, Thomas Huth wrote:
>>> Add a sanity check to fix the following crash:
>>>
>>> $ echo "Insane in the mainframe" > /tmp/test.txt
>>> $ s390x-softmmu/qemu-system-s390x -nographic -kernel /tmp/test.txt
>>> Segmentation fault (core dumped)
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com> =20
>>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>
>> I think a similar problem exists for INITRD_PARM_START and INITRD_PARM=
_SIZE. No?
>=20
> I think so as well.

You're right:

$ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt \
                                  -initrd /tmp/test.txt
Segmentation fault (core dumped)

Shall I sent a v2 of this patch, or do you prefer a separate patch for
that issue?

>>> ---
>>>  hw/s390x/ipl.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>> index 04245b5..9bb9b50 100644
>>> --- a/hw/s390x/ipl.c
>>> +++ b/hw/s390x/ipl.c
>>> @@ -168,7 +168,8 @@ static void s390_ipl_realize(DeviceState *dev, Er=
ror **errp)
>>>           * we can not rely on the ELF entry point - it was 0x800 (th=
e SALIPL
>>>           * loader) and it won't work. For this case we force it to 0=
x10000, too.
>>>           */
>>> -        if (pentry =3D=3D KERN_IMAGE_START || pentry =3D=3D 0x800) {
>>> +        if ((pentry =3D=3D KERN_IMAGE_START || pentry =3D=3D 0x800) =
&&
>>> +            kernel_size > KERN_PARM_AREA + strlen(ipl->cmdline)) {
>>>              ipl->start_addr =3D KERN_IMAGE_START;
>>>              /* Overwrite parameters in the kernel image, which are "=
rom" */
>>>              strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
>=20
> The outcome of this is that we don't write into areas we must not write
> into, but we still have a broken "kernel" and will simply fail if the
> thing we're pointing to isn't a valid PSW. I guess that's what we want
> ("crap in, crap out"), i.e. no fallback to the bios or something like
> that?

Yes, I think "crap in, crap out" is ok here. Theoretically, the user
could also have a self-made micro-kernel that is just one byte smaller
than KERN_PARM_AREA, and this would still work with this patch, so no
need for an extra error message in that case.

 Thomas
