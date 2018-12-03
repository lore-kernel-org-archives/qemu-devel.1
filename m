Received: from eggs.gnu.org ([2001:4830:134:3::10]:40766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTtjO-0004P7-KX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTtjN-0005oT-WA
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:18:10 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gTtjN-0005nn-PZ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:18:09 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so13404141wra.6
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 11:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20181203170105.2367492-1-stefanb@linux.vnet.ibm.com>
	<20181203170105.2367492-3-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20181203170105.2367492-3-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Dec 2018 23:17:56 +0400
Message-ID: <CAJ+F1CJii+_xR=NOgE5a8AH6rUdMk0t3WqzPqB30CS+1==dvKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tpm: Make sure new locality passed
 to tpm_tis_prep_abort() is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>, stefanb@linux.ibm.com

Hi

On Mon, Dec 3, 2018 at 9:01 PM Stefan Berger <stefanb@linux.vnet.ibm.com> w=
rote:
>
> Make sure that the new locality passed to tpm_tis_prep_abort()
> is valid. This is merely a precaution since none of the current
> callers passes an invalid locality number into this function.

If this should never happen, then let's make it an assert()

> Add a comment to aborting_locty that it may be any locality, including
> TPM_TIS_NO_LOCALITY.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  hw/tpm/tpm_tis.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 176d424ed9..9b2737b5bf 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -263,7 +263,10 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t =
locty, uint8_t newlocty)
>  {
>      uint8_t busy_locty;
>
> -    s->aborting_locty =3D locty;
> +    if (!TPM_TIS_IS_VALID_LOCTY(newlocty))
> +        return;

Follow qemu coding-style, add braces.

> +
> +    s->aborting_locty =3D locty; /* may also be TPM_TIS_NO_LOCALITY */
>      s->next_locty =3D newlocty;  /* locality after successful abort */
>
>      /*
> --
> 2.17.1
>


--=20
Marc-Andr=C3=A9 Lureau
