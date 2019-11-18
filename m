Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F01EC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F4820727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcfpT1Cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F4820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdPT-0000qP-Bq
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iWdNF-00080l-Lb
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iWdNE-00030B-B8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:31:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iWdNE-0002ya-1P
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574069466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyLFeV03hnSmiKHlur23seGiYQgSDPqySEsm3nQMXBY=;
 b=QcfpT1Cn7Hp+WKzxHGevDwFt3fw5tOWChw6e40sxIL1JNMULxubLoBY7PHr9st0qOSRmcs
 qpFYACaZFSfv5amReKwz0KplHSt6u90j4THIWMHBKeLb0JZTcla/In8a4xYdaVP/v6AmQw
 RsIN34NZCysbHHJ9bQucvY+xVql+D+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-zOCohxGoMkW2qDTzI_g8ng-1; Mon, 18 Nov 2019 04:31:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97E98800EBE;
 Mon, 18 Nov 2019 09:31:02 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C304F9F71;
 Mon, 18 Nov 2019 09:31:01 +0000 (UTC)
Date: Mon, 18 Nov 2019 10:30:59 +0100
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] target/arm: Merge arm_cpu_vq_map_next_smaller into
 sole caller
Message-ID: <20191118093059.4dxafav6e66p6ovq@kamzik.brq.redhat.com>
References: <20191118091414.19440-1-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191118091414.19440-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zOCohxGoMkW2qDTzI_g8ng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Mon, Nov 18, 2019 at 10:14:14AM +0100, Richard Henderson wrote:
> Coverity reports, in sve_zcr_get_valid_len,
>=20
> "Subtract operation overflows on operands
> arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"
>=20
> First, the aarch32 stub version of arm_cpu_vq_map_next_smaller,
> returning 0, does exactly what Coverity reports.  Remove it.
>=20
> Second, the aarch64 version of arm_cpu_vq_map_next_smaller has
> a set of asserts, but they don't cover the case in question.
> Further, there is a fair amount of extra arithmetic needed to
> convert from the 0-based zcr register, to the 1-base vq form,
> to the 0-based bitmap, and back again.  This can be simplified
> by leaving the value in the 0-based form.
>=20
> Finally, use test_bit to simplify the common case, where the
> length in the zcr registers is in fact a supported length.
>=20
> Reported-by: Coverity (CID 1407217)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>=20
> v2: Merge arm_cpu_vq_map_next_smaller into sve_zcr_get_valid_len,
>     as suggested by Andrew Jones.
>=20
> v3: Use test_bit to make the code even more obvious; the
>     current_length + 1 thing to let us find current_length in the
>     bitmap seemed unnecessarily clever.  (For real this time).
>=20
> ---
>  target/arm/cpu.h    |  3 ---
>  target/arm/cpu64.c  | 15 ---------------
>  target/arm/helper.c |  9 +++++++--
>  3 files changed, 7 insertions(+), 20 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e1a66a2d1c..47d24a5375 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -185,12 +185,9 @@ typedef struct {
>  #ifdef TARGET_AARCH64
>  # define ARM_MAX_VQ    16
>  void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
> -uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
>  #else
>  # define ARM_MAX_VQ    1
>  static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
> -static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t=
 vq)
> -{ return 0; }
>  #endif
> =20
>  typedef struct ARMVectorReg {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 68baf0482f..a39d6fcea3 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -458,21 +458,6 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>      cpu->sve_max_vq =3D max_vq;
>  }
> =20
> -uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
> -{
> -    uint32_t bitnum;
> -
> -    /*
> -     * We allow vq =3D=3D ARM_MAX_VQ + 1 to be input because the caller =
may want
> -     * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
> -     * function always returns the next smaller than the input.
> -     */
> -    assert(vq && vq <=3D ARM_MAX_VQ + 1);
> -
> -    bitnum =3D find_last_bit(cpu->sve_vq_map, vq - 1);
> -    return bitnum =3D=3D vq - 1 ? 0 : bitnum + 1;
> -}
> -
>  static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *=
name,
>                                     void *opaque, Error **errp)
>  {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index be67e2c66d..a089fb5a69 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5363,9 +5363,14 @@ int sve_exception_el(CPUARMState *env, int el)
> =20
>  static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
>  {
> -    uint32_t start_vq =3D (start_len & 0xf) + 1;
> +    uint32_t end_len;
> =20
> -    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
> +    end_len =3D start_len &=3D 0xf;
> +    if (!test_bit(start_len, cpu->sve_vq_map)) {
> +        end_len =3D find_last_bit(cpu->sve_vq_map, start_len);
> +        assert(end_len < start_len);
> +    }
> +    return end_len;
>  }
> =20
>  /*
> --=20
> 2.17.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com>


