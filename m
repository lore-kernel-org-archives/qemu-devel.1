Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BEFC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 22:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31C22245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 22:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LP6zaUom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31C22245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iczi8-0000Ba-O0
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 17:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iczh8-0007zy-C5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iczh1-0005ik-WC
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:33:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iczgz-0005ep-1q
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575585227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HWMtsqko9C2dTYmM1o5ZIxnFXtXC2FTQMR5CQothB7s=;
 b=LP6zaUombxh/2BvqKv9i5MkinwY7xK5NxIRUUoOnS6wkAAV6Eo1nOGQJquyLcH7y7iE4ps
 uR6geSdvQjlOjHnsIu+gbQeRl74MP2aWg/XtuD0nS+2/pSQBpMO5uUgYMqh/zA2h+7nSYt
 4kfDHW5ED5rsSMPZGPYC7gCPZqmtopo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-q8yD5t2aOqy2FN8xu6vG6A-1; Thu, 05 Dec 2019 17:33:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA77101F4F2;
 Thu,  5 Dec 2019 22:33:44 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0018A5D6BB;
 Thu,  5 Dec 2019 22:33:40 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] i386: Resolve CPU models to v1 by default
Date: Thu,  5 Dec 2019 19:33:39 -0300
Message-Id: <20191205223339.764534-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: q8yD5t2aOqy2FN8xu6vG6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, libvir-list@redhat.com,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
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
---
I don't think this should block QEMU 4.2.0 from being tagged.
The bug is present since 4.1.0, so we can fix it in 4.1.2 and/or
4.2.1.
---
 qemu-deprecated.texi | 8 ++++++++
 target/i386/cpu.c    | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 4b4b7425ac..b42d8b3c5f 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -374,6 +374,14 @@ guarantees must resolve the CPU model aliases using te
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
index 69f518a21a..54e7f18a09 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3924,7 +3924,13 @@ static PropValue tcg_default_props[] =3D {
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


