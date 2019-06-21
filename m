Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2F3C48BE3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916D42084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FBfQe0ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916D42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJ1s-0005HV-Rk
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39220)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heIps-00055f-TG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heIpp-0004FW-Qb
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:40:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heIpp-00047G-FH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:40:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LCY3DH046146;
 Fri, 21 Jun 2019 12:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=YKYtvmNBR6/e/kUGQi+xsdwebSpS/gXEjL9tjEnOpwY=;
 b=FBfQe0neYCm8QtSiBwR96K0XZp+tIKGhy5O25jjVRtcHUnWdADaJedLOaE93VxXMBl/t
 7WyhR7j0LUngBRlEc/zFC2hTg0/cjVvcaktLd3ugA4Tc/GlCPADIKzJYvaypFFAsDGsV
 LqZCBee6DXQ15vi4Wks8qUh0nyV78x7ylBNfszmKgZvYHjmjX6R4IhHFpLzOpOpso8E0
 5iiDaNxFApzS31O9gsOY/sWyff3SogJXl+qa5Ko8P0izWqFJNJ36gxMCwN+1lOcMEpKg
 ChQk6vdnveshXZF2rnxuGCDzGTLSS5C7CLPR6noWtw3FLZWS6QzDvQfK7M5glcqcyUEt Dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t7809p8jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 12:40:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LCcYWW109332;
 Fri, 21 Jun 2019 12:40:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t77ypxbuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 12:40:03 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5LCe2Pv021208;
 Fri, 21 Jun 2019 12:40:02 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 12:40:01 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
Date: Fri, 21 Jun 2019 15:39:59 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <96A3CC63-2B7D-44C2-AA9A-C02AF8FC3691@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PULL 22/25] target/i386: kvm: Add nested
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 21 Jun 2019, at 14:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> From: Liran Alon <liran.alon@oracle.com>
>=20
> Previous commits have added support for migration of nested =
virtualization
> workloads. This was done by utilising two new KVM capabilities:
> KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD. Both which are
> required in order to correctly migrate such workloads.
>=20
> Therefore, change code to add a migration blocker for vCPUs exposed =
with
> Intel VMX or AMD SVM in case one of these kernel capabilities is
> missing.
>=20
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
> Message-Id: <20190619162140.133674-11-liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> target/i386/kvm.c     | 9 +++++++--
> target/i386/machine.c | 2 +-
> 2 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index c931e9d..e4b4f57 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1640,9 +1640,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                                   !!(c->ecx & CPUID_EXT_SMX);
>     }
>=20
> -    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
> +    if (cpu_has_vmx(env) && !nested_virt_mig_blocker &&

The change here from cpu_has_nested_virt(env) to cpu_has_vmx(env) is not =
clear.
We should explicitly explain that it=E2=80=99s because we still wish to =
preserve backwards-compatability
to migrating AMD vCPU exposed with SVM.

In addition, commit ("target/i386: kvm: Block migration for vCPUs =
exposed with nested virtualization")
doesn=E2=80=99t make sense in case we still want to allow migrating AMD =
vCPU exposed with SVM.

Since QEMU commit 75d373ef9729 ("target-i386: Disable SVM by default in =
KVM mode"),
machine-types since v2.2 don=E2=80=99t expose AMD SVM by default.
Therefore, my personal opinion on this is that it=E2=80=99s fine to =
block migration in this case.

> +        ((kvm_max_nested_state_length() <=3D 0) || =
!has_exception_payload)) {
>         error_setg(&nested_virt_mig_blocker,
> -                   "Nested virtualization does not support live =
migration yet");
> +                   "Kernel do not provide required capabilities for =
=E2=80=9C

As Maran have noted, we should change this =E2=80=9Cdo not=E2=80=9D to =
=E2=80=9Cdoes not=E2=80=9D.
Sorry for my bad English grammer. :)

> +                   "nested virtualization migration. "
> +                   "(CAP_NESTED_STATE=3D%d, =
CAP_EXCEPTION_PAYLOAD=3D%d)",
> +                   kvm_max_nested_state_length() > 0,
> +                   has_exception_payload);
>         r =3D migrate_add_blocker(nested_virt_mig_blocker, =
&local_err);
>         if (local_err) {
>             error_report_err(local_err);
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index fc49e5a..851b249 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -233,7 +233,7 @@ static int cpu_pre_save(void *opaque)
>=20
> #ifdef CONFIG_KVM
>     /* Verify we have nested virtualization state from kernel if =
required */
> -    if (cpu_has_nested_virt(env) && !env->nested_state) {
> +    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {

Good catch regarding adding kvm_enabled() here.
But I think this should have been added to commit ("target/i386: kvm: =
Add support for save and restore nested state=E2=80=9D).

-Liran

>         error_report("Guest enabled nested virtualization but kernel "
>                 "does not support saving of nested state");
>         return -EINVAL;
> --=20
> 1.8.3.1
>=20
>=20


