Received: from eggs.gnu.org ([2001:4830:134:3::10]:46540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <claudio.fontana@gliwa.com>) id 1g06t3-0004OZ-On
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 11:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <claudio.fontana@gliwa.com>) id 1g06t0-0004iw-Hg
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 11:17:01 -0400
Received: from s30320.gliwa.com ([148.251.52.238]:60180 helo=mail.gliwa.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <claudio.fontana@gliwa.com>)
	id 1g06sy-0004ba-EE
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 11:16:58 -0400
References: <905c68e0-531a-d915-4033-474bda42a643@gliwa.com>
	<20180912082250-mutt-send-email-mst@kernel.org>
From: Claudio <claudio.fontana@gliwa.com>
Message-ID: <fc7fca76-391a-4c03-32ca-d6f6c6b7a17a@gliwa.com>
Date: Wed, 12 Sep 2018 17:16:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180912082250-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] virtio-net sporadic error with QNX 7.0 guest:
 virtio-net ctrl missing headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, paolo bonzini <pbonzini@redhat.com>

Thank you both for your responses,

and ciao Paolo,

On 09/12/2018 02:37 PM, Michael S. Tsirkin wrote:
> On Wed, Sep 12, 2018 at 10:01:34AM +0200, Claudio wrote:
>> Hello Michael, Jason and all,
>>
>> I am currently using latest mainline QEMU on x86_64 to run a QNX 7 guest.
>>
>> QNX 7 is not free software anymore unfortunately, with the
>> the last open source versions in the 6.x range.
>>
>> I am using the official virtio-net guest driver from QNX 7.
>>
>> During initialization I sporadically get this error message:
>>
>> $ qemu-system-x86_64 -machine pc,accel=kvm,kernel_irqchip=on -smp 2 -m 2048 -display none -nodefconfig -nodefaults -chardev stdio,mux=on,id=char0 -serial chardev:char0 -monitor none -mon chardev=char0,mode=readline -netdev user,id=user0,hostfwd=udp::9004-:9004 -device virtio-net,netdev=user0 qnx.img
>>
>> virtio-net ctrl missing headers
> 
> This means a control buffer is sent either without the input element
> or without an output element, or with a single byte output element.
> 
>> and following that my host->guest UDP port forwarding does not work, that is,
>> the qemu process shows up as listening on the interface, but no packets appear in the guest.
>>
>> This error during initialization does not appear every time I launch QEMU.
>> It appears to be more or less random.
>>
>> Whenever the error does not appear, the interface works as expected, and port forwarding works.
>>
>> Latest commit is 
>>
>> 19b599f7664b ("Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2'")
>>
>> Thanks a lot for any advice!
>>
>> Ciao,
>>
>> Claudio
> 
> If it's easy to reproduce, you can try printing out all commands.
> E.g.:
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index f154756e85..34251273a9 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -987,6 +987,10 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>          if (!elem) {
>              break;
>          }
> +        fprintf(stderr, "%s: in %d/%d, out %d/%d\n",
> +                elem->in_num, iov_size(elem->in_sg, elem->in_num),
> +                elem->out_num, iov_size(elem->out_sg, elem->out_num));
> +
>          if (iov_size(elem->in_sg, elem->in_num) < sizeof(status) ||
>              iov_size(elem->out_sg, elem->out_num) < sizeof(ctrl)) {
>              virtio_error(vdev, "virtio-net ctrl missing headers");
> @@ -1014,6 +1018,9 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>          } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
>              status = virtio_net_handle_offloads(n, ctrl.cmd, iov, iov_cnt);
>          }
> +        fprintf(stderr, "%s: class 0x%x cmd 0x%x cnt %d status 0x%x\n",
> +                ctrl.class, ctrl.cmd, iov_cnt, status);
> +
>  
>          s = iov_from_buf(elem->in_sg, elem->in_num, 0, &status, sizeof(status));
>          assert(s == sizeof(status));
> 
> 
> You can also try replacing virtio_error with fprintf - that will
> avoid wedging the device on an error and let you proceed
> with debugging.
> 

I managed to automate the detection of the error, and it does appear to be a regression from my point of view.

I did a git bisect, and you can see the result and log as follows:

>From 4a3f03ba8dbf53fce36d0c1dd5d0cc0f340fe5f3 Mon Sep 17 00:00:00 2001                   
From: Paolo Bonzini <pbonzini@redhat.com>                                                
Date: Wed, 11 Jan 2017 09:38:15 +0100                                                    
Subject: [PATCH] virtio-net: enable ioeventfd even if vhost=off                          
                                                                                         
virtio-net-pci does not enable ioeventfd for historical reasons (and                     
nobody ever checked whether it should be revisited).  Note that other                    
backends do enable ioeventfd for virtio-net.                                             
                                                                                         
However, it has a major effect on performance.  On Windows, throughput is                
_multiplied_ by 2 or 3 on TCP_STREAM (on small packets it is "only" a 30%                
improvement) and a little less so on TCP_MAERTS albeit still very much                   
statistically significant.  Latency also has a single digit improvement.                 
                                                                                         
This is not visible when using vhost, which forces ioeventfd=on, but it                  
is substantial without vhost.  In addition, also on Windows and with the                 
RHEL 7.3 kernel, APICv seems to slow down virtio-net performance a bit,                  
but the penalty with this patch goes from -25% to -7%.                                   
                                                                                         
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>                                       
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>                                         
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>                                       
---
 hw/virtio/virtio-pci.c | 2 +-                                                           
 1 file changed, 1 insertion(+), 1 deletion(-)                                           
                                                                                         
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c                             
index 854b8f2..8baaf2b 100644                                                            
--- a/hw/virtio/virtio-pci.c                                                             
+++ b/hw/virtio/virtio-pci.c                                                             
@@ -2278,7 +2278,7 @@ static const TypeInfo virtio_serial_pci_info = {
                                                                                         
 static Property virtio_net_properties[] = {                                             
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,                                 
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, false),                          
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),                           
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),                         
     DEFINE_PROP_END_OF_LIST(),                                                          
 };                                                                                      
--                                                                                       
2.7.4



git bisect start
# good: [ec57db1630f9cdcd13c8c55acbc8daf5237aabf1] virtio-net: unbreak the minix guest
git bisect good ec57db1630f9cdcd13c8c55acbc8daf5237aabf1
# good: [ec57db1630f9cdcd13c8c55acbc8daf5237aabf1] virtio-net: unbreak the minix guest
git bisect good ec57db1630f9cdcd13c8c55acbc8daf5237aabf1
# good: [ec57db1630f9cdcd13c8c55acbc8daf5237aabf1] virtio-net: unbreak the minix guest
git bisect good ec57db1630f9cdcd13c8c55acbc8daf5237aabf1
# bad: [19b599f7664b2ebfd0f405fb79c14dd241557452] Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging
git bisect bad 19b599f7664b2ebfd0f405fb79c14dd241557452
# good: [c0f3f6754a120abc3451ebf7a7c703fbaf7b29e7] block: m25p80: 4byte address mode
git bisect good c0f3f6754a120abc3451ebf7a7c703fbaf7b29e7
# bad: [67b9c5d4f37ea373ebf9aad251883886e34bf2e1] Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging
git bisect bad 67b9c5d4f37ea373ebf9aad251883886e34bf2e1
# good: [6bbcb76301a72dc80c8d29af13d40bb9a759c9c6] MAINTAINERS: Remove obsolete stable branches
git bisect good 6bbcb76301a72dc80c8d29af13d40bb9a759c9c6
# bad: [ff79d5e939c38677a575e3493eb9b4d36eb21865] Merge remote-tracking branch 'remotes/xtensa/tags/20170306-xtensa' into staging
git bisect bad ff79d5e939c38677a575e3493eb9b4d36eb21865
# bad: [a0def594286d9110a6035e02eef558cf3cf5d847] Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging
git bisect bad a0def594286d9110a6035e02eef558cf3cf5d847
# good: [b6c08970bc989bfddcf830684ea7a96b7a4d62a7] Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2017-01-11-2' into staging
git bisect good b6c08970bc989bfddcf830684ea7a96b7a4d62a7
# good: [c5fc89b36c0a167548ae7af40dc085707a7756d2] hw/intc/arm_gicv3: Implement gicv3_cpuif_virt_update()
git bisect good c5fc89b36c0a167548ae7af40dc085707a7756d2
# bad: [009fad7f4ccbbf3ea115e9196edde88c0a17c1c2] migration: Change name of live migration thread
git bisect bad 009fad7f4ccbbf3ea115e9196edde88c0a17c1c2
# bad: [ebe9383caefd56d519e965a5d87bca29f0aeffe3] target-hppa: Implement floating-point insns
git bisect bad ebe9383caefd56d519e965a5d87bca29f0aeffe3
# bad: [db655a9653af05aaa90f41e55433d41e398d4b75] Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging
git bisect bad db655a9653af05aaa90f41e55433d41e398d4b75
# bad: [2943b53f682f54548e7ddcf2ebb6c6d12d8dc821] virtio: force VIRTIO_F_IOMMU_PLATFORM
git bisect bad 2943b53f682f54548e7ddcf2ebb6c6d12d8dc821
# bad: [a5b3ebfd23bc70fa68461dff1d7145ff65e07150] fw-cfg: bump "x-file-slots" to 0x20 for 2.9+ machine types
git bisect bad a5b3ebfd23bc70fa68461dff1d7145ff65e07150
# bad: [c471ad0e9bd46ca5f5c9c796e727230e043a091d] vhost_net: device IOTLB support
git bisect bad c471ad0e9bd46ca5f5c9c796e727230e043a091d
# bad: [332fa82d0963409fa14997a02639289afa226596] Revert "virtio: turn vq->notification into a nested counter"
git bisect bad 332fa82d0963409fa14997a02639289afa226596
# bad: [4a3f03ba8dbf53fce36d0c1dd5d0cc0f340fe5f3] virtio-net: enable ioeventfd even if vhost=off
git bisect bad 4a3f03ba8dbf53fce36d0c1dd5d0cc0f340fe5f3
# first bad commit: [4a3f03ba8dbf53fce36d0c1dd5d0cc0f340fe5f3] virtio-net: enable ioeventfd even if vhost=off


I reverted the commit on master, and this solves the problem for me.

Ciao,

Claudio
