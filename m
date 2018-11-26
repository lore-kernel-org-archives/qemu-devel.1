Received: from eggs.gnu.org ([2001:4830:134:3::10]:59968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRCaI-0004eq-Rz
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRCaF-0002Lt-Ky
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:49:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRCaF-0002LW-Fg
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:49:35 -0500
Date: Mon, 26 Nov 2018 09:49:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181126084933.jdlxzj6l7lq5kubg@sirius.home.kraxel.org>
References: <D9DE8DBB19F2A24080482022C1DE758302D325DC@DGGEMM529-MBX.china.huawei.com>
	<20181126064611.zgsxden3jemuglaj@sirius.home.kraxel.org>
	<D9DE8DBB19F2A24080482022C1DE758302D336B2@DGGEMM529-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302D336B2@DGGEMM529-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [question] live migration about redir-usb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>

On Mon, Nov 26, 2018 at 06:53:23AM +0000, linzhecheng wrote:
> 
> 
> > -----Original Message-----
> > From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> > Sent: Monday, November 26, 2018 2:46 PM
> > To: linzhecheng <linzhecheng@huawei.com>
> > Cc: qemu-devel@nongnu.org; wangxin (U) <wangxinxin.wang@huawei.com>;
> > Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Subject: Re: [Qemu-devel] [question] live migration about redir-usb
> > 
> > On Mon, Nov 26, 2018 at 02:29:12AM +0000, linzhecheng wrote:
> > > Hi, Gerd
> > > I have read this discussion thread about live migration in tcp mode.
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1254971
> > > Only spice redirection supports live migration not, but why not tcp mode?
> > > Does usbredirserver not support it or qemu?
> > 
> > usbredirserver.
> > 
> > spice client holds a connection to both source and target host for a seamless
> > connection handover, and usb-redir needs that too to hand over the usb device
> > without interruption.
> > 
> > usbredirserver can't do that.

> So if we realize the handover between src and dst chardev of qemu, we
> can do live migration in tcp mode.

> Is it similar with openvswtich who both accept the connection of src and dst qemu?

It is more complicated than just accepting two connections.  Network can
just throw away packages if needed, typicaly they will be resent by the
guest.  That doesn't work with usb, you must properly keep track of
every in-flight usb transfer.

What exactly do you want do?

Maybe it will be simpler to build a stripped-down spice client with only
the usb redir code, which doesn't require a UI and which you can start
from the command line like usbredirserver?  Most spice client code is
actually in shared libraries, so it should not be too much work.

cheers,
  Gerd
