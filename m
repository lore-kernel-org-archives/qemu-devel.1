Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC58EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B5A206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJ9T1DiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B5A206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6X4o-0000QV-NH
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6W5M-0005QH-TO
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6W5L-0005XL-3z
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597397594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caug1tB4z0DsZh9Y7yoUcHX4OyVjZusMpSMtp0xzkPg=;
 b=jJ9T1DiJsGb9tiLjRuf2iePMu2bleJ6gxqONwTBY8iyYm++Ak0uTwlND11ErXW5ji/FJtI
 w7wo7VEPMlpTpuD6nzbogRLw5FtU1PFhsADCXV/GW92TKK4syLH2MEddUSA/6qiVuxocrx
 C0BNs4N7cOtopCtwGM4MEtyeat4113E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-9EFWN5VgMa-MEk7kAQwAjQ-1; Fri, 14 Aug 2020 05:33:10 -0400
X-MC-Unique: 9EFWN5VgMa-MEk7kAQwAjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D5C081CBE5;
 Fri, 14 Aug 2020 09:33:09 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF19A1992D;
 Fri, 14 Aug 2020 09:33:07 +0000 (UTC)
Date: Fri, 14 Aug 2020 11:33:04 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 3/3] target/arm: Use object_property_add_bool for
 "sve" property
Message-ID: <20200814093304.5e6k4lfgguj3yx7b@kamzik.brq.redhat.com>
References: <20200813200243.3036772-1-richard.henderson@linaro.org>
 <20200813200243.3036772-4-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200813200243.3036772-4-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 01:02:43PM -0700, Richard Henderson wrote:
> The interface for object_property_add_bool is simpler,
> making the code easier to understand.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu64.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 0227862d39..cce0da0b90 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -488,6 +488,12 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
>      cpu->sve_max_vq = max_vq;
>  }
>  
> +/*
> + * Note that cpu_arm_get/set_sve_vq cannot use the simpler
> + * object_property_add_bool interface because they make use
> + * of the contents of "name" to determine which bit on which
> + * to operate.
> + */
>  static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
>                                 void *opaque, Error **errp)
>  {
> @@ -529,26 +535,17 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>      set_bit(vq - 1, cpu->sve_vq_init);
>  }
>  
> -static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> +static bool cpu_arm_get_sve(Object *obj, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> -    bool value = cpu_isar_feature(aa64_sve, cpu);
> -
> -    visit_type_bool(v, name, &value, errp);
> +    return cpu_isar_feature(aa64_sve, cpu);
>  }
>  
> -static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> +static void cpu_arm_set_sve(Object *obj, bool value, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> -    bool value;
>      uint64_t t;
>  
> -    if (!visit_type_bool(v, name, &value, errp)) {
> -        return;
> -    }
> -
>      if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
>          error_setg(errp, "'sve' feature not supported by KVM on this host");
>          return;
> @@ -563,8 +560,7 @@ void aarch64_add_sve_properties(Object *obj)
>  {
>      uint32_t vq;
>  
> -    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> -                        cpu_arm_set_sve, NULL, NULL);
> +    object_property_add_bool(obj, "sve", cpu_arm_get_sve, cpu_arm_set_sve);
>  
>      for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
>          char name[8];
> -- 
> 2.25.1
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>


