Received: from eggs.gnu.org ([2001:4830:134:3::10]:38731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqwYy-0006Mr-0k
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 02:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqwYu-0008QS-Vh
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 02:49:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170322204844.446-1-f4bug@amsat.org>
	<20170322204844.446-2-f4bug@amsat.org>
Date: Thu, 23 Mar 2017 07:49:27 +0100
In-Reply-To: <20170322204844.446-2-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed,
	22 Mar 2017 17:48:42 -0300")
Message-ID: <87y3vw1o94.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND 1/3] usb-ccid: make
 ccid_write_data_block() cope with null buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> static code analyzer complain:
>
> hw/usb/dev-smartcard-reader.c:816:5: warning: Null pointer passed as an a=
rgument to a 'nonnull' parameter
>     memcpy(p->abData, data, len);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/usb/dev-smartcard-reader.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index 757b8b3f5a..c38a4e5886 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -799,8 +799,14 @@ static void ccid_write_parameters(USBCCIDState *s, C=
CID_Header *recv)
>  static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t=
 seq,
>                                    const uint8_t *data, uint32_t len)
>  {
> -    CCID_DataBlock *p =3D ccid_reserve_recv_buf(s, sizeof(*p) + len);
> +    CCID_DataBlock *p;
>=20=20
> +    if (len =3D=3D 0) {
> +        return;

Correct only if messages without data always have the same meaning as no
message.  Gerd?

> +    }
> +    g_assert(data !=3D NULL);

The assertion feels like noise to me.

> +
> +    p =3D ccid_reserve_recv_buf(s, sizeof(*p) + len);
>      if (p =3D=3D NULL) {
>          return;
>      }
