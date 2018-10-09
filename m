Received: from eggs.gnu.org ([2001:4830:134:3::10]:51786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9qJA-00086D-DV
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9qJ9-0008Fi-JE
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:36:12 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9qJ7-0008Bi-Pm
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:36:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id x12-v6so1425271wru.8
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 04:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-25-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-25-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 15:35:54 +0400
Message-ID: <CAJ+F1CLw=M609d9vEhQNmZ67Qn5FnD=bGSEWb57DP7i1whZuNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 24/31] vl: Clean up error reporting in
 vnc_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Mon, Oct 8, 2018 at 9:38 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  vnc_init_func() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc.c | 5 +++--
>  vl.c     | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index cf221c83cc..df6c84b802 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4082,8 +4082,9 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Err=
or **errp)
>      vnc_display_init(id);
>      vnc_display_open(id, &local_err);
>      if (local_err !=3D NULL) {
> -        error_reportf_err(local_err, "Failed to start VNC server: ");
> -        exit(1);
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "Failed to start VNC server: ");
> +        return -1;
>      }
>      return 0;
>  }
> diff --git a/vl.c b/vl.c
> index 86eee4c798..5c159ca45c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4479,7 +4479,7 @@ int main(int argc, char **argv, char **envp)
>      /* init remote displays */
>  #ifdef CONFIG_VNC
>      qemu_opts_foreach(qemu_find_opts("vnc"),
> -                      vnc_init_func, NULL, NULL);
> +                      vnc_init_func, NULL, &error_fatal);
>  #endif
>
>      if (using_spice) {
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
