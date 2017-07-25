Received: from eggs.gnu.org ([2001:4830:134:3::10]:50478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZv3G-0000wT-PS
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZv3C-0003Ed-Qv
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:18:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZv3C-0003E7-LF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:18:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-5-f4bug@amsat.org>
Date: Tue, 25 Jul 2017 10:18:38 +0200
In-Reply-To: <20170724182751.18261-5-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon,
	24 Jul 2017 15:27:20 -0300")
Message-ID: <87d18pudy9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 04/35] ivshmem: fix incorrect
 error handling in ivshmem_recv_msg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> If qemu_chr_fe_read_all() returns -EINTR the do {} statement continues an=
d the
> n accumulator used to complete reads upto sizeof(msg) is decremented by 4=
 (the
> value of EINTR on Linux).
> To avoid that, use simpler if() statements and continue if EINTR occured.
>
> hw/misc/ivshmem.c:650:14: warning: Loss of sign in implicit conversion
>     } while (n < sizeof(msg));
>              ^
>

Let's add "Screwed up in commit 3a55fc0f, v2.6.0."

> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> get_maintainer.pl: No maintainers found!
>
>  hw/misc/ivshmem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index a58f9ee579..47a015f072 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -642,7 +642,10 @@ static int64_t ivshmem_recv_msg(IVShmemState *s, int=
 *pfd, Error **errp)
>      do {
>          ret =3D qemu_chr_fe_read_all(&s->server_chr, (uint8_t *)&msg + n,
>                                     sizeof(msg) - n);
> -        if (ret < 0 && ret !=3D -EINTR) {
> +        if (ret < 0) {
> +            if (ret =3D=3D -EINTR) {
> +                continue;
> +            }
>              error_setg_errno(errp, -ret, "read from server failed");
>              return INT64_MIN;
>          }

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Paolo, you taking this through your miscellaneous queue would save me
(and possibly Peter) a bit of work.  Only if you have something queued
already.  Let me know.
