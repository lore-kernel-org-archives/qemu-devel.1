Received: from eggs.gnu.org ([2001:4830:134:3::10]:44409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFmLt-0001U5-B6
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFmEM-0005rW-K8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:27:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gFmEM-0005rC-CP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CE0EC0B201F
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 20:27:45 +0000 (UTC)
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <93e507fb-f8d0-083e-c343-c466e9a49c22@redhat.com>
Date: Thu, 25 Oct 2018 21:27:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181025085256.20522-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] adlib: mark as insecure and deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Prasad J Pandit <ppandit@redhat.com>

On 2018-10-25 09:52, Gerd Hoffmann wrote:
> We have a lovely, guest-triggerable buffer overflow in opl2 emulation.
>=20
> Reproducer:
>     outw(0xff60, 0x220);
>     outw(0x1020, 0x220);
>     outw(0xffb0, 0x220);
> Result:
>     Will overflow FM_OPL->AR_TABLE[] (see hw/audio/fmopl.[ch])
>=20
> The specs google finds (http://www.symphoniae.com/Yamaha/YSC/YM3812.pdf=
)
> are rather sparse, possibly incomplete (looks like scanned fax with a
> scrambled page at the end) and not really helpful in identifying which
> of the register writes sets some illegal value.
>=20
> So, go tag the device as deprecated with a warning messge, to notify
> users and schedule it for removal according to our deprecation policy.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/audio/adlib.c     | 1 +
>  qemu-deprecated.texi | 4 ++++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index 97b876c..fb4a29c 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -311,6 +311,7 @@ static void adlib_class_initfn (ObjectClass *klass,=
 void *data)
>      set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>      dc->desc =3D ADLIB_DESC;
>      dc->props =3D adlib_properties;
> +    dc->deprecation_reason =3D "insecure, buffer overflow in opl2 emul=
ation";
>  }
> =20
>  static const TypeInfo adlib_info =3D {
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 11b870c..7951a4f 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -116,6 +116,10 @@ The @option{[hub_id name]} parameter tuple of the =
'hostfwd_add' and
>  The ``ivshmem'' device type is replaced by either the ``ivshmem-plain'=
'
>  or ``ivshmem-doorbell`` device types.
> =20
> +@subsection adlib (since 3.1)
> +
> +Has known buffer overflow.
> +
>  @section System emulator machines
> =20
>  @subsection pc-0.10 and pc-0.11 (since 3.0)
>=20

Any chance you could maybe at least add an assert() to the affected code
so that it crashes instead of silently overflowing the buffer?

Anyway, with the "messge" typo fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>
