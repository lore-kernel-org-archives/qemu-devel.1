Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CCDC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610CF20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNRicseZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610CF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvYa-0003ZA-I7
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iyvXm-0002Ua-E0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iyvXl-0000Rb-7u
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:34:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iyvXl-0000P1-2d
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580812496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2ppv8VdQFYEFb3YbQEdr4SJtjIEKEg19DLBErWYPcY=;
 b=gNRicseZ0BtdEdDZOKj6sgX/5PJsM3ulQpVW/w/kPq75A5u3EGi7WqGvBZJ8KTOjU8dYIe
 sh2Ng5vP29seEVCdIsJmu8jumZ9GRWcTuCrvoBF8z9HrGvhOPagbKXM27LVSj8HdNTQWlF
 FebKOTufV8TT4XP38ADkmz5eadRj0mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-Z-AHNODQMpS_xR1azR6Erw-1; Tue, 04 Feb 2020 05:34:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 443E9801A1F;
 Tue,  4 Feb 2020 10:34:51 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A9DD8068E;
 Tue,  4 Feb 2020 10:34:49 +0000 (UTC)
Date: Tue, 4 Feb 2020 11:34:47 +0100
From: Andrew Jones <drjones@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 1/2] target/arm: kvm: Inject events at the last stage
 of sync
Message-ID: <20200204103447.naw26xl2y2zbyrqb@kamzik.brq.redhat.com>
References: <20200129202441.12745-1-beata.michalska@linaro.org>
 <20200129202441.12745-2-beata.michalska@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200129202441.12745-2-beata.michalska@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Z-AHNODQMpS_xR1azR6Erw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, Christoffer.Dall@arm.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 08:24:40PM +0000, Beata Michalska wrote:
> KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
> As such this should be the last step of sync to avoid potential overwriti=
ng
> of whatever changes KVM might have done.
>=20
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  target/arm/kvm32.c | 20 ++++++++++----------
>  target/arm/kvm64.c | 20 ++++++++++----------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>=20
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index 32bf8d6..cf2b47f 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -386,17 +386,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
> =20
> -    ret =3D kvm_put_vcpu_events(cpu);
> -    if (ret) {
> -        return ret;
> -    }
> -
>      write_cpustate_to_list(cpu, true);
> =20
>      if (!write_list_to_kvmstate(cpu, level)) {
>          return EINVAL;
>      }
> =20
> +    ret =3D kvm_put_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +

I think we should put a comment above this that says basically the same
thing as the commit message in order to explain why kvm_put_vcpu_events()
*must* be after write_list_to_kvmstate().

>      kvm_arm_sync_mpstate_to_kvm(cpu);
> =20
>      return ret;
> @@ -462,11 +462,6 @@ int kvm_arch_get_registers(CPUState *cs)
>      }
>      vfp_set_fpscr(env, fpscr);
> =20
> -    ret =3D kvm_get_vcpu_events(cpu);
> -    if (ret) {
> -        return ret;
> -    }
> -
>      if (!write_kvmstate_to_list(cpu)) {
>          return EINVAL;
>      }
> @@ -475,6 +470,11 @@ int kvm_arch_get_registers(CPUState *cs)
>       */
>      write_list_to_cpustate(cpu);
> =20
> +    ret =3D kvm_get_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +

Why are we moving kvm_get_vcpu_events()?

>      kvm_arm_sync_mpstate_to_qemu(cpu);
> =20
>      return 0;
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 6344113..d06fd32 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -1043,17 +1043,17 @@ int kvm_arch_put_registers(CPUState *cs, int leve=
l)
>          return ret;
>      }
> =20
> -    ret =3D kvm_put_vcpu_events(cpu);
> -    if (ret) {
> -        return ret;
> -    }
> -
>      write_cpustate_to_list(cpu, true);
> =20
>      if (!write_list_to_kvmstate(cpu, level)) {
>          return -EINVAL;
>      }
> =20
> +    ret =3D kvm_put_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      kvm_arm_sync_mpstate_to_kvm(cpu);
> =20
>      return ret;
> @@ -1251,11 +1251,6 @@ int kvm_arch_get_registers(CPUState *cs)
>      }
>      vfp_set_fpcr(env, fpr);
> =20
> -    ret =3D kvm_get_vcpu_events(cpu);
> -    if (ret) {
> -        return ret;
> -    }
> -
>      if (!write_kvmstate_to_list(cpu)) {
>          return -EINVAL;
>      }
> @@ -1264,6 +1259,11 @@ int kvm_arch_get_registers(CPUState *cs)
>       */
>      write_list_to_cpustate(cpu);
> =20
> +    ret =3D kvm_get_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      kvm_arm_sync_mpstate_to_qemu(cpu);
> =20
>      /* TODO: other registers */
> --=20
> 2.7.4
>=20
>=20

Same comments for kvm64.c as for kvm32.c

Thanks,
drew


