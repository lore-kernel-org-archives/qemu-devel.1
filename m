Received: from eggs.gnu.org ([2001:4830:134:3::10]:40838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cJC5z-0006TJ-CM
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 23:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cJC5w-0001tp-9C
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 23:32:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:41729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cJC5v-0001tI-TG
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 23:32:08 -0500
Message-ID: <5858B472.9000007@intel.com>
Date: Tue, 20 Dec 2016 12:32:50 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
	<CAJ+F1CKWSznG3hxj0=F1UAJD+ZOZg=q+Oio1YnbsRyz6vy51FQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CKWSznG3hxj0=F1UAJD+ZOZg=q+Oio1YnbsRyz6vy51FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RESEND Patch v1 00/37] Implementation of
 vhost-pci for inter-vm commucation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

Hi Marc-André, thanks for the comments.

On 12/20/2016 12:43 AM, Marc-André Lureau wrote:
> Hi Wei,
>
> On Mon, Dec 19, 2016 at 7:00 AM Wei Wang <wei.w.wang@intel.com 
> <mailto:wei.w.wang@intel.com>> wrote:
>
>     This patch series implements vhost-pci, which is a point-to-point
>     based inter-vm
>     communication solution. The QEMU side implementation includes the
>     vhost-user
>     extension, vhost-pci device emulation and management. The current
>     device part
>     implementation is based on virtio 1.0, but it can be easily
>     upgraded to support
>     the upcoming virtio 1.1.
>
>     The current QEMU implementation supports the polling mode driver
>     on both sides
>     to receive packets. More features, such as interrupt support, live
>     migration
>     support, protected memory accesses will be added later.
>
>
>
> I highly appreciate the effort you put in splitting the patch series 
> and commenting each, although some are probably superfluous.

I will see if I can combine some of the unnecessary splits in the next 
version.

> Before going into details, I suppose you have kernel side bits too. 
> I'd suggest before sending individual patches for review, that you 
> send a RFC with links to the various git trees and instructions to 
> test the proposed device. This would really help things and 
> potentially bring more people for testing and comments (think about 
> libvirt side etc). Even better would be to have some tests (with qtest).

The driver is still in the draft version (functional with simple tests 
like Ping, but not ready for a robust test yet).  If that helps, I can 
share the draft version and people can use that to verify the 
correctness of the device part implementation in QEMU.

> High level question, why do you need to create device dynamically? I 
> would rather have the following qemu setup:
>
> -chardev socket,id=chr,path=.. -device vhost-pci-net,chardev=chr
>
> This would also avoid some global state (vp_slave etc)

With the above commands, the slave QEMU will create and plug in the 
vhost-pci-net device at the QEMU booting time. I think this won't work, 
because at the slave QEMU booting time, the master, in most cases, 
hasn't connected to the slave to transmit the info (e.g. memory info) 
that's required for the device setup - for example, the device bar can't 
be constructed without the memory info passed from the master, and if 
the device is created and plugged in the VM without a bar at the 
beginning, I think we don't have another chance to add a bar on the fly 
when the device is already driven in the guest. That's the reason that I 
get a global vp_slave to manage (dynamically create/destroy a device 
when requested by the master) the vhost-pci device.

>
> Regarding the protocol changes to support slave request: I tried to 
> explained that before, apprently I didn't manage to. It is not enough 
> to support bidirectionnal communications to simply add chardev 
> frontend handlers. Until now, qemu's code expects an immediate reply 
> after a request. With your protocol change, it must now also consider 
> that the slave may send a request before the master request reaches 
> the slave handler. So all req/reply write()/read() must now handle in 
> between requests from slave to be race-free (master can read back a 
> request when it expects a reply). That's not really trivial change, 
> that's why I proposed to have a secondary channel for slave->master 
> communications in the past. Not only would this be easier to 
> implement, but the protocol documentation would also be simpler, the 
> cost is simply 1 additional unix socket (that I proposed to setup and 
> pass with ancilliary data on the main channel).

I don't disagree with the second channel method. That implementation 
hasn't been in the upstream QEMU yet, are you planning to get it in 
first, so that we can upstream vhost-pci based on that?

> Another question, what are vpnet->rqs used for?

This should be redundant, I will remove it.

>
>
>     RESEND change: Fixed some coding style issue
>
>
> there are some spelling to be fixed, and perhaps some variables/fields 
> to rename  (asyn -> async, crq -> ctrlq?) That can be addressed in a 
> detailed review.

Sure, I will fix them.

Best,
Wei
