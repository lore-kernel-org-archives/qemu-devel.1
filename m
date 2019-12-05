Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4786AC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 06:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7112224F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 06:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="nKCS4PGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7112224F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ickGW-0000KL-20
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 01:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ickFj-0008M1-6q
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 01:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ickFf-0006PH-Kg
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 01:04:37 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:44007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ickFf-0006Jo-0U
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 01:04:35 -0500
Received: by mail-pj1-x1044.google.com with SMTP id g4so825261pjs.10
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 22:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MIfPe4utOfKL41cHBgGL0r0vu0Ig53efVJFzmm2tN+s=;
 b=nKCS4PGMrpykaUg4xBNnEjGZXBX/GopxYAFNbBKZ9kLpOe7W9nQ3J6N/WA1q9mukmy
 MrKM7QrO8f2YEKX9+IdCNPGhGcuJk7AVsMiWXYFGP63EbB4H6B6t03OG5VVM/+TWR97J
 Dr11+gTkkVUgqiUW8Xd7FVJB/MPEUdn7LYww+bgOgF7BjpZ18OnmH4xvEnPSGKmoviuy
 Ifbrgzk5kBDKZZnaQRDeh3pbP1/YxYP2dn+Ju2klqSmz/rt/N+dSnUS+JII9YtgrmsQj
 2xD4sxOXxlQ0r3MRIM1A1SSgf6zEmd4pU6K/C8NyMu4hE/52j/qjzFlFCcFAnkNpsE6z
 6+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MIfPe4utOfKL41cHBgGL0r0vu0Ig53efVJFzmm2tN+s=;
 b=t+8crhsbYfNO6WRZOIusu+GQQGBO8nU+kpqVSCxcceHRda+E78mlUgakaPUR35nDLB
 Mo118x/dtlkJtZ58tmWikY+tf1xdPPHzGBrKsZmtjlLCG1+7Z63uWrp7mr++mUgTrmV8
 7YdMUaI1FJDXquGg+rxy5oCNKXNG7fLrEHZiYKT+AvBjoO1zma7LJGppR3eLPIWhtBwB
 8ORuJwDQmPN85SNrXap7LXNPGqeCX55XXZsXx5WPuu4CVG00heOK0Aczy4qmks9Z/Uz8
 1TLAd/MyrvBpIuGNR1/1wCYgYUPQ1A9O/PGpi9MzcZp5ymIjcyCNeBUt6JPHwoOmaS3n
 JCGQ==
X-Gm-Message-State: APjAAAW1vc3UIt3IqI6FmQC9BLkj5qScKRIov6vsL7tf4cKY1l84hXci
 clzK1cqbNDxD4TjCdRLu7UVsNw==
X-Google-Smtp-Source: APXvYqylM5ECx6onrs7QfKsuPLjmWiTGVoFPUwg4lg1fv7rvWd8uL/s9vGQ+xBRob2OmQeSQ0ezCdA==
X-Received: by 2002:a17:902:8306:: with SMTP id
 bd6mr7400314plb.303.1575525872947; 
 Wed, 04 Dec 2019 22:04:32 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b16sm9794427pfo.64.2019.12.04.22.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 22:04:32 -0800 (PST)
Subject: Re: [PATCH v2] virtio-pci: disable vring processing when
 bus-mastering is disabled
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20191120005003.27035-1-mdroth@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <1e40e7a5-2e94-9fab-ffc5-befd1b72021d@ozlabs.ru>
Date: Thu, 5 Dec 2019 17:04:28 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120005003.27035-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I was wondering if this is going anywhere or if SLOF is still expected
to get fixed and if it is SLOF, then what exactly in SLOF's behaviour is
incorrect and requires fixing? I am a bit lost here. Thanks,




On 20/11/2019 11:50, Michael Roth wrote:
> Currently the SLOF firmware for pseries guests will disable/re-enable
> a PCI device multiple times via IO/MEM/MASTER bits of PCI_COMMAND
> register after the initial probe/feature negotiation, as it tends to
> work with a single device at a time at various stages like probing
> and running block/network bootloaders without doing a full reset
> in-between.
> 
> In QEMU, when PCI_COMMAND_MASTER is disabled we disable the
> corresponding IOMMU memory region, so DMA accesses (including to vring
> fields like idx/flags) will no longer undergo the necessary
> translation. Normally we wouldn't expect this to happen since it would
> be misbehavior on the driver side to continue driving DMA requests.
> 
> However, in the case of pseries, with iommu_platform=on, we trigger the
> following sequence when tearing down the virtio-blk dataplane ioeventfd
> in response to the guest unsetting PCI_COMMAND_MASTER:
> 
>   #2  0x0000555555922651 in virtqueue_map_desc (vdev=vdev@entry=0x555556dbcfb0, p_num_sg=p_num_sg@entry=0x7fffe657e1a8, addr=addr@entry=0x7fffe657e240, iov=iov@entry=0x7fffe6580240, max_num_sg=max_num_sg@entry=1024, is_write=is_write@entry=false, pa=0, sz=0)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:757
>   #3  0x0000555555922a89 in virtqueue_pop (vq=vq@entry=0x555556dc8660, sz=sz@entry=184)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:950
>   #4  0x00005555558d3eca in virtio_blk_get_request (vq=0x555556dc8660, s=0x555556dbcfb0)
>       at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:255
>   #5  0x00005555558d3eca in virtio_blk_handle_vq (s=0x555556dbcfb0, vq=0x555556dc8660)
>       at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:776
>   #6  0x000055555591dd66 in virtio_queue_notify_aio_vq (vq=vq@entry=0x555556dc8660)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1550
>   #7  0x000055555591ecef in virtio_queue_notify_aio_vq (vq=0x555556dc8660)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1546
>   #8  0x000055555591ecef in virtio_queue_host_notifier_aio_poll (opaque=0x555556dc86c8)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:2527
>   #9  0x0000555555d02164 in run_poll_handlers_once (ctx=ctx@entry=0x55555688bfc0, timeout=timeout@entry=0x7fffe65844a8)
>       at /home/mdroth/w/qemu.git/util/aio-posix.c:520
>   #10 0x0000555555d02d1b in try_poll_mode (timeout=0x7fffe65844a8, ctx=0x55555688bfc0)
>       at /home/mdroth/w/qemu.git/util/aio-posix.c:607
>   #11 0x0000555555d02d1b in aio_poll (ctx=ctx@entry=0x55555688bfc0, blocking=blocking@entry=true)
>       at /home/mdroth/w/qemu.git/util/aio-posix.c:639
>   #12 0x0000555555d0004d in aio_wait_bh_oneshot (ctx=0x55555688bfc0, cb=cb@entry=0x5555558d5130 <virtio_blk_data_plane_stop_bh>, opaque=opaque@entry=0x555556de86f0)
>       at /home/mdroth/w/qemu.git/util/aio-wait.c:71
>   #13 0x00005555558d59bf in virtio_blk_data_plane_stop (vdev=<optimized out>)
>       at /home/mdroth/w/qemu.git/hw/block/dataplane/virtio-blk.c:288
>   #14 0x0000555555b906a1 in virtio_bus_stop_ioeventfd (bus=bus@entry=0x555556dbcf38)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:245
>   #15 0x0000555555b90dbb in virtio_bus_stop_ioeventfd (bus=bus@entry=0x555556dbcf38)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:237
>   #16 0x0000555555b92a8e in virtio_pci_stop_ioeventfd (proxy=0x555556db4e40)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:292
>   #17 0x0000555555b92a8e in virtio_write_config (pci_dev=0x555556db4e40, address=<optimized out>, val=1048832, len=<optimized out>)
>       at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:613
> 
> I.e. the calling code is only scheduling a one-shot BH for
> virtio_blk_data_plane_stop_bh, but somehow we end up trying to process
> an additional virtqueue entry before we get there. This is likely due
> to the following check in virtio_queue_host_notifier_aio_poll:
> 
>   static bool virtio_queue_host_notifier_aio_poll(void *opaque)
>   {
>       EventNotifier *n = opaque;
>       VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
>       bool progress;
> 
>       if (!vq->vring.desc || virtio_queue_empty(vq)) {
>           return false;
>       }
> 
>       progress = virtio_queue_notify_aio_vq(vq);
> 
> namely the call to virtio_queue_empty(). In this case, since no new
> requests have actually been issued, shadow_avail_idx == last_avail_idx,
> so we actually try to access the vring via vring_avail_idx() to get
> the latest non-shadowed idx:
> 
>   int virtio_queue_empty(VirtQueue *vq)
>   {
>       bool empty;
>       ...
> 
>       if (vq->shadow_avail_idx != vq->last_avail_idx) {
>           return 0;
>       }
> 
>       rcu_read_lock();
>       empty = vring_avail_idx(vq) == vq->last_avail_idx;
>       rcu_read_unlock();
>       return empty;
> 
> but since the IOMMU region has been disabled we get a bogus value (0
> usually), which causes virtio_queue_empty() to falsely report that
> there are entries to be processed, which causes errors such as:
> 
>   "virtio: zero sized buffers are not allowed"
> 
> or
> 
>   "virtio-blk missing headers"
> 
> and puts the device in an error state.
> 
> This patch works around the issue by introducing virtio_set_disabled(),
> which sets a 'disabled' flag to bypass checks like virtio_queue_empty()
> when bus-mastering is disabled. Since we'd check this flag at all the
> same sites as vdev->broken, we replace those checks with an inline
> function which checks for either vdev->broken or vdev->disabled.
> 
> The 'disabled' flag is only migrated when set, which should be fairly
> rare, but to maintain migration compatibility we disable it's use for
> older machine types. Users requiring the use of the flag in conjunction
> with older machine types can set it explicitly as a virtio-device
> option.
> 
> NOTES:
> 
>  - This leaves some other oddities in play, like the fact that
>    DRIVER_OK also gets unset in response to bus-mastering being
>    disabled, but not restored (however the device seems to continue
>    working)
>  - Similarly, we disable the host notifier via
>    virtio_bus_stop_ioeventfd(), which seems to move the handling out
>    of virtio-blk dataplane and back into the main IO thread, and it
>    ends up staying there till a reset (but otherwise continues working
>    normally)
> 
> Cc: David Gibson <david@gibson.dropbear.id.au>,
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
> v2:
>  - add migration support and only default to using 'disabled' flag
>    for newer machines via virtio-device compat option (MST)
>  - use inline functions to decouple checks from specific fields (MST)
>  - rebased on master
> ---
>  hw/core/machine.c          |  1 +
>  hw/virtio/virtio-pci.c     | 12 ++++++++----
>  hw/virtio/virtio.c         | 35 ++++++++++++++++++++++++++++-------
>  include/hw/virtio/virtio.h | 15 +++++++++++++++
>  4 files changed, 52 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1689ad3bf8..9f3073b23b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -29,6 +29,7 @@
>  
>  GlobalProperty hw_compat_4_1[] = {
>      { "virtio-pci", "x-pcie-flr-init", "off" },
> +    { "virtio-device", "use-disabled-flag", "false" },
>  };
>  const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
>  
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c6b47a9c73..394d409fb9 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -608,10 +608,14 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
>          pcie_cap_flr_write_config(pci_dev, address, val, len);
>      }
>  
> -    if (range_covers_byte(address, len, PCI_COMMAND) &&
> -        !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> -        virtio_pci_stop_ioeventfd(proxy);
> -        virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DRIVER_OK);
> +    if (range_covers_byte(address, len, PCI_COMMAND)) {
> +        if (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> +            virtio_set_disabled(vdev, true);
> +            virtio_pci_stop_ioeventfd(proxy);
> +            virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DRIVER_OK);
> +        } else {
> +            virtio_set_disabled(vdev, false);
> +        }
>      }
>  
>      if (proxy->config_cap &&
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 04716b5f6c..3cb603a466 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -546,7 +546,7 @@ static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
>   * Called within rcu_read_lock().  */
>  static int virtio_queue_empty_rcu(VirtQueue *vq)
>  {
> -    if (unlikely(vq->vdev->broken)) {
> +    if (virtio_device_disabled(vq->vdev)) {
>          return 1;
>      }
>  
> @@ -565,7 +565,7 @@ static int virtio_queue_split_empty(VirtQueue *vq)
>  {
>      bool empty;
>  
> -    if (unlikely(vq->vdev->broken)) {
> +    if (virtio_device_disabled(vq->vdev)) {
>          return 1;
>      }
>  
> @@ -783,7 +783,7 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
>  
>      virtqueue_unmap_sg(vq, elem, len);
>  
> -    if (unlikely(vq->vdev->broken)) {
> +    if (virtio_device_disabled(vq->vdev)) {
>          return;
>      }
>  
> @@ -839,7 +839,7 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
>  
>  void virtqueue_flush(VirtQueue *vq, unsigned int count)
>  {
> -    if (unlikely(vq->vdev->broken)) {
> +    if (virtio_device_disabled(vq->vdev)) {
>          vq->inuse -= count;
>          return;
>      }
> @@ -1602,7 +1602,7 @@ err_undo_map:
>  
>  void *virtqueue_pop(VirtQueue *vq, size_t sz)
>  {
> -    if (unlikely(vq->vdev->broken)) {
> +    if (virtio_device_disabled(vq->vdev)) {
>          return NULL;
>      }
>  
> @@ -1698,7 +1698,7 @@ unsigned int virtqueue_drop_all(VirtQueue *vq)
>  {
>      struct VirtIODevice *vdev = vq->vdev;
>  
> -    if (unlikely(vdev->broken)) {
> +    if (virtio_device_disabled(vq->vdev)) {
>          return 0;
>      }
>  
> @@ -1816,7 +1816,7 @@ static void virtio_notify_vector(VirtIODevice *vdev, uint16_t vector)
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>  
> -    if (unlikely(vdev->broken)) {
> +    if (virtio_device_disabled(vdev)) {
>          return;
>      }
>  
> @@ -1920,6 +1920,7 @@ void virtio_reset(void *opaque)
>      vdev->guest_features = 0;
>      vdev->queue_sel = 0;
>      vdev->status = 0;
> +    vdev->disabled = false;
>      atomic_set(&vdev->isr, 0);
>      vdev->config_vector = VIRTIO_NO_VECTOR;
>      virtio_notify_vector(vdev, vdev->config_vector);
> @@ -2553,6 +2554,13 @@ static bool virtio_started_needed(void *opaque)
>      return vdev->started;
>  }
>  
> +static bool virtio_disabled_needed(void *opaque)
> +{
> +    VirtIODevice *vdev = opaque;
> +
> +    return vdev->disabled;
> +}
> +
>  static const VMStateDescription vmstate_virtqueue = {
>      .name = "virtqueue_state",
>      .version_id = 1,
> @@ -2718,6 +2726,17 @@ static const VMStateDescription vmstate_virtio_started = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_virtio_disabled = {
> +    .name = "virtio/disabled",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = &virtio_disabled_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BOOL(disabled, VirtIODevice),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_virtio = {
>      .name = "virtio",
>      .version_id = 1,
> @@ -2735,6 +2754,7 @@ static const VMStateDescription vmstate_virtio = {
>          &vmstate_virtio_extra_state,
>          &vmstate_virtio_started,
>          &vmstate_virtio_packed_virtqueues,
> +        &vmstate_virtio_disabled,
>          NULL
>      }
>  };
> @@ -3569,6 +3589,7 @@ static void virtio_device_instance_finalize(Object *obj)
>  static Property virtio_properties[] = {
>      DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
>      DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
> +    DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c32a815303..f23d2efbc0 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -100,6 +100,8 @@ struct VirtIODevice
>      uint16_t device_id;
>      bool vm_running;
>      bool broken; /* device in invalid state, needs reset */
> +    bool use_disabled_flag; /* allow use of 'disable' flag when needed */
> +    bool disabled; /* device in temporarily disabled state */
>      bool use_started;
>      bool started;
>      bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
> @@ -378,4 +380,17 @@ static inline void virtio_set_started(VirtIODevice *vdev, bool started)
>          vdev->started = started;
>      }
>  }
> +
> +static inline void virtio_set_disabled(VirtIODevice *vdev, bool disable)
> +{
> +    if (vdev->use_disabled_flag) {
> +        vdev->disabled = disable;
> +    }
> +}
> +
> +static inline bool virtio_device_disabled(VirtIODevice *vdev)
> +{
> +    return unlikely(vdev->disabled || vdev->broken);
> +}
> +
>  #endif
> 

-- 
Alexey

