Received: from eggs.gnu.org ([2001:4830:134:3::10]:35297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fdFti-0007bJ-PM
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fdFte-0002CN-6n
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:15:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fdFte-0002Bt-2h
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:15:10 -0400
Date: Wed, 11 Jul 2018 16:15:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180711161502.7f087034@redhat.com>
In-Reply-To: <0a3e915f-2420-e81c-011e-132f6c518b3a@redhat.com>
References: <20180710155037.16834-1-stefanha@redhat.com>
	<20180710155037.16834-2-stefanha@redhat.com>
	<20180711132908.GK31228@stefanha-x1.localdomain>
	<0a3e915f-2420-e81c-011e-132f6c518b3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qdev: add HotplugHandler->post_plug()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, l00284672 <lizhengui@huawei.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 11 Jul 2018 15:32:12 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/07/2018 15:29, Stefan Hajnoczi wrote:
> >>          if (dev->hotplugged) {
> >>              device_reset(dev);
> >> +
> >> +            if (hotplug_ctrl) {  
> > In the final patch I will move this out of if (dev->hotplugged) since
> > the other HotplugHandler callbacks are also invoked unconditionally.  
> 
> I'm not even sure why the reset is needed (removing it would also fix
> the bug!), and why it's only done on hotplug; however, it is probably
> there because it updates some bus-level state, so it's dangerous to
> remove it.
it might be also so that each device won't have to call reset manually from
their realize (5ab28c834) to initialize device into initial state.

> Paolo
> 
> >> +                hotplug_handler_post_plug(hotplug_ctrl, dev, &local_err);
> >> +                if (local_err != NULL) {
> >> +                    goto child_realize_fail;
> >> +                }
> >> +            }
> >>          }
> >>          dev->pending_deleted_event = false;  
> 
