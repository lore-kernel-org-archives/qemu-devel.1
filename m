Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1691C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48959206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bttjDE/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48959206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZqc-0004ru-AK
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZmv-0000XN-To; Wed, 30 Sep 2020 06:56:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZmu-000161-1F; Wed, 30 Sep 2020 06:56:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAt5Lp042822;
 Wed, 30 Sep 2020 10:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=8yX1l7AGMQRULODb1nu11K6vxiMxQeinMz0ccnsz9HI=;
 b=bttjDE/WYbljEfUpJM7Bd6wEwh3PM6j6XM3685d/bq7huGFjy+1HcugXhWQBWy0+QS3A
 XGHVR4QZfVc/KzEBqyod4wtkg3TfG6P988SgO5GqyDPRphaRl0OfbI+2NWVQkLNQFr/U
 BbsxX0WFuUQAfrVVblnjElrJddH2rTvwLIQoTsKrJPQWpCiRn8cXugOrnvmS5UmFpI8c
 Pu2eyAMmbtCTuh5YFA6TG/wJYA8Wrp+KtdlPU9sN7xownzCY1BPkk3DcALMOb8PnHFh9
 MdiDJZiFGp1tnWK0uPW/VaffxI9IjDONePU9xVDfv2zs72pLIuCPnipkjA35jh9L0i9x 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33sx9n7rge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:56:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAss3X014009;
 Wed, 30 Sep 2020 10:56:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33uv2f6j19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:56:31 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08UAuUlt027373;
 Wed, 30 Sep 2020 10:56:30 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:56:30 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 710b6bd5;
 Wed, 30 Sep 2020 10:56:27 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 13/14] alpha/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-14-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-14-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:56:27 +0100
Message-ID: <m2a6x7pm78.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=1 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=1
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300088
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=david.edmondson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 06:51:12
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

On Wednesday, 2020-09-30 at 17:53:20 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/alpha.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/alpha/cpu.h       | 4 ++--
>  target/alpha/translate.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index be29bdd..8a6d477 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -190,7 +190,7 @@ enum {
>  
>     That said, we're only emulating Unix PALcode, and not attempting VMS,
>     so we don't need to implement Executive and Supervisor.  QEMU's own
> -   PALcode cheats and usees the KSEG mapping for its code+data rather than
> +   PALcode cheats and uses the KSEG mapping for its code+data rather than
>     physical addresses.  */
>  
>  #define MMU_KERNEL_IDX   0
> @@ -370,7 +370,7 @@ enum {
>     The Unix PALcode only uses bit 4.  */
>  #define PS_USER_MODE  8u
>  
> -/* CPUAlphaState->flags constants.  These are layed out so that we
> +/* CPUAlphaState->flags constants.  These are laid out so that we
>     can set or reset the pieces individually by assigning to the byte,
>     or manipulated as a whole.  */
>  
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 8870284..6aef9ec 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -2939,7 +2939,7 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
>         the first fp insn of the TB.  Alternately we could define a proper
>         default for every TB (e.g. QUAL_RM_N or QUAL_RM_D) and make sure
>         to reset the FP_STATUS to that default at the end of any TB that
> -       changes the default.  We could even (gasp) dynamiclly figure out
> +       changes the default.  We could even (gasp) dynamically figure out
>         what default would be most efficient given the running program.  */
>      ctx->tb_rm = -1;
>      /* Similarly for flush-to-zero.  */
> -- 
> 2.26.2.windows.1

dme.
-- 
They like the smell of it in Hollywood.

