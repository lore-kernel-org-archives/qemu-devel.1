Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC33C2D0C8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE596206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6Wr3L5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE596206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiNqs-0000Dg-Au
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iiNpP-00072z-5o
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iiNpN-0005jC-QH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46093
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iiNpN-0005gf-Lg
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576869644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAIg1jndVqtbahW24LK42vpmp+cvAhx5zyExwQTzPOg=;
 b=I6Wr3L5dypJxgFaVU1aqdf2Pt9srGOQKVgFBNv2wZfettIlYvp3KzKqVhdIl8fOhszDVRq
 oip9Wa983GWdSDnPvibw8v6lfiK0s+DUXtR9/k3E8tgCn0SPZWBJ1lterOBXpEdDZQ4TiD
 AeHm5lK3qJoKYgBfxCRGu43g7+DPLG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-y0H0z--FOO2fBnQyBan3Qg-1; Fri, 20 Dec 2019 14:20:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99595DB23;
 Fri, 20 Dec 2019 19:20:41 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96E1E5C1B0;
 Fri, 20 Dec 2019 19:20:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/3] i386: Resolve CPU models to v1 by default
Date: Fri, 20 Dec 2019 16:20:29 -0300
Message-Id: <20191220192031.2226378-2-ehabkost@redhat.com>
In-Reply-To: <20191220192031.2226378-1-ehabkost@redhat.com>
References: <20191220192031.2226378-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: y0H0z--FOO2fBnQyBan3Qg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using `query-cpu-definitions` using `-machine none`,
QEMU is resolving all CPU models to their latest versions.  The
actual CPU model version being used by another machine type (e.g.
`pc-q35-4.0`) might be different.

In theory, this was OK because the correct CPU model
version is returned when using the correct `-machine` argument.

Except that in practice, this breaks libvirt expectations:
libvirt always use `-machine none` when checking if a CPU model
is runnable, because runnability is not expected to be affected
when the machine type is changed.

For example, when running on a Haswell host without TSX,
Haswell-v4 is runnable, but Haswell-v1 is not.  On those hosts,
`query-cpu-definitions` says Haswell is runnable if using
`-machine none`, but Haswell is actually not runnable using any
of the `pc-*` machine types (because they resolve Haswell to
Haswell-v1).  In other words, we're breaking the "runnability
guarantee" we promised to not break for a few releases (see
qemu-deprecated.texi).

To address this issue, change the default CPU model version to v1
on all machine types, so we make `query-cpu-definitions` output
when using `-machine none` match the results when using `pc-*`.
This will change in the future (the plan is to always return the
latest CPU model version if using `-machine none`), but only
after giving libvirt the opportunity to adapt.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779078
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20191205223339.764534-1-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-deprecated.texi | 8 ++++++++
 target/i386/cpu.c    | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 62680f7bd5..7b94653cef 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -367,6 +367,14 @@ guarantees must resolve the CPU model aliases using te
 ``alias-of'' field returned by the ``query-cpu-definitions'' QMP
 command.
=20
+While those guarantees are kept, the return value of
+``query-cpu-definitions'' will have existing CPU model aliases
+point to a version that doesn't break runnability guarantees
+(specifically, version 1 of those CPU models).  In future QEMU
+versions, aliases will point to newer CPU model versions
+depending on the machine type, so management software must
+resolve CPU model aliases before starting a virtual machine.
+
=20
 @node Recently removed features
 @appendix Recently removed features
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0a9ac65974..ba5e9d5d6b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3981,7 +3981,13 @@ static PropValue tcg_default_props[] =3D {
 };
=20
=20
-X86CPUVersion default_cpu_version =3D CPU_VERSION_LATEST;
+/*
+ * We resolve CPU model aliases using -v1 when using "-machine
+ * none", but this is just for compatibility while libvirt isn't
+ * adapted to resolve CPU model versions before creating VMs.
+ * See "Runnability guarantee of CPU models" at * qemu-deprecated.texi.
+ */
+X86CPUVersion default_cpu_version =3D 1;
=20
 void x86_cpu_set_default_version(X86CPUVersion version)
 {
--=20
2.23.0


