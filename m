Received: from eggs.gnu.org ([2001:4830:134:3::10]:60068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dYR7w-0007lF-Cu
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dYR7r-0007ww-CW
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:09:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dYR7r-0007vt-65
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:09:23 -0400
Message-ID: <1500617358.12926.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Jul 2017 08:09:18 +0200
In-Reply-To: <1500541371-24788-2-git-send-email-sf@sfritsch.de>
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
	<1500541371-24788-2-git-send-email-sf@sfritsch.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/8] usb-ccid: Add support to dump all
 USB packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org

> index bef1f03c42..624dc2c447 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -54,9 +54,25 @@ do { \
> =C2=A0#define D_INFO 2
> =C2=A0#define D_MORE_INFO 3
> =C2=A0#define D_VERBOSE 4
> +#define D_TRACE 5
> +#define D_REMOTEIO 10

Considered converting all DPRINTFs into tracepoints instead?

Then you can turn then on/off individually as needed.

> =C2=A0#define CCID_DEV_NAME "usb-ccid"
> =C2=A0#define USB_CCID_DEV(obj) OBJECT_CHECK(USBCCIDState, (obj),
> CCID_DEV_NAME)
> +
> +static void usb_packet_dump(int lvl, const char *dir, uint8_t *buf,
> size_t len)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0int i;
> +=C2=A0=C2=A0=C2=A0=C2=A0if (lvl < D_TRACE) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0printf("usb-ccid: usb packet(%s/%zd):", dir, l=
en);
> +=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < len; ++i) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf(" %02x", buf[i]=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0printf("\n");
> +}

There is qemu_hexdump() ...

cheers,
  Gerd
