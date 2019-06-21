Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EE7C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F92F206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IwsGI9yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F92F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heLIl-0004yd-Cg
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 11:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heLAZ-0005KK-25
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heLAX-0003Ao-H7
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:09:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heLAW-00036l-Ag
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:09:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LF4ept068472;
 Fri, 21 Jun 2019 15:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=3467ZZVoUfPMW7CWI0UiR90dmWyH03kiaFVa0PL6ZMY=;
 b=IwsGI9ylTIKwU8BWXBlC6oIxFqNxOAZ7QpG7gv0Rz1UNRfRuEjL6CdK5BQuQPdqubk4h
 XysMYmLp/uXpfDTQPX+Kym5SAXGms6y0JYjoMGgB7N5ghbvQFL3rxfbYvlFix7CUw93m
 5ickO01XxF4Wjld8g06uAfqWf20E4BuLy2OXlk+D6SUE2fXUgECITEP7sxyFr/TNlxI8
 Iy586EYil50QAvYv/xdtNilGmXN0e7fdJ6U+HbxTg+fbDEZ4zDm3G2wLAMNYBQ3/gpI+
 G8wVhYlXHAMwIpYXKNKw4wIEa5m2vJanTbNDEHdXh+6f9OwJ+UgLEbE+bRIDXiweD7lj 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t7809q2n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 15:09:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LF7JjZ021374;
 Fri, 21 Jun 2019 15:07:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2t7rdxsv60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 15:07:32 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5LF7V2D027761;
 Fri, 21 Jun 2019 15:07:31 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 15:07:31 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <150eb2f8-3b1a-e0ab-df36-adcbd601055d@redhat.com>
Date: Fri, 21 Jun 2019 18:07:28 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <672D2B0A-E79C-467A-A9F0-57DC414842C3@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
 <96A3CC63-2B7D-44C2-AA9A-C02AF8FC3691@oracle.com>
 <150eb2f8-3b1a-e0ab-df36-adcbd601055d@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210124
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
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



> On 21 Jun 2019, at 18:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 21/06/19 14:39, Liran Alon wrote:
>>> On 21 Jun 2019, at 14:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>=20
>>> From: Liran Alon <liran.alon@oracle.com>
>>>=20
>>> Previous commits have added support for migration of nested =
virtualization
>>> workloads. This was done by utilising two new KVM capabilities:
>>> KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD. Both which are
>>> required in order to correctly migrate such workloads.
>>>=20
>>> Therefore, change code to add a migration blocker for vCPUs exposed =
with
>>> Intel VMX or AMD SVM in case one of these kernel capabilities is
>>> missing.
>>>=20
>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>> Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
>>> Message-Id: <20190619162140.133674-11-liran.alon@oracle.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>> target/i386/kvm.c     | 9 +++++++--
>>> target/i386/machine.c | 2 +-
>>> 2 files changed, 8 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>> index c931e9d..e4b4f57 100644
>>> --- a/target/i386/kvm.c
>>> +++ b/target/i386/kvm.c
>>> @@ -1640,9 +1640,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>                                  !!(c->ecx & CPUID_EXT_SMX);
>>>    }
>>>=20
>>> -    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
>>> +    if (cpu_has_vmx(env) && !nested_virt_mig_blocker &&
>>=20
>> The change here from cpu_has_nested_virt(env) to cpu_has_vmx(env) is =
not clear.
>> We should explicitly explain that it=E2=80=99s because we still wish =
to preserve backwards-compatability
>> to migrating AMD vCPU exposed with SVM.
>>=20
>> In addition, commit ("target/i386: kvm: Block migration for vCPUs =
exposed with nested virtualization")
>> doesn=E2=80=99t make sense in case we still want to allow migrating =
AMD vCPU exposed with SVM.
>>=20
>> Since QEMU commit 75d373ef9729 ("target-i386: Disable SVM by default =
in KVM mode"),
>> machine-types since v2.2 don=E2=80=99t expose AMD SVM by default.
>> Therefore, my personal opinion on this is that it=E2=80=99s fine to =
block migration in this case.
>=20
> I totally missed that commit.  My bad.
>=20
> Actually, now that I think about it SVM *will* have some state while
> running in guest mode, namely:
>=20
> - the NPT page table root
>=20
> - the L1 CR4.PAE, EFER.LMA and EFER.NXE bits, which determine the =
format
> of the NPT12 page tables
>=20
> These are covered by the existing vmstate_svm_npt subsection.
>=20
> On the other hand, the lack of something like VMXON/VMCS12 state means
> that AMD already sorta works unless you're migrating while in guest
> mode.  For Intel, just execute VMXON before migration, and starting =
any
> VM after migration is doomed.

True.

>=20
> So, overall I prefer not to block migration.

I=E2=80=99m not sure I agree.
It is quite likely that vCPU is currently in guest-mode while you are =
migrating=E2=80=A6
A good hypervisor tries to maximise CPU time to be in guest-mode rather =
than host-mode. :)

I prefer to block migration and once we formally complete the =
implementation of SVM nested state,
we can modify QEMU code such that migration of vCPU exposed with SVM =
will work in case
nested-state states that guest is in host-mode.

>=20
>>> +        ((kvm_max_nested_state_length() <=3D 0) || =
!has_exception_payload)) {
>>>        error_setg(&nested_virt_mig_blocker,
>>> -                   "Nested virtualization does not support live =
migration yet");
>>> +                   "Kernel do not provide required capabilities for =
=E2=80=9C
>>=20
>> As Maran have noted, we should change this =E2=80=9Cdo not=E2=80=9D =
to =E2=80=9Cdoes not=E2=80=9D.
>> Sorry for my bad English grammer. :)
>>=20
>>> +                   "nested virtualization migration. "
>>> +                   "(CAP_NESTED_STATE=3D%d, =
CAP_EXCEPTION_PAYLOAD=3D%d)",
>>> +                   kvm_max_nested_state_length() > 0,
>>> +                   has_exception_payload);
>>>        r =3D migrate_add_blocker(nested_virt_mig_blocker, =
&local_err);
>>>        if (local_err) {
>>>            error_report_err(local_err);
>>> diff --git a/target/i386/machine.c b/target/i386/machine.c
>>> index fc49e5a..851b249 100644
>>> --- a/target/i386/machine.c
>>> +++ b/target/i386/machine.c
>>> @@ -233,7 +233,7 @@ static int cpu_pre_save(void *opaque)
>>>=20
>>> #ifdef CONFIG_KVM
>>>    /* Verify we have nested virtualization state from kernel if =
required */
>>> -    if (cpu_has_nested_virt(env) && !env->nested_state) {
>>> +    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
>>=20
>> Good catch regarding adding kvm_enabled() here.
>=20
> Caught by "make check", not by me!

Ah nice to know :) Thanks for the tip.

>=20
>> But I think this should have been added to commit ("target/i386: kvm: =
Add support for save and restore nested state=E2=80=9D).
>=20
> This commit is where bisection broke. :)
>=20
> Paolo


