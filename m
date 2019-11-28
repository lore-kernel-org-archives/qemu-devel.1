Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D5FC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE1F2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEW/LW4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE1F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLGb-0008Kt-5U
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaKow-000367-PP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaKoq-0001Bc-1z
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:30:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36360
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaKop-0000vr-Qw
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574951452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=zTi7RCuRGqRg19ojTdgRf65UBir01TR5H3GZctm4RF4=;
 b=dEW/LW4FQU0Cf9SNpTVL72/0EeXVR9Mcqp367EScdyv19EkQwnkVqTpbfgnX0VHyQg+RNE
 QdyWN3HJcp5ziWBTWQkuBS4/qCkgvRuzLMmEMAmySo8HD47rTsWfB5H0SkQFSG/zu15Qb0
 1vI/xxycJ7IfqcpJWUoKOFON5Cp/DZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-CIh-CseONzurPrhHVU-eYg-1; Thu, 28 Nov 2019 09:30:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE60101F7D3;
 Thu, 28 Nov 2019 14:30:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26D635D9C5;
 Thu, 28 Nov 2019 14:30:42 +0000 (UTC)
Subject: Re: [PATCH 12/15] s390x: protvirt: Set guest IPL PSW
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-13-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <514819c7-261b-4d7e-4531-2da7d28526c7@redhat.com>
Date: Thu, 28 Nov 2019 15:30:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-13-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CIh-CseONzurPrhHVU-eYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 12.43, Janosch Frank wrote:
> Handling of CPU reset and setting of the IPL psw from guest storage at
> offset 0 is done by a Ultravisor call. Let's only fetch it if
> necessary.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/pv.c              | 5 +++++
>  hw/s390x/pv.h              | 1 +
>  hw/s390x/s390-virtio-ccw.c | 3 ++-
>  linux-headers/linux/kvm.h  | 1 +
>  target/s390x/cpu.c         | 9 ++++++++-
>  5 files changed, 17 insertions(+), 2 deletions(-)
[...]
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 6fd50b4c42..e020b92854 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -404,7 +404,8 @@ static void s390_machine_reset(MachineState *machine)
>          s390_ipl_pv_unpack();
>          /* Verify integrity */
>          s390_pv_verify();
> -        s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> +        env->pv =3D true;

Ah, here you set env->pv =3D true manually ... so maybe that's another
good reason to get rid of patch 05/15 ("s390x: protvirt: Sync PV state")
in the end?

Reviewed-by: Thomas Huth <thuth@redhat.com>


