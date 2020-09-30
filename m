Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB458C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DD9206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="szWcAt8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DD9206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZnk-0000m9-2d
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZkX-0005lZ-7K; Wed, 30 Sep 2020 06:54:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZkV-0000te-8l; Wed, 30 Sep 2020 06:54:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAs7RK175447;
 Wed, 30 Sep 2020 10:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=ZG0SQtec/S54eBM2oA8X8lopzg5kWqBlUTT32E2cAQ4=;
 b=szWcAt8DoUNSQtGHqWkB9hrIgpHQ1Koe9uMmWjVbFvgh13W3/wqKN2Ya28x/chkKZIIi
 wxki4dB7unqpLnNjtJmS2/9d6Hb+ZRo/ELIJp46LVzbjtVbOIX5AzWtCdWc2oXCQdfVL
 TN416simh7a1mFhrNqc+nLZXJpE9hr6i4sSPzne1WGICRdfJdJAx3/dIFj5x6fTnKc8H
 dmQkODs4DxAY4Llj7mpo7vyt/gaXjOk/VIcbFjMJIf7MnNzvhpujoFrOujjlWVWpNwEa
 FiRBLIZFOZONs0wuSsfGmK+diJBgnfVheYY+uflQxxQjbtdvad/e1nkdu3hZ9ofdU4yp pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 33su5aywbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:54:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAnmoq006386;
 Wed, 30 Sep 2020 10:54:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 33tfjyf768-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:54:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UAs6dG011204;
 Wed, 30 Sep 2020 10:54:06 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:54:05 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id ae31ab39;
 Wed, 30 Sep 2020 10:54:04 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 08/14] m68k/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-9-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-9-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:54:04 +0100
Message-ID: <m2o8lnpmb7.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=5
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=5
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300088
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=david.edmondson@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 06:53:43
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Wednesday, 2020-09-30 at 17:53:15 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/m68k.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/m68k/translate.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 3fc67aa..133a404 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -438,7 +438,7 @@ static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
>  }
>  
>  /*
> - * Handle a base + index + displacement effective addresss.
> + * Handle a base + index + displacement effective address.
>   * A NULL_QREG base means pc-relative.
>   */
>  static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
> @@ -1696,7 +1696,7 @@ static void bcd_add(TCGv dest, TCGv src)
>  
>      /*
>       * t1 = (src + 0x066) + dest + X
> -     *    = result with some possible exceding 0x6
> +     *    = result with some possible exceeding 0x6
>       */
>  
>      t0 = tcg_const_i32(0x066);
> @@ -1706,7 +1706,7 @@ static void bcd_add(TCGv dest, TCGv src)
>      tcg_gen_add_i32(t1, t0, dest);
>      tcg_gen_add_i32(t1, t1, QREG_CC_X);
>  
> -    /* we will remove exceding 0x6 where there is no carry */
> +    /* we will remove exceeding 0x6 where there is no carry */
>  
>      /*
>       * t0 = (src + 0x0066) ^ dest
> @@ -1736,7 +1736,7 @@ static void bcd_add(TCGv dest, TCGv src)
>      tcg_temp_free(t0);
>  
>      /*
> -     * remove the exceding 0x6
> +     * remove the exceeding 0x6
>       * for digits that have not generated a carry
>       */
>  
> @@ -2638,7 +2638,7 @@ DISAS_INSN(negx)
>      gen_flush_flags(s); /* compute old Z */
>  
>      /*
> -     * Perform substract with borrow.
> +     * Perform subtract with borrow.
>       * (X, N) =  -(src + X);
>       */
>  
> @@ -2653,7 +2653,7 @@ DISAS_INSN(negx)
>      /*
>       * Compute signed-overflow for negation.  The normal formula for
>       * subtraction is (res ^ src) & (src ^ dest), but with dest==0
> -     * this simplies to res & src.
> +     * this simplifies to res & src.
>       */
>  
>      tcg_gen_and_i32(QREG_CC_V, QREG_CC_N, src);
> @@ -3159,7 +3159,7 @@ static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
>      gen_flush_flags(s); /* compute old Z */
>  
>      /*
> -     * Perform substract with borrow.
> +     * Perform subtract with borrow.
>       * (X, N) = dest - (src + X);
>       */
>  
> @@ -3169,7 +3169,7 @@ static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
>      gen_ext(QREG_CC_N, QREG_CC_N, opsize, 1);
>      tcg_gen_andi_i32(QREG_CC_X, QREG_CC_X, 1);
>  
> -    /* Compute signed-overflow for substract.  */
> +    /* Compute signed-overflow for subtract.  */
>  
>      tcg_gen_xor_i32(QREG_CC_V, QREG_CC_N, dest);
>      tcg_gen_xor_i32(tmp, dest, src);
> -- 
> 2.26.2.windows.1

dme.
-- 
Don't you know you're never going to get to France.

