Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3D3C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CAF2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pIA/M3N5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CAF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZju-0004By-Ir
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZiH-0002PP-7t; Wed, 30 Sep 2020 06:51:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZiF-0000eL-9R; Wed, 30 Sep 2020 06:51:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAneBg100954;
 Wed, 30 Sep 2020 10:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=mfqi5cNpZDxFa3TIvOdWNYWzsiu8+D5MdIykpVcBTCY=;
 b=pIA/M3N5C/J65B1gCy00BUvvPyLeVYGTB+pF7iuuu6/WBoxCYZjvCRDDb22JrM7Hbqlj
 KOYOzKP5BScDGwjGlEQ/OA5RNzr9xeYMFiJjcCgJ+wLTYibzOo76pcGv2h5W/QHk+tog
 EyS88eNGMSTJuVTkYIEl7qdlrJZFlljbUW82aX/VjZQWbCv5OeoQz3IZLxhP9NFnlsSi
 gSbdPHKI71v3+w4jnkyd8mzQqsw1ZEE2chCnXxdl9wLXr+KlIvAVPemznzgVxJ6EOSxL
 OWsnQFMTUqJvHAR0AodTB1b0m3PcpgVPbGI8PSEl9VLbD7WGskzSyMOmf2GOSnUwmi8t LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 33swkkytyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:51:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAnmgY006397;
 Wed, 30 Sep 2020 10:51:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 33tfjyf4r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:51:45 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08UApioQ025444;
 Wed, 30 Sep 2020 10:51:44 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:51:44 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 42cceebd;
 Wed, 30 Sep 2020 10:51:42 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 03/14] riscv/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-4-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-4-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:51:42 +0100
Message-ID: <m2362zr0zl.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
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

On Wednesday, 2020-09-30 at 17:53:10 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/riscv.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/riscv/cpu.c           | 2 +-
>  target/riscv/cpu_bits.h      | 2 +-
>  target/riscv/csr.c           | 6 +++---
>  target/riscv/vector_helper.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 0bbfd7f..f40a0b2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -472,7 +472,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>                      return;
>                  }
>              } else {
> -                qemu_log("vector verison is not specified, "
> +                qemu_log("vector version is not specified, "
>                          "use the default value v0.7.1\n");
>              }
>              set_vext_version(env, vext_version);
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index bd36062..6e11555 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -536,7 +536,7 @@
>  /* Leaf page shift amount */
>  #define PGSHIFT             12
>  
> -/* Default Reset Vector adress */
> +/* Default Reset Vector address */
>  #define DEFAULT_RSTVEC      0x1000
>  
>  /* Exception causes */
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 26ae347..559db11 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -624,7 +624,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>  
> -/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> +/* This register is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>  static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>      if (env->priv_ver < PRIV_VERSION_1_11_0) {
> @@ -634,7 +634,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
>      return 0;
>  }
>  
> -/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> +/* This register is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>  static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
>  {
>      if (env->priv_ver < PRIV_VERSION_1_11_0) {
> @@ -1278,7 +1278,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>          !riscv_cpu_virt_enabled(env)) {
>          /*
>           * We are in S mode without virtualisation, therefore we are in HS Mode.
> -         * Add 1 to the effective privledge level to allow us to access the
> +         * Add 1 to the effective privilege level to allow us to access the
>           * Hypervisor CSRs.
>           */
>          effective_priv++;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a156573..fa89a6e 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -709,7 +709,7 @@ typedef void vext_amo_noatomic_fn(void *vs3, target_ulong addr,
>                                    uint32_t wd, uint32_t idx, CPURISCVState *env,
>                                    uintptr_t retaddr);
>  
> -/* no atomic opreation for vector atomic insructions */
> +/* no atomic operation for vector atomic insructions */
>  #define DO_SWAP(N, M) (M)
>  #define DO_AND(N, M)  (N & M)
>  #define DO_XOR(N, M)  (N ^ M)
> -- 
> 2.26.2.windows.1

dme.
-- 
But are you safe Miss Gradenko?

