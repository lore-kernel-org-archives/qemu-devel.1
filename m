Received: from eggs.gnu.org ([2001:4830:134:3::10]:50925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fyAAk-0001WS-HF
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fyAAh-0003nN-Ca
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:23:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fyAAh-0003jh-4p
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:23:11 -0400
Date: Fri, 7 Sep 2018 08:23:07 +0200
From: gerd hoffmann <kraxel@redhat.com>
Message-ID: <20180907062307.f7dnpvbok37ztkvo@sirius.home.kraxel.org>
References: <D9DE8DBB19F2A24080482022C1DE758302CED514@DGGEMM529-MBX.china.huawei.com>
	<20180906120404.zuvf3kkgmzwkb6a3@sirius.home.kraxel.org>
	<D9DE8DBB19F2A24080482022C1DE758302CED55C@DGGEMM529-MBX.china.huawei.com>
	<20180906135223.fy5bsibinxqdhp7t@sirius.home.kraxel.org>
	<9cc5ff6.583e8.165af44797e.Coremail.linzc@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cc5ff6.583e8.165af44797e.Coremail.linzc@zju.edu.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Some confusion about live migration of usb device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: CheneyLin <linzc@zju.edu.cn>
Cc: linzhecheng <linzhecheng@huawei.com>, "wangxin (u)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Sep 06, 2018 at 10:23:45PM +0800, CheneyLin wrote:
>=20
>=20
>=20
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "gerd hoffmann" <kraxel@redhat.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018-09-06 21:52:23 (=E6=98=9F=E6=
=9C=9F=E5=9B=9B)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: linzhecheng <linzhecheng@huawei.com>
> > =E6=8A=84=E9=80=81: "wangxin (U)" <wangxinxin.wang@huawei.com>, Chene=
yLin <linzc@zju.edu.cn>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
> > =E4=B8=BB=E9=A2=98: Re: [Qemu-devel] Some confusion about live migrat=
ion of usb device
> >=20
> > On Thu, Sep 06, 2018 at 12:10:08PM +0000, linzhecheng wrote:
> > > You had said that copying vmstate of usb-host is pointless, so just=
 unpulg and plug it after migration is all right,
> > >  but will other usb devices like usb-storage devices lose pending U=
SBPackets then? =20
> >=20
> > Ah, emulated usb devices.  The usb host adapters will re-submit any
> > unfinished usb transfers on the target machine.
> You mean target vm usb controllers will re-submit them?=20

Yes.

> And what about usb-redir, btw?

Basically the same.  But some extra care is needed to make sure the
physical device will not see requests twice when the target starts
replaying unfinished requests.  All usb requests get a unique tag
(USBPacket->id) so the usbredir server (typically spice client) has a
chance to handle this correctly.

cheers,
  Gerd
