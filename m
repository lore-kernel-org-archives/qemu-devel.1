Received: from eggs.gnu.org ([2001:4830:134:3::10]:57379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ee1yJ-0000aZ-Sy
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ee1yF-0004aw-P5
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:02:55 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ee1yF-0004aD-L9
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:02:51 -0500
Received: by mail-qt0-f194.google.com with SMTP id a27so3108361qtd.1
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 09:02:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123164718.12714-2-berrange@redhat.com>
References: <20180123164718.12714-1-berrange@redhat.com>
	<20180123164718.12714-2-berrange@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 23 Jan 2018 18:02:50 +0100
Message-ID: <CAMxuvaxJ+rRC65j5n8ja68t486pDs7_0UyG+KOXQRk_R=nS8wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/2] Revert "build-sys: silence make by
 default or V=0"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Tue, Jan 23, 2018 at 5:47 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> This reverts commit 42a77f1ce4934b243df003f95bda88530631387a.
>
> The primary intention of this change was to silence messages
> like
>
>   make[1]: '/home/berrange/src/virt/qemu/capstone/libcapstone.a' is up to=
 date.
>
> which we get when calling make recursively with explicit
> targets.
>
> The problem is that this change affected every make target,
> not merely the targets that triggered these "is up to date"
> messages. As a result any targets that were not invoking
> commands via "$(call quiet-command ...)" suddenly become
> silent. This is particularly bad for "make install" which
> now appears todo nothing.
>
> Rather than go through every make rule and try to identify
> places where we now need to explicitly print a message to
> show work taking place, just revert the change.
>
> To address the original problem of silencing "is up to date"
> messages, we simply add --quiet to the SUBDIR_MAKEVARS
> variable, so it only affects us on recursive make calls.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  Makefile  | 2 +-
>  rules.mak | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f26ef1b1df..c263190b8d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -280,7 +280,7 @@ else
>  DOCS=3D
>  endif
>
> -SUBDIR_MAKEFLAGS=3DBUILD_DIR=3D$(BUILD_DIR)
> +SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --quiet) BUILD_DIR=3D=
$(BUILD_DIR)
>  SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
>  SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARGET_=
DIRS))
>
> diff --git a/rules.mak b/rules.mak
> index 5fb4951561..6e943335f3 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -131,8 +131,6 @@ modules:
>  # If called with only a single argument, will print nothing in quiet mod=
e.
>  quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && =
$1, @$1))
>
> -MAKEFLAGS +=3D $(if $(V),,--no-print-directory --quiet)
> -
>  # cc-option
>  # Usage: CFLAGS+=3D$(call cc-option, -falign-functions=3D0, -malign-func=
tions=3D0)
>
> --
> 2.14.3
>
