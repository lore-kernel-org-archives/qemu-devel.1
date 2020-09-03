Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2B0C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C40206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PNKF6IBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C40206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkuS-0006jk-T3
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDkto-0005tw-N8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:47:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDktm-0003eW-AC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:47:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838iCgn073799;
 Thu, 3 Sep 2020 08:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=ZjFQegTuHzqJNp1RDUFN8PCna+i5Fxj5tpM8K1aY/rM=;
 b=PNKF6IBJHWQuZCEvnv9PNm54WPiLYixeFUwU9cgHk6O2WHDqmmxZn2sFx10LbVxRxTU7
 x7qitgui//n2owgx/zEloo6V92X+Hq3w5LlXJ8erDdCIcZfmqSua1kHdSH06dzfAOjzV
 +ztYjMLdFxVnc2P9ZvqrjFZYQvVOajcGux9vhYQiKjCs0SrYrzskJi0YCyYLwKC5SLkg
 fdepXDCXHbRr+2xuoglT/1F3AlC+BRnK7pFV+pBWL1DHWf8EszjVpQ997BJ8brn8puuO
 EOU4ssiH3xBuldXmZO35/wKC6JXQa0BYD2z8TslLtYoS8umJdu2i150FIf0PpDz+3Zmn sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 337eymfcrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 08:47:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838j87B025603;
 Thu, 3 Sep 2020 08:45:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 3380svq3px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 08:45:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0838j08c024552;
 Thu, 3 Sep 2020 08:45:00 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 01:45:00 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 0AF7C134F00D; Thu,  3 Sep 2020 09:44:58 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 05/15] fuzz: Declare DMA Read callback function
In-Reply-To: <20200819061110.1320568-6-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-6-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 09:44:58 +0100
Message-ID: <m2y2lrs0z9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030080
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:47:13
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-19 at 02:11:00 -04, Alexander Bulekov wrote:
> This patch declares the fuzz_dma_read_cb function and uses the
> preprocessor and linker(weak symbols) to handle these cases:
>
> When we build softmmu/all with --enable-fuzzing, there should be no
> strong symbol defined for fuzz_dma_read_cb, and we link against a weak
> stub function.
>
> When we build softmmu/fuzz with --enable-fuzzing, we link agains the

TYPO: s/agains/against/

> strong symbol in general_fuzz.c
>
> When we build softmmu/all without --enable-fuzzing, fuzz_dma_read_cb is
> an empty, inlined function. As long as we don't call any other functions
> when building the arguments, there should be no overhead.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  include/exec/memory.h | 15 +++++++++++++++
>  softmmu/memory.c      | 13 +++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 307e527835..2ec3b597f1 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -47,6 +47,21 @@
>          OBJECT_GET_CLASS(IOMMUMemoryRegionClass, (obj), \
>                           TYPE_IOMMU_MEMORY_REGION)
>  
> +#ifdef CONFIG_FUZZ
> +void fuzz_dma_read_cb(size_t addr,
> +                      size_t len,
> +                      MemoryRegion *mr,
> +                      bool is_write);
> +#else
> +static inline void fuzz_dma_read_cb(size_t addr,
> +                                    size_t len,
> +                                    MemoryRegion *mr,
> +                                    bool is_write)
> +{
> +    /* Do Nothing */
> +}
> +#endif
> +
>  extern bool global_dirty_log;
>  
>  typedef struct MemoryRegionOps MemoryRegionOps;
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index af25987518..b0c2cf2535 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -3223,6 +3223,19 @@ void memory_region_init_rom_device(MemoryRegion *mr,
>      vmstate_register_ram(mr, owner_dev);
>  }
>  
> +/*
> + * Support softmmu builds with CONFIG_FUZZ using a weak symbol and a stub for
> + * the fuzz_dma_read_cb callback
> + */
> +#ifdef CONFIG_FUZZ
> +void __attribute__((weak)) fuzz_dma_read_cb(size_t addr,
> +                      size_t len,
> +                      MemoryRegion *mr,
> +                      bool is_write)
> +{
> +}
> +#endif
> +
>  static const TypeInfo memory_region_info = {
>      .parent             = TYPE_OBJECT,
>      .name               = TYPE_MEMORY_REGION,
> -- 
> 2.27.0

