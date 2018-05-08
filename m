Received: from eggs.gnu.org ([2001:4830:134:3::10]:36495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG4ZU-0004IY-BH
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG4ZT-0002ly-BX
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:30:32 -0400
Date: Tue, 8 May 2018 16:30:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180508153015.GE5967@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1525793375-15367-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525793375-15367-1-git-send-email-stefanb@linux.vnet.ibm.com>
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, f4bug@amsat.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, May 08, 2018 at 11:29:35AM -0400, Stefan Berger wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> No need to close the TPM data socket on the emulator end, qemu will
> close it after a SHUTDOWN. This avoids a race between close() and
> read() in the TPM data thread.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  tests/tpm-emu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
> index 4dada76..8c2bd53 100644
> --- a/tests/tpm-emu.c
> +++ b/tests/tpm-emu.c
> @@ -125,7 +125,7 @@ void *tpm_emu_ctrl_thread(void *data)
>          case CMD_SHUTDOWN: {
>              ptm_res res =3D 0;
>              qio_channel_write(ioc, (char *)&res, sizeof(res), &error_a=
bort);
> -            qio_channel_close(s->tpm_ioc, &error_abort);
> +            /* the tpm data thread is expected to finish now */
>              g_thread_join(s->emu_tpm_thread);
>              break;
>          }
> --=20
> 2.5.5
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
