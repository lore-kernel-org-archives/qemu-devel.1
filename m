Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMz3V-0007KB-LK
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMz3U-0002yS-BF
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:29:49 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eMz3U-0002xR-3B
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:29:48 -0500
Received: by mail-wm0-x244.google.com with SMTP id g130so1334833wme.0
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 08:29:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171207153454-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171206134957.GD12584@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
	<CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
	<5A28BC2D.6000308@intel.com>
	<CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
	<5A290398.60508@intel.com>
	<CAJSP0QURjdD8BnOmJo83fzJn_zCijSKQh==Pz+Xu4r6Q2i3SkQ@mail.gmail.com>
	<20171207153454-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Dec 2017 16:29:45 +0000
Message-ID: <CAJSP0QVu4iwAu01Sth84VZshQde97x3FW1E1ua_YXVKs-65vhQ@mail.gmail.com>
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

On Thu, Dec 7, 2017 at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Dec 07, 2017 at 01:08:04PM +0000, Stefan Hajnoczi wrote:
>> Instead of responding individually to these points, I hope this will
>> explain my perspective.  Let me know if you do want individual
>> responses, I'm happy to talk more about the points above but I think
>> the biggest difference is our perspective on this:
>>
>> Existing vhost-user slave code should be able to run on top of
>> vhost-pci.  For example, QEMU's
>> contrib/vhost-user-scsi/vhost-user-scsi.c should work inside the guest
>> with only minimal changes to the source file (i.e. today it explicitly
>> opens a UNIX domain socket and that should be done by libvhost-user
>> instead).  It shouldn't be hard to add vhost-pci vfio support to
>> contrib/libvhost-user/ alongside the existing UNIX domain socket code.
>>
>> This seems pretty easy to achieve with the vhost-pci PCI adapter that
>> I've described but I'm not sure how to implement libvhost-user on top
>> of vhost-pci vfio if the device doesn't expose the vhost-user
>> protocol.
>>
>> I think this is a really important goal.  Let's use a single
>> vhost-user software stack instead of creating a separate one for guest
>> code only.
>>
>> Do you agree that the vhost-user software stack should be shared
>> between host userspace and guest code as much as possible?
>
>
>
> The sharing you propose is not necessarily practical because the security goals
> of the two are different.
>
> It seems that the best motivation presentation is still the original rfc
>
> http://virtualization.linux-foundation.narkive.com/A7FkzAgp/rfc-vhost-user-enhancements-for-vm2vm-communication
>
> So comparing with vhost-user iotlb handling is different:
>
> With vhost-user guest trusts the vhost-user backend on the host.
>
> With vhost-pci we can strive to limit the trust to qemu only.
> The switch running within a VM does not have to be trusted.

Can you give a concrete example?

I have an idea about what you're saying but it may be wrong:

Today the iotlb mechanism in vhost-user does not actually enforce
memory permissions.  The vhost-user slave has full access to mmapped
memory regions even when iotlb is enabled.  Currently the iotlb just
adds an indirection layer but no real security.  (Is this correct?)

Are you saying the vhost-pci device code in QEMU should enforce iotlb
permissions so the vhost-user slave guest only has access to memory
regions that are allowed by the iotlb?

This is a weak way to enforce memory permissions.  If the guest is
able to exploit a bug in QEMU then it has full memory access.  It's a
security problem waiting to happen and QEMU generally doesn't
implement things this way.

A stronger solution is for the vhost-user master to control memory
protection and to disallow the vhost-user slave from changing memory
protection.  I think the kernel mechanism to support this does not
exist today.  Such a mechanism would also make the vhost-user host
userspace use case secure.  The kernel mechanism to do this would
definitely be useful outside of virtualization too.

Stefan
