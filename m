Received: from eggs.gnu.org ([2001:4830:134:3::10]:46599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eZZbX-0003IT-AN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eZZbV-0006x7-Rn
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:56:59 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eZZbV-0006vt-Hb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:56:57 -0500
Received: by mail-wm0-x241.google.com with SMTP id x4so1929265wmc.0
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 01:56:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5A5704B4.5090502@intel.com>
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<5A5704B4.5090502@intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 11 Jan 2018 09:56:55 +0000
Message-ID: <CAJSP0QWyaE8qUGMgcpzB460Y=kpX4VDfqFWm-CWmmX4X3nmRMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Jan 11, 2018 at 6:31 AM, Wei Wang <wei.w.wang@intel.com> wrote:
> On 01/11/2018 12:14 AM, Stefan Hajnoczi wrote:
>>
>> Hi Wei,
>> I wanted to summarize the differences between the vhost-pci and
>> virtio-vhost-user approaches because previous discussions may have been
>> confusing.
>>
>> vhost-pci defines a new virtio device type for each vhost device type
>> (net, scsi, blk).  It therefore requires a virtio device driver for each
>> device type inside the slave VM.
>>
>> Adding a new device type requires:
>> 1. Defining a new virtio device type in the VIRTIO specification.
>> 3. Implementing a new QEMU device model.
>> 2. Implementing a new virtio driver.
>>
>> virtio-vhost-user is a single virtio device that acts as a vhost-user
>> protocol transport for any vhost device type.  It requires one virtio
>> driver inside the slave VM and device types are implemented using
>> existing vhost-user slave libraries (librte_vhost in DPDK and
>> libvhost-user in QEMU).
>>
>> Adding a new device type to virtio-vhost-user involves:
>> 1. Adding any new vhost-user protocol messages to the QEMU
>>     virtio-vhost-user device model.
>> 2. Adding any new vhost-user protocol messages to the vhost-user slave
>>     library.
>> 3. Implementing the new device slave.
>>
>> The simplest case is when no new vhost-user protocol messages are
>> required for the new device.  Then all that's needed for
>> virtio-vhost-user is a device slave implementation (#3).  That slave
>> implementation will also work with AF_UNIX because the vhost-user slave
>> library hides the transport (AF_UNIX vs virtio-vhost-user).  Even
>> better, if another person has already implemented that device slave to
>> use with AF_UNIX then no new code is needed for virtio-vhost-user
>> support at all!
>>
>> If you compare this to vhost-pci, it would be necessary to design a new
>> virtio device, implement it in QEMU, and implement the virtio driver.
>> Much of virtio driver is more or less the same thing as the vhost-user
>> device slave but it cannot be reused because the vhost-user protocol
>> isn't being used by the virtio device.  The result is a lot of
>> duplication in DPDK and other codebases that implement vhost-user
>> slaves.
>>
>> The way that vhost-pci is designed means that anyone wishing to support
>> a new device type has to become a virtio device designer.  They need to
>> map vhost-user protocol concepts to a new virtio device type.  This will
>> be time-consuming for everyone involved (e.g. the developer, the VIRTIO
>> community, etc).
>>
>> The virtio-vhost-user approach stays at the vhost-user protocol level as
>> much as possible.  This way there are fewer concepts that need to be
>> mapped by people adding new device types.  As a result, it will allow
>> virtio-vhost-user to keep up with AF_UNIX vhost-user and grow because
>> it's easier to work with.
>>
>> What do you think?
>>
>
> Thanks Stefan for the clarification.
>
> I agree with idea of making one single device for all device types.

Great!

> Would
> you think it is also possible with vhost-pci? (Fundamentally, the duty of
> the device is to use a bar to expose the master guest memory, and passes the
> master vring address info and memory region info, which has no dependency on
> device types)

Yes, it's possible to have a single virtio device with vhost-pci but...

> If you agree with the above, I think the main difference is what to pass to
> the driver. I think vhost-pci is simpler because it only passes the above
> mentioned info, which is sufficient.

...the current vhost-pci patch series exposes a smaller interface to
the driver only because the code is incomplete.  Once you add fully
implement vhost-user-net, reconnection, and allow other device types,
then the vhost-pci interface will just be an extra layer on top of the
vhost-user protocol - it will not be simpler.  I'll explain why I say
this below.

> Relaying needs to
> 1) pass all the vhost-user messages to the driver, and

vhost-pci will need to pass at least some messages to the user.  For
example, VHOST_USER_SEND_RARP and VHOST_USER_NET_SET_MTU are needed
for vhost-user-net.  Once you add a mechanism to relay certain
messages then vhost-pci already starts to look more like
virtio-vhost-user.

> 2) requires the driver to join the vhost-user negotiation.

The driver must participate in vhost-user negotiation.  The vhost-pci
patches try to avoid this by taking features bits on the QEMU
command-line and hardcoding the number of supported virtqueues.  That
doesn't work in production environments because:
1. What if the driver inside the VM has been updated and now supports
different features?
2. What if the user isn't allowed to modify the VM configuration?
3. What if the management software doesn't expose the feature bits
command-line parameter?
4. What if the number of virtqueues must be different from QEMU's
default value to limit resource consumption?

Users will find it incovenient to manually enter feature bits for the
driver they are using.  The driver needs to be part of negotiation so
it can indicate which features are supported, how many virtqueues,
etc.

> Without above two, the solution already works well, so I'm not sure why would we need the above two from functionality point of view.

The "[PATCH v3 0/7] Vhost-pci for inter-VM communication" series is
incomplete.  It is a subset of vhost-user-net and it works only for
poll-mode drivers.  It's the requirements that haven't been covered by
the vhost-pci patch series yet that make me prefer the
virtio-vhost-user approach.

The virtio device design needs to be capable of supporting the rest of
vhost-user functionality in the future.  Once the code is merged in
QEMU and DPDK it will be very difficult to make changes to the virtio
device.

It's simpler to relay vhost-user protocol messages than to try to hide
them from the driver.  Mistakes will be made when designing a virtio
device interface that hides them.

vhost-pci also cannot share the slave driver code with AF_UNIX
vhost-user.  I don't see something that makes up for this
disadvantage.

> Finally, either we choose vhost-pci or virtio-vhost-user, future developers
> will need to study vhost-user protocol and virtio spec (one device). This
> wouldn't make much difference, right?

It's easier to read the spec than to change a virtio device.  The
virtio-vhost-user approach is focussed on the vhost-user protocol with
a straightforward mapping to virtio.  The vhost-pci approach tries to
consume virtio-protocol messages and provide a new virtio device
interface - this requires more knowledge of virtio device design.  The
difference is smaller now that we are in agreement that there should
only be one virtio device though.

Stefan
