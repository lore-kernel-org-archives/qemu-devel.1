Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB3BC5ACD6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B943920735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bvIdWo1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B943920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGGZ-00036s-SX
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jEGFz-0002hH-7t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jEGFx-0004hO-Ea
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:43:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jEGFx-0004Ym-4E
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:43:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02HHfPKL144478;
 Tue, 17 Mar 2020 17:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xThm8GOVvm08cwD0Jla7v9+rgSKpFSRlL0rnjtxGtnU=;
 b=bvIdWo1yEwWsje6XOA2akO+t7EBGbPXmu/rQ8FscLk9xgvqCy9/1AbJO0yQfds56s6s7
 p89FDZKjiDgJ1dxoFCIwWroh+YPbr2ne1cSmJaXDorUYay5QYjVgw8eFE4eknCmvs3pG
 pgcTG9htBUboaCKbg8z2sHv+WSH2lnIj8QY851QrNc5qCtlJZ2tn/jYRM3BrH+xQzmzO
 /iGCu87g+vjUj4HJyoTsDQ84ixEvwAk6/MQSQHR9MmpwAS1dGRVInU8Ot5K95Nnq0G/o
 /poJdnB9lGdQ+gfzkcKfFx1JrLgrDuBOXNoQTUgcGktsx/FbLcMfDfPFH8vdhAzX3SYX 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yrq7kxauy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2020 17:43:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02HHKcaM040873;
 Tue, 17 Mar 2020 17:43:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2ys8rfb6pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2020 17:43:52 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02HHhpZc008070;
 Tue, 17 Mar 2020 17:43:51 GMT
Received: from [192.168.14.112] (/79.179.237.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 17 Mar 2020 10:43:51 -0700
Subject: Re: [PATCH] i386/kvm: Add CPU property to expose VMware CPUID
 signature
To: qemu-devel@nongnu.org
References: <20200310004017.100484-1-liran.alon@oracle.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <bc4ee7b0-99e7-5d1a-892a-6848ee25adaa@oracle.com>
Date: Tue, 17 Mar 2020 19:43:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200310004017.100484-1-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9563
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003170069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9563
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=1
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003170069
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gentle ping (A week have passed since submission).

Thanks,
-Liran

On 10/03/2020 2:40, Liran Alon wrote:
> Some guests are only familiar with VMware PV interface. Therefore, in
> order for these guests to run properly on KVM, we need to be able to
> expose VMware main CPUID leaf. i.e. leaf 0x40000000.
>
> E.g. Without exposing this VMware CPUID leaf, some guests will fail to boot.
> For example, because of guest attempt to calibrate TSC.
>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   target/i386/cpu.c |  1 +
>   target/i386/cpu.h |  1 +
>   target/i386/kvm.c | 35 +++++++++++++++++++++++++++++------
>   3 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 92fafa265914..694766d45a9b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7127,6 +7127,7 @@ static Property x86_cpu_properties[] = {
>       DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
>       DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
>                        false),
> +    DEFINE_PROP_BOOL("vmware-cpuid", X86CPU, expose_vmware, false),
>       DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
>       DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
>       DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 9c7cd7cde107..bca626963e25 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1647,6 +1647,7 @@ struct X86CPU {
>        */
>       bool force_features;
>       bool expose_kvm;
> +    bool expose_vmware;
>       bool expose_tcg;
>       bool migratable;
>       bool migrate_smi_count;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 00917196dffb..2656258b96b3 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1187,6 +1187,15 @@ static int hyperv_handle_properties(CPUState *cs,
>       if (!hyperv_enabled(cpu))
>           return 0;
>   
> +    /*
> +     * VMware & Hyper-V conflicts in CPUID leafs.
> +     * Therefore, they cannot exists together.
> +     */
> +    if (cpu->expose_vmware) {
> +        error_report("vmware-cpuid not compatible with hyperv options");
> +        return -ENOTSUP;
> +    }
> +
>       if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ||
>           cpu->hyperv_passthrough) {
>           uint16_t evmcs_version;
> @@ -1508,6 +1517,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           has_msr_hv_hypercall = true;
>       }
>   
> +    if (cpu->expose_vmware) {
> +        c = &cpuid_data.entries[cpuid_i++];
> +        c->function = KVM_CPUID_SIGNATURE;
> +        memcpy(signature, "VMwareVMware", 12);
> +        c->eax = KVM_CPUID_SIGNATURE;
> +        c->ebx = signature[0];
> +        c->ecx = signature[1];
> +        c->edx = signature[2];
> +
> +        kvm_base = KVM_CPUID_SIGNATURE_NEXT;
> +    }
> +
>       if (cpu->expose_kvm) {
>           memcpy(signature, "KVMKVMKVM\0\0\0", 12);
>           c = &cpuid_data.entries[cpuid_i++];
> @@ -1791,11 +1812,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           }
>       }
>   
> -    if (cpu->vmware_cpuid_freq
> -        /* Guests depend on 0x40000000 to detect this feature, so only expose
> -         * it if KVM exposes leaf 0x40000000. (Conflicts with Hyper-V) */
> -        && cpu->expose_kvm
> -        && kvm_base == KVM_CPUID_SIGNATURE
> +    if (cpu->vmware_cpuid_freq &&
> +        (cpu->expose_vmware ||
> +         /*
> +          * Guests depend on 0x40000000 to detect this feature, so only expose
> +          * it if KVM exposes leaf 0x40000000. (Conflicts with Hyper-V)
> +          */
> +          (cpu->expose_kvm && kvm_base == KVM_CPUID_SIGNATURE))
>           /* TSC clock must be stable and known for this feature. */
>           && tsc_is_stable_and_known(env)) {
>   
> @@ -1805,7 +1828,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           c->ebx = env->apic_bus_freq / 1000; /* Hz to KHz */
>           c->ecx = c->edx = 0;
>   
> -        c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
> +        c = cpuid_find_entry(&cpuid_data.cpuid, KVM_CPUID_SIGNATURE, 0);
>           c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
>       }
>   

