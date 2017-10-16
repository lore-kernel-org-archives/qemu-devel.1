Received: from eggs.gnu.org ([2001:4830:134:3::10]:51750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e498w-0001PJ-DY
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e498t-0002XY-6Q
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1e498s-0002TV-TN
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:25:31 -0400
References: <8ba7e693-4e32-7873-70bf-4efbf57f9cf5@huawei.com>
	<20170928011407-mutt-send-email-mst@kernel.org>
	<405bbc99-1a43-aa8b-37e9-9599480f4c06@huawei.com>
	<20171001063010-mutt-send-email-mst@kernel.org>
	<49d576f3-454f-05f4-7afd-9ca8b5fb0706@huawei.com>
	<20171016113324.14e549c9@nial.brq.redhat.com>
	<0184EA26B2509940AA629AE1405DD7F2016994E5@DGGEMA503-MBX.china.huawei.com>
	<59E4E57D.4040304@arm.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <69f10790-f178-0383-3f74-0c7e5d0afce8@redhat.com>
Date: Mon, 16 Oct 2017 19:25:18 +0200
MIME-Version: 1.0
In-Reply-To: <59E4E57D.4040304@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiAgdXNpbmcgd2hpY2ggbm90aWZpY2F0?=
 =?utf-8?q?ion_for_guest_about_GHES_error?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Morse <james.morse@arm.com>, gengdongjiu <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Wuquanming <wuquanming@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, Andrew Jones <drjones@redhat.com>

On 10/16/17 18:59, James Morse wrote:
> Hi gengdongjiu, Igor,
> 
> On 16/10/17 15:33, gengdongjiu wrote:
>>> On Mon, 16 Oct 2017 14:10:05 +0800
>>> gengdongjiu <gengdongjiu@huawei.com> wrote:
>>>> Now we use Qemu to create APEI table and record CPER for guest, After
>>>> QEMU recorded a asynchronous CPER error, we needs to notify guest using interrupt or Polled notification.
>>>> For the asynchronous error. I think using GPIO-signaled notification may be better in the Qemu, and also which is suggested by APEI spec.
>>>> James worried that old guest OS may not support GPIO or GSIV notification for GHES, because GPIO or GSIV notification is supported in OS
>>> since about kernel version 4.10.
>>>
>>> How APEI support is fairly new on ARM (kernel), isn't it still in state of development?
> 
> The NMI-like notifications, (SEA, SEI, SDEI) are still being worked on, but the
> less exotic Polled and many-flavours-of-interrupt should have exactly the same
> meaning/behaviour as on x86. (it should be possible to emulate/configure these
> with common user-space code too)
> 
> 
>>> Do we really care about old guests in this case?
> 
> I think the scenario here is the host kernel has some RAS support, Qemu has RAS
> support and has advertised its CPER regions via the HEST, but the guest doesn't
> doesn't support RAS. (booted via DT, wasn't configured for APEI, the kernel
> pre-dates the support etc).
> 
> What should Qemu do in response to 'action optional' memory errors?
> 
> My suggestion is whatever action Qemu takes, it shouldn't kill a guest that
> doesn't support RAS. Using NOTIFY_SEI for an action-optional memory error will
> do this. A guest that doesn't know about NOTIFY_SEI will take this as a fatal
> SError.

As far as I understand, this QEMU feature is not enabled by default; it
takes at least one specific -device option (maybe some other options
too). If that's the case, then adding the option, and then seeing a
guest (without supporting the feature) hang itself, is okay.

It is no different from the guest OS lacking drivers for other important
-- such as boot -- devices, such as virtio drivers in general, or
virtio-1.0 drivers for modern-only virtio devices.

Such knowledge (= what OS has built-in drivers or other kind of support
for what devices) is maintained in libosinfo.

> I think you shouldn't expect host kernel, guest kernel and Qemu version to all
> pair up nicely.

If I understand correctly, the things that are expected to match up are:
- guest kernel (more generally, guest OS image),
- and QEMU command line (more generally, virtual hardware
  configuration).


Just my two cents anyway; I haven't been following this discussion closely.

Thanks
Laszlo
