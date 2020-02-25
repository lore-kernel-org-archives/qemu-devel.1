Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A82DC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1336321744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly+5EFlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1336321744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6X1A-0003Lx-2r
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6X0M-0002oQ-SQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6X0L-0001Tj-K2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:59:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52018
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6X0L-0001RJ-Fn
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582624792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=anO+rp3TUnZfeKw/E63z9DJGiUpxTb5UTIlafVAI7gM=;
 b=Ly+5EFlDX2tSybXYVw6/G1lg2QIbzWRCEUOsDAflM73LHrigKcRf3Hj7M0m9msuVk8lXhO
 g7CQQdHc5NxBTGT6J0mPCv4KxlA1ifN4P7haZ8ZONSaY8BIfjivSP42lT3s8BmbLbzHsGs
 gt6E+/lgvcjF/+6bp6UqK2jqBsEC01c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-78CVt8RvM_-xfNnu6qAqhg-1; Tue, 25 Feb 2020 04:59:51 -0500
X-MC-Unique: 78CVt8RvM_-xfNnu6qAqhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29E3218C8C03;
 Tue, 25 Feb 2020 09:59:50 +0000 (UTC)
Received: from [10.36.117.12] (ovpn-117-12.ams2.redhat.com [10.36.117.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4A1A5D9CD;
 Tue, 25 Feb 2020 09:59:48 +0000 (UTC)
Subject: Re: [PATCH v4 07/16] s390x: Add SIDA memory ops
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200220125638.7241-1-frankja@linux.ibm.com>
 <20200220125638.7241-8-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <86138afc-dd99-edab-7612-f377ba0b6246@redhat.com>
Date: Tue, 25 Feb 2020 10:59:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220125638.7241-8-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.02.20 13:56, Janosch Frank wrote:
> Protected guests save the instruction control blocks in the SIDA
> instead of QEMU/KVM directly accessing the guest's memory.
>=20
> Let's introduce new functions to access the SIDA.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  linux-headers/linux/kvm.h |  2 ++
>  target/s390x/cpu.h        |  7 ++++++-
>  target/s390x/kvm.c        | 23 +++++++++++++++++++++++
>  target/s390x/kvm_s390x.h  |  2 ++
>  target/s390x/mmu_helper.c |  9 +++++++++
>  5 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 2e647f2d9b..7ccf5988d2 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -483,6 +483,8 @@ struct kvm_s390_mem_op {
>  /* types for kvm_s390_mem_op->op */
>  #define KVM_S390_MEMOP_LOGICAL_READ=090
>  #define KVM_S390_MEMOP_LOGICAL_WRITE=091
> +#define KVM_S390_MEMOP_SIDA_READ=092
> +#define KVM_S390_MEMOP_SIDA_WRITE=093
>  /* flags for kvm_s390_mem_op->flags */
>  #define KVM_S390_MEMOP_F_CHECK_ONLY=09=09(1ULL << 0)
>  #define KVM_S390_MEMOP_F_INJECT_EXCEPTION=09(1ULL << 1)
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index cbc53c99cf..491d6860a8 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -823,7 +823,12 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, =
uint8_t ar, void *hostbuf,
>  #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
>          s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
>  void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra);
> -
> +int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset,  void *hostbuf=
,
> +                       int len, bool is_write);
> +#define s390_cpu_pv_mem_read(cpu, offset, dest, len)    \
> +        s390_cpu_pv_mem_rw(cpu, offset, dest, len, false)
> +#define s390_cpu_pv_mem_write(cpu, offset, dest, len)       \
> +        s390_cpu_pv_mem_rw(cpu, offset, dest, len, true)
> =20
>  /* sigp.c */
>  int s390_cpu_restart(S390CPU *cpu);
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index eec0b92479..f222836df5 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -846,6 +846,29 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_=
t ar, void *hostbuf,
>      return ret;
>  }
> =20
> +int kvm_s390_mem_op_pv(S390CPU *cpu, uint64_t offset, void *hostbuf,
> +                       int len, bool is_write)
> +{
> +    int ret =3D 0;

move that after the struct declaration/definition. No need to initialize
to 0.

> +    struct kvm_s390_mem_op mem_op =3D {
> +        .sida_offset =3D offset,
> +        .size =3D len,
> +        .op =3D is_write ? KVM_S390_MEMOP_SIDA_WRITE
> +                       : KVM_S390_MEMOP_SIDA_READ,
> +        .buf =3D (uint64_t)hostbuf,
> +    };
> +
> +    if (!cap_mem_op) {
> +        return -ENOSYS;
> +    }

if (!cap_mem_op || !cap_protected)

And move cap_protected from patch 15 in here.

> +
> +    ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
> +    if (ret < 0) {
> +        warn_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));

I'd even error_report(). After all, this should never fail.

> +    }
> +    return ret;
> +}
> +
>  /*
>   * Legacy layout for s390:
>   * Older S390 KVM requires the topmost vma of the RAM to be
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index 0b21789796..9c38f6ccce 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -19,6 +19,8 @@ void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s=
390_irq *irq);
>  void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_=
code);
>  int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
>                      int len, bool is_write);
> +int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
> +                       bool is_write);
>  void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
>  int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
>  void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index c9f3f34750..ad485399db 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -474,6 +474,15 @@ static int translate_pages(S390CPU *cpu, vaddr addr,=
 int nr_pages,
>      return 0;
>  }
> =20
> +int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
> +                       int len, bool is_write)
> +{
> +    int ret;
> +
> +    ret =3D kvm_s390_mem_op_pv(cpu, offset, hostbuf, len, is_write);
> +    return ret;

if (kvm_enabled()) {
...
} else {
    /* Helpful comment */
    g_assert_not_reached();
}


--=20
Thanks,

David / dhildenb


