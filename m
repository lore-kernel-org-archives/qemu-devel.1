Received: from eggs.gnu.org ([2001:4830:134:3::10]:48446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJhzM-0000kU-3f
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJhzJ-0007gQ-Ft
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:12:16 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJhzJ-0007gB-97
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:12:13 -0400
Received: by mail-wm0-x241.google.com with SMTP id f8-v6so16201489wmc.4
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 09:12:13 -0700 (PDT)
References: <20180316142223.28745-1-marcandre.lureau@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180316142223.28745-1-marcandre.lureau@redhat.com>
Date: Fri, 18 May 2018 17:12:10 +0100
Message-ID: <87d0xtdjtx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: fix tpm-crb tpm-tis tests race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, stefanb@linux.vnet.ibm.com


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> No need to close the TPM data socket on the emulator end, qemu will
> close it after a SHUTDOWN. This avoids a race between close() and
> read() in the TPM data thread.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/tpm-emu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
> index 4dada76834..8c2bd53cad 100644
> --- a/tests/tpm-emu.c
> +++ b/tests/tpm-emu.c
> @@ -125,7 +125,7 @@ void *tpm_emu_ctrl_thread(void *data)
>          case CMD_SHUTDOWN: {
>              ptm_res res =3D 0;
>              qio_channel_write(ioc, (char *)&res, sizeof(res), &error_abo=
rt);
> -            qio_channel_close(s->tpm_ioc, &error_abort);
> +            /* the tpm data thread is expected to finish now */
>              g_thread_join(s->emu_tpm_thread);
>              break;
>          }


--
Alex Benn=C3=A9e
