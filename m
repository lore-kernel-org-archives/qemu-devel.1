Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CE9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 11:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAF920756
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 11:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7hrah/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAF920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5oW6-0001aB-CT
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 07:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5oVC-00018l-BF
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 07:01:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42588
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5oV9-0000Ip-FP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 07:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597230057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u2x5jfQeXyiAlBi6DgTColKf6gqo3uNb9SgFkqlHZtU=;
 b=c7hrah/+RZB2tdR4WTHyvHyS3ehp/GV3N1Ms0IXiafUs0Riop1wpEVbapcXTf24S3rioiA
 e4gObiGHdN8ARzUctAAoq4NymfmwbUtCk92SJUjXi2nNo/Oro5QAt6r/zozzpSImLhwug/
 4oM1rDsbv3/erMqOoxjVpGazb1gMOqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-FBWYL2fvO6OpNkLlV1Kdfw-1; Wed, 12 Aug 2020 07:00:55 -0400
X-MC-Unique: FBWYL2fvO6OpNkLlV1Kdfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14BCE1DE1;
 Wed, 12 Aug 2020 11:00:54 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 812045D6BD;
 Wed, 12 Aug 2020 11:00:52 +0000 (UTC)
Date: Wed, 12 Aug 2020 13:00:49 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/2] target/arm: Add cpu property to control pauth
Message-ID: <20200812110049.ghtvl7dmtspkfdor@kamzik.brq.redhat.com>
References: <20200812065339.2030527-1-richard.henderson@linaro.org>
 <20200812065339.2030527-2-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200812065339.2030527-2-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 11, 2020 at 11:53:38PM -0700, Richard Henderson wrote:
> The crypto overhead of emulating pauth can be significant for
> some workloads.  Add an enumeration property that allows the
> feature to be turned off, on with the architected algorithm,
> or on with an implementation defined algorithm.
> 
> The architected algorithm is quite expensive to emulate;
> using another algorithm may allow hardware acceleration.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu64.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index dd696183df..3181d0e2f8 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -572,6 +572,69 @@ void aarch64_add_sve_properties(Object *obj)
>      }
>  }
>  
> +static const char * const pauth_names[] = {
> +    "off", "impdef", "arch"
> +};

Hi Richard,

Please add three boolean properties, rather than one enum:

pauth:            enable support of the pauth feature
pauth-fast:       enable QEMU's fast non-cryptographic hash for pauth
                  (pauth must be enabled)
pauth-arch:       enable the architected algorithm for pauth
                  (pauth must be enabled)

These booleans can then be added to the cpu feature probing list used by
qmp_query_cpu_model_expansion()

> +
> +static const QEnumLookup pauth_lookup = {
> +    .array = pauth_names,
> +    .size = ARRAY_SIZE(pauth_names)
> +};
> +
> +static int cpu_arm_get_pauth(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    int value;
> +
> +    /* We will always set GPA+APA and GPI+API to the same value. */
> +    if (FIELD_EX64(cpu->isar.id_aa64isar1, ID_AA64ISAR1, APA)) {
> +        value = 2;
> +    } else if (FIELD_EX64(cpu->isar.id_aa64isar1, ID_AA64ISAR1, API)) {
> +        value = 1;
> +    } else {
> +        value = 0;
> +    }
> +    return value;
> +}
> +
> +static void cpu_arm_set_pauth(Object *obj, int value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint64_t t;
> +
> +    /* TODO: Handle HaveEnhancedPAC, HaveEnhancedPAC2, HaveFPAC. */
> +    t = cpu->isar.id_aa64isar1;
> +    switch (value) {
> +    case 0:
> +        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 0);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 0);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
> +        break;
> +    case 1:
> +        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 0);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 0);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 1);
> +        break;
> +    case 2:
> +        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    cpu->isar.id_aa64isar1 = t;
> +}
> +
> +static void aarch64_add_pauth_properties(Object *obj)
> +{
> +    object_property_add_enum(obj, "pauth", "ARMPauthKind", &pauth_lookup,
> +                             cpu_arm_get_pauth, cpu_arm_set_pauth);
> +}
> +
>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
>   * otherwise, a CPU with as many features enabled as our emulation supports.
>   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> @@ -720,6 +783,7 @@ static void aarch64_max_initfn(Object *obj)
>  #endif
>      }
>  
> +    aarch64_add_pauth_properties(obj);

We don't yet support enabling pauth on KVM accelerated guests, so this
call should be in the !kvm_enabled() part of this function.

>      aarch64_add_sve_properties(obj);
>      object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
>                          cpu_max_set_sve_max_vq, NULL, NULL);
> -- 
> 2.25.1
> 
>

Thanks,
drew


