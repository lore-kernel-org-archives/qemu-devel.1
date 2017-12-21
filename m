Received: from eggs.gnu.org ([2001:4830:134:3::10]:32863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS1ZL-0002Hk-J8
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS1ZK-0001NG-L6
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:11:31 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eS1ZK-0001LX-DW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:11:30 -0500
Received: by mail-wm0-x244.google.com with SMTP id b76so16162770wmg.1
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 06:11:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510323112-2207-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510323112-2207-3-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Dec 2017 15:11:28 +0100
Message-ID: <CAJ+F1C+k=RiLmp+jYSsRpxxRrKuSs9K7HwN58_pAr1-jCAKJyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/13] tpm_tis: limit size of buffer
 from backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On Fri, Nov 10, 2017 at 3:11 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> This is a preparatory patch for the subsequent ones where we
> get rid of the flexibility of supporting any kind of buffer size
> that the backend may support. We keep the size at 4096, which is
> also the size the external emulator supports. So, limit the size
> of the buffer we can support and pass it back to the backend.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/tpm/tpm_tis.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 69fe531..90c6df2 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -1008,7 +1008,8 @@ static void tpm_tis_reset(DeviceState *dev)
>      int c;
>
>      s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
> -    s->be_buffer_size =3D tpm_backend_get_buffer_size(s->be_driver);
> +    s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver),
> +                            TPM_TIS_BUFFER_MAX);
>
>      tpm_backend_reset(s->be_driver);
>
> @@ -1040,7 +1041,7 @@ static void tpm_tis_reset(DeviceState *dev)
>          tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size);
>      }
>
> -    tpm_tis_do_startup_tpm(s, 0);
> +    tpm_tis_do_startup_tpm(s, s->be_buffer_size);
>  }
>
>  static const VMStateDescription vmstate_tpm_tis =3D {
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
