Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A26C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35892076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kd8Eoo+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35892076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZkm-0005sC-I6
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZiM-0002c4-T7; Wed, 30 Sep 2020 06:52:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZiK-0000f5-Iy; Wed, 30 Sep 2020 06:52:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAo66t101282;
 Wed, 30 Sep 2020 10:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=qCpMWjoYf+MDmmjQcOwnI90kRLEBrFQtSTUZS9J+gds=;
 b=Kd8Eoo+0Iph712PIYnXEJK6p0DgHUrAtU/NVdPI8mvDRY8x7LmquPL9oKtOJFClkkukf
 BDaBwzSURtB1/iRpaTDknz/4G7XbSkWNJE3zwhi+rUQgNqY0ucfhvKbAmkFIuzIuQgVR
 2x1jGP0cfaWUUMRy+xFy7halVh9laFcEoD4uFUM60ko9WJVnBuCj/tx1+rM6xIlpexrI
 PR/TJsyqO4HQxrmICjHtkokcMN+9sRscKX195zI8cxC8ae+CGZkjhnWNEEVLRmiax+os
 wskYJiIU9lieid+S6tybe1k9PTUC5Avpxi8hmvKOFjaCXNm0/JGZGQ7gHPBjaL1J9H81 /w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 33swkkytyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:51:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAkSxQ029939;
 Wed, 30 Sep 2020 10:49:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 33tfhyxe2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:49:52 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08UAnoLq016793;
 Wed, 30 Sep 2020 10:49:51 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:49:50 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 83b0d625;
 Wed, 30 Sep 2020 10:49:48 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 01/14] cris/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-2-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-2-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:49:48 +0100
Message-ID: <m28scrr12r.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=5 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300086
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
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_PASS=-0.001,
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

On Wednesday, 2020-09-30 at 17:53:08 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/cris.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

With the correction below...

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/cris/helper.c    |  6 +++---
>  target/cris/op_helper.c |  2 +-
>  target/cris/translate.c | 14 +++++++-------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/target/cris/helper.c b/target/cris/helper.c
> index b5159b8..50419e7 100644
> --- a/target/cris/helper.c
> +++ b/target/cris/helper.c
> @@ -141,7 +141,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
>      assert(!(env->pregs[PR_CCS] & PFIX_FLAG));
>      switch (cs->exception_index) {
>      case EXCP_BREAK:
> -        /* These exceptions are genereated by the core itself.
> +        /* These exceptions are generated by the core itself.
>             ERP should point to the insn following the brk.  */
>          ex_vec = env->trap_vector;
>          env->pregs[PRV10_BRP] = env->pc;
> @@ -197,7 +197,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
>  
>      switch (cs->exception_index) {
>      case EXCP_BREAK:
> -        /* These exceptions are genereated by the core itself.
> +        /* These exceptions are generated by the core itself.
>             ERP should point to the insn following the brk.  */
>          ex_vec = env->trap_vector;
>          env->pregs[PR_ERP] = env->pc;
> @@ -256,7 +256,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
>         undefined.  */
>      env->pc = cpu_ldl_code(env, env->pregs[PR_EBP] + ex_vec * 4);
>  
> -    /* Clear the excption_index to avoid spurios hw_aborts for recursive
> +    /* Clear the excption_index to avoid spurious hw_aborts for recursive

"exception_index"

>         bus faults.  */
>      cs->exception_index = -1;
>  
> diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
> index 6b1e7ae..3c4aacc 100644
> --- a/target/cris/op_helper.c
> +++ b/target/cris/op_helper.c
> @@ -231,7 +231,7 @@ static inline uint32_t evaluate_flags_writeback(CPUCRISState *env,
>  {
>      unsigned int x, z, mask;
>  
> -    /* Extended arithmetics, leave the z flag alone.  */
> +    /* Extended arithmetic, leave the z flag alone.  */
>      x = env->cc_x;
>      mask = env->cc_mask | X_FLAG;
>      if (x) {
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index c312e6f..16b0ef8 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -348,7 +348,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, TCGv ccs)
>      tcg_temp_free(t);
>  }
>  
> -/* Extended arithmetics on CRIS.  */
> +/* Extended arithmetic on CRIS.  */
>  static inline void t_gen_add_flag(TCGv d, int flag)
>  {
>      TCGv c;
> @@ -725,7 +725,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
>      switch (op) {
>      case CC_OP_ADD:
>          tcg_gen_add_tl(dst, a, b);
> -        /* Extended arithmetics.  */
> +        /* Extended arithmetic.  */
>          t_gen_addx_carry(dc, dst);
>          break;
>      case CC_OP_ADDC:
> @@ -738,7 +738,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
>          break;
>      case CC_OP_SUB:
>          tcg_gen_sub_tl(dst, a, b);
> -        /* Extended arithmetics.  */
> +        /* Extended arithmetic.  */
>          t_gen_subx_carry(dc, dst);
>          break;
>      case CC_OP_MOVE:
> @@ -764,7 +764,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
>          break;
>      case CC_OP_NEG:
>          tcg_gen_neg_tl(dst, b);
> -        /* Extended arithmetics.  */
> +        /* Extended arithmetic.  */
>          t_gen_subx_carry(dc, dst);
>          break;
>      case CC_OP_LZ:
> @@ -787,7 +787,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
>          break;
>      case CC_OP_CMP:
>          tcg_gen_sub_tl(dst, a, b);
> -        /* Extended arithmetics.  */
> +        /* Extended arithmetic.  */
>          t_gen_subx_carry(dc, dst);
>          break;
>      default:
> @@ -3053,12 +3053,12 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
>   * On QEMU care needs to be taken when a branch+delayslot sequence is broken
>   * and the branch and delayslot don't share pages.
>   *
> - * The TB contaning the branch insn will set up env->btarget and evaluate 
> + * The TB containing the branch insn will set up env->btarget and evaluate 
>   * env->btaken. When the translation loop exits we will note that the branch 
>   * sequence is broken and let env->dslot be the size of the branch insn (those
>   * vary in length).
>   *
> - * The TB contaning the delayslot will have the PC of its real insn (i.e no lsb
> + * The TB containing the delayslot will have the PC of its real insn (i.e no lsb
>   * set). It will also expect to have env->dslot setup with the size of the 
>   * delay slot so that env->pc - env->dslot point to the branch insn. This TB 
>   * will execute the dslot and take the branch, either to btarget or just one 
> -- 
> 2.26.2.windows.1

dme.
-- 
Driving at 90 down those country lanes, singing to "Tiny Dancer".

