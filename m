Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E4AC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B566206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P1iLvrOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B566206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdxPj-0004wf-Fl
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 09:47:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hdxL6-0002eg-3J
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hdxL4-0001i9-Dl
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:42:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hdxL4-0001hh-3m
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:42:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KDdcgd010527;
 Thu, 20 Jun 2019 13:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=9HdU2U+stuqNpmsAAx7ml3U2tP+4IG26hVrZ9/sPtWo=;
 b=P1iLvrOaBJEqAu9JdjXXyInm51Dlz4E00eAd8Z8qltDetyhWxGTI2YjCGD+DE4JPsYGJ
 B+MeJZf6/LsUXGs8e1VImGiKQtqScJr9XSh6QuWdORA0nxLTGo1TIzqIdQZee36btGem
 krCYMxbAD3AZcKPbQma82sGq+cjx2EGgYYVQbs7w4gNt89QKV9/rtaukldXvUGQsCQfd
 jt1W6RcrluerZ8T7Zet81Sr24/ygxL49ki2ipnb+2G2A/dBTd3ihnlKkLygT2SEUFCoV
 nwpmuEpysTiqxduDGN3fuiz1XlLqP95Y+8DoqYCfKDeSu6JI2twVv43FVVZTijYnJP7G wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2t7809h6jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 13:42:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KDdHss071465;
 Thu, 20 Jun 2019 13:40:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2t7rdx601n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 13:40:50 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5KDen9l023209;
 Thu, 20 Jun 2019 13:40:49 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 20 Jun 2019 06:40:34 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <D804B7FE-EB38-4D3E-A251-C69CC979D383@oracle.com>
Date: Thu, 20 Jun 2019 16:40:30 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <04A2B953-177F-4EA3-98E0-0D141C97FCF4@oracle.com>
References: <20190619162140.133674-1-liran.alon@oracle.com>
 <bcb617b1-7d20-d2ff-81c5-9f165eae5683@redhat.com>
 <D804B7FE-EB38-4D3E-A251-C69CC979D383@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [QEMU PATCH v4 0/10]: target/i386: kvm: Add
 support for save and restore of nested state
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 20 Jun 2019, at 16:28, Liran Alon <liran.alon@oracle.com> wrote:
>=20
>=20
>=20
>> On 20 Jun 2019, at 15:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>=20
>> On 19/06/19 18:21, Liran Alon wrote:
>>> Hi,
>>>=20
>>> This series aims to add support for QEMU to be able to migrate VMs =
that
>>> are running nested hypervisors. In order to do so, it utilizes the =
new
>>> IOCTLs introduced in KVM commit 8fcc4b5923af ("kvm: nVMX: Introduce
>>> KVM_CAP_NESTED_STATE") which was created for this purpose.
>>=20
>> Applied with just three minor changes that should be uncontroversial:
>=20
> ACK. Where can I see the applied patches for review?
>=20
>>=20
>>> 6rd patch updates linux-headers to have updated struct =
kvm_nested_state.
>>> The updated struct now have explicit fields for the data portion.
>>=20
>> Changed patch title to "linux-headers: sync with latest KVM headers =
from
>> Linux 5.2=E2=80=9D
>=20
> ACK.
>=20
>>=20
>>> 7rd patch add vmstate support for saving/restoring kernel integer =
types (e.g. __u16).
>>>=20
>>> 8th patch adds support for saving and restoring nested state in =
order to migrate
>>> guests which run a nested hypervisor.
>>=20
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index e924663f32..f3cf6e1b27 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1671,10 +1671,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>            struct kvm_vmx_nested_state_hdr *vmx_hdr =3D
>>                &env->nested_state->hdr.vmx;
>>=20
>> +            env->nested_state->format =3D =
KVM_STATE_NESTED_FORMAT_VMX;
>>            vmx_hdr->vmxon_pa =3D -1ull;
>>            vmx_hdr->vmcs12_pa =3D -1ull;
>>        }
>> -
>>    }
>>=20
>>    cpu->kvm_msr_buf =3D g_malloc0(MSR_BUF_SIZE);
>>=20
>> which is a no-op since KVM_STATE_NESTED_FORMAT_VMX is zero, but it's =
tidy.
>=20
> I agree. My bad. Thanks for adding this :)

Actually, I think it makes more sense to condition here on =
cpu_has_vmx(env) instead of IS_INTEL_CPU(env).
And also add an =E2=80=9Celse if (cpu_has_svm(env))=E2=80=9D that sets =
env->nested_state->format to KVM_STATE_NESTED_FORMAT_SVM.
If you can change that when applying. :)

-Liran

>=20
>>=20
>>> 9th patch add support for KVM_CAP_EXCEPTION_PAYLOAD. This new KVM =
capability
>>> allows userspace to properly distingiush between pending and =
injecting exceptions.
>>>=20
>>> 10th patch changes the nested virtualization migration blocker to =
only
>>> be added when kernel lack support for one of the capabilities =
required
>>> for correct nested migration. i.e. Either KVM_CAP_NESTED_STATE or
>>> KVM_CAP_EXCEPTION_PAYLOAD.
>>=20
>> Had to disable this for SVM unfortunately.
>=20
> For backwards compatibility I assume=E2=80=A6 Sounds reasonable to me =
so ACK.
>=20
> Even though I must say I would really like to hear your opinion about =
the thread I had with David Gilbert regarding QEMU=E2=80=99s migration =
backwards compatibility:
> =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.mail-2Darchive.=
com_qemu-2Ddevel-40nongnu.org_msg622274.html&d=3DDwIFaQ&c=3DRoP1YumCXCgaWH=
vlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbp=
Tx0&m=3DaPCucPqkbmosKyDNeWq6rNNJ4Ry4GCh4HlxnZcQvAS8&s=3DZnEgQlntxSZ2cZf9nn=
qJa74vM3cq_yPUlTEL1pwVpUs&e=3D
>=20
> Thanks for the assistance pushing this forward,
> -Liran
>=20
>=20


