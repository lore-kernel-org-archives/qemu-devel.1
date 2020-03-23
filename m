Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347FDC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A292072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxZ6KXJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A292072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMlk-000433-25
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jGMl0-0003Jz-Bs
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jGMkz-0002Fr-1Q
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:04:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42175)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jGMky-0002Fa-Tz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584968680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4Murym63psX6+meV4lKlRgPFKJCk2F10k6WzTNwuxg=;
 b=ZxZ6KXJmrhdYZGb+M6FwSIMOW8QXJWYjDGPQJNarCcX2HKPhFR973ZIYYwkg09MBT7WwTV
 uiTeo9B5l75rKz9hU/vtiTpwb+PIWLl8R+xmEOuJVFVRJe1/6Mq6Hq5D8kRq7xVX617ats
 +ppMcwsCj0R2h3ewMUBPe754QlBY7aw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-p2lY1WNCM5quTXMe0tST5A-1; Mon, 23 Mar 2020 09:04:36 -0400
X-MC-Unique: p2lY1WNCM5quTXMe0tST5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF96B107ACC4;
 Mon, 23 Mar 2020 13:04:34 +0000 (UTC)
Received: from localhost (unknown [10.40.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A460A5E242;
 Mon, 23 Mar 2020 13:04:00 +0000 (UTC)
Date: Mon, 23 Mar 2020 14:03:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 03/10] exec: Fix for qemu_ram_resize() callback
Message-ID: <20200323140358.76d534f4@redhat.com>
In-Reply-To: <20200311172014.33052-4-shameerali.kolothum.thodi@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
 <20200311172014.33052-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, david@redhat.com,
 shannon.zhaosl@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 17:20:07 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: David Hildenbrand <david@redhat.com>
> 
> Summarizing the issue:
> 1. Memory regions contain ram blocks with a different size,  if the
>    size is  not properly aligned. While memory regions can have an
>    unaligned size, ram blocks can't. This is true when creating
>    resizable memory region with  an unaligned size.
> 2. When resizing a ram block/memory region, the size of the memory
>    region  is set to the aligned size. The callback is called with
>    the aligned size. The unaligned piece is lost.
> 
> Because of the above, if ACPI blob length modifications happens
> after the initial virt_acpi_build() call, and the changed blob
> length is within the PAGE size boundary, then the revised size
> is not seen by the firmware on Guest reboot.
> 
> Hence make sure callback is called if memory region size is changed,
> irrespective of aligned or not.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> [Shameer: added commit log]
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Please find the discussion here,
> https://patchwork.kernel.org/patch/11339591/
> ---
>  exec.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 0cc500d53a..f8974cd303 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2073,11 +2073,21 @@ static int memory_try_enable_merging(void *addr, size_t len)
>   */
>  int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>  {
> +    const ram_addr_t unaligned_size = newsize;
> +
>      assert(block);
>  
>      newsize = HOST_PAGE_ALIGN(newsize);
>  
>      if (block->used_length == newsize) {
> +        /*
> +         * We don't have to resize the ram block (which only knows aligned
> +         * sizes), however, we have to notify if the unaligned size changed.
> +         */
> +        if (block->resized && unaligned_size != memory_region_size(block->mr)) {
> +            block->resized(block->idstr, unaligned_size, block->host);
> +            memory_region_set_size(block->mr, unaligned_size);
> +        }
>          return 0;
>      }
>  
> @@ -2101,9 +2111,9 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>      block->used_length = newsize;
>      cpu_physical_memory_set_dirty_range(block->offset, block->used_length,
>                                          DIRTY_CLIENTS_ALL);
> -    memory_region_set_size(block->mr, newsize);
> +    memory_region_set_size(block->mr, unaligned_size);
>      if (block->resized) {
> -        block->resized(block->idstr, newsize, block->host);
> +        block->resized(block->idstr, unaligned_size, block->host);
>      }
>      return 0;
>  }


