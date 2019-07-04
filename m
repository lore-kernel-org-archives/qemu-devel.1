Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4085C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6FC21852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AA/T/0VM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6FC21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3nQ-0007uY-MU
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 11:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39565)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hj3lJ-0005wQ-KI
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hj3lI-0004Bc-5v
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:35:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hj3lH-0004B4-U8
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:35:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64FYKYl076730;
 Thu, 4 Jul 2019 15:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=hGR7YFPXzIc+qrlVGBLWd28DGtpEfZpFnh2JmNxsOWA=;
 b=AA/T/0VMzOJE6uo2qR7GBd627ZTIK7kyjCLXwD6pxXYkAX3JjkT9o0J/7JwslDBUcvcq
 cJ3bdUrusXQU+zxi9FJX1beyCPZDZJBg8sNcglTjn5gQHV7YvqkmqTh52oRLbtcxl3ui
 VCeiE+RIy2g7nhtGS/dr6dCacwVMrxkCGcOuI7SFpk6J9R+dDCeryoan4gr/KmLiSDoF
 BazSwebl6MLDxxxnvLej9U+VkDLW0jSX2re7KVd+x1PXsXMFGqrJu5UbJdHQMorb5gqM
 7UHO2UXVNEe0005gf0N/4+YrD3xAL/lSsDV3qWc/33fCDTQKtkHOWa8cskLVvI4ecsWV 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2te61efd2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 04 Jul 2019 15:35:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64FX8E9192678;
 Thu, 4 Jul 2019 15:35:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2th5qm3pcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 04 Jul 2019 15:35:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x64FYx6Y026908;
 Thu, 4 Jul 2019 15:34:59 GMT
Received: from [10.30.3.14] (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 04 Jul 2019 08:34:59 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <c5e7fd4d-3554-4df9-1e92-49e4ec02d653@redhat.com>
Date: Thu, 4 Jul 2019 18:34:55 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <24787A1B-1CD5-40C3-8CB2-FB16039EC5E6@oracle.com>
References: <20190624230514.53326-1-liran.alon@oracle.com>
 <6499083f-c159-1c3e-0339-87aa5b13c2c0@redhat.com>
 <432511A2-C6B4-4B03-87A5-176D886C0BF2@oracle.com>
 <c5e7fd4d-3554-4df9-1e92-49e4ec02d653@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040197
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040197
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH] target/i386: kvm: Fix when nested state is
 needed for migration
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 4 Jul 2019, at 18:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 04/07/19 16:31, Liran Alon wrote:
>>=20
>>=20
>>> On 2 Jul 2019, at 19:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>=20
>>> On 25/06/19 01:05, Liran Alon wrote:
>>>> When vCPU is in VMX operation and enters SMM mode,
>>>> it temporarily exits VMX operation but KVM maintained nested-state
>>>> still stores the VMXON region physical address, i.e. even when the
>>>> vCPU is in SMM mode then (nested_state->hdr.vmx.vmxon_pa !=3D =
-1ull).
>>>>=20
>>>> Therefore, there is no need to explicitly check for
>>>> KVM_STATE_NESTED_SMM_VMXON to determine if it is necessary
>>>> to save nested-state as part of migration stream.
>>>>=20
>>>> In addition, destination must enable eVMCS if it is enabled on
>>>> source as specified by the KVM_STATE_NESTED_EVMCS flag, even if
>>>> the VMXON region is not set. Thus, change the code to require =
saving
>>>> nested-state as part of migration stream in case it is set.
>>>>=20
>>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>> ---
>>>> target/i386/machine.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/target/i386/machine.c b/target/i386/machine.c
>>>> index 851b249d1a39..e7d72faf9e24 100644
>>>> --- a/target/i386/machine.c
>>>> +++ b/target/i386/machine.c
>>>> @@ -999,7 +999,7 @@ static bool vmx_nested_state_needed(void =
*opaque)
>>>>=20
>>>>    return ((nested_state->format =3D=3D =
KVM_STATE_NESTED_FORMAT_VMX) &&
>>>>            ((nested_state->hdr.vmx.vmxon_pa !=3D -1ull) ||
>>>> -             (nested_state->hdr.vmx.smm.flags & =
KVM_STATE_NESTED_SMM_VMXON)));
>>>> +             (nested_state->flags & KVM_STATE_NESTED_EVMCS)));
>>>> }
>>>>=20
>>>> static const VMStateDescription vmstate_vmx_nested_state =3D {
>>>>=20
>>>=20
>>> Queued, thanks.
>>>=20
>>> Paolo
>>=20
>> Actually Paolo after I have created KVM patch
>> ("KVM: nVMX: Change KVM_STATE_NESTED_EVMCS to signal vmcs12 is copied =
from eVMCS=E2=80=9D)
>> I think I realised that KVM_STATE_NESTED_EVMCS is actually not a =
requirement for nested-state to be sent.
>> I suggest to replace this commit with another one that just change =
vmx_nested_state_needed() to return true
>> In case format is FORMAT_VMX and vmxon_pa !=3D -1ull and that=E2=80=99s=
 it.
>>=20
>> As anyway, QEMU provisioned on destination side is going to enable =
the relevant eVMCS capability.
>> I=E2=80=99m going to send another series that refines QEMU =
nested-migration a bit more so I will do it along the way.
>> But I think this patch should be un-queued. Sorry for realizing this =
later but at least it=E2=80=99s before it was merged to master :)
>=20
> Replaced with
>=20
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 851b249d1a..704ba6de46 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -997,9 +997,8 @@ static bool vmx_nested_state_needed(void *opaque)
> {
>     struct kvm_nested_state *nested_state =3D opaque;
>=20
> -    return ((nested_state->format =3D=3D KVM_STATE_NESTED_FORMAT_VMX) =
&&
> -            ((nested_state->hdr.vmx.vmxon_pa !=3D -1ull) ||
> -             (nested_state->hdr.vmx.smm.flags & =
KVM_STATE_NESTED_SMM_VMXON)));
> +    return (nested_state->format =3D=3D KVM_STATE_NESTED_FORMAT_VMX =
&&
> +            nested_state->hdr.vmx.vmxon_pa !=3D -1ull);
> }
>=20
> static const VMStateDescription vmstate_vmx_nested_state =3D {
>=20
> and dropped the last paragraph of the commit message.
>=20
> Paolo
>=20

Yep that=E2=80=99s what I wanted to do.
Thanks. I have some more patches pending anyway but unrelated to this. =
This now seems good to me.

-Liran



