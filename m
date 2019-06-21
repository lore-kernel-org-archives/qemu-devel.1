Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA933C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8743020449
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="amp4RluE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8743020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heL7I-0002QG-9k
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 11:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50618)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heL2C-0008UM-77
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heL1s-00017B-S4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:00:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heL1n-0000yo-IG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:00:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LExQuD069311;
 Fri, 21 Jun 2019 15:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=iUueJpciRd5+L7Nyb1u2ZjUOAY3oI3QhAUxM/MUEwnc=;
 b=amp4RluE2JuK7dgyTHplTXHpJkAfRzfJLRmF4UeWeSS2rT9JKpT33hcRndxQivqO8KWI
 /353eBnVWc85FI/e9OEfa7Mgp0abaOk7rejnyWE5wqgEMi7Aa/z32L3OgOsOvuPHgtT2
 1q462vL8DSZoXk423WzN/GX6PKrQLcHkqXjFVTiQ/lnHsdDPfb5EK0R5/ph7oqvrPYfL
 b4giSNwe2Qn+3bcKQAjwBxpe3223SpW7UqbJIs5opus47axe4IKPJWeOTifsnAuzCU//
 zYSuOCLgEw5hwB9MNs/NZ43v77wgOAXhKt6B4q8CcRR4siHOmdysOz6US829YA/RBmoS 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t7809pybt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 15:00:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LExg64070025;
 Fri, 21 Jun 2019 15:00:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2t77yp8byq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 15:00:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5LF0UIf010676;
 Fri, 21 Jun 2019 15:00:30 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 08:00:30 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <beac3448-d66f-438f-c0bf-b35bc7c90137@redhat.com>
Date: Fri, 21 Jun 2019 18:00:28 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <10C55D5F-B505-4172-8500-D8EBCEA43941@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-21-git-send-email-pbonzini@redhat.com>
 <C67C73E9-F0FA-4711-98F1-BB5CD782E473@oracle.com>
 <3b4d778c-8c41-b8f2-7e1c-b7328072c3d5@redhat.com>
 <96B0BE25-AA15-4FAA-9228-A68C0845E110@oracle.com>
 <beac3448-d66f-438f-c0bf-b35bc7c90137@redhat.com>
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
 definitions=main-1906210123
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PULL 20/25] target/i386: kvm: Add support for
 save and restore nested state
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



> On 21 Jun 2019, at 17:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 21/06/19 14:48, Liran Alon wrote:
>>=20
>>=20
>>> On 21 Jun 2019, at 15:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>=20
>>> On 21/06/19 14:29, Liran Alon wrote:
>>>>> +    max_nested_state_len =3D kvm_max_nested_state_length();
>>>>> +    if (max_nested_state_len > 0) {
>>>>> +        assert(max_nested_state_len >=3D offsetof(struct =
kvm_nested_state, data));
>>>>> +        env->nested_state =3D g_malloc0(max_nested_state_len);
>>>>> +
>>>>> +        env->nested_state->size =3D max_nested_state_len;
>>>>> +
>>>>> +        if (IS_INTEL_CPU(env)) {
>>>> I think it=E2=80=99s better to change this to: =E2=80=9Cif =
(cpu_has_vmx(env))=E2=80=9D {
>>>>=20
>>>>> +            struct kvm_vmx_nested_state_hdr *vmx_hdr =3D
>>>>> +                &env->nested_state->hdr.vmx;
>>>>> +
>>>>> +            env->nested_state->format =3D =
KVM_STATE_NESTED_FORMAT_VMX;
>>>>> +            vmx_hdr->vmxon_pa =3D -1ull;
>>>>> +            vmx_hdr->vmcs12_pa =3D -1ull;
>>>>> +        }
>>>>> +    }
>>>> I think we should add here:
>>>> } else if (cpu_has_svm(env)) {
>>>>   env->nested_state->format =3D KVM_STATE_NESTED_FORMAT_SVM;
>>>> }
>>>=20
>>> Or even force max_nested_state_len to 0 for AMD hosts, so that
>>> kvm_get/put_nested_state are dropped completely.
>>>=20
>>> Paolo
>>>=20
>>=20
>> On AMD hosts, KVM returns 0 for KVM_CAP_NESTED_STATE because
>> Kvm-and.ko have kvm_x86_ops->get_nested_state set to NULL.
>> See kvm_vm_ioctl_check_extension().
>=20
> Yes, now it does, my idea was to force that behavior in QEMU until we
> know what SVM support actually looks like.
>=20
> In principle I don't like the idea of crossing fingers, even though
> there's an actual possibility that it could work.  But it couldn't be
> worse than what we have now, so maybe it *is* actually a good idea, =
just
> with some comment that explains the rationale.
>=20
> Paolo

Cool.
Are you planning to make those changes when applying/merging or
do you need me to submit a new patch-series version?
Also note my comment on the other patch regarding block migration on AMD =
vCPU which expose SVM.

-Liran

>=20
>=20
>> I just thought it will be nicer to add what I proposed above as when =
kernel adds support
>> for nested state on AMD host, QEMU would maybe just work.
>> (Because maybe all state required for AMD nSVM is just flags in =
env->nested_state->flags).
>>=20
>> -Liran
>>=20
>=20


