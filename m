Received: from eggs.gnu.org ([209.51.188.92]:53784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1guc2M-0005LN-Vr
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1guc2L-0008Cf-Ko
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:52:10 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:32848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1guc1q-0007kC-19
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:52:09 -0500
Received: by mail-wr1-x42c.google.com with SMTP id i12so10076084wrw.0
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-9-philmd@redhat.com>
In-Reply-To: <20190214201939.494-9-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Feb 2019 12:51:23 +0100
Message-ID: <CAJ+F1CKrTcGmPWCQXuhqOvp5jLPsLW4khZyU_tDmytD70MHt7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/9] ccid-card-passthru: Use size_t to
 hold size argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Thu, Feb 14, 2019 at 9:28 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> check_atr() is called once with a unsigned argument.
> Since there is no need to use a signed type, use a size_t.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

and make data const?

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/usb/ccid-card-passthru.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index d63aa28584..083eb5ca08 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -149,9 +149,10 @@ static void ccid_card_vscard_handle_init(
>      ccid_card_vscard_send_init(card);
>  }
>
> -static int check_atr(PassthruState *card, uint8_t *data, int len)
> +static int check_atr(PassthruState *card, uint8_t *data, size_t len)
>  {
> -    int historical_length, opt_bytes;
> +    size_t historical_length;
> +    int opt_bytes;
>      int td_count =3D 0;
>      int td;
>
> @@ -185,18 +186,18 @@ static int check_atr(PassthruState *card, uint8_t *=
data, int len)
>      }
>      if (len < 2 + historical_length + opt_bytes) {
>          DPRINTF(card, D_WARN,
> -            "atr too short: len %d, but historical_len %d, T1 0x%X\n",
> +            "atr too short: len %zu, but historical_len %zu, T1 0x%X\n",
>              len, historical_length, data[1]);
>          return 0;
>      }
>      if (len > 2 + historical_length + opt_bytes) {
>          DPRINTF(card, D_WARN,
> -            "atr too long: len %d, but hist/opt %d/%d, T1 0x%X\n",
> +            "atr too long: len %zu, but hist/opt %zu/%d, T1 0x%X\n",
>              len, historical_length, opt_bytes, data[1]);
>          /* let it through */
>      }
>      DPRINTF(card, D_VERBOSE,
> -            "atr passes check: %d total length, %d historical, %d option=
al\n",
> +            "atr passes check: %zu total length, %zu historical, %d opti=
onal\n",
>              len, historical_length, opt_bytes);
>
>      return 1;
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
