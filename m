Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE30C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B64206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MotO6IrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B64206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6X2L-0005Cp-Pp
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6WAs-00013u-Ec
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:38:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6WAq-0006FF-5y
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597397935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TLLBO/lfs0pEBlgFPExznbHS6KzdYgGc1qa06kgLUcQ=;
 b=MotO6IrUEBuIh1DSZ2+emOrqopq33lq/LGMTzxrvFEPrhhm6+5+JZMwTW0igkShCbvz6PH
 gQi5kujipQGJs9eYkSXLGb6x2xM2Ds/q73sT068Ts1TsSUei/zuzj6DNt2ecdpM83bpUqa
 H61soLsWWHSbru8s6u2fRApoSsy/q38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-GgIwkXIWNSKv-2ekLVjQSQ-1; Fri, 14 Aug 2020 05:38:53 -0400
X-MC-Unique: GgIwkXIWNSKv-2ekLVjQSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0992B1015DC0;
 Fri, 14 Aug 2020 09:38:52 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A87F5D9F3;
 Fri, 14 Aug 2020 09:38:50 +0000 (UTC)
Date: Fri, 14 Aug 2020 11:38:47 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 1/3] target/arm: Add cpu properties to control pauth
Message-ID: <20200814093847.rlrp752toycz5m7b@kamzik.brq.redhat.com>
References: <20200813200243.3036772-1-richard.henderson@linaro.org>
 <20200813200243.3036772-2-richard.henderson@linaro.org>
 <20200814091726.l7g43rz2t6op3vci@kamzik.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200814091726.l7g43rz2t6op3vci@kamzik.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
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

On Fri, Aug 14, 2020 at 11:17:30AM +0200, Andrew Jones wrote:
> On Thu, Aug 13, 2020 at 01:02:41PM -0700, Richard Henderson wrote:
> > The crypto overhead of emulating pauth can be significant for
> > some workloads.  Add two boolean properties that allows the
> > feature to be turned off, on with the architected algorithm,
> > or on with an implementation defined algorithm.
> > 
> > We need two intermediate booleans to control the state while
> > parsing properties lest we clobber ID_AA64ISAR1 into an invalid
> > intermediate state.
> > 
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> > v2: Use boolean properties instead of an enum (drjones).
> > ---
> >  target/arm/cpu.h     | 10 ++++++++++
> >  target/arm/cpu.c     | 13 +++++++++++++
> >  target/arm/cpu64.c   | 40 ++++++++++++++++++++++++++++++++++++----
> >  target/arm/monitor.c |  1 +
> >  4 files changed, 60 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 9e8ed423ea..44901923c8 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -196,9 +196,11 @@ typedef struct {
> >  #ifdef TARGET_AARCH64
> >  # define ARM_MAX_VQ    16
> >  void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
> > +void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
> >  #else
> >  # define ARM_MAX_VQ    1
> >  static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
> > +static inline void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp) { }
> >  #endif
> >  
> >  typedef struct ARMVectorReg {
> > @@ -938,6 +940,14 @@ struct ARMCPU {
> >      uint64_t reset_cbar;
> >      uint32_t reset_auxcr;
> >      bool reset_hivecs;
> > +
> > +    /*
> > +     * Intermediate values used during property parsing.
> > +     * Once finalized, the values should be read from ID_AA64ISAR1.
> > +     */
> > +    bool prop_pauth;
> > +    bool prop_pauth_impdef;
> > +
> >      /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
> >      uint32_t dcz_blocksize;
> >      uint64_t rvbar;
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 111579554f..c719562d3d 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1307,6 +1307,19 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
> >              error_propagate(errp, local_err);
> >              return;
> >          }
> > +
> > +        /*
> > +         * KVM does not support modifications to this feature.
> > +         * We have not registered the cpu properties when KVM
> > +         * is in use, so the user will not be able to set them.
> > +         */
> > +        if (!kvm_enabled()) {
> > +            arm_cpu_pauth_finalize(cpu, &local_err);
> > +            if (local_err != NULL) {
> > +                error_propagate(errp, local_err);
> > +                return;
> > +            }
> > +        }
> >      }
> >  }
> >  
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index dd696183df..0227862d39 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -28,6 +28,8 @@
> >  #include "sysemu/kvm.h"
> >  #include "kvm_arm.h"
> >  #include "qapi/visitor.h"
> > +#include "hw/qdev-properties.h"
> > +
> >  
> >  #ifndef CONFIG_USER_ONLY
> >  static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> > @@ -572,6 +574,36 @@ void aarch64_add_sve_properties(Object *obj)
> >      }
> >  }
> >  
> > +void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
> > +{
> > +    int arch_val = 0, impdef_val = 0;
> > +    uint64_t t;
> > +
> > +    /* TODO: Handle HaveEnhancedPAC, HaveEnhancedPAC2, HaveFPAC. */
> > +    if (cpu->prop_pauth) {
> > +        if (cpu->prop_pauth_impdef) {
> > +            impdef_val = 1;
> > +        } else {
> > +            arch_val = 1;
> > +        }
> > +    } else if (cpu->prop_pauth_impdef) {
> > +        error_setg(errp, "cannot enable pauth-impdef without pauth");
> > +        error_append_hint(errp, "Add pauth=on to the CPU property list.\n");
> > +    }
> > +
> > +    t = cpu->isar.id_aa64isar1;
> > +    t = FIELD_DP64(t, ID_AA64ISAR1, APA, arch_val);
> > +    t = FIELD_DP64(t, ID_AA64ISAR1, GPA, arch_val);
> > +    t = FIELD_DP64(t, ID_AA64ISAR1, API, impdef_val);
> > +    t = FIELD_DP64(t, ID_AA64ISAR1, GPI, impdef_val);
> > +    cpu->isar.id_aa64isar1 = t;
> > +}
> > +
> > +static Property arm_cpu_pauth_property =
> > +    DEFINE_PROP_BOOL("pauth", ARMCPU, prop_pauth, true);
> > +static Property arm_cpu_pauth_impdef_property =
> > +    DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
> > +
> >  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
> >   * otherwise, a CPU with as many features enabled as our emulation supports.
> >   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> > @@ -627,10 +659,6 @@ static void aarch64_max_initfn(Object *obj)
> >          t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);
> >          t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
> >          t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
> > -        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
> > -        t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
> > -        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
> > -        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
> >          t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
> >          t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);
> >          t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);
> > @@ -718,6 +746,10 @@ static void aarch64_max_initfn(Object *obj)
> >          cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
> >          cpu->dcz_blocksize = 7; /*  512 bytes */
> >  #endif
> > +
> > +        /* Default to PAUTH on, with the architected algorithm. */
> > +        qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_property);
> > +        qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_impdef_property);
> 
> Many of our CPU properties have descriptions added with
> object_property_set_description(), maybe we should add
> descriptions for these as well. And, maybe I should look
> into generating descriptions for each of the sve* properties
> too.
> 
> >      }
> >  
> >      aarch64_add_sve_properties(obj);
> > diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> > index ba6e01abd0..2c7be32b33 100644
> > --- a/target/arm/monitor.c
> > +++ b/target/arm/monitor.c
> > @@ -104,6 +104,7 @@ static const char *cpu_model_advertised_features[] = {
> >      "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
> >      "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
> >      "kvm-no-adjvtime",
> > +    "pauth", "pauth-impdef",
> >      NULL
> >  };
> >  
> > -- 
> > 2.25.1
> > 
> > 
> 
> With the qtest change below I tested the property setting. Maybe we should
> add that diff to this patch.
> 
> In any case,
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> 
> Thanks,
> drew
> 
> 
> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
> index f7e062c1891e..bfe08b9b84f0 100644
> --- a/tests/qtest/arm-cpu-features.c
> +++ b/tests/qtest/arm-cpu-features.c
> @@ -427,6 +427,18 @@ static void sve_tests_sve_off_kvm(const void *data)
>      qtest_quit(qts);
>  }
>  
> +static void pauth_tests_default(QTestState *qts, const char *cpu_type)
> +{
> +    assert_has_feature_enabled(qts, "max", "pauth");
> +    assert_has_feature_disabled(qts, "max", "pauth-impdef");
> +    assert_set_feature(qts, "max", "pauth", false);
> +    assert_set_feature(qts, "max", "pauth", true);
> +    assert_set_feature(qts, "max", "pauth-impdef", true);
> +    assert_set_feature(qts, "max", "pauth-impdef", false);
> +    assert_error(qts, "max", "cannot enable pauth-impdef without pauth",
> +                 "{ 'pauth': false, 'pauth-impdef': true }");

Eh, all the '"max"' uses above should be 'cpu_type', like below.

Thanks,
drew


diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index f7e062c1891e..176b7f2fdd05 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -427,6 +427,18 @@ static void sve_tests_sve_off_kvm(const void *data)
     qtest_quit(qts);
 }
 
+static void pauth_tests_default(QTestState *qts, const char *cpu_type)
+{
+    assert_has_feature_enabled(qts, cpu_type, "pauth");
+    assert_has_feature_disabled(qts, cpu_type, "pauth-impdef");
+    assert_set_feature(qts, cpu_type, "pauth", false);
+    assert_set_feature(qts, cpu_type, "pauth", true);
+    assert_set_feature(qts, cpu_type, "pauth-impdef", true);
+    assert_set_feature(qts, cpu_type, "pauth-impdef", false);
+    assert_error(qts, cpu_type, "cannot enable pauth-impdef without pauth",
+                 "{ 'pauth': false, 'pauth-impdef': true }");
+}
+
 static void test_query_cpu_model_expansion(const void *data)
 {
     QTestState *qts;
@@ -461,6 +473,7 @@ static void test_query_cpu_model_expansion(const void *data)
         assert_has_feature_enabled(qts, "cortex-a57", "aarch64");
 
         sve_tests_default(qts, "max");
+        pauth_tests_default(qts, "max");
 
         /* Test that features that depend on KVM generate errors without. */
         assert_error(qts, "max",


