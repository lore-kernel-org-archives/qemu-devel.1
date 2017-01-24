Received: from eggs.gnu.org ([2001:4830:134:3::10]:38616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVzJS-0003uX-62
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVzJN-0000qG-4v
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:30:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:32981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVzJM-0000q7-VU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:30:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVzJL-0000Kh-Ak
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D7E0B2E80D2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jan 2017 11:20:52 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1658634 <1658634@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170123095738.20994.7212.malonedeb@gac.canonical.com>
	<1485253217-7405-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CKV8R7bpOjVHjHt=N2QqGdV-O3-Tb8DGs=ZWfKf4WYPDA@mail.gmail.com>
Message-Id: <91b6af8c-76cc-845f-bbd7-4af8c44da520@redhat.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1658634] [PATCH] console: fix console resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 01/24/17 11:37, elmarco wrote:
> Hi
> =

> On Tue, Jan 24, 2017 at 2:31 PM Gerd Hoffmann <1658634@bugs.launchpad.net>
> wrote:
> =

>> Only skip surface reallocation in case the old surface was created using
>> qemu_alloc_display (via qemu_create_displaysurface) too, otherwise we
>> might end up with a DisplaySurface with the wrong backing storage.
>>
>> Cc: 1658634@bugs.launchpad.net
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Fixes: cd958edb1fae85d0c7d1e1acbff82d22724e8d64
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  ui/console.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ui/console.c b/ui/console.c
>> index b9575f2..67c65b7 100644
>> --- a/ui/console.c
>> +++ b/ui/console.c
>> @@ -2121,7 +2121,7 @@ void qemu_console_resize(QemuConsole *s, int width,
>> int height)
>>
>>      assert(s->console_type =3D=3D GRAPHIC_CONSOLE);
>>
>> -    if (s->surface &&
>> +    if (s->surface && (surface->flags & QEMU_ALLOCATED_FLAG) &&
>>          pixman_image_get_width(s->surface->image) =3D=3D width &&
>>          pixman_image_get_height(s->surface->image) =3D=3D height) {
>>          return;
>>
> =

> You are missing the 's->' !
> =

> with that,
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

With that change:

Tested-by: Laszlo Ersek <lersek@redhat.com>

Also,

Cc: qemu-stable@nongnu.org

Thanks
Laszlo


> --
>> 1.8.3.1
>>
>> --
>> You received this bug notification because you are subscribed to the bug
>> report.
>> https://bugs.launchpad.net/bugs/1658634
>>
>> Title:
>>   Can't get correct display with latest QEMU and OVMF BIOS
>>
>> To manage notifications about this bug go to:
>> https://bugs.launchpad.net/qemu/+bug/1658634/+subscriptions
>>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658634

Title:
  Can't get correct display with latest QEMU and OVMF BIOS

Status in QEMU:
  Confirmed

Bug description:
  I tried to install a Ubuntu 16.04.1 Desktop 64bits with latest QEMU and O=
VMF UEFI BIOS, however I can't get correct display output with default vga =
configuration (-vga std). However, qemu works with a couple of different co=
nfigurations:
  1. "-vga cirrus" + "-bios OVMF.fd": works
  2. "-vga std" + non-UEFI bios: works

  The same error with QEMU 2.8.0 release. Everything works well on
  2.7.0/1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658634/+subscriptions
