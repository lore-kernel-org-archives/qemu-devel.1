Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6662EC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B39E20826
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezgMG7P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B39E20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDMU7-0003Rp-BI
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 02:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kDMTZ-00030W-B3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kDMTW-0007Wg-RJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599028949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3dtdCqmLWGoOl2NJVmRnPt8gmbcaGUCUjJWvaZGGyE=;
 b=ezgMG7P+eDrBrmG2GYTjJTvFBHzONEU7PxSfesXHgY0gtC6pH24zoOA8C6tdUy3SZ+QBay
 c2tH1Btwn1b6zVsA21afx2n762bdhn4aJIp2Xa2WKGifcfoKXvbWnrzqtqmLQ2NiNpr6Qq
 M0iF6GXbKTMpLgUO3fkaQVJ1SwbeOoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-0Tuvh76NPZKSFywXMP_-JA-1; Wed, 02 Sep 2020 02:42:27 -0400
X-MC-Unique: 0Tuvh76NPZKSFywXMP_-JA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05584189E609;
 Wed,  2 Sep 2020 06:42:26 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE4575C1BB;
 Wed,  2 Sep 2020 06:42:21 +0000 (UTC)
Date: Wed, 2 Sep 2020 08:42:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v7 1/2] i386: Simplify CPUID_8000_001d for AMD
Message-ID: <20200902084220.4b334daa@redhat.com>
In-Reply-To: <159897584649.30750.3939159632943292252.stgit@naples-babu.amd.com>
References: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
 <159897584649.30750.3939159632943292252.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 01 Sep 2020 10:57:26 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Remove all the hardcoded values and replace with generalized
> fields.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c |   31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ba4667b33c..b12addf323 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -395,11 +395,12 @@ static int cores_in_core_complex(int nr_cores)
>  }
>  
>  /* Encode cache info for CPUID[8000001D] */
> -static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
> -                                uint32_t *eax, uint32_t *ebx,
> -                                uint32_t *ecx, uint32_t *edx)
> +static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> +                                       X86CPUTopoInfo *topo_info,
> +                                       uint32_t *eax, uint32_t *ebx,
> +                                       uint32_t *ecx, uint32_t *edx)
>  {
> -    uint32_t l3_cores;
> +    uint32_t l3_threads;
>      assert(cache->size == cache->line_size * cache->associativity *
>                            cache->partitions * cache->sets);
>  
> @@ -408,10 +409,10 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
>  
>      /* L3 is shared among multiple cores */
>      if (cache->level == 3) {
> -        l3_cores = cores_in_core_complex(cs->nr_cores);
> -        *eax |= ((l3_cores * cs->nr_threads) - 1) << 14;
> +        l3_threads = topo_info->cores_per_die * topo_info->threads_per_core;
> +        *eax |= (l3_threads - 1) << 14;
>      } else {
> -        *eax |= ((cs->nr_threads - 1) << 14);
> +        *eax |= ((topo_info->threads_per_core - 1) << 14);
>      }
>  
>      assert(cache->line_size > 0);
> @@ -5994,20 +5995,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          switch (count) {
>          case 0: /* L1 dcache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
> -                                       eax, ebx, ecx, edx);
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
> +                                       &topo_info, eax, ebx, ecx, edx);
>              break;
>          case 1: /* L1 icache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
> -                                       eax, ebx, ecx, edx);
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
> +                                       &topo_info, eax, ebx, ecx, edx);
>              break;
>          case 2: /* L2 cache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
> -                                       eax, ebx, ecx, edx);
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
> +                                       &topo_info, eax, ebx, ecx, edx);
>              break;
>          case 3: /* L3 cache info */
> -            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
> -                                       eax, ebx, ecx, edx);
> +            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
> +                                       &topo_info, eax, ebx, ecx, edx);
>              break;
>          default: /* end of info */
>              *eax = *ebx = *ecx = *edx = 0;
> 


