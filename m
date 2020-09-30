Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B123C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008942071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dUQUTie7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008942071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZso-0006xG-V8
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZnA-0000mq-HY; Wed, 30 Sep 2020 06:57:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZn6-00016I-Rf; Wed, 30 Sep 2020 06:56:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAu8pO105547;
 Wed, 30 Sep 2020 10:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=XagkkAKuPG/OQf5ovEgHy6V8nnK3SSkKwWZDSfeHv+U=;
 b=dUQUTie7iMMOf5qECOfSm9ru+pNz2GREnz6qznuVaMl0eDuUXG2TMllAqUJ8IeMDxIyc
 XFBlKK46Sj2djz/egQ06lvSBm8KU4ppAJMRuyPzLLAssq0WJi2p7cRFslUedoYjwZugO
 pc+BwJEdxLZBHSChMhml3AQPddB08Ha+sjHawVXDiCkjEGrJ/e/QFkSbhpb9Q413MGbM
 YwEIe8DEOkMbjFqqc7HYB5OEEeJGQkVHF8Oc0Dntc8l3tWLxOXZDFPZTlgj/2va/A1D6
 Pw2aP1MUhHFEo4bsg0X7zhzIP7wz3AgK7UDCLCaPXhp6Yao9AJ65mWztDg6G9Z3/vOwb 5w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 33swkkyudx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:56:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAssW5014008;
 Wed, 30 Sep 2020 10:56:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 33uv2f6j9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:56:45 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UAuj7H019856;
 Wed, 30 Sep 2020 10:56:45 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:56:44 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 3ae3fd50;
 Wed, 30 Sep 2020 10:56:42 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 14/14] target/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-15-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-15-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:56:42 +0100
Message-ID: <m27dsbpm6t.fsf@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300088
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

On Wednesday, 2020-09-30 at 17:53:21 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/openrisc/cpu.h        | 2 +-
>  target/sparc/asi.h           | 2 +-
>  target/unicore32/translate.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index bd42faf..8ca8605 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -291,7 +291,7 @@ typedef struct CPUOpenRISCState {
>      int is_counting;
>  
>      uint32_t picmr;         /* Interrupt mask register */
> -    uint32_t picsr;         /* Interrupt contrl register*/
> +    uint32_t picsr;         /* Interrupt control register*/
>  #endif
>      void *irq[32];          /* Interrupt irq input */
>  } CPUOpenRISCState;
> diff --git a/target/sparc/asi.h b/target/sparc/asi.h
> index bb58735..4e9f1d5 100644
> --- a/target/sparc/asi.h
> +++ b/target/sparc/asi.h
> @@ -231,7 +231,7 @@
>  #define ASI_INTR_ID		0x63 /* (CMT) Interrupt ID register	*/
>  #define ASI_CORE_ID		0x63 /* (CMT) LP ID register		*/
>  #define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
> -#define ASI_IC_INSTR		0x66 /* Insn cache instrucion ram diag	*/
> +#define ASI_IC_INSTR		0x66 /* Insn cache instruction ram diag	*/
>  #define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
>  #define ASI_IC_STAG		0x68 /* (III) Insn cache snoop tag ram	*/
>  #define ASI_IC_PRE_DECODE	0x6e /* Insn cache pre-decode ram diag	*/
> diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
> index d4b06df..2e91b05 100644
> --- a/target/unicore32/translate.c
> +++ b/target/unicore32/translate.c
> @@ -119,7 +119,7 @@ static void load_reg_var(DisasContext *s, TCGv var, int reg)
>  {
>      if (reg == 31) {
>          uint32_t addr;
> -        /* normaly, since we updated PC */
> +        /* normally, since we updated PC */
>          addr = (long)s->pc;
>          tcg_gen_movi_i32(var, addr);
>      } else {
> -- 
> 2.26.2.windows.1

dme.
-- 
Tell her I'll be waiting, in the usual place.

