Received: from eggs.gnu.org ([2001:4830:134:3::10]:54351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZG0U-000708-58
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZG0Q-0001ei-RW
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:05:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gZG0Q-0001eS-Jo
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:05:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gZEpc-0008A0-Gc
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:50:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7C9BA2E80C7
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Dec 2018 12:42:55 -0000
From: elmarco <marcandre.lureau@gmail.com>
Reply-To: Bug 1803872 <1803872@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154254872666.7803.12367996737502527787.malonedeb@wampee.canonical.com>
Message-Id: <CAJ+F1C+iQ0MDdPx8YJkxG0RR-3QXKmpLGSEr+npf0qHRc8kGKA@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1803872] Re: [PATCH v2 3/3] migration: Replace
 strncpy() by strpadcpy(pad='\0')
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Tue, Dec 18, 2018 at 3:09 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> GCC 8 added a -Wstringop-truncation warning:
>
>   The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
>   bug 81117 is specifically intended to highlight likely unintended
>   uses of the strncpy function that truncate the terminating NUL
>   character from the source string.
>
> This new warning leads to compilation failures:
>
>     CC      migration/global_state.o
>   qemu/migration/global_state.c: In function 'global_state_store_running':
>   qemu/migration/global_state.c:45:5: error: 'strncpy' specified bound 10=
0 equals destination size [-Werror=3Dstringop-truncation]
>        strncpy((char *)global_state.runstate, state, sizeof(global_state.=
runstate));
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>   make: *** [qemu/rules.mak:69: migration/global_state.o] Error 1
>
> The runstate name doesn't require the strings to be NUL-terminated,
> therefore strncpy is the right function to use here.
>
> We could add a #pragma GCC diagnostic ignored "-Wstringop-truncation"
> around, disable the warning globally using -Wno-stringop-truncation,
> but since QEMU provides the strpadcpy() which does the same purpose,
> simply use it to avoid the annoying warning.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  migration/global_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 8e8ab5c51e..c7e7618118 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -42,8 +42,8 @@ int global_state_store(void)
>  void global_state_store_running(void)
>  {
>      const char *state =3D RunState_str(RUN_STATE_RUNNING);
> -    strncpy((char *)global_state.runstate,
> -           state, sizeof(global_state.runstate));
> +    strpadcpy((char *)global_state.runstate,
> +              sizeof(global_state.runstate), state, '\0');
>  }
>
>  bool global_state_received(void)
> --
> 2.17.2
>
>


-- =

Marc-Andr=C3=A9 Lureau

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
