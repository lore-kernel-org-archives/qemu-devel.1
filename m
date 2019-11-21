Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C07C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D486920721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2Ir3jR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D486920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkO7-0003iv-Cm
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXkMi-0002Qh-Li
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXkMd-0003Kt-Ok
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:11:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXkMd-0003KY-LJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574334666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TawzbczB5ZaLworRLuYkNSRH0uLu3loMqvUOzkwLSLI=;
 b=b2Ir3jR3Q2VnDn6wvZHiLfJ6Y0J+Fm1MAPR5WacuRohUJ/rLaZFx/+d/0PZF54WdFfQUYm
 itxt4Xu9c1XuuhZiC6IOZLFoOjK32i1rCvDAjnU/FmihgoNty2wJogDvfstQbiO4XgRfSB
 oVPKnYM3wAreG+Xp4KMP948k8dM6f6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-hH1nT1lhN-6-OQrLiZ_x5Q-1; Thu, 21 Nov 2019 06:11:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55CEA184CAA3;
 Thu, 21 Nov 2019 11:11:02 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FF096CE70;
 Thu, 21 Nov 2019 11:10:58 +0000 (UTC)
Date: Thu, 21 Nov 2019 12:10:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 01/15] s390x: Cleanup cpu resets
Message-ID: <20191121121055.40968340.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-2-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-2-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hH1nT1lhN-6-OQrLiZ_x5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 06:43:20 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's move the resets into one function and switch by type, so we can
> use fallthroughs for shared reset actions.

Doing that makes sense.

>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c |   3 +
>  target/s390x/cpu.c         | 111 ++++++++++++++++---------------------
>  2 files changed, 52 insertions(+), 62 deletions(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d3edeef0ad..c1d1440272 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -348,6 +348,9 @@ static void s390_machine_reset(MachineState *machine)
>          break;
>      case S390_RESET_LOAD_NORMAL:
>          CPU_FOREACH(t) {
> +            if (t =3D=3D cs) {
> +                continue;
> +            }

Hm, why is this needed now?

>              run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>          }
>          subsystem_reset();
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3abe7e80fd..10d5b915d8 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -82,67 +82,53 @@ static void s390_cpu_load_normal(CPUState *s)
>  }
>  #endif
> =20
> -/* S390CPUClass::cpu_reset() */

Not sure if it would be worth keeping these comments near by the
calling functions.

> -static void s390_cpu_reset(CPUState *s)
> +enum {
> +    S390_CPU_RESET_NORMAL,
> +    S390_CPU_RESET_INITIAL,
> +    S390_CPU_RESET_CLEAR,
> +};

Maybe make this into a proper type, so you can use type checking?

(...)

The diff is a bit hard to read, but the change seems fine at a glance.


