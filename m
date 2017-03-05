Received: from eggs.gnu.org ([2001:4830:134:3::10]:42669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ckdHM-0004JE-Kd
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ckdHL-0006DY-Qa
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:01:20 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ckdHL-0006CY-FB
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:01:19 -0500
Received: by mail-lf0-x242.google.com with SMTP id v2so5326248lfi.2
	for <qemu-devel@nongnu.org>; Sun, 05 Mar 2017 13:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20170304185533.10618-1-f4bug@amsat.org>
	<20170304185533.10618-2-f4bug@amsat.org>
In-Reply-To: <20170304185533.10618-2-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 05 Mar 2017 21:01:07 +0000
Message-ID: <CAJ+F1CKdWDMmnvuC_WrDghjOEYDboRbshjNeB5=ceYpLMvRH+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] usb-ccid: make ccid_write_data_block()
 cope with null buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Sat, Mar 4, 2017 at 10:57 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> static code analyzer complain:
>
> hw/usb/dev-smartcard-reader.c:816:5: warning: Null pointer passed as an
> argument to a 'nonnull' parameter
>     memcpy(p->abData, data, len);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  hw/usb/dev-smartcard-reader.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
> index 757b8b3f5a..c38a4e5886 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -799,8 +799,14 @@ static void ccid_write_parameters(USBCCIDState *s,
> CCID_Header *recv)
>  static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t
> seq,
>                                    const uint8_t *data, uint32_t len)
>  {
> -    CCID_DataBlock *p =3D ccid_reserve_recv_buf(s, sizeof(*p) + len);
> +    CCID_DataBlock *p;
>
> +    if (len =3D=3D 0) {
> +        return;
> +    }
> +    g_assert(data !=3D NULL);
> +
> +    p =3D ccid_reserve_recv_buf(s, sizeof(*p) + len);
>      if (p =3D=3D NULL) {
>          return;
>      }
> --
> 2.11.0
>
>
> --
Marc-Andr=C3=A9 Lureau
