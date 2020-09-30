Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22CCC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A7920754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0LEexCee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A7920754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZlF-0006UO-DF
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZjJ-0003s6-2f; Wed, 30 Sep 2020 06:53:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZjG-0000m8-Tl; Wed, 30 Sep 2020 06:53:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAnYVR100890;
 Wed, 30 Sep 2020 10:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=JXLP8hxbNhGItwwLU+zik8bUn/Atx2TpSPFRMYqvKt4=;
 b=0LEexCee1RMs47sNSN6gTuvn/400kGNn0KDZHJfkmfb7pbKEjWAitc2+bi+CF7G0Ejxj
 ZY/ifzQkQuHlzKrcO5uTD1eqzAuW6GCX15Y0+OgDBGocqEbOIGHCgCmMxaagbQ29piWc
 H26Yr1X+4r0ajVZUSQNSRmbEvFoI0QfrtY6E//0vRrl8qJUdTLkFu6OWt76k2R130b3B
 qvNAuOxHO67YeY6RXqxOwY2m67QcNFwBdgaV8wgxusOnlkYH5Vpkijgvy+w8fCgoXI9V
 sDEwU7X2TiIqy/IGnDACQY4uqorkPfpOC5MtNAIIVZNul2M3IsoeIfm20BksuJqBhDHO Ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 33swkkyu2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:52:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAoToj039534;
 Wed, 30 Sep 2020 10:52:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 33tfhyxhr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:52:50 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UAqnhd018035;
 Wed, 30 Sep 2020 10:52:49 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:52:49 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 3b6b7b95;
 Wed, 30 Sep 2020 10:52:47 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 06/14] mips/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-7-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-7-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:52:47 +0100
Message-ID: <m2tuvfpmdc.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=5 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=5 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300087
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=david.edmondson@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 06:51:53
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_PASS=-0.001,
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-09-30 at 17:53:13 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/mips.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/mips/internal.h           |  2 +-
>  target/mips/translate.c          | 10 +++++-----
>  target/mips/translate_init.c.inc |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 7f159a9..b811f54 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -188,7 +188,7 @@ static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
>          /*
>           * A MIPS configured with a vectorizing external interrupt controller
>           * will feed a vector into the Cause pending lines. The core treats
> -         * the status lines as a vector level, not as indiviual masks.
> +         * the status lines as a vector level, not as individual masks.
>           */
>          r = pending > status;
>      } else {
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 398edf7..b4d0090 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -3718,7 +3718,7 @@ static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
>  
>      t0 = tcg_temp_new();
>      addr = tcg_temp_new();
> -    /* compare the address against that of the preceeding LL */
> +    /* compare the address against that of the preceding LL */
>      gen_base_offset_addr(ctx, addr, base, offset);
>      tcg_gen_brcond_tl(TCG_COND_EQ, addr, cpu_lladdr, l1);
>      tcg_temp_free(addr);
> @@ -25597,7 +25597,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
>          }
>          /* return resulting half-words to its original position */
>          tcg_gen_shri_i32(t0, t0, 16);
> -        /* finaly update the destination */
> +        /* finally update the destination */
>          tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
>  
>          tcg_temp_free(t1);
> @@ -25633,7 +25633,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
>          }
>          /* return resulting half-words to its original position */
>          tcg_gen_shri_i32(t0, t0, 16);
> -        /* finaly update the destination */
> +        /* finally update the destination */
>          tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
>  
>          tcg_temp_free(t1);
> @@ -25702,7 +25702,7 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
>              }
>              /* return resulting byte to its original position */
>              tcg_gen_shri_i32(t0, t0, 8 * (3 - i));
> -            /* finaly update the destination */
> +            /* finally update the destination */
>              tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
>          }
>  
> @@ -25742,7 +25742,7 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
>              }
>              /* return resulting byte to its original position */
>              tcg_gen_shri_i32(t0, t0, 8 * (3 - i));
> -            /* finaly update the destination */
> +            /* finally update the destination */
>              tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
>          }
>  
> diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
> index 637cacc..c735b2b 100644
> --- a/target/mips/translate_init.c.inc
> +++ b/target/mips/translate_init.c.inc
> @@ -995,7 +995,7 @@ static void mvp_init (CPUMIPSState *env, const mips_def_t *def)
>  
>      /* MVPConf1 implemented, TLB sharable, no gating storage support,
>         programmable cache partitioning implemented, number of allocatable
> -       and sharable TLB entries, MVP has allocatable TCs, 2 VPEs
> +       and shareable TLB entries, MVP has allocatable TCs, 2 VPEs
>         implemented, 5 TCs implemented. */
>      env->mvp->CP0_MVPConf0 = (1U << CP0MVPC0_M) | (1 << CP0MVPC0_TLBS) |
>                               (0 << CP0MVPC0_GS) | (1 << CP0MVPC0_PCP) |
> -- 
> 2.26.2.windows.1

dme.
-- 
There in the midst of it so alive and alone, words support like bone.

