Received: from eggs.gnu.org ([2001:4830:134:3::10]:52092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cH4oJ-0000S8-47
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:21:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cH4oE-0008Mg-04
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:21:10 -0500
References: <1473773430-19616-1-git-send-email-maxime.coquelin@redhat.com>
	<20161213212745.1976.91005@loki>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <a985d559-64aa-7690-1396-654e197989ff@redhat.com>
Date: Wed, 14 Dec 2016 09:20:58 +0100
MIME-Version: 1.0
In-Reply-To: <20161213212745.1976.91005@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v2] virtio-bus: Plug devices
 after features are negotiated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, mst@redhat.com, qemu-devel@nongnu.org
Cc: cornelia.huck@de.ibm.com, marcel@redhat.com, eblake@redhat.com, qemu-stable@nongnu.org, stefanha@redhat.com, dgilbert@redhat.com



On 12/13/2016 10:27 PM, Michael Roth wrote:
> Quoting Maxime Coquelin (2016-09-13 08:30:30)
>> > Currently, devices are plugged before features are negotiated.
>> > If the backend doesn't support VIRTIO_F_VERSION_1, the transport
>> > needs to rewind some settings.
>> >
>> > This is the case for CCW, for which a post_plugged callback had
>> > been introduced, where max_rev field is just updated if
>> > VIRTIO_F_VERSION_1 is not supported by the backend.
>> > For PCI, implementing post_plugged would be much more
>> > complicated, so it needs to know whether the backend supports
>> > VIRTIO_F_VERSION_1 at plug time.
>> >
>> > Currently, nothing is done for PCI. Modern capabilities get
>> > exposed to the guest even if VIRTIO_F_VERSION_1 is not supported
>> > by the backend, which confuses the guest.
>> >
>> > This patch replaces existing post_plugged solution with an
>> > approach that fits with both transports.
>> > Features negotiation is performed before ->device_plugged() call.
>> > A pre_plugged callback is introduced so that the transports can
>> > set their supported features.
>> >
>> > Cc: Michael S. Tsirkin <mst@redhat.com>
>> > Cc: qemu-stable@nongnu.org
>> > Tested-by: Cornelia Huck <cornelia.huck@de.ibm.com> [ccw]
>> > Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> > Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>> > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>
> It looks like this patch breaks migration under certain circumstances.
> One such scenario is migrating 2.7 -> 2.8.0-rc3 as detailed below on a
> host that doesn't have support for virtio-1 in vhost (which was
> introduced via 41e3e42 in kernel 3.18. In my case, I'm using Ubuntu
> 14.04, kernel 3.13):
>
>  source (2.7.0):
>
>    sudo build/v2.7.0/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -L
>    build/v2.7.0-bios -M pc-i440fx-2.7 -m 512M -drive
>    file=/home/mdroth/vm/win7_home_sp1_virtio_testing.qcow2,if=virtio -vga
>    cirrus -smp 4 -device virtio-net-pci,netdev=net0 -netdev
>    tap,id=net0,vhost=on,script=/etc/qemu-ifup -monitor
>    unix:/tmp/vm-hmp.sock,server,nowait -qmp
>    unix:/tmp/vm-qmp.sock,server,nowait -vnc :200
>
>  target (2.8.0-rc3):
>
>    sudo build/v2.8.0-rc3/x86_64-softmmu/qemu-system-x86_64 -enable-kvm
>    -L build/v2.8.0-rc3-bios -M pc-i440fx-2.7 -m 512M -drive
>    file=/home/mdroth/vm/win7_home_sp1_virtio_testing.qcow2,if=virtio -vga
>    cirrus -smp 4 -device virtio-net-pci,netdev=net0 -netdev
>    tap,id=net0,vhost=on,script=/etc/qemu-ifup -monitor
>    unix:/tmp/vm-hmp-incoming.sock,server,nowait -qmp
>    unix:/tmp/vm-qmp-incoming.sock,server,nowait -vnc :201
>    -incoming unix:/tmp/migrate.sock
>
>  error on target after migration:
>
>    qemu-system-x86_64: get_pci_config_device: Bad config data: i=0x34
>    read: 98 device: 40 cmask: ff wmask: 0 w1cmask:0
>    qemu-system-x86_64: Failed to load PCIDevice:config
>    qemu-system-x86_64: Failed to load virtio-net:virtio
>    qemu-system-x86_64: error while loading state for instance 0x0 of
>    device '0000:00:03.0/virtio-net'
>    qemu-system-x86_64: load of migration failed: Invalid argument
>
>
> Based on discussion on IRC (excerpts below), I think the new handling needs
> to be controllable via a machine option that can be disabled by default
> for older machine types. This is being considered a release blocker for
> 2.8 since there are still pre-3.18 LTS kernels in the wild.


First, thanks for reporting this bad regression with a detailed
analysis.

>
>
> root-cause:
>
> 14:35 < stefanha> v3.13 will not work
> 14:35 < stefanha>         VHOST_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
> 14:35 < stefanha>                          (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
> 14:35 < stefanha>                          (1ULL << VIRTIO_RING_F_EVENT_IDX) |
> 14:35 < stefanha>                          (1ULL << VHOST_F_LOG_ALL),
> 14:35 < stefanha> The kernel side only knows about these guys
> 14:35 < davidgiluk> our downstream 3.10.0-524 seems to work - but that's probably got all the vhost stuff backported
> 14:35 < stefanha> plus these guys:
> 14:35 < stefanha> F        VHOST_NET_FEATURES = VHOST_FEATURES |
> 14:35 < stefanha>                          (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> 14:35 < stefanha>                          (1ULL << VIRTIO_NET_F_MRG_RXBUF),
> 14:36 < stefanha> mdroth: So QEMU is going to check a list of feature bits including VERSION_1
> 14:36 < stefanha> and it will see that vhost doesn't support them.
> 14:36 < stefanha> So we're kind of doing the right thing now.
> 14:36 < stefanha> Before userspace was overriding the fact that vhost cannot handle VERSION_1.
> 14:36 < stefanha> ...except we broke migration
> 14:36 < davidgiluk> stefanha: But shouldn't it refuse to startup ?
> 14:36 < stefanha> Everything is perfect*
> 14:36 < stefanha> * except we broke migration
> 14:36 < stefanha> :)
>
> suggestions on how to fix this:
>
> 14:40 < stefanha> My understanding is this bug is vhost-specific.  If you have an old kernel that doesn't support VERSION_1 vhost then migration will break.
> 14:41 < stefanha> The actual bug is in QEMU though, not vhost
> 14:42 < stefanha> vhost is reporting the truth.  It's QEMU that has changed behavior.
> 14:44 < stefanha> mdroth: I think a lame fix would be to make virtio_pci_device_plugged() dependent on a flag that says: use old broken behavior instead of reporting the truth to the guest.
> 14:44 < stefanha> The flag could be enabled for all old machine types
> 14:44 < stefanha> and new machine types will report the truth.
> 14:44 < stefanha> That way migration continues to work.
Right.
The problem doing this however is that it would re-introduce initial
bug for old kernel on host and new kernel on guest.

Indeed, in recent Kernels, virtio-pci device probe fails if modern 
interface is exposed but VERSION_1 is not advertised.

> 14:44 < stefanha> Not sure if anyone can think of a nicer solution.
> 14:45 < stefanha> But we're going to have to keep lying to the guest if we want to preserve migration compatibility
> 14:45 < stefanha> The key change in behavior with the patch you identified is:
> 14:46 < stefanha> if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
> 14:46 < stefanha> virtio_pci_disable_modern(proxy);
> 14:46 < stefanha> Previously it didn't care about vdev->host_features.  It simply allowed VERSION_1 when proxy's disable_modern boolean was false.
> 14:47 < mdroth> stefanha: ok, that explains why it seems to work with disable-modern=true
> 14:48 < stefanha> mdroth: Your Ubuntu kernel old but 14.04 LTS is definitely still around so I don't think we can ship QEMU 2.8 like this.
> 14:49 < stefanha> mdroth: Let's summarize it on the mailing list and see what Michael Tsirkin and Maxime Coquelin think.
> 14:49 < mdroth> stefanha: i suppose a potential workaround would be to tell users to set disable-modern= to match their vhost capabilities, but it's hard for them to apply that retroactively if they're looking to migrate
> 14:49 < stefanha> We can delay the release in the meantime.
> 14:50 < stefanha> mdroth: I don't think a workaround is going to be smooth in this case
> 14:50 < stefanha> People will only notice once migration fails,
> 14:50 < stefanha> and that's when you lose your VM state!
>
>

Thanks,
Maxime
