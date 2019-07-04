Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D05C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948F8218AD
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RfYAQdKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948F8218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj2qc-0003FG-Q7
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 10:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hj2nb-0001Ii-T9
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hj2nY-0006Op-56
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:33:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hj2nU-0006JQ-Qv
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:33:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64ESpDc039062;
 Thu, 4 Jul 2019 14:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=SYkJRChKr5OFaHNsQCl7CS4H4WHEPPFFCS9F8ZVEN6Q=;
 b=RfYAQdKqNo+ijKvg6FiF+WDqUMauQyNdrMusYvn9CVKoL4EOEQaillZWkZZQ1dj1cizY
 4vrmEUqAryNTRs3+Xs2fHOvvN+9PzsTUhQQSm3vmem+kDU7Z1f6QL4/5iYSDDmMSj6dw
 VHAoF2CLF5j0gna+5j9vtRS0k0p34xNO3MHXC1hb1S3HW+YqIsY2S39m82/MifOMIrdp
 tPKWaDhrG0x4MY/vzVS4qaLNgS01bPwfy+cbZzae+qhhaUwNqP49XtBLk1HalFH0lNLb
 xsMcoMCN928R5YbYSPYnu7eOwmorOqY47VLl8Rxn8q6iQ9ty/JGpTfUUodIE4BjuATTF SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2te61q76pc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 04 Jul 2019 14:33:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64ESLkQ070103;
 Thu, 4 Jul 2019 14:31:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2th5qm306b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 04 Jul 2019 14:31:10 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x64EV95F027849;
 Thu, 4 Jul 2019 14:31:09 GMT
Received: from [10.30.3.14] (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 04 Jul 2019 07:31:09 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <6499083f-c159-1c3e-0339-87aa5b13c2c0@redhat.com>
Date: Thu, 4 Jul 2019 17:31:06 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <432511A2-C6B4-4B03-87A5-176D886C0BF2@oracle.com>
References: <20190624230514.53326-1-liran.alon@oracle.com>
 <6499083f-c159-1c3e-0339-87aa5b13c2c0@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040182
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
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



> On 2 Jul 2019, at 19:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 25/06/19 01:05, Liran Alon wrote:
>> When vCPU is in VMX operation and enters SMM mode,
>> it temporarily exits VMX operation but KVM maintained nested-state
>> still stores the VMXON region physical address, i.e. even when the
>> vCPU is in SMM mode then (nested_state->hdr.vmx.vmxon_pa !=3D -1ull).
>>=20
>> Therefore, there is no need to explicitly check for
>> KVM_STATE_NESTED_SMM_VMXON to determine if it is necessary
>> to save nested-state as part of migration stream.
>>=20
>> In addition, destination must enable eVMCS if it is enabled on
>> source as specified by the KVM_STATE_NESTED_EVMCS flag, even if
>> the VMXON region is not set. Thus, change the code to require saving
>> nested-state as part of migration stream in case it is set.
>>=20
>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>> target/i386/machine.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/target/i386/machine.c b/target/i386/machine.c
>> index 851b249d1a39..e7d72faf9e24 100644
>> --- a/target/i386/machine.c
>> +++ b/target/i386/machine.c
>> @@ -999,7 +999,7 @@ static bool vmx_nested_state_needed(void *opaque)
>>=20
>>     return ((nested_state->format =3D=3D KVM_STATE_NESTED_FORMAT_VMX) =
&&
>>             ((nested_state->hdr.vmx.vmxon_pa !=3D -1ull) ||
>> -             (nested_state->hdr.vmx.smm.flags & =
KVM_STATE_NESTED_SMM_VMXON)));
>> +             (nested_state->flags & KVM_STATE_NESTED_EVMCS)));
>> }
>>=20
>> static const VMStateDescription vmstate_vmx_nested_state =3D {
>>=20
>=20
> Queued, thanks.
>=20
> Paolo

Actually Paolo after I have created KVM patch
("KVM: nVMX: Change KVM_STATE_NESTED_EVMCS to signal vmcs12 is copied =
from eVMCS=E2=80=9D)
I think I realised that KVM_STATE_NESTED_EVMCS is actually not a =
requirement for nested-state to be sent.
I suggest to replace this commit with another one that just change =
vmx_nested_state_needed() to return true
In case format is FORMAT_VMX and vmxon_pa !=3D -1ull and that=E2=80=99s =
it.

As anyway, QEMU provisioned on destination side is going to enable the =
relevant eVMCS capability.
I=E2=80=99m going to send another series that refines QEMU =
nested-migration a bit more so I will do it along the way.
But I think this patch should be un-queued. Sorry for realizing this =
later but at least it=E2=80=99s before it was merged to master :)

-Liran


