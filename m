Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E2C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8382081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iimQPlfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8382081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40585 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLl5T-00081A-Ej
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 04:59:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLl4V-0007dy-Dl
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLl4S-0001vf-Ae
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:58:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hLl4L-0001qP-QS; Wed, 01 May 2019 04:58:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x418s7hB085578; Wed, 1 May 2019 08:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=A8YADu2rwKAWQLEiDUXG3KJGUE1l397TUlHOb3L6fLM=;
	b=iimQPlfPW3V3sgiaFtTDrqyKzZ1cdR13rNCQgWz2DbwZN0YzNz5ODveEx8mp62n15Ak2
	yIxAcovzdhpegxNg1qEWBcZtAuL2m/ISaNz7hSG5iCc67CvNyoLuFyZD0mWZw6R0mEUI
	dkq0Umh2WfXTv8Rd5WN1BY18mLKMUbitKznDSSAqxnqclFZQRRlIXwiy/4Oz3OlfSHN/
	8ZgbD68AEQdKM/4sGwWbkqU8Bd8MmdSFEoFV6K0NW9cidkW7XOSWP4yi3uCDTtLQXvz0
	4rUVIPexaAS8rZjYGKr37cNfTJyli9Ad7dh2x2Bu7uUN9C+tv5fNDNso1n6oPLoxHIYn
	Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 2s6xhy9kwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2019 08:58:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x418vFeb081647; Wed, 1 May 2019 08:58:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 2s6xhgedcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2019 08:58:20 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x418wAKN008357;
	Wed, 1 May 2019 08:58:12 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 01 May 2019 01:58:10 -0700
Date: Wed, 1 May 2019 11:58:06 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Boxuan Li <liboxuan@connect.hku.hk>
Message-ID: <20190501085805.GA8174@lap1>
References: <20190501081039.58938-1-liboxuan@connect.hku.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190501081039.58938-1-liboxuan@connect.hku.hk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905010060
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905010060
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: Re: [Qemu-devel] [PATCH v2] hw/virtio/virtio-mmio: Convert DPRINTF
 to traces
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
Cc: qemu-trivial@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501085806.hmRfRPacoXgkQsyYJEyiVEv3a5PJSa4CENwCQyaORbM@z>

On Wed, May 01, 2019 at 04:10:39PM +0800, Boxuan Li wrote:
> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
> v2: Instead of using conditional debugs, convert DPRINTF to traces
> ---
>  hw/virtio/trace-events  | 13 +++++++++++++
>  hw/virtio/virtio-mmio.c | 35 ++++++++++++-----------------------
>  2 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 60c649c4bc..37c781b487 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -46,3 +46,16 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
>  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
>  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
>  virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
> +
> +# virtio-mmio.c
> +virtio_mmio_read(int offset) "virtio_mmio_read offset 0x%x"
> +virtio_mmio_wrong_size_read(void) "wrong size access to register!"
> +virtio_mmio_read_interrupt(void) "read of write-only register"
> +virtio_mmio_bad_read_offset(void) "bad register offset"
> +virtio_mmio_write_offset(int offset, uint64_t value) "virtio_mmio_write offset 0x%x value 0x%" PRIx64
> +virtio_mmio_wrong_size_write(void) "wrong size access to register!"
> +virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 " shift %d"
> +virtio_mmio_queue_write(int value, int max_size) "mmio_queue write %d max %d"
> +virtio_mmio_write_interrupt(void) "write to readonly register"
> +virtio_mmio_bad_write_offset(void) "bad register offset"
> +virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 5807aa87fe..4251df399d 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -27,16 +27,7 @@
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
> +#include "trace.h"
>  
>  /* QOM macros */
>  /* virtio-mmio-bus */
> @@ -107,7 +98,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>      VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>  
> -    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
> +    trace_virtio_mmio_read((int)offset);
>  
>      if (!vdev) {
>          /* If no backend is present, we treat most registers as
> @@ -144,7 +135,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>          }
>      }
>      if (size != 4) {
> -        DPRINTF("wrong size access to register!\n");
> +        trace_virtio_mmio_wrong_size_read();

Have you considered using qemu_error_report to report such errors?

>          return 0;
>      }
>      switch (offset) {
> @@ -182,10 +173,10 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>      case VIRTIO_MMIO_QUEUE_ALIGN:
>      case VIRTIO_MMIO_QUEUE_NOTIFY:
>      case VIRTIO_MMIO_INTERRUPT_ACK:
> -        DPRINTF("read of write-only register\n");
> +        trace_virtio_mmio_read_interrupt();
>          return 0;
>      default:
> -        DPRINTF("bad register offset\n");
> +        trace_virtio_mmio_bad_read_offset();

Ditto to all other errors.

>          return 0;
>      }
>      return 0;
> @@ -197,8 +188,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>      VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>  
> -    DPRINTF("virtio_mmio_write offset 0x%x value 0x%" PRIx64 "\n",
> -            (int)offset, value);
> +    trace_virtio_mmio_write_offset((int)offset, value);
>  
>      if (!vdev) {
>          /* If no backend is present, we just make all registers
> @@ -226,7 +216,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          return;
>      }
>      if (size != 4) {
> -        DPRINTF("wrong size access to register!\n");
> +        trace_virtio_mmio_wrong_size_write();
>          return;
>      }
>      switch (offset) {
> @@ -246,8 +236,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          if (proxy->guest_page_shift > 31) {
>              proxy->guest_page_shift = 0;
>          }
> -        DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
> -                proxy->guest_page_shift);
> +        trace_virtio_mmio_guest_page(value, proxy->guest_page_shift);
>          break;
>      case VIRTIO_MMIO_QUEUE_SEL:
>          if (value < VIRTIO_QUEUE_MAX) {
> @@ -255,7 +244,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          }
>          break;
>      case VIRTIO_MMIO_QUEUE_NUM:
> -        DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
> +        trace_virtio_mmio_queue_write((int)value, VIRTQUEUE_MAX_SIZE);
>          virtio_queue_set_num(vdev, vdev->queue_sel, value);
>          /* Note: only call this function for legacy devices */
>          virtio_queue_update_rings(vdev, vdev->queue_sel);
> @@ -303,11 +292,11 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>      case VIRTIO_MMIO_DEVICE_FEATURES:
>      case VIRTIO_MMIO_QUEUE_NUM_MAX:
>      case VIRTIO_MMIO_INTERRUPT_STATUS:
> -        DPRINTF("write to readonly register\n");
> +        trace_virtio_mmio_write_interrupt();
>          break;
>  
>      default:
> -        DPRINTF("bad register offset\n");
> +        trace_virtio_mmio_bad_write_offset();
>      }
>  }
>  
> @@ -327,7 +316,7 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
>          return;
>      }
>      level = (atomic_read(&vdev->isr) != 0);
> -    DPRINTF("virtio_mmio setting IRQ %d\n", level);
> +    trace_virtio_mmio_setting_irq(level);
>      qemu_set_irq(proxy->irq, level);
>  }

I went through all code changes and found no mistakes but suggesting to
turn errors to errors and not just threat them as traces.

If you already considered it then fine.

>  
> -- 
> 2.13.2
> 
> 

