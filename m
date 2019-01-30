Received: from eggs.gnu.org ([209.51.188.92]:41526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1goq3L-0004XE-3o
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1goq3K-0007eI-Ef
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:37:19 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:47927
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1goq3K-0007bN-8p
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:37:18 -0500
References: <20190129203219.6473-1-jcmvbkbc@gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <cfc9fee5-9f8b-2fb2-d58e-f8e08f5a0a52@adacore.com>
Date: Wed, 30 Jan 2019 14:37:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190129203219.6473-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gdbstub: allow killing QEMU via vKill
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@greensocs.com>

Hi,

Le 1/29/19 =C3=A0 9:32 PM, Max Filippov a =C3=A9crit=C2=A0:
> With multiprocess extensions gdb uses 'vKill' packet instead of 'k' to
> kill the inferior. Handle 'vKill' the same way 'k' was handled in the
> presence of single process.
>=20
> Fixes: 7cf48f6752e5 ("gdbstub: add multiprocess support to
> (f|s)ThreadInfo and ThreadExtraInfo")
>=20
> Cc: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   gdbstub.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index bfc7afb50968..1ef31240c055 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1383,6 +1383,28 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>  =20
>               put_packet(s, buf);
>               break;
> +        } else if (strncmp(p, "Kill;", 5) =3D=3D 0) {
> +            unsigned long pid;
> +
> +            p +=3D 5;
> +
> +            if (qemu_strtoul(p, &p, 16, &pid)) {
> +                put_packet(s, "E22");
> +                break;
> +            }
> +            process =3D gdb_get_process(s, pid);
> +
> +            if (process =3D=3D NULL) {
> +                put_packet(s, "E22");
> +                break;
> +            }
> +            if (s->process_num <=3D 1) {
> +                /* Kill the target */
> +                error_report("QEMU: Terminated via GDBstub");
> +                exit(0);

I suggest:

#ifdef CONFIG_USER_ONLY
         exit(0);
#else
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
#endif

instead of exit(0);

> +            }
> +            /* TODO: handle multiprocess case */
> +            goto unknown_command;
>           } else {
>               goto unknown_command;
>           }
>=20
