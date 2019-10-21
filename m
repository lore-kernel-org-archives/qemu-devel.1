Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4533ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1024B20700
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asiHonXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1024B20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYca-0007J1-3y
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iMYbC-0006Tm-FB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iMYbA-0000N2-0a
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:23:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iMYb9-0000Mg-TM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571667831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mmzl8tBYsqn/W504QeCUkEapn7V7z3TPbpoTXZn8Mno=;
 b=asiHonXLtLYKMy35hIEt+QOa5kLUp7/Q93Va6YPjKrbFn1jetKiZ19lWymShVkYNkrrDvk
 Cr86mES1jJDJOqMay5p/tDLHJ7VqExJ79XqQr6ngJlgf9vBBKSpqd77mcuZR/QDw9QIZjf
 iznILecSR1Uk1A45p7R8YevEQYGUvtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-ADIe0o63MeipDzLfcE0e-A-1; Mon, 21 Oct 2019 10:23:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0FD71800DC7;
 Mon, 21 Oct 2019 14:23:46 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11B3C5C549;
 Mon, 21 Oct 2019 14:23:39 +0000 (UTC)
Date: Mon, 21 Oct 2019 16:23:36 +0200
From: Andrew Jones <drjones@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 0/9] target/arm/kvm: enable SVE in guests
Message-ID: <20191021142336.e4xekqlmqv5txu5w@kamzik.brq.redhat.com>
References: <20191016085408.24360-1-drjones@redhat.com>
 <CAFEAcA8pV5batrPk+J6RLU2rv9SNAmL8JS9Kd9tWP3pD-m29eA@mail.gmail.com>
 <3f54f759-9d6d-bf04-85aa-59c1cac31044@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3f54f759-9d6d-bf04-85aa-59c1cac31044@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ADIe0o63MeipDzLfcE0e-A-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 02:54:30PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 10/21/19 2:36 PM, Peter Maydell wrote:
> > On Wed, 16 Oct 2019 at 09:54, Andrew Jones <drjones@redhat.com> wrote:
> > >=20
> > > Since Linux kernel v5.2-rc1 KVM has support for enabling SVE in guest=
s.
> > > This series provides the QEMU bits for that enablement. First, we
> > > select existing CPU properties representing features we want to
> > > advertise in addition to the SVE vector lengths and prepare
> > > them for a qmp query. Then we introduce the qmp query, applying
> > > it immediately to those selected features. We also document ARM CPU
> > > features at this time. We next add a qtest for the selected CPU
> > > features that uses the qmp query for its tests - and we continue to
> > > add tests as we add CPU features with the following patches. So then,
> > > once we have the support we need for CPU feature querying and testing=
,
> > > we add our first SVE CPU feature property, 'sve', which just allows
> > > SVE to be completely enabled/disabled. Following that feature propert=
y,
> > > we add all 16 vector length properties along with the input validatio=
n
> > > they need and tests to prove the validation works. At this point the
> > > SVE features are still only for TCG, so we provide some patches to
> > > prepare for KVM and then a patch that allows the 'max' CPU type to
> > > enable SVE with KVM, but at first without vector length properties.
> > > After a bit more preparation we add the SVE vector length properties
> > > to the KVM-enabled 'max' CPU type along with the additional input
> > > validation and tests that that needs.  Finally we allow the 'host'
> > > CPU type to also enjoy these properties by simply sharing them with i=
t.
> >=20
> > This fails 'make check' on an aarch32 box with KVM support:
> >=20
> > MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> > QTEST_QEMU_BINARY=3Darm-softmmu/qemu-system-arm QTEST_QEMU_IMG=3Dqemu-i=
mg
> > tests/arm-cpu-features -m=3Dquick -k --tap < /dev/null |
> > ./scripts/tap-driver.pl --test-name=3D"arm-cpu-features"
> > PASS 1 arm-cpu-features /arm/arm/query-cpu-model-expansion
> > **
> > ERROR:/home/pm215/qemu/tests/arm-cpu-features.c:420:test_query_cpu_mode=
l_expansion_kvm:
> > assertion failed: (resp_has_props(_resp))
>=20
> Glad you could test it, I was wondering how this test work because it fir=
st
> unconditionally assert the host has PMU feature (failing the test) then
> there is a unreachable if(!aarch64) "'pmu' feature not supported" warning=
.
>

Yes, this is the case you were concerned about, but the problem is for a
slightly different reason. *If* the PMU feature was getting added to the
kvm32 'host' CPU type, then both tests here would be correct: the feature
would be present, but arm_set_pmu() would report "feature not supported",
as that's what KVM would report on kvm32. However, I see now that
target/arm/kvm32.c:kvm_arm_get_host_cpu_features() does *not* add
ARM_FEATURE_PMU, like it does in the target/arm/kvm64.c implementation
and in the 32-bit CPU models like the Cortex-A15. Indeed, had this
test been run with '-cpu cortex-a15', and the kvm32 host allowed that
CPU type, then this test would also work. We want to use 'host' here
though, as that's more appropriate, so the fix is simply to remove the
tests on kvm32 like below.

Peter, would you mind running your test on the kvm32 machine with this
change before I send a v7? Actually, do I need to send a v7? Or is
type of fixup OK to do on merge?

Thanks,
drew


diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 92668efb8f56..14100ebd8521 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -417,8 +417,6 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
=20
     qts =3D qtest_init(MACHINE "-accel kvm -cpu host");
=20
-    assert_has_feature(qts, "host", "pmu");
-
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
         char max_name[8], name[8];
@@ -428,6 +426,7 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
         char *error;
=20
         assert_has_feature(qts, "host", "aarch64");
+        assert_has_feature(qts, "host", "pmu");
=20
         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
@@ -497,9 +496,6 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
         }
     } else {
         assert_has_not_feature(qts, "host", "sve");
-        assert_error(qts, "host",
-                     "'pmu' feature not supported by KVM on this host",
-                     "{ 'pmu': true }");
     }
=20
     qtest_quit(qts);


