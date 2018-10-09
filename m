Received: from eggs.gnu.org ([2001:4830:134:3::10]:45530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9pxg-00080i-52
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9pxf-0005zZ-HM
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:14:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9pxf-0005yw-AT
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:13:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id g15-v6so1355641wru.9
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 04:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-20-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-20-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 15:13:46 +0400
Message-ID: <CAJ+F1CLLM7nOAXPABTGRzddRNvryN9BFetv_g5Uo7mM6bGX2MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/31] vl: Clean up error reporting in
 parse_add_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Oct 8, 2018 at 9:51 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  chardev_init_func() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

commit title is wrong, apart from that:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index b8576f8f10..ecb70f87d8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2239,7 +2239,7 @@ static int chardev_init_func(void *opaque, QemuOpts=
 *opts, Error **errp)
>
>      if (!qemu_chr_new_from_opts(opts, &local_err)) {
>          if (local_err) {
> -            error_report_err(local_err);
> +            error_propagate(errp, local_err);
>              return -1;
>          }
>          exit(0);
> @@ -4185,10 +4185,8 @@ int main(int argc, char **argv, char **envp)
>                        user_creatable_add_opts_foreach,
>                        object_create_initial, &error_fatal);
>
> -    if (qemu_opts_foreach(qemu_find_opts("chardev"),
> -                          chardev_init_func, NULL, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("chardev"),
> +                      chardev_init_func, NULL, &error_fatal);
>
>  #ifdef CONFIG_VIRTFS
>      if (qemu_opts_foreach(qemu_find_opts("fsdev"),
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
