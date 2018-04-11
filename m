Received: from eggs.gnu.org ([2001:4830:134:3::10]:48373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6BJR-0001AG-80
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6BJL-0005jL-7l
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:41:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:46626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f6BJK-0005iS-SR
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:40:59 -0400
Date: Wed, 11 Apr 2018 16:38:53 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180411083853.qa6y6zevjpvamrdx@debian>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<fc66437c-ae8c-15fa-c8d3-6aa6bdb22a36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc66437c-ae8c-15fa-c8d3-6aa6bdb22a36@redhat.com>
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com

On Wed, Apr 11, 2018 at 04:01:19PM +0800, Jason Wang wrote:
> On 2018年04月11日 15:20, Tiwei Bie wrote:
> > This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> > feature for vhost-user. By default, vhost-user backend needs
> > to query the IOTLBs from QEMU after meeting unknown IOVAs.
> > With this protocol feature negotiated, QEMU will provide all
> > the IOTLBs to vhost-user backend without waiting for the
> > queries from backend. This is helpful when using a hardware
> > accelerator which is not able to handle unknown IOVAs at the
> > vhost-user backend.
> > 
> > Signed-off-by: Tiwei Bie<tiwei.bie@intel.com>
> > ---
> > The idea of this patch is to let QEMU push all the IOTLBs
> > to vhost-user backend without waiting for the queries from
> > the backend. Because hardware accelerator at the vhost-user
> > backend may not be able to handle unknown IOVAs.
> > 
> > This is just a RFC for now. It seems that, it doesn't work
> > as expected when guest is using kernel driver (To handle
> > this case, it seems that some RAM regions' events also need
> > to be listened). Any comments would be appreciated! Thanks!
> 
> Interesting, a quick question is why this is needed? Can we just use exist
> IOTLB update message?

Yeah, we are still using the existing IOTLB update messages
to send the IOTLB messages to backend. The only difference
is that, QEMU won't wait for the queries before sending the
IOTLB update messages.

> 
> It looks to me at least kernel does not need this.

Something similar in kernel vhost is that, for kernel vhost,
QEMU needs to push the IOTLBs of some ring addrs to kernel
vhost backend without waiting for the queries.

Best regards,
Tiwei Bie

> 
> Thanks
