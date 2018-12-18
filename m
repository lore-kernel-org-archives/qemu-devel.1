Received: from eggs.gnu.org ([2001:4830:134:3::10]:34943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZLEr-00059n-Uv
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZLEn-0002qQ-6p
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:41:09 -0500
Received: from indium.canonical.com ([91.189.90.7]:50678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gZLEk-0002WQ-2C
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:41:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gZLEi-0003yA-OE
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 19:41:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 78A582E80CC
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 19:41:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Dec 2018 19:33:43 -0000
From: Eric Blake <1803872@bugs.launchpad.net>
Reply-To: Bug 1803872 <1803872@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154254872666.7803.12367996737502527787.malonedeb@wampee.canonical.com>
Message-Id: <42d9f6f7-617d-db80-1cda-b079416ec995@redhat.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1803872] Re: [PATCH v3 5/5] migration: Use
 strnlen() for fixed-size string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 12/18/18 11:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> GCC 8 introduced the -Wstringop-overflow, which detect buffer overflow
> by string-modifying functions declared in <string.h>, such strncpy(),
> used in global_state_store_running().
> =

> Since the global_state.runstate does not necessarily contains a
> terminating NUL character, We had to use the QEMU_NONSTRING attribute.

s/We/we/

> =

> The GCC manual says about the nonstring attribute:
> =

>    However, when the array is declared with the attribute the call to
>    strlen is diagnosed because when the array doesn=E2=80=99t contain a
>    NUL-terminated string the call is undefined. [...]
>    In addition, calling strnlen and strndup with such arrays is safe
>    provided a suitable bound is specified, and not diagnosed.
> =

> GCC indeed found an incorrect use of strlen(), because this array
> is loaded by VMSTATE_BUFFER(runstate, GlobalState) then parsed
> using qapi_enum_parse which does not get the buffer length.
> =

> Use strnlen() which returns sizeof(s->runstate) if the array is not
> NUL-terminated.
> =

> This fixes:
> =

>      CC      migration/global_state.o
>    qemu/migration/global_state.c: In function 'global_state_pre_save':
>    qemu/migration/global_state.c:109:15: error: 'strlen' argument 1 decla=
red attribute 'nonstring' [-Werror=3Dstringop-overflow=3D]
>         s->size =3D strlen((char *)s->runstate) + 1;
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    qemu/migration/global_state.c:24:13: note: argument 'runstate' declare=
d here
>         uint8_t runstate[100] QEMU_NONSTRING;
>                 ^~~~~~~~
>    cc1: all warnings being treated as errors
>    make: *** [qemu/rules.mak:69: migration/global_state.o] Error 1
> =

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   migration/global_state.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/migration/global_state.c b/migration/global_state.c
> index 6e19333422..c19030ef62 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -106,7 +106,7 @@ static int global_state_pre_save(void *opaque)
>       GlobalState *s =3D opaque;
>   =

>       trace_migrate_global_state_pre_save((char *)s->runstate);
> -    s->size =3D strlen((char *)s->runstate) + 1;

The old code sets s->size to the string length + space for the NUL byte =

(by assuming that a NUL byte was present), and accidentally sets it =

beyond the s->runstate array if there was no NUL byte (our existing =

runstate names are shorter than 100 bytes, so this could only happen on =

a malicious stream).

> +    s->size =3D strnlen((char *)s->runstate, sizeof(s->runstate)) + 1;

The new code can still end up setting s->size beyond the array.  Is that =

intended, or would it be better to use strnlen(s->runstate, =

sizeof(s->runstate) - 1) + 1?

Also, as I argued on 4/5, why isn't this squashed in with the patch that =

marks the field NONSTRING?

-- =

Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1803872

Title:
  gcc 8.2 reports stringop-truncation when building qemu

Status in QEMU:
  New

Bug description:
  QEMU 3.0

  block/sheepdog.c: In function 'find_vdi_name':
  block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals dest=
ination size [-Werror=3Dstringop-truncation]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_V=
DI_TAG_LEN);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~

  If this is the intended behavior, please suppress the warning. For
  example:

  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wstringop-truncation"
  =C2=A0=C2=A0=C2=A0=C2=A0strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG=
_LEN);
  #pragma GCC diagnostic pop

  This also happens on other sources, for example hw/acpi/core.c, so
  another option is to suppress it globally on CFLAGS (-Wno-stringop-
  truncation)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1803872/+subscriptions
