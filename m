Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC19C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 23:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269C220656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 23:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n6+72eiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269C220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42614 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdkQ9-0002mE-Bj
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 19:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maran.wilson@oracle.com>) id 1hdkOC-0001hV-1G
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maran.wilson@oracle.com>) id 1hdkO9-00023q-U5
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:53:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maran.wilson@oracle.com>)
 id 1hdkO9-00021J-K2
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:53:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JNnZXI076903;
 Wed, 19 Jun 2019 23:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=juZE9Qg2p6QoV0FADmXwZn45FspqngSNBEE+z0aiHAE=;
 b=n6+72eiI8B1UIGb08xvUPZz2XxuTbdrLFsVEu7FHkUN/7gz6NlvcDkqo8gKT8Ja5iZQR
 v4vxA8R2a0LmBkgn2H2+59zQ42SMhThbEmKzT45l4XXh7Xl+d2amHUF4TSe8dwCHjdHP
 oqAHvAYFeP3QwKiUAMIGs1JccBwH93PtCIL4k6+1FEuZ4Gt6K0i5e8CZMVK2tH2oiGVj
 SHHhF4ZmIfn3l0+n9umXuclcKMZaeIhgZIVP20Y3y5Jmu8PJfgh0orwz2ai6hZbN5Pwh
 C+1Xvr8N+1SY46SvJa4EGvAQgJFs8AJkKssrWg0FJ+P2PF3vltz49/PXbrFvzCnsL90X Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t7809e4bj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 23:53:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JNpdDg106385;
 Wed, 19 Jun 2019 23:53:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2t77ync13w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 23:53:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JNr1KK008938;
 Wed, 19 Jun 2019 23:53:01 GMT
Received: from [10.159.140.81] (/10.159.140.81)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 16:53:01 -0700
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190619162140.133674-1-liran.alon@oracle.com>
 <20190619162140.133674-11-liran.alon@oracle.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <5ae979fd-39e0-50e2-df53-c6f70f939dd2@oracle.com>
Date: Wed, 19 Jun 2019 16:52:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619162140.133674-11-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190193
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190193
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [QEMU PATCH v4 10/10] target/i386: kvm: Add nested
 migration blocker only when kernel lacks required capabilities
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

On 6/19/2019 9:21 AM, Liran Alon wrote:
> Previous commits have added support for migration of nested virtualization
> workloads. This was done by utilising two new KVM capabilities:
> KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD. Both which are
> required in order to correctly migrate such workloads.
>
> Therefore, change code to add a migration blocker for vCPUs exposed with
> Intel VMX or AMD SVM in case one of these kernel capabilities is
> missing.
>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   target/i386/kvm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 99480a52ad33..a3d0fbed3b35 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1313,9 +1313,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                                     !!(c->ecx & CPUID_EXT_SMX);
>       }
>   
> -    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
> +    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker &&
> +        ((kvm_max_nested_state_length() <= 0) || !has_exception_payload)) {
>           error_setg(&nested_virt_mig_blocker,
> -                   "Nested virtualization does not support live migration yet");
> +                   "Kernel do not provide required capabilities for "

s/do/does/

And with that change:

Reviewed-by: Maran Wilson <maran.wilson@oracle.com>

Thanks,
-Maran


> +                   "nested virtualization migration. "
> +                   "(CAP_NESTED_STATE=%d, CAP_EXCEPTION_PAYLOAD=%d)",
> +                   kvm_max_nested_state_length() > 0,
> +                   has_exception_payload);
>           r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
>           if (local_err) {
>               error_report_err(local_err);


