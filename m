Received: from eggs.gnu.org ([2001:4830:134:3::10]:36184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJthV-0003ej-HC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJthQ-0007YA-SB
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:10:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eJthQ-0007XC-Eo
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:10:16 -0500
Date: Wed, 29 Nov 2017 06:10:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171129060910-mutt-send-email-mst@kernel.org>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
	<6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
	<b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7E32@DGGEMA505-MBS.china.huawei.com>
	<3f0ed9b0-ff77-bb0f-c868-609abf0826b2@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A8D54@DGGEMA505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4A8D54@DGGEMA505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] cryptodev-vhost-user: add crypto
 session handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "jianfeng.tan@intel.com" <jianfeng.tan@intel.com>

On Wed, Nov 29, 2017 at 02:33:59AM +0000, Gonglei (Arei) wrote:
> 
> > -----Original Message-----
> > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > Sent: Tuesday, November 28, 2017 7:20 PM
> > To: Gonglei (Arei); qemu-devel@nongnu.org
> > Cc: mst@redhat.com; Huangweidong (C); stefanha@redhat.com; Zhoujian
> > (jay); pasic@linux.vnet.ibm.com; longpeng; xin.zeng@intel.com;
> > roy.fan.zhang@intel.com
> > Subject: Re: [PATCH 3/4] cryptodev-vhost-user: add crypto session handler
> > 
> > On 28/11/2017 12:06, Gonglei (Arei) wrote:
> > >>> You mean we can share control virtqueue to DPDK as well? Like data
> > queues?
> > >> I don't know :) but why not?
> > >>
> > > Current there are two main reasons for this design:
> > >
> > > 1) we should use another cpu to polling the control virtqueue, which is
> > expensive.
> > 
> > IIRC DPDK also supports interrupt mode, doesn't it?  Is it possible to
> > do interrupt mode for some virtqueues and poll mode for others?
> > 
> 
> The intel guy Tan (Ccing) said to me:
> 
> " Interrupt mode for vhost-user is still not supported in current 
> implementation. But we are evaluating the necessity now.

That's more or less a spec violation. Guest must get interrupts
if it does not disable them. And it must notify host
if host does not disable notifications.

> And yes, the mode (polling or interrupt) can be different for different 
> queues."
> 
> > > 2) we should copy the logic of parsing control message to DPDK, which break
> > >  current layered architecture .
> > 
> > But isn't it already a layering violation that you're adding *some*
> > control messages to the vhost-user protocol?  I am not sure why only
> > these two are necessary.
> > 
> Sorry, but I don't think this is layering violation, just like "vhost_net_set_mtu"
> for vhost-net and "vhost_vsock_set_guest_cid_op" for vhost_vsock. They're all
> device-specific messages. Aren't they?
> 
> Thanks,
> -Gonglei
> 
> > Paolo
> > 
> > > I'm not sure if there are any other hidden issues for future scalability, such as
> > > using Qemu to manage some control messages, avoiding D-Dos attack etc.
> > >
> > > Thanks,
> > > -Gonglei
> 
