Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B12C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B4720740
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHCIA1N9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B4720740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHCQT-00065G-8P
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 16:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHCPq-0005ge-Am
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHCPo-0005L3-Gy
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:14:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHCPo-0005K8-03
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585167254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgYxynXtb3SbJQ7mEAm56njPlG5iX0ode6CXQ0kLybc=;
 b=IHCIA1N9pHqmh18Jd4QGrDgivpevGaudNxAf1iwSsnfvWCJPs4Jljnud1XT4MWqfgyqZOA
 hRoIBxecA1wU38RFq/kDJWfZGZqcO7bxwHn2axztw71vsjw730yBC7rySumUpuR4rSuFpm
 vxrgmo+kV/gI+28yruJnuzKB1fnCNNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458--Bw0Hmz0PN2g4O5DWdRZ-A-1; Wed, 25 Mar 2020 16:14:12 -0400
X-MC-Unique: -Bw0Hmz0PN2g4O5DWdRZ-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC509107ACCC
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 20:14:11 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49F495D9C5;
 Wed, 25 Mar 2020 20:14:05 +0000 (UTC)
Date: Wed, 25 Mar 2020 20:14:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 8/9] KVM: Add dirty-ring-size property
Message-ID: <20200325201403.GH2635@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-9-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-9-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> Add a parameter for size of dirty ring.  If zero, dirty ring is
> disabled.  Otherwise dirty ring will be enabled with the per-vcpu size
> as specified.  If dirty ring cannot be enabled due to unsupported
> kernel, it'll fallback to dirty logging.  By default, dirty ring is
> not enabled (dirty-ring-size=3D=3D0).
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

<snip>

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 224a8e8712..140bd38726 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -119,6 +119,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>      "                kernel-irqchip=3Don|off|split controls accelerated =
irqchip support (default=3Don)\n"
>      "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\n"
>      "                tb-size=3Dn (TCG translation block cache size)\n"
> +    "                dirty-ring-size=3Dn (KVM dirty ring size in Bytes)\=
n"
>      "                thread=3Dsingle|multi (enable multi-threaded TCG)\n=
", QEMU_ARCH_ALL)
>  STEXI
>  @item -accel @var{name}[,prop=3D@var{value}[,...]]
> @@ -140,6 +141,8 @@ irqchip completely is not recommended except for debu=
gging purposes.
>  Defines the size of the KVM shadow MMU.
>  @item tb-size=3D@var{n}
>  Controls the size (in MiB) of the TCG translation block cache.
> +@item dirty-ring-size=3D@val{n}
> +Controls the size (in Bytes) of KVM dirty ring (<=3D0 to disable).

I think that needs to say 'per vcpu'

Dave

>  @item thread=3Dsingle|multi
>  Controls number of TCG threads. When the TCG is multi-threaded there wil=
l be one
>  thread per vCPU therefor taking advantage of additional host cores. The =
default
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


