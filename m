Received: from eggs.gnu.org ([2001:4830:134:3::10]:43888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNLJT-0006FN-4J
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNLJS-0005rx-1t
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:15:47 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eNLJR-0005rk-RZ
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:15:45 -0500
Received: by mail-wm0-x241.google.com with SMTP id i11so3961518wmf.4
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 08:15:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171208161606-mutt-send-email-mst@kernel.org>
References: <5A290398.60508@intel.com>
	<CAJSP0QURjdD8BnOmJo83fzJn_zCijSKQh==Pz+Xu4r6Q2i3SkQ@mail.gmail.com>
	<20171207153454-mutt-send-email-mst@kernel.org>
	<CAJSP0QVu4iwAu01Sth84VZshQde97x3FW1E1ua_YXVKs-65vhQ@mail.gmail.com>
	<20171207183945-mutt-send-email-mst@kernel.org>
	<CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
	<20171207193003-mutt-send-email-mst@kernel.org>
	<CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
	<CAJSP0QXYMVBidUd5-NJb5FDYbc6wSkNYgdadjk8+NXvwosLMPw@mail.gmail.com>
	<20171208161606-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Dec 2017 16:15:43 +0000
Message-ID: <CAJSP0QVuzeCaAmjCyQJAz5D8B9p41=i8FNe6-RdfjLfubDKJYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On Fri, Dec 8, 2017 at 2:27 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Dec 08, 2017 at 06:08:05AM +0000, Stefan Hajnoczi wrote:
>> On Thu, Dec 7, 2017 at 11:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Thu, Dec 07, 2017 at 06:28:19PM +0000, Stefan Hajnoczi wrote:
>> >> On Thu, Dec 7, 2017 at 5:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > On Thu, Dec 07, 2017 at 05:29:14PM +0000, Stefan Hajnoczi wrote:
>> >> >> On Thu, Dec 7, 2017 at 4:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> >> > On Thu, Dec 07, 2017 at 04:29:45PM +0000, Stefan Hajnoczi wrote:
>> >> >> >> On Thu, Dec 7, 2017 at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> >> >> > On Thu, Dec 07, 2017 at 01:08:04PM +0000, Stefan Hajnoczi wrote:
>> >>
>> >> > Besides, this means implementing iotlb in both qemu and guest.
>> >>
>> >> It's free in the guest, the libvhost-user stack already has it.
>> >
>> > That library is designed to work with a unix domain socket
>> > though. We'll need extra kernel code to make a device
>> > pretend it's a socket.
>>
>> A kernel vhost-pci driver isn't necessary because I don't think there
>> are in-kernel users.
>>
>> A vfio vhost-pci backend can go alongside the UNIX domain socket
>> backend that exists today in libvhost-user.
>>
>> If we want to expose kernel vhost devices via vhost-pci then a
>> libvhost-user program can translate the vhost-user protocol into
>> kernel ioctls.  For example:
>> $ vhost-pci-proxy --vhost-pci-addr 00:04.0 --vhost-fd 3 3<>/dev/vhost-net
>>
>> The vhost-pci-proxy implements the vhost-user protocol callbacks and
>> submits ioctls on the vhost kernel device fd.  I haven't compared the
>> kernel ioctl interface vs the vhost-user protocol to see if everything
>> maps cleanly though.
>>
>> Stefan
>
> I don't really like this, it's yet another package to install, yet
> another process to complicate debugging and yet another service that can
> go down.
>
> Maybe vsock can do the trick though?

Not sure what you have in mind.

An in-kernel vhost-pci driver is possible too.  The neatest
integration would be alongside drivers/vhost/vhost.c so that existing
net, scsi, vsock vhost drivers can work with vhost-pci.  Userspace
still needs to configure the devices and associate them with a
vhost-pci instance (e.g. which vhost-pci device should be a vhost_scsi
target and the SCSI target configuration).  But I think this approach
is more work than the vhost-pci-proxy program I've described.

Stefan
