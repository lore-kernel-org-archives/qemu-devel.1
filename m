Received: from eggs.gnu.org ([2001:4830:134:3::10]:51519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f3NKv-0004tv-PW
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f3NKr-000411-Vc
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:55:01 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:46632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f3NKr-00040T-P5
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:54:57 -0400
Received: by mail-wr0-x22b.google.com with SMTP id d1so19007793wrj.13
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 07:54:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7c6e36a4-f03f-1042-dc34-cfaf48d7518a@redhat.com>
References: <3c36db1dc0702763ebb7966cc27428ed67d43804.1522751624.git.mprivozn@redhat.com>
	<CAJ+F1CKzkhdXHyZ0wRQ7Hjx8cVLVhDCgoGP9pVgte26+NMQmbA@mail.gmail.com>
	<7c6e36a4-f03f-1042-dc34-cfaf48d7518a@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Apr 2018 16:54:55 +0200
Message-ID: <CAJ+F1C++rpmeA-Ve9wKCTJc7=+aCjTQxi-+SW4Kod77AuXB5Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ccid-card: include libcacard.h only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Tue, Apr 3, 2018 at 1:48 PM, Michal Privoznik <mprivozn@redhat.com> wrot=
e:
> On 04/03/2018 01:38 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Tue, Apr 3, 2018 at 12:34 PM, Michal Privoznik <mprivozn@redhat.com> =
wrote:
>>> When trying to build with latest libcacard-2.5.1, I hit the
>>> following error:
>>>
>>> In file included from hw/usb/ccid-card-passthru.c:12:0:
>>> /usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libcac=
ard.h> can be included directly" [-Werror=3Dcpp]
>>>  #warning "Only <libcacard.h> can be included directly"
>>>
>>> While it was fixed in libcacard upstream (so that individual
>>> files can be included directly), it doesn't make much sense.
>>> Let's switch to including the main libcacard.h and also require
>>> at least libcacard-2.5.1 which introduced it. It's available
>>> since late 2015.
>>>
>>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>>> ---
>>>
>>> diff to v1:
>>> - Introduce configure change to require newer libcacard version
>>>
>>>  configure                   | 2 +-
>>>  hw/usb/ccid-card-emulated.c | 5 +----
>>>  hw/usb/ccid-card-passthru.c | 2 +-
>>>  3 files changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/configure b/configure
>>> index 4d0e92c96c..0edec24fff 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -4440,7 +4440,7 @@ fi
>>>
>>>  # check for smartcard support
>>>  if test "$smartcard" !=3D "no"; then
>>> -    if $pkg_config libcacard; then
>>> +    if $pkg_config --atleast-version=3D2.5.1 libcacard; then
>>>          libcacard_cflags=3D$($pkg_config --cflags libcacard)
>>>          libcacard_libs=3D$($pkg_config --libs libcacard)
>>>          smartcard=3D"yes"
>>> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
>>> index ea42e4681d..7b538ae6da 100644
>>> --- a/hw/usb/ccid-card-emulated.c
>>> +++ b/hw/usb/ccid-card-emulated.c
>>> @@ -27,10 +27,7 @@
>>>   */
>>>
>>>  #include "qemu/osdep.h"
>>> -#include <eventt.h>
>>> -#include <vevent.h>
>>> -#include <vreader.h>
>>> -#include <vcard_emul.h>
>>> +#include <cacard/libcacard.h>
>>
>> You should be able to #include <libcacard.h> only.
>
> Yes, you're right. Do you want me to resend or will you handle this when
> merging the patch?

I'll let Gerd decide:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau
