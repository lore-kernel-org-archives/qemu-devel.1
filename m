Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EDAC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A624D206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hT3G8x17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A624D206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZpN-0003CZ-Ms
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZlo-0007cz-DH; Wed, 30 Sep 2020 06:55:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZli-00012Y-6M; Wed, 30 Sep 2020 06:55:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAo0kf101106;
 Wed, 30 Sep 2020 10:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=ojj3tAddVkTIJeRWZR6A2Efai90NZ2FQ3Wa9teU3IDY=;
 b=hT3G8x17KpFhKI7ej9M4I9PDBDX2SBMaUXIx4otXi3ijgV5s76ImUC+HMnM5VzS5yGoD
 XZjfT2xt/tnRdxXiMtfnJL6lMwa2Qo7aHQLZrs7Pl4xQh6GkF7qAUjYYETwoESxvnwMY
 DLNUNddugB1u3AR4wZ/htJREetQTNxryynx5efagyQTBxkg3b2CDYZXtG6lqMMnzVsXu
 yHHP5mughEi/IsjVzPwBQlfYtSWkhd1yrkrrtbS+JgGihNAPA1XfebHsRZ9NUqMkeSo2
 3ooGZdcqoUOe3uOWSmfZEUBHNy39vq8vLF9H5tYdSvcQg/XPwJmwp2jLhvapDqV4CO7i ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 33swkkyuaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:55:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAoSXs039391;
 Wed, 30 Sep 2020 10:55:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 33tfhyxm86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:55:24 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UAtNdO011724;
 Wed, 30 Sep 2020 10:55:23 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:55:22 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 102f625f;
 Wed, 30 Sep 2020 10:55:20 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 10/14] i386/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-11-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-11-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:55:20 +0100
Message-ID: <m2imbvpm93.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxscore=0
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

On Wednesday, 2020-09-30 at 17:53:17 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/i386.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/i386/cpu.c           | 4 ++--
>  target/i386/hax-interface.h | 4 ++--
>  target/i386/hax-windows.c   | 2 +-
>  target/i386/kvm.c           | 2 +-
>  target/i386/machine.c       | 6 +++---
>  target/i386/translate.c     | 8 ++++----
>  target/i386/whpx-all.c      | 2 +-
>  7 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3ffd877..23851e5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4677,7 +4677,7 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
>      return name;
>  }
>  
> -/* Compatibily hack to maintain legacy +-feat semantic,
> +/* Compatibility hack to maintain legacy +-feat semantic,
>   * where +-feat overwrites any feature set by
>   * feat=on|feat even if the later is parsed after +-feat
>   * (i.e. "-x2apic,x2apic=on" will result in x2apic disabled)
> @@ -6896,7 +6896,7 @@ static void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
>      GuestPanicInformation *panic_info;
>  
>      if (!cs->crash_occurred) {
> -        error_setg(errp, "No crash occured");
> +        error_setg(errp, "No crash occurred");
>          return;
>      }
>  
> diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
> index 537ae08..edef4fd 100644
> --- a/target/i386/hax-interface.h
> +++ b/target/i386/hax-interface.h
> @@ -238,7 +238,7 @@ enum exit_status {
>      HAX_EXIT_UNKNOWN_VMEXIT,
>      /* HALT from guest */
>      HAX_EXIT_HLT,
> -    /* Reboot request, like because of tripple fault in guest */
> +    /* Reboot request, like because of triple fault in guest */
>      HAX_EXIT_STATECHANGE,
>      /* the vcpu is now only paused when destroy, so simply return to hax */
>      HAX_EXIT_PAUSED,
> @@ -295,7 +295,7 @@ struct hax_qemu_version {
>      uint32_t min_version;
>  } __attribute__ ((__packed__));
>  
> -/* The mac specfic interface to qemu, mostly is ioctl related */
> +/* The mac specific interface to qemu, mostly is ioctl related */
>  struct hax_tunnel_info {
>      uint64_t va;
>      uint64_t io_va;
> diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
> index 863c2bc..881089b 100644
> --- a/target/i386/hax-windows.c
> +++ b/target/i386/hax-windows.c
> @@ -174,7 +174,7 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
>      if (!ret) {
>          err = GetLastError();
>          if (err == ERROR_INSUFFICIENT_BUFFER || err == ERROR_MORE_DATA) {
> -            fprintf(stderr, "hax module verion is too long to hold.\n");
> +            fprintf(stderr, "hax module version is too long to hold.\n");
>          }
>          fprintf(stderr, "Failed to get Hax module version:%lu\n", err);
>          return -EFAULT;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 9efb07e..fbdbb49 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1179,7 +1179,7 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
>  /*
>   * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
>   * case of success, errno < 0 in case of failure and 0 when no Hyper-V
> - * extentions are enabled.
> + * extensions are enabled.
>   */
>  static int hyperv_handle_properties(CPUState *cs,
>                                      struct kvm_cpuid_entry2 *cpuid_ent)
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index b1acf7d..90e6139 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -264,12 +264,12 @@ static int cpu_pre_save(void *opaque)
>       * hypervisor, its exception payload (CR2/DR6 on #PF/#DB)
>       * should not be set yet in the respective vCPU register.
>       * Thus, in case an exception is pending, it is
> -     * important to save the exception payload seperately.
> +     * important to save the exception payload separately.
>       *
>       * Therefore, if an exception is not in a pending state
>       * or vCPU is not in guest-mode, it is not important to
>       * distinguish between a pending and injected exception
> -     * and we don't need to store seperately the exception payload.
> +     * and we don't need to store separately the exception payload.
>       *
>       * In order to preserve better backwards-compatible migration,
>       * convert a pending exception to an injected exception in
> @@ -1138,7 +1138,7 @@ static int nested_state_post_load(void *opaque, int version_id)
>          return -EINVAL;
>      }
>      if (nested_state->size > max_nested_state_len) {
> -        error_report("Recieved unsupported nested state size: "
> +        error_report("Received unsupported nested state size: "
>                       "nested_state->size=%d, max=%d",
>                       nested_state->size, max_nested_state_len);
>          return -EINVAL;
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index caea6f5..5cdfe0e 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -893,7 +893,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
>  }
>  
>  /* perform a conditional store into register 'reg' according to jump opcode
> -   value 'b'. In the fast case, T0 is guaranted not to be used. */
> +   value 'b'. In the fast case, T0 is guaranteed not to be used. */
>  static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
>  {
>      int inv, jcc_op, cond;
> @@ -1026,7 +1026,7 @@ static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
>  }
>  
>  /* generate a conditional jump to label 'l1' according to jump opcode
> -   value 'b'. In the fast case, T0 is guaranted not to be used. */
> +   value 'b'. In the fast case, T0 is guaranteed not to be used. */
>  static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
>  {
>      CCPrepare cc = gen_prepare_cc(s, b, s->T0);
> @@ -1043,7 +1043,7 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
>  }
>  
>  /* Generate a conditional jump to label 'l1' according to jump opcode
> -   value 'b'. In the fast case, T0 is guaranted not to be used.
> +   value 'b'. In the fast case, T0 is guaranteed not to be used.
>     A translation block must end soon.  */
>  static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
>  {
> @@ -6841,7 +6841,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
>          if (s->prefix & PREFIX_LOCK) {
>              switch (op) {
>              case 0: /* bt */
> -                /* Needs no atomic ops; we surpressed the normal
> +                /* Needs no atomic ops; we suppressed the normal
>                     memory load for LOCK above so do it now.  */
>                  gen_op_ld_v(s, ot, s->T0, s->A0);
>                  break;
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 5a0f337..661f9c7 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -1214,7 +1214,7 @@ int whpx_init_vcpu(CPUState *cpu)
>      vcpu = g_malloc0(sizeof(struct whpx_vcpu));
>  
>      if (!vcpu) {
> -        error_report("WHPX: Failed to allocte VCPU context.");
> +        error_report("WHPX: Failed to allocate VCPU context.");
>          return -ENOMEM;
>      }
>  
> -- 
> 2.26.2.windows.1

dme.
-- 
Tell me sweet little lies.

