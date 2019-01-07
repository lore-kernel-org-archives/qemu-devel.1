Received: from eggs.gnu.org ([209.51.188.92]:37917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggYaz-00029S-6o
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggYat-0006IA-KX
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:21:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggYat-0006GV-ET
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:21:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-9-fli@suse.com>
Date: Mon, 07 Jan 2019 18:21:36 +0100
In-Reply-To: <20181225140449.15786-9-fli@suse.com> (Fei Li's message of "Tue,
	25 Dec 2018 22:04:41 +0800")
Message-ID: <87ftu4mli7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 08/16] qemu_thread: supplement
 error handling for qmp_dump_guest_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Fei Li <fli@suse.com> writes:

> Utilize the existed errp to propagate the error instead of the
> temporary &error_abort.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  dump.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/dump.c b/dump.c
> index c35d6ddd22..ef5ea324fa 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -2020,9 +2020,10 @@ void qmp_dump_guest_memory(bool paging, const char=
 *file,
>      if (detach_p) {
>          /* detached dump */
>          s->detached =3D true;
> -        /* TODO: let the further caller handle the error instead of abor=
t() */
> -        qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
> -                           s, QEMU_THREAD_DETACHED, &error_abort);
> +        if (!qemu_thread_create(&s->dump_thread, "dump_thread", dump_thr=
ead,
> +                           s, QEMU_THREAD_DETACHED, errp)) {
> +            /* keep 'if' here in case there is further error handling lo=
gic */
> +        }

I don't think keeping the conditional "just in case" is worthwhile.
Plain

           qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
                              s, QEMU_THREAD_DETACHED, errp);

should do fine.

>      } else {
>          /* sync dump */
>          dump_process(s, errp);
