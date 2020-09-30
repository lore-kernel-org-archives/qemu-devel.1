Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161D3C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF400206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ajzhG7VJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF400206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZmb-00085y-O5
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZkq-0006PS-Bb; Wed, 30 Sep 2020 06:54:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZko-0000ug-DB; Wed, 30 Sep 2020 06:54:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAneBq100954;
 Wed, 30 Sep 2020 10:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=1P3NmFeUqjyJiKOlajDgWUP2X9JIw0XEGAavTL4k1Sk=;
 b=ajzhG7VJYMw8EYyyvCuma/AuWNGmdDRfQlz0u2NrMfaObjlFjVVS5dPYgh0fx+R33tsj
 oCsUnCx9elkKNxMGyw/KArc8dCF6QR7cpajgiaHzcFcrNIEzISeR1+xS8RHTuv8t62kt
 rF6F6sI6Wt3HLkkxgmLaVEb7Qe+7PXmrbkqEKj+xOuDrROUKeiA2exhpfd88JKduuwhP
 gR1Fc4pbpfa/6UHDjBLuyLaD6a66meX6XjfuO9Y/OCO2cWQZ34vy0shnPptvhnkQjC2M
 bJ9JZRKbAAKO1dmmofCNuf8+/2NgQV31jHtmpmnXgQ6OZ2po9SlgxfnP247pXJe7QAnu lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 33swkkyu85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:54:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAotJc004306;
 Wed, 30 Sep 2020 10:54:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33uv2f6g30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:54:29 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08UAsS5u026477;
 Wed, 30 Sep 2020 10:54:28 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:54:28 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id a6d65441;
 Wed, 30 Sep 2020 10:54:26 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 09/14] sh4/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-10-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-10-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:54:26 +0100
Message-ID: <m2lfgrpmal.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=1 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 priorityscore=1501
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

On Wednesday, 2020-09-30 at 17:53:16 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/sh4.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/sh4/cpu.h       | 2 +-
>  target/sh4/op_helper.c | 2 +-
>  target/sh4/translate.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index dbe58c7..91fa949 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -160,7 +160,7 @@ typedef struct CPUSH4State {
>      uint32_t pteh;		/* page table entry high register */
>      uint32_t ptel;		/* page table entry low register */
>      uint32_t ptea;		/* page table entry assistance register */
> -    uint32_t ttb;		/* tranlation table base register */
> +    uint32_t ttb;		/* translation table base register */
>      uint32_t tea;		/* TLB exception address register */
>      uint32_t tra;		/* TRAPA exception register */
>      uint32_t expevt;		/* exception event register */
> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> index 14c3db0..9de4152 100644
> --- a/target/sh4/op_helper.c
> +++ b/target/sh4/op_helper.c
> @@ -400,7 +400,7 @@ float32 helper_fsrra_FT(CPUSH4State *env, float32 t0)
>      t0 = float32_div(float32_one, t0, &env->fp_status);
>      /* Since this is supposed to be an approximation, an imprecision
>         exception is required.  One supposes this also follows the usual
> -       IEEE rule that other exceptions take precidence.  */
> +       IEEE rule that other exceptions take precedence.  */
>      if (get_float_exception_flags(&env->fp_status) == 0) {
>          set_float_exception_flags(float_flag_inexact, &env->fp_status);
>      }
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 60c863d..c57218e 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1959,7 +1959,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>      NEXT_INSN;
>      switch (ctx->opcode & 0xf00f) {
>      case 0x6003: /* mov Rm,Rn */
> -        /* Here we want to recognize ld_dst being saved for later consumtion,
> +        /* Here we want to recognize ld_dst being saved for later consumption,
>             or for another input register being copied so that ld_dst need not
>             be clobbered during the operation.  */
>          op_dst = B11_8;
> -- 
> 2.26.2.windows.1

dme.
-- 
Music has magic, it's good clear syncopation.

