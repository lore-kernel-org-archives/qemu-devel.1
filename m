Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2555C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD7D2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5cRtJ50Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD7D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdMUY-0000Ux-J7
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 18:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maran.wilson@oracle.com>) id 1hdMPr-0004jm-61
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maran.wilson@oracle.com>) id 1hdMPi-0007wQ-1h
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:17:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maran.wilson@oracle.com>)
 id 1hdMPc-0007s3-AC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:17:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IMEJUo084014;
 Tue, 18 Jun 2019 22:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ErVOMnHLEU3iYCpPY/9GqzKz/EQai2BPkiy8hqBf6U8=;
 b=5cRtJ50Zhns5cW4pmfht9ESqVvbgEZ++sHDMudmcHfV6NkRSpEm6BdzcWUhFXa6Oj5Q0
 cOse2QQRlrRYdo7SpsibVhQjOQJ15pJqMuDw3UB8WU5Ts1gmCrlYfZGYSqVYa4DnfdJG
 1Jz4Y59M+BU0847EWQl7tVY9+85E16U2gE1wZFqBnd7llsNF2H1Oh1Br6mNBuBeaBgyv
 T7Ie1QKPywdNI9cY83uy1BOFddmcgJ7YLJhvUOvpD6ShoLD+aoSkJqFcenC46gU+HdYO
 FmnYRKLIclaV2NftiJt5N304OEVs8LBuV3Rk2pDD8iUBIaoWR3SkoR46RqVkFWjmgP7K zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t780983sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 22:17:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IMFAb1069654;
 Tue, 18 Jun 2019 22:17:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2t77ymremn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 22:17:02 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5IMH1kJ032165;
 Tue, 18 Jun 2019 22:17:01 GMT
Received: from [10.141.197.71] (/10.141.197.71)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Jun 2019 15:17:01 -0700
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-10-liran.alon@oracle.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <907faf19-aaff-1d1a-422e-739ee5aa7d12@oracle.com>
Date: Tue, 18 Jun 2019 15:17:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617175658.135869-10-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906180178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906180178
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [QEMU PATCH v3 9/9] KVM: i386: Remove VMX
 migration blocker
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/2019 10:56 AM, Liran Alon wrote:
> This effectively reverts d98f26073beb ("target/i386: kvm: add VMX migration blocker").
> This can now be done because previous commits added support for Intel VMX migration.
>
> AMD SVM migration is still blocked. This is because kernel
> KVM_CAP_{GET,SET}_NESTED_STATE in case of AMD SVM is not
> implemented yet. Therefore, required vCPU nested state is still
> missing in order to perform valid migration for vCPU exposed with SVM.
>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   target/i386/kvm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 797f8ac46435..772c8619efc4 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -948,7 +948,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>   }
>   
>   static Error *invtsc_mig_blocker;
> -static Error *nested_virt_mig_blocker;
> +static Error *svm_mig_blocker;
>   
>   #define KVM_MAX_CPUID_ENTRIES  100
>   
> @@ -1313,13 +1313,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                                     !!(c->ecx & CPUID_EXT_SMX);
>       }
>   
> -    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
> -        error_setg(&nested_virt_mig_blocker,
> -                   "Nested virtualization does not support live migration yet");
> -        r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
> +    if (cpu_has_svm(env) && !svm_mig_blocker) {
> +        error_setg(&svm_mig_blocker,
> +                   "AMD SVM does not support live migration yet");
> +        r = migrate_add_blocker(svm_mig_blocker, &local_err);
>           if (local_err) {
>               error_report_err(local_err);
> -            error_free(nested_virt_mig_blocker);
> +            error_free(svm_mig_blocker);
>               return r;
>           }
>       }

Reviewed-by: Maran Wilson <maran.wilson@oracle.com>

Thanks,
-Maran

