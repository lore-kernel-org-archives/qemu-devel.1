Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5F7C31E44
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7513421848
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jMKSNyN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7513421848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbx27-00031E-PX
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 20:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33243)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hbwq2-00035R-Lz
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hbwq0-0007A3-IM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:46:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hbwpv-0006yW-8C
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:46:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5F0ic4a183388;
 Sat, 15 Jun 2019 00:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=xqx5AeEH7HTlnSEdm1aYiuaDxJZlTepCeRJIr0PjXro=;
 b=jMKSNyN9PzkMCmgPyk1hA+qaAFqJ46+JtzPZxFcFMtBFHmDVLh9karYcErvp+BCRfGIx
 8Xf7g5Rytn6D8xdm5KUzUGGNVZGFzWa3Oc5FtSSGsSzwT7DFV2R595N2YYCEO9bR+MUQ
 2b5TEDacJnNl6HFmrdwYoMhDSLnND/fDflKvzmhDQpryWHXDa7iEp3fhN3LD26oeY0P5
 UkH81A9I48pGDKDK0+1uJZS3LNbQ7w7ZnvUUB2YsCmaU6K7Xx6oyL6/YHboQpwd4P/OE
 nGBtcqGtYbZ6QIxJm4VLPK3L0bYmSFxf8SVeiEK79ERAeG+oh4sCX+bVR8MqjFfIs3M0 Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t05nr9rrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jun 2019 00:46:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5F0jS9q087329;
 Sat, 15 Jun 2019 00:46:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2t4nst0ajn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jun 2019 00:46:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5F0kDx4026162;
 Sat, 15 Jun 2019 00:46:14 GMT
Received: from [10.0.0.13] (/109.66.72.187)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 14 Jun 2019 17:46:13 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190615004256.16367-2-pbonzini@redhat.com>
Date: Sat, 15 Jun 2019 03:46:10 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <216F5631-D0EC-4A72-B333-FC51C675DF64@oracle.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
 <20190615004256.16367-2-pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9288
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906150003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9288
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906150003
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH 1/7] KVM: i386: Use symbolic constant for
 #DB/#BP exception constants
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
Cc: qemu-devel@nongnu.org, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 15 Jun 2019, at 3:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> From: Liran Alon <liran.alon@oracle.com>
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> target/i386/kvm.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3b29ce5c0d..c8d8196e71 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2994,9 +2994,9 @@ static int kvm_guest_debug_workarounds(X86CPU =
*cpu)
>     unsigned long reinject_trap =3D 0;
>=20
>     if (!kvm_has_vcpu_events()) {
> -        if (env->exception_injected =3D=3D 1) {
> +        if (env->exception_injected =3D=3D EXCP01_DB) {
>             reinject_trap =3D KVM_GUESTDBG_INJECT_DB;
> -        } else if (env->exception_injected =3D=3D 3) {
> +        } else if (env->exception_injected =3D=3D EXCP03_INT3) {
>             reinject_trap =3D KVM_GUESTDBG_INJECT_BP;
>         }
>         env->exception_injected =3D -1;
> @@ -3508,7 +3508,7 @@ static int kvm_handle_debug(X86CPU *cpu,
>     int ret =3D 0;
>     int n;
>=20
> -    if (arch_info->exception =3D=3D 1) {
> +    if (arch_info->exception =3D=3D EXCP01_DB) {
>         if (arch_info->dr6 & (1 << 14)) {

Note: In the patch-series I will submit, I also replaced this =E2=80=9C1 =
<< 14=E2=80=9D with DR6_BS.

>             if (cs->singlestep_enabled) {
>                 ret =3D EXCP_DEBUG;
> --=20
> 2.21.0
>=20
>=20


