Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC22C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB04720861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hbMIJcMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB04720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcq43-0005Tp-64
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hcpul-0000j6-Hi
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hcpuc-0006Ml-Ne
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:35:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hcpua-0006Cd-Rj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:34:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HBYVo6127979;
 Mon, 17 Jun 2019 11:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=AOrjJsAqgZmajPixleP9RpjlmZ7aT1aCDqcmaieEUE8=;
 b=hbMIJcMuKN0A+Z38Th2Dde8p1Iw4RhPPz7YBsn+tthDs5i7834i7l6T1jSm6BlIeff/b
 6LV/lrN4CRaMbIUNmfhYezbalH3DNNPoJtBCY0fZcXBg8JhsokeNcjqBdEuHIFvpswBj
 +ray5ZDpT7H8FoB7ZbN1NHCj2W95iBBXF5f8qe6onpCiomm+rO0XaA6DYdMu0Wov7985
 v8W6fq0Ad2VXCyTpENnmN2aPeCHyF1h9T2QwLuj2pE5QVMBwd3BXLxRMuYkaVaexnruC
 sHUGmAQ9FSjYp8esW9Ce9TFePUlww2vQd83bwBOuJ4aayE5zFbSUm5TSPY6CxJjNmn// +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t4rmnx1ja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 11:34:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HBX49M018380;
 Mon, 17 Jun 2019 11:34:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2t5h5t3c4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 11:34:48 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HBYltb001257;
 Mon, 17 Jun 2019 11:34:47 GMT
Received: from [10.30.3.10] (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 04:34:47 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <0144E234-98F2-4D05-B2AB-8DA23E418D46@oracle.com>
Date: Mon, 17 Jun 2019 14:34:44 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <74FC0FAA-54DE-4E72-90F5-32B0551F1D83@oracle.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
 <20190615004256.16367-4-pbonzini@redhat.com>
 <EB7EDEC6-BD44-460E-B7B2-29060631E4FF@oracle.com>
 <0144E234-98F2-4D05-B2AB-8DA23E418D46@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170108
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH 3/7] KVM: i386: Add support for
 KVM_CAP_EXCEPTION_PAYLOAD
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
Cc: Maran Wilson <maran.wilson@oracle.com>, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 16 Jun 2019, at 15:38, Liran Alon <liran.alon@oracle.com> wrote:
>=20
>=20
>=20
>> On 15 Jun 2019, at 3:57, Liran Alon <liran.alon@oracle.com> wrote:
>>=20
>>> On 15 Jun 2019, at 3:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>=20
>>> From: Liran Alon <liran.alon@oracle.com>
>>>=20
>>> +static bool is_vmx_enabled(CPUX86State *env)
>>> +{
>>> +    return (IS_INTEL_CPU(env) && (env->cr[4] & CR4_VMXE_MASK));
>>> +}
>>> +
>>> +static bool is_svm_enabled(CPUX86State *env)
>>> +{
>>> +    return (IS_AMD_CPU(env) && (env->efer & MSR_EFER_SVME));
>>> +}
>>> +
>>> +static bool is_nested_virt_enabled(CPUX86State *env)
>>> +{
>>> +    return (is_vmx_enabled(env) || is_svm_enabled(env));
>>> +}
>>=20
>> I have later realised that this nested_virt_enabled() function is not =
enough to determine if nested_state is required to be sent.
>> This is because it may be that vCPU is running L2 but have =
momentarily entered SMM due to SMI.
>> In this case, CR4 & MSR_EFER are saved in SMRAM and are set to 0 on =
entering to SMM.
>> This means that in case (env->hflags & HF_SMM_MASK), we theoretically =
should have read saved CR4 & MSR_EFER from SMRAM.
>> However, because we cannot reference guest memory at this point (Not =
valid in case we migrate guest in post-copy), I should change
>> code to assume that in case (env->hflags & HF_SMM_MASK), we need to =
assume that nested-state is needed.
>> This should break backwards-compatability migration only in very rare =
cases and therefore I think it should be sufficient.
>> Any objections to this idea?
>>=20
>=20
> Actually, this is even worse than I originally thought.
> Even in case guest is not currently in SMM mode, if it=E2=80=99s in =
VMX non-root mode, the CR4 read here is L2 CR4. Not L1 CR4.
> Therefore, CR4.VMXE doesn=E2=80=99t necessarily indicate if guest have =
nested-virtualization enabled. Same is true for MSR_EFER in case of SVM.
>=20
> Putting this all together, in case kernel doesn=E2=80=99t support =
extracting nested-state, there is no decent way to know if guest is =
running nested-virtualization.
> Which means that in theory we always need to fail migration in case =
kernel doesn=E2=80=99t support KVM_CAP_NESTED_STATE or =
KVM_CAP_EXCEPTION_PAYLOAD
> and vCPU is exposed with VMX/SVM capability.
>=20
> I can condition this behaviour with a flag that can be manipulated =
using QMP to allow user to indicate it wishes to migrate guest anyway in =
this case.
> This however bring me back to the entire discussion I had with Dr. =
David Alan Gilbert on migration backwards compatibility in general and =
the fact that I believe
> we should have a generic QMP command which allows to provide list of =
VMState subsections that can be ignored in migration=E2=80=A6
> See: https://www.mail-archive.com/qemu-devel@nongnu.org/msg622274.html
>=20
> Paolo, What are your thoughts on how I would proceed with this?
>=20
> -Liran
>=20

Paolo, can you also elaborate what was your original intent in this QEMU =
commit you made:
f8dc4c645ec2 ("target/i386: rename HF_SVMI_MASK to HF_GUEST_MASK")

How did you expect this flag to be used in nVMX migration?
Currently the HF_GUEST_MASK flag in KVM that is set in vcpu->arch.hflags =
is never propagated to userspace.
Did you expect to set HF_GUEST_MASK in QEMU=E2=80=99s hflag based on =
nested_state returned by KVM_GET_NESTED_STATE ioctl?
What is the value of this hflag in QEMU given that we have all the =
information we need in env->nested_state?
(E.g. We can deduce vCPU is in VMX non-root mode by testing for =
(env->nested_state.flags & KVM_STATE_NESTED_GUEST_MODE)).

-Liran


