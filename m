Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8717C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4173206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rir1SdxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4173206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnhC-0008Ia-T4
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXnfw-0007E2-Bf
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXnfu-0006zA-5u
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:43:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXnfu-0006yy-2Z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574347393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fM8GLoJpU6pzWJXNcYQGd+wc8okas4dvZbTXAH4xIC4=;
 b=Rir1SdxRCfhuqJfigVmD9uq33/IuofLdoBqr6YT4kuf48fuJugjVEEf1oGoK4jTSxNu81Y
 E2KJa0gDwMWk5/EY5V0af3mgW73dqmWJTyLIwbp9grcgCuiTmdswoYXwUhfnYfM6z+K8Y3
 xHbzAcl0gNlbUq2qOQ7bpsARQ0l2nMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-NdbPsDqrPT6MEpTQwqY_xQ-1; Thu, 21 Nov 2019 09:43:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F13BDB6E;
 Thu, 21 Nov 2019 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-86.ams2.redhat.com
 [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E2641E8;
 Thu, 21 Nov 2019 14:43:02 +0000 (UTC)
Subject: Re: [PATCH 05/15] s390x: protvirt: Sync PV state
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-6-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a26d6806-a21c-b5f9-19b5-dc45d0f6d90c@redhat.com>
Date: Thu, 21 Nov 2019 15:43:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-6-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NdbPsDqrPT6MEpTQwqY_xQ-1
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 12.43, Janosch Frank wrote:
> We do not always have the SIE intercept code handy at each place where
> we do emulation. Unfortunately emulation for secure guests often
> differ slightly from normal emulation and we need to make decisions
> based on the protected state of the VCPU.
>=20
> Let's sync the protected state and make it available.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  linux-headers/asm-s390/kvm.h | 1 +
>  target/s390x/cpu.h           | 1 +
>  target/s390x/kvm.c           | 4 ++++
>  3 files changed, 6 insertions(+)
>=20
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
> index 41976d33f0..7c46cf6078 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -231,6 +231,7 @@ struct kvm_guest_debug_arch {
>  #define KVM_SYNC_GSCB   (1UL << 9)
>  #define KVM_SYNC_BPBC   (1UL << 10)
>  #define KVM_SYNC_ETOKEN (1UL << 11)
> +#define KVM_SYNC_PV=09(1UL << 12)
>  /* length and alignment of the sdnx as a power of two */
>  #define SDNXC 8
>  #define SDNXL (1UL << SDNXC)
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 17460ed7b3..a787221772 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -116,6 +116,7 @@ struct CPUS390XState {
> =20
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
> +    bool pv; /* protected virtualization */
> =20
>  #if !defined(CONFIG_USER_ONLY)
>      uint32_t core_id; /* PoP "CPU address", same as cpu_index */
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index c24c869e77..418154ccfe 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -676,6 +676,10 @@ int kvm_arch_get_registers(CPUState *cs)
>          env->etoken_extension =3D cs->kvm_run->s.regs.etoken_extension;
>      }
> =20
> +    if (can_sync_regs(cs, KVM_SYNC_PV)) {
> +        env->pv =3D !!cs->kvm_run->s.regs.pv;
> +    }

Does this really need to be sync'ed each time during
kvm_arch_get_registers()? I mean, this is not a state that continuously
changes ... so when I guest enters PV mode, I assume that we have to do
some stuff in QEMU anyway, so we could set the "pv =3D true" in that case.
And during reset, we could clear it again. Or do I miss something?

 Thomas


