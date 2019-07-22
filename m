Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E29C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D65BA2199C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hpXPrjBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65BA2199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUsS-0003Hl-QU
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48092)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hpUsF-0002ka-81
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hpUsD-0007co-Pe
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:44:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hpUsD-0007bC-Fw
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:44:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6M9hWMn001044;
 Mon, 22 Jul 2019 09:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=fQ63cis1xmizacMOIDbI1yyu/suYh+T6Ujx1epFnZCU=;
 b=hpXPrjBrp6L35mXnD+1f+pJHVtLwlFY2Yi9VZhXzO/Kt6I3DPvnWlrLsM1iIHBtzzc0g
 /3R8ZQBrDxQGRVaaKBs8BAn65zfA+M0ymxk5sSxfNDWt+Oub5NhDM+2V3ycdrpWCZbEz
 NZiKFDZqdAVXi0YjaqReDNvFM50X+O/LrwmzNuS/JwAAKUwP/7bXcQ1QUixecThrzdDR
 9ApiDGU/iRTAVtzn+3xyXpVoYxG4tunmo0Otrv/UQJNyEyQMaXzwIgNPHLlfNjswFldJ
 PU6o0OkQK5UG1wbMW8clmk9Oc9aEdBCHw365lmjw+XxO01YJJWrVTaku5HzLzoin69cH nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2tuukqdgs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2019 09:44:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6M9hLwC071067;
 Mon, 22 Jul 2019 09:44:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2tur2tqrqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2019 09:44:46 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6M9ijst029603;
 Mon, 22 Jul 2019 09:44:45 GMT
Received: from [192.168.14.112] (/79.181.226.30)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 22 Jul 2019 02:44:45 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <bdd53f40-4e60-f3ae-7ec6-162198214953@siemens.com>
Date: Mon, 22 Jul 2019 12:44:42 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9036EC6-848A-4D42-95AF-42E2302EEC0B@oracle.com>
References: <bdd53f40-4e60-f3ae-7ec6-162198214953@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9325
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=882
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9325
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=931 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220115
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: Do not sync nested state during
 runtime
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 22 Jul 2019, at 7:00, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>=20
> Writing the nested state e.g. after a vmport access can invalidate
> important parts of the kernel-internal state, and it is not needed as
> well. So leave this out from KVM_PUT_RUNTIME_STATE.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

As QEMU never modifies vCPU nested-state in userspace besides in vmload =
and vCPU creation,
shouldn=E2=80=99t this be under KVM_PUT_FULL_STATE? Same as the call to =
kvm_arch_set_tsc_khz().

-Liran=20

> ---
> target/i386/kvm.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ec7870c6af..da98b2cbca 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -3577,12 +3577,12 @@ int kvm_arch_put_registers(CPUState *cpu, int =
level)
>=20
>     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>=20
> -    ret =3D kvm_put_nested_state(x86_cpu);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
>     if (level >=3D KVM_PUT_RESET_STATE) {
> +        ret =3D kvm_put_nested_state(x86_cpu);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
>         ret =3D kvm_put_msr_feature_control(x86_cpu);
>         if (ret < 0) {
>             return ret;
> --=20
> 2.16.4


