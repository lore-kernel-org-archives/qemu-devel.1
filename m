Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE730C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18B0206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NxnwUAFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18B0206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkvT-00085n-Sl
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDkur-0007Nm-OC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:48:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDkup-0003lF-TN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:48:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838iv4Z187751;
 Thu, 3 Sep 2020 08:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=+VWBbLOEc973LVW6lsoZ/SjndtAZrk5BkAQY3HQLdzQ=;
 b=NxnwUAFNbV9mySxEA5PS6XuFkMBC4d4/vJAx781DfD0t67MTs+1Coyx0dwpjyAlDiINb
 rj5pUsFFcTUAHahsL/tOPW2pmut4UcwsiH1iY0c8zm7SM6Sl2hk8Ahka8n86xJHnO8OH
 B23z8q0ePdn8Been+1J4/9GiJy/sUHqqUAeSOHQvzviXmlm9ZXmivnqrlUSWSx+DCslB
 fItQzGIH0E47RgEPoiuve8yZFGU0UksSyBTQDUZXM64on4Nl2t3u0+s5hP6H87lWDxvX
 Jc6WV7q0upTHp128sL00OzCDq6tpYSoJ7Th0NnYP5ECNsMlF8RSA4zjJ4pJ6sFumXw2Z sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 337eer7g4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 08:48:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838ifP5070008;
 Thu, 3 Sep 2020 08:46:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 3380x9aadb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 08:46:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0838kD5K017259;
 Thu, 3 Sep 2020 08:46:13 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 01:46:13 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id A2EAD134F108; Thu,  3 Sep 2020 09:46:10 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/15] fuzz: Add fuzzer callbacks to DMA-read functions
In-Reply-To: <20200819061110.1320568-7-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-7-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 09:46:10 +0100
Message-ID: <m2v9gvs0x9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=2 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030080
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:48:18
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
Cc: f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-19 at 02:11:01 -04, Alexander Bulekov wrote:
> We should be careful to not call any functions besides fuzz_dma_read_cb.
> Without --enable-fuzzing, fuzz_dma_read_cb is an empty inlined function.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  exec.c                                | 2 ++
>  include/exec/memory.h                 | 1 +
>  include/exec/memory_ldst_cached.inc.h | 3 +++
>  memory_ldst.inc.c                     | 4 ++++
>  softmmu/memory.c                      | 1 +
>  5 files changed, 11 insertions(+)
>
> diff --git a/exec.c b/exec.c
> index 6f381f98e2..c81f41514d 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3241,6 +3241,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
>              stn_he_p(buf, l, val);
>          } else {
>              /* RAM case */
> +            fuzz_dma_read_cb(addr, len, mr, false);
>              ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
>              memcpy(buf, ram_ptr, l);
>          }
> @@ -3601,6 +3602,7 @@ void *address_space_map(AddressSpace *as,
>      memory_region_ref(mr);
>      *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
>                                          l, is_write, attrs);
> +    fuzz_dma_read_cb(addr, *plen, mr, is_write);
>      ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
>  
>      return ptr;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 2ec3b597f1..f8b943521a 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2444,6 +2444,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
>                            void *buf, hwaddr len)
>  {
>      assert(addr < cache->len && len <= cache->len - addr);
> +    fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr, false);
>      if (likely(cache->ptr)) {
>          memcpy(buf, cache->ptr + addr, len);
>          return MEMTX_OK;
> diff --git a/include/exec/memory_ldst_cached.inc.h b/include/exec/memory_ldst_cached.inc.h
> index fd4bbb40e7..aff574039f 100644
> --- a/include/exec/memory_ldst_cached.inc.h
> +++ b/include/exec/memory_ldst_cached.inc.h
> @@ -28,6 +28,7 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
>      hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
>  {
>      assert(addr < cache->len && 4 <= cache->len - addr);
> +    fuzz_dma_read_cb(cache->xlat + addr, 4, cache->mrs.mr, false);
>      if (likely(cache->ptr)) {
>          return LD_P(l)(cache->ptr + addr);
>      } else {
> @@ -39,6 +40,7 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
>      hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
>  {
>      assert(addr < cache->len && 8 <= cache->len - addr);
> +    fuzz_dma_read_cb(cache->xlat + addr, 8, cache->mrs.mr, false);
>      if (likely(cache->ptr)) {
>          return LD_P(q)(cache->ptr + addr);
>      } else {
> @@ -50,6 +52,7 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
>      hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
>  {
>      assert(addr < cache->len && 2 <= cache->len - addr);
> +    fuzz_dma_read_cb(cache->xlat + addr, 2, cache->mrs.mr, false);
>      if (likely(cache->ptr)) {
>          return LD_P(uw)(cache->ptr + addr);
>      } else {
> diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
> index c54aee4a95..8d45d2eeff 100644
> --- a/memory_ldst.inc.c
> +++ b/memory_ldst.inc.c
> @@ -42,6 +42,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
>                                          MO_32 | devend_memop(endian), attrs);
>      } else {
>          /* RAM case */
> +        fuzz_dma_read_cb(addr, 4, mr, false);
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          switch (endian) {
>          case DEVICE_LITTLE_ENDIAN:
> @@ -110,6 +111,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
>                                          MO_64 | devend_memop(endian), attrs);
>      } else {
>          /* RAM case */
> +        fuzz_dma_read_cb(addr, 8, mr, false);
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          switch (endian) {
>          case DEVICE_LITTLE_ENDIAN:
> @@ -175,6 +177,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
>          r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
>      } else {
>          /* RAM case */
> +        fuzz_dma_read_cb(addr, 1, mr, false);
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          val = ldub_p(ptr);
>          r = MEMTX_OK;
> @@ -212,6 +215,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
>                                          MO_16 | devend_memop(endian), attrs);
>      } else {
>          /* RAM case */
> +        fuzz_dma_read_cb(addr, 2, mr, false);
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          switch (endian) {
>          case DEVICE_LITTLE_ENDIAN:
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index b0c2cf2535..be87044641 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1405,6 +1405,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
>      unsigned size = memop_size(op);
>      MemTxResult r;
>  
> +    fuzz_dma_read_cb(addr, size, mr, false);
>      if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
>          *pval = unassigned_mem_read(mr, addr, size);
>          return MEMTX_DECODE_ERROR;
> -- 
> 2.27.0

