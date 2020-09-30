Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1DBC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67770206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pQdpcIbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67770206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZoR-0001bp-IU
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZk4-00051M-Tu; Wed, 30 Sep 2020 06:53:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZk0-0000sD-LZ; Wed, 30 Sep 2020 06:53:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAo6OT172342;
 Wed, 30 Sep 2020 10:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=Cfy9m35AYAzl8RntmCP3gEKRoaFkzRg1NsBJNfqUGk0=;
 b=pQdpcIbp8T+zsRRGeT2Lzs+lZPcJ8VTHJilHWwnXuyyBBfJQIq3ytluc8rPyPA3MgGb6
 QazZWEq2JQLWE53udW0nIRRHiJx77dhDX3grnzhNfEpq9CxLD7vHIKmVhZ/ogRid5Waw
 35nPEFAfkgqKCCY98huWmlfFvsDNDmY7g8JDXrXn1cr99MeWfja4iONkS2zN1y1NZivA
 b0Y7aCeN31sOoHY8uO2876FDrrS38RFlewUjTngP4Tvso5RGuwdOF+BAdAAZKQfUu+v1
 b0/7tN22L+bq2xAQy+v7/9Hzk0aYllA3eO+0huxuVrwwy62mLfeTKfA8BlNqp4uTZe27 AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 33su5aywa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:53:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAolfw035536;
 Wed, 30 Sep 2020 10:53:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 33tfdtp7b4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:53:33 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UArWQE018205;
 Wed, 30 Sep 2020 10:53:32 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:53:32 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 6f888adf;
 Wed, 30 Sep 2020 10:53:30 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 07/14] s390x/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-8-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-8-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:53:30 +0100
Message-ID: <m2r1qjpmc5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=5
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300087
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

On Wednesday, 2020-09-30 at 17:53:14 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/s390x.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/s390x/cpu_models.h       | 4 ++--
>  target/s390x/excp_helper.c      | 2 +-
>  target/s390x/fpu_helper.c       | 2 +-
>  target/s390x/insn-data.def      | 2 +-
>  target/s390x/misc_helper.c      | 2 +-
>  target/s390x/translate.c        | 4 ++--
>  target/s390x/translate_vx.c.inc | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
> index 74d1f87..15c0f0d 100644
> --- a/target/s390x/cpu_models.h
> +++ b/target/s390x/cpu_models.h
> @@ -24,13 +24,13 @@ struct S390CPUDef {
>      uint8_t gen;            /* hw generation identification */
>      uint16_t type;          /* cpu type identification */
>      uint8_t ec_ga;          /* EC GA version (on which also the BC is based) */
> -    uint8_t mha_pow;        /* Maximum Host Adress Power, mha = 2^pow-1 */
> +    uint8_t mha_pow;        /* Maximum Host Address Power, mha = 2^pow-1 */
>      uint32_t hmfai;         /* hypervisor-managed facilities */
>      /* base/min features, must never be changed between QEMU versions */
>      S390FeatBitmap base_feat;
>      /* used to init base_feat from generated data */
>      S390FeatInit base_init;
> -    /* deafault features, QEMU version specific */
> +    /* default features, QEMU version specific */
>      S390FeatBitmap default_feat;
>      /* used to init default_feat from generated data */
>      S390FeatInit default_init;
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index 3b58d10..9644a67 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -538,7 +538,7 @@ try_deliver:
>          /* don't trigger a cpu_loop_exit(), use an interrupt instead */
>          cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
>      } else if (cs->halted) {
> -        /* unhalt if we had a WAIT PSW somehwere in our injection chain */
> +        /* unhalt if we had a WAIT PSW somewhere in our injection chain */
>          s390_cpu_unhalt(cpu);
>      }
>  }
> diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
> index f155bc0..3e609b7 100644
> --- a/target/s390x/fpu_helper.c
> +++ b/target/s390x/fpu_helper.c
> @@ -89,7 +89,7 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
>      /*
>       * invalid/divbyzero cannot coexist with other conditions.
>       * overflow/underflow however can coexist with inexact, we have to
> -     * handle it separatly.
> +     * handle it separately.
>       */
>      if (s390_exc & ~S390_IEEE_MASK_INEXACT) {
>          if (s390_exc & ~S390_IEEE_MASK_INEXACT & env->fpc >> 24) {
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index d79ae9e..1631948 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -523,7 +523,7 @@
>  /* LOAD LOGICAL HALFWORD RELATIVE LONG */
>      C(0xc402, LLHRL,   RIL_b, GIE, 0, ri2, new, r1_32, ld16u, 0)
>      C(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld16u, 0)
> -/* LOAD LOGICAL IMMEDATE */
> +/* LOAD LOGICAL IMMEDIATE */
>      D(0xc00e, LLIHF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 32)
>      D(0xc00f, LLILF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 0)
>      D(0xa50c, LLIHH,   RI_a,  Z,  0, i2_16u_shl, 0, r1, mov2, 0, 48)
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 58dbc02..929e509 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -312,7 +312,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
>              /* same as machine type number in STORE CPU ID, but in EBCDIC */
>              snprintf(type, ARRAY_SIZE(type), "%X", cpu->model->def->type);
>              ebcdic_put(sysib.sysib_111.type, type, 4);
> -            /* model number (not stored in STORE CPU ID for z/Architecure) */
> +            /* model number (not stored in STORE CPU ID for z/Architecture) */
>              ebcdic_put(sysib.sysib_111.model, "QEMU            ", 16);
>              ebcdic_put(sysib.sysib_111.sequence, "QEMU            ", 16);
>              ebcdic_put(sysib.sysib_111.plant, "QEMU", 4);
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index a777343..58ad6c8 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -433,7 +433,7 @@ static void gen_program_exception(DisasContext *s, int code)
>  {
>      TCGv_i32 tmp;
>  
> -    /* Remember what pgm exeption this was.  */
> +    /* Remember what pgm exception this was.  */
>      tmp = tcg_const_i32(code);
>      tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUS390XState, int_pgm_code));
>      tcg_temp_free_i32(tmp);
> @@ -489,7 +489,7 @@ static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
>  
>      /*
>       * Note that d2 is limited to 20 bits, signed.  If we crop negative
> -     * displacements early we create larger immedate addends.
> +     * displacements early we create larger immediate addends.
>       */
>      if (b2 && x2) {
>          tcg_gen_add_i64(tmp, regs[b2], regs[x2]);
> diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
> index eb767f5..983da56 100644
> --- a/target/s390x/translate_vx.c.inc
> +++ b/target/s390x/translate_vx.c.inc
> @@ -789,7 +789,7 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *o)
>          }
>          break;
>      case 0x94:
> -        /* If sources and destination dont't overlap -> fast path */
> +        /* If sources and destination don't overlap -> fast path */
>          if (v1 != v2 && v1 != v3) {
>              const uint8_t src_es = get_field(s, m4);
>              const uint8_t dst_es = src_es - 1;
> -- 
> 2.26.2.windows.1

dme.
-- 
Do I have to tell the story, of a thousand rainy days since we first met?

