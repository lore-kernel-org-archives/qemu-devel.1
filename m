Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CEC20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5YoDL8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CEC20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFPl-0007du-Tf
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 07:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jmFOp-0006NF-Se
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:41:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jmFOo-0003Aj-0f
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592566893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ciTHkDJblJ9rWL0l3niXPRssQfA1jdhX6wUgfZqPUV0=;
 b=d5YoDL8vLojueQYCToIpoZVzzygLKz/cNP7WhiIWOYm+U8ioOTCT6GI9lrsTRv3HM1tZgT
 vuykZx6sZK8bxRx44gZErjWmqZY9IkDAWDm4gaJfiFHxQkkwhAZD043s0hkOXlTXyQs1sT
 jSKR3U+fNBRmLCYUWNaMWe7dqrvqRkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-xKZLqt_PNI-0CyN0b4gYpQ-1; Fri, 19 Jun 2020 07:41:30 -0400
X-MC-Unique: xKZLqt_PNI-0CyN0b4gYpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EB39835B49;
 Fri, 19 Jun 2020 11:41:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC5555BAC3;
 Fri, 19 Jun 2020 11:41:25 +0000 (UTC)
Date: Fri, 19 Jun 2020 13:41:23 +0200
From: Andrew Jones <drjones@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] target/arm: Check supported KVM features globally
 (not per vCPU)
Message-ID: <20200619114123.7nhuehm76iwhsw5i@kamzik.brq.redhat.com>
References: <20200619095542.2095-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="42nl7cd6ilamj2ht"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619095542.2095-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm@nongnu.org, Haibo Xu <haibo.xu@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--42nl7cd6ilamj2ht
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 19, 2020 at 11:55:42AM +0200, Philippe Mathieu-Daudé wrote:
> Since commit d70c996df23f, when enabling the PMU we get:
> 
>   $ qemu-system-aarch64 -cpu host,pmu=on -M virt,accel=kvm,gic-version=3
>   Segmentation fault (core dumped)
> 
>   Thread 1 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
>   0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
>   2588        ret = ioctl(s->fd, type, arg);
>   (gdb) bt
>   #0  0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
>   #1  0x0000aaaaaae31568 in kvm_check_extension (s=0x0, extension=126) at accel/kvm/kvm-all.c:916
>   #2  0x0000aaaaaafce254 in kvm_arm_pmu_supported (cpu=0xaaaaac214ab0) at target/arm/kvm.c:213
>   #3  0x0000aaaaaafc0f94 in arm_set_pmu (obj=0xaaaaac214ab0, value=true, errp=0xffffffffe438) at target/arm/cpu.c:1111
>   #4  0x0000aaaaab5533ac in property_set_bool (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", opaque=0xaaaaac222730, errp=0xffffffffe438) at qom/object.c:2170
>   #5  0x0000aaaaab5512f0 in object_property_set (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1328
>   #6  0x0000aaaaab551e10 in object_property_parse (obj=0xaaaaac214ab0, string=0xaaaaac11b4c0 "on", name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1561
>   #7  0x0000aaaaab54ee8c in object_apply_global_props (obj=0xaaaaac214ab0, props=0xaaaaac018e20, errp=0xaaaaabd6fd88 <error_fatal>) at qom/object.c:407
>   #8  0x0000aaaaab1dd5a4 in qdev_prop_set_globals (dev=0xaaaaac214ab0) at hw/core/qdev-properties.c:1218
>   #9  0x0000aaaaab1d9fac in device_post_init (obj=0xaaaaac214ab0) at hw/core/qdev.c:1050
>   ...
>   #15 0x0000aaaaab54f310 in object_initialize_with_type (obj=0xaaaaac214ab0, size=52208, type=0xaaaaabe237f0) at qom/object.c:512
>   #16 0x0000aaaaab54fa24 in object_new_with_type (type=0xaaaaabe237f0) at qom/object.c:687
>   #17 0x0000aaaaab54fa80 in object_new (typename=0xaaaaabe23970 "host-arm-cpu") at qom/object.c:702
>   #18 0x0000aaaaaaf04a74 in machvirt_init (machine=0xaaaaac0a8550) at hw/arm/virt.c:1770
>   #19 0x0000aaaaab1e8720 in machine_run_board_init (machine=0xaaaaac0a8550) at hw/core/machine.c:1138
>   #20 0x0000aaaaaaf95394 in qemu_init (argc=5, argv=0xffffffffea58, envp=0xffffffffea88) at softmmu/vl.c:4348
>   #21 0x0000aaaaaada3f74 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at softmmu/main.c:48
> 
> This is because in frame #2, cpu->kvm_state is still NULL
> (the vCPU is not yet realized).
> 
> KVM has a hard requirement of all cores supporting the same
> feature set. We only need to check if the accelerator supports
> a feature, not each vCPU individually.
> 
> Fix by kvm_arm_<FEATURE>_supported() functions take a AccelState
> argument (already realized/valid at this point) instead of a
> CPUState argument.
> 
> Reported-by: Haibo Xu <haibo.xu@linaro.org>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Use global kvm_state (bonzini)
> 
> Paolo, does this break migration of encrypted memory assumptions?
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Supersedes: <20200617130800.26355-1-philmd@redhat.com>
> ---
>  target/arm/kvm_arm.h | 21 +++++++++------------
>  target/arm/cpu.c     |  2 +-
>  target/arm/cpu64.c   | 10 +++++-----
>  target/arm/kvm.c     |  4 ++--
>  target/arm/kvm64.c   | 14 +++++---------
>  5 files changed, 22 insertions(+), 29 deletions(-)
>

Hi Phil,

Can you also post the attached patch with this one (a two patch series)?
I want to ensure the bug is fixed before the test gets merged, but I
also would like the test to be added in order to catch things like this
in the future.

Thanks,
drew

--42nl7cd6ilamj2ht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-tests-qtest-arm-cpu-features-Add-feature-setting-tes.patch"

From 0bcb766d51b7c1c328218ae735f687b1160d6b42 Mon Sep 17 00:00:00 2001
From: Andrew Jones <drjones@redhat.com>
Date: Fri, 19 Jun 2020 13:30:38 +0200
Subject: [PATCH] tests/qtest/arm-cpu-features: Add feature setting tests

A recent regression (-cpu host,pmu=on caused a segfault) inspired
adding these tests.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 tests/qtest/arm-cpu-features.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 469217367661..d6bdbc171893 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -159,16 +159,35 @@ static bool resp_get_feature(QDict *resp, const char *feature)
     qobject_unref(_resp);                                              \
 })
 
-#define assert_feature(qts, cpu_type, feature, expected_value)         \
+#define resp_assert_feature(resp, feature, expected_value)             \
 ({                                                                     \
-    QDict *_resp, *_props;                                             \
+    QDict *_props;                                                     \
                                                                        \
-    _resp = do_query_no_props(qts, cpu_type);                          \
     g_assert(_resp);                                                   \
     g_assert(resp_has_props(_resp));                                   \
     _props = resp_get_props(_resp);                                    \
     g_assert(qdict_get(_props, feature));                              \
     g_assert(qdict_get_bool(_props, feature) == (expected_value));     \
+})
+
+#define assert_feature(qts, cpu_type, feature, expected_value)         \
+({                                                                     \
+    QDict *_resp;                                                      \
+                                                                       \
+    _resp = do_query_no_props(qts, cpu_type);                          \
+    g_assert(_resp);                                                   \
+    resp_assert_feature(_resp, feature, expected_value);               \
+    qobject_unref(_resp);                                              \
+})
+
+#define assert_set_feature(qts, cpu_type, feature, value)              \
+({                                                                     \
+    const char *_fmt = (value) ? "{ %s: true }" : "{ %s: false }";     \
+    QDict *_resp;                                                      \
+                                                                       \
+    _resp = do_query(qts, cpu_type, _fmt, feature);                    \
+    g_assert(_resp);                                                   \
+    resp_assert_feature(_resp, feature, value);                        \
     qobject_unref(_resp);                                              \
 })
 
@@ -464,7 +483,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         return;
     }
 
+    /* Enabling and disabling kvm-no-adjvtime should always work. */
     assert_has_feature_disabled(qts, "host", "kvm-no-adjvtime");
+    assert_set_feature(qts, "host", "kvm-no-adjvtime", true);
+    assert_set_feature(qts, "host", "kvm-no-adjvtime", false);
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
@@ -475,7 +497,11 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         char *error;
 
         assert_has_feature_enabled(qts, "host", "aarch64");
+
+        /* Enabling and disabling pmu should always work. */
         assert_has_feature_enabled(qts, "host", "pmu");
+        assert_set_feature(qts, "host", "pmu", true);
+        assert_set_feature(qts, "host", "pmu", false);
 
         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
-- 
2.25.4


--42nl7cd6ilamj2ht--


