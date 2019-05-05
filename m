Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449CEC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 10:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8E7208C0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 10:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IuWm92dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8E7208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39437 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNEqc-0006Fv-B8
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 06:58:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNEpk-0005uj-S2
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNEpj-00036b-BY
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:57:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:32784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hNEpf-00034j-K4; Sun, 05 May 2019 06:57:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x45Asieu139170; Sun, 5 May 2019 10:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=0bWTbKfABVAr5N+twtd1oJ1+vchJ3rkejxd1DkXvgfY=;
	b=IuWm92dOqIfXBwYGX73NbPHlzaCbyG2oTmL5uAbOP8io0kYEVwU0zofn+GrfXmO/Dkbs
	WK7wZS66c+Y7JzY2TeLjNhBJuzlKErT8CqNF54DQdPLckvutHt6Tn61vz02ulklo2OZB
	kNnCOmLTT9MkUzVRhSIIN7Xjr2Ng8YO3XimdN1P2yxG+nvoLJ6BuHl8RBDwH069zLLUa
	KIAn7dhvXQm191eEjPk1kUtx3llwyHCDFj9T1u/q0bU7AlFf9aZhpXuoKsKltJ90SvFc
	GBUQtHDmDvOp/RycgdJde0lUz8tKgDmAyWyCsAUBz5WYA2ck7ZwudvkMfmDJ7dO8IReL
	kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 2s94b5jnxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2019 10:57:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x45Au2Ww144710; Sun, 5 May 2019 10:57:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2s94aqt8ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2019 10:57:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x45AvAX3017611;
	Sun, 5 May 2019 10:57:10 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 05 May 2019 10:57:10 +0000
Date: Sun, 5 May 2019 13:57:04 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Boxuan Li <liboxuan@connect.hku.hk>
Message-ID: <20190505105703.GA9490@lap1>
References: <20190503154424.73933-1-liboxuan@connect.hku.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190503154424.73933-1-liboxuan@connect.hku.hk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9247
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905050099
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9247
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905050099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: Re: [Qemu-devel] [PATCH v4] hw/virtio/virtio-mmio: Convert DPRINTF
 to trace and log
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505105704.veXCpVoQmCBpIemDKUUqmXl-GvKBTDofC0Amxvf50y8@z>

On Fri, May 03, 2019 at 11:44:24PM +0800, Boxuan Li wrote:
> Use traces for debug message and qemu_log_mask for errors.
> 
> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
> v1: https://patchew.org/QEMU/20190428110258.86681-1-liboxuan@connect.hku.hk/
> v2: https://patchew.org/QEMU/20190501081039.58938-1-liboxuan@connect.hku.hk/
> v3: https://patchew.org/QEMU/20190503084654.18413-1-liboxuan@connect.hku.hk/
> v4: Fix indentation and do not convert uint64_t to int
> ---
>  hw/virtio/trace-events  |  7 +++++++
>  hw/virtio/virtio-mmio.c | 44 +++++++++++++++++++++-----------------------
>  2 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 60c649c4bc..e28ba48da6 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -46,3 +46,10 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
>  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
>  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
>  virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
> +
> +# virtio-mmio.c
> +virtio_mmio_read(uint64_t offset) "virtio_mmio_read offset 0x%" PRIx64
> +virtio_mmio_write_offset(uint64_t offset, uint64_t value) "virtio_mmio_write offset 0x%" PRIx64 " value 0x%" PRIx64
> +virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 " shift %d"
> +virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue write 0x%" PRIx64 " max %d"
> +virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 5807aa87fe..96c762f0bf 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -27,16 +27,8 @@
>  #include "sysemu/kvm.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "qemu/error-report.h"
> -
> -/* #define DEBUG_VIRTIO_MMIO */
> -
> -#ifdef DEBUG_VIRTIO_MMIO
> -
> -#define DPRINTF(fmt, ...) \
> -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while (0)
> -#endif
> +#include "qemu/log.h"
> +#include "trace.h"
>  
>  /* QOM macros */
>  /* virtio-mmio-bus */
> @@ -107,7 +99,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>      VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>  
> -    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
> +    trace_virtio_mmio_read(offset);
>  
>      if (!vdev) {
>          /* If no backend is present, we treat most registers as
> @@ -144,7 +136,9 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>          }
>      }
>      if (size != 4) {
> -        DPRINTF("wrong size access to register!\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: wrong size access to register!\n",
> +                      __func__);
>          return 0;
>      }
>      switch (offset) {
> @@ -182,10 +176,12 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>      case VIRTIO_MMIO_QUEUE_ALIGN:
>      case VIRTIO_MMIO_QUEUE_NOTIFY:
>      case VIRTIO_MMIO_INTERRUPT_ACK:
> -        DPRINTF("read of write-only register\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: read of write-only register\n",
> +                      __func__);
>          return 0;
>      default:
> -        DPRINTF("bad register offset\n");
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
>          return 0;
>      }
>      return 0;
> @@ -197,8 +193,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>      VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>  
> -    DPRINTF("virtio_mmio_write offset 0x%x value 0x%" PRIx64 "\n",
> -            (int)offset, value);
> +    trace_virtio_mmio_write_offset(offset, value);
>  
>      if (!vdev) {
>          /* If no backend is present, we just make all registers
> @@ -226,7 +221,9 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          return;
>      }
>      if (size != 4) {
> -        DPRINTF("wrong size access to register!\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: wrong size access to register!\n",
> +                      __func__);
>          return;
>      }
>      switch (offset) {
> @@ -246,8 +243,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          if (proxy->guest_page_shift > 31) {
>              proxy->guest_page_shift = 0;
>          }
> -        DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
> -                proxy->guest_page_shift);
> +        trace_virtio_mmio_guest_page(value, proxy->guest_page_shift);
>          break;
>      case VIRTIO_MMIO_QUEUE_SEL:
>          if (value < VIRTIO_QUEUE_MAX) {
> @@ -255,7 +251,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          }
>          break;
>      case VIRTIO_MMIO_QUEUE_NUM:
> -        DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
> +        trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
>          virtio_queue_set_num(vdev, vdev->queue_sel, value);
>          /* Note: only call this function for legacy devices */
>          virtio_queue_update_rings(vdev, vdev->queue_sel);
> @@ -303,11 +299,13 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>      case VIRTIO_MMIO_DEVICE_FEATURES:
>      case VIRTIO_MMIO_QUEUE_NUM_MAX:
>      case VIRTIO_MMIO_INTERRUPT_STATUS:
> -        DPRINTF("write to readonly register\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: write to readonly register\n",
> +                      __func__);
>          break;
>  
>      default:
> -        DPRINTF("bad register offset\n");
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
>      }
>  }
>  
> @@ -327,7 +325,7 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
>          return;
>      }
>      level = (atomic_read(&vdev->isr) != 0);
> -    DPRINTF("virtio_mmio setting IRQ %d\n", level);
> +    trace_virtio_mmio_setting_irq(level);
>      qemu_set_irq(proxy->irq, level);
>  }

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

>  
> -- 
> 2.13.2
> 

