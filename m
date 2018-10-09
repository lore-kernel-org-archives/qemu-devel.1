Received: from eggs.gnu.org ([2001:4830:134:3::10]:47205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9q1u-0001Sm-JR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9q1t-0001tV-SF
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:18:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9q1t-0001sX-HR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:18:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id y11-v6so1383122wrd.4
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 04:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-21-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-21-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 15:18:08 +0400
Message-ID: <CAJ+F1CKgbYGprmpy9Zx8ieCkDCj2Fxnxj9kGKx-zrOV1xz-BUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 20/31] vl: Clean up error reporting in
 machine_set_property()
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

On Mon, Oct 8, 2018 at 9:47 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  machine_set_property() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index ecb70f87d8..3adc9dbe4f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2676,7 +2676,7 @@ static int machine_set_property(void *opaque,
>      g_free(qom_name);
>
>      if (local_err) {
> -        error_report_err(local_err);
> +        error_propagate(errp, local_err);
>          return -1;
>      }
>
> @@ -4201,11 +4201,8 @@ int main(int argc, char **argv, char **envp)
>      }
>
>      machine_opts =3D qemu_get_machine_opts();
> -    if (qemu_opt_foreach(machine_opts, machine_set_property, current_mac=
hine,
> -                         NULL)) {
> -        object_unref(OBJECT(current_machine));
> -        exit(1);
> -    }
> +    qemu_opt_foreach(machine_opts, machine_set_property, current_machine=
,
> +                     &error_fatal);
>
>      configure_accelerator(current_machine);
>
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
