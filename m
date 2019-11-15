Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3E8C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88DD2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnOXvEU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88DD2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVe9C-0003YA-KS
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iVe8R-0002u8-Lf
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iVe8O-0000Ue-Nh
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:07:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iVe8O-0000UK-Dy
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573834063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aScKk7d8oMI7xOeymNT1W0UWcwIjCMDBGVIBA5RdvM=;
 b=fnOXvEU+/F8S5wmG0lwfPdNDR00IXURcJ8W0RAmfoq7hM1FTM5CzTdaWDhyKIx940SQUqk
 RVHVUltq01bszTjHRPmcjPaZdvyEztsYofFNqtHS2fWzNft1sVUCeEcLhMaiaaoaZtqZbA
 274/fzUi7xSIScsT8CtJHe0ST9OSCvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-Czi9hoxwPhGxBgi-sJs62w-1; Fri, 15 Nov 2019 11:06:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78E5477;
 Fri, 15 Nov 2019 16:06:33 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C3299D75;
 Fri, 15 Nov 2019 16:06:32 +0000 (UTC)
Date: Fri, 15 Nov 2019 17:06:30 +0100
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] target/arm: Clean up arm_cpu_vq_map_next_smaller asserts
Message-ID: <20191115160630.ofkre7rp5gszbpcd@kamzik.brq.redhat.com>
References: <20191115131623.322-1-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191115131623.322-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Czi9hoxwPhGxBgi-sJs62w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 15, 2019 at 02:16:23PM +0100, Richard Henderson wrote:
> Coverity reports, in sve_zcr_get_valid_len,
>=20
> "Subtract operation overflows on operands
> arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"
>=20
> First, fix the aarch32 stub version to not return 0, but to
> simply assert unreachable.  Because that nonsense return value
> does exactly what Coverity reports.
>=20
> Second, 1 is the minimum value that can be returned from the
> aarch64 version of arm_cpu_vq_map_next_smaller, but that is
> non-obvious from the set of asserts in the function.  Begin by
> asserting that 2 is the minimum input, and finish by asserting
> that we did in fact find a set bit in the bitmap.  Bit 0 is
> always set, so we must be able to find that.
>=20
> Reported-by: Coverity (CID 1407217)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h   |  4 +++-
>  target/arm/cpu64.c | 11 +++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e1a66a2d1c..d89e727d7b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -190,7 +190,9 @@ uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uin=
t32_t vq);
>  # define ARM_MAX_VQ    1
>  static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
>  static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t=
 vq)
> -{ return 0; }
> +{
> +    g_assert_not_reached();
> +}

This is indeed a better way to implement a stub.

>  #endif
> =20
>  typedef struct ARMVectorReg {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 68baf0482f..83ff8c8713 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -466,11 +466,18 @@ uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, u=
int32_t vq)
>       * We allow vq =3D=3D ARM_MAX_VQ + 1 to be input because the caller =
may want
>       * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
>       * function always returns the next smaller than the input.
> +     *
> +     * Similarly, vq =3D=3D 2 is the minimum input because 1 is the mini=
mum
> +     * output that makes sense.
>       */
> -    assert(vq && vq <=3D ARM_MAX_VQ + 1);
> +    assert(vq >=3D 2 && vq <=3D ARM_MAX_VQ + 1);

This makes sense since nobody should request the next-smaller than
the smallest.

> =20
>      bitnum =3D find_last_bit(cpu->sve_vq_map, vq - 1);
> -    return bitnum =3D=3D vq - 1 ? 0 : bitnum + 1;
> +
> +    /* We always have vq =3D=3D 1 present in sve_vq_map.  */

This is true with TCG and 99.9999% likely to be true with KVM, but we
take pains to not assume it's true in all SVE paths shared with KVM. This
function isn't currently used by KVM, but nothing about it looks TCG
specific. Maybe we should just remove this function and put the
find_last_bit() call and all input/output validation directly in
sve_zcr_get_valid_len() ?

Thanks,
drew

> +    assert(bitnum < vq - 1);
> +
> +    return bitnum + 1;
>  }
> =20
>  static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *=
name,
> --=20
> 2.17.1
>=20


