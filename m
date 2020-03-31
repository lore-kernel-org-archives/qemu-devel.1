Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8B0C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21A620781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad9uoukP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21A620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJINN-0004yR-RZ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIKE-00083F-3X
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIKC-00052E-MG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42389
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIKC-00051p-I2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvegJ88q70bON/LohdWsxFm4RI480T8ytw4ZvouggGw=;
 b=Ad9uoukPAoLmk7MnuICsihEVEMlraos5garenEH+Tkq9HNtD1aovpc2NbKCm7nqwX+Ua50
 cOt+dazakpNbt/7f3/RsNgYTnfIBnCNKSILLMgNyAGtS2OinAJ9F1Cjpoe9n3cd/NKoC77
 bD3/z+wpRyQJ+bqDKRg8/qZD8juIA3A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-KPSvr1VPNiapxXDe5XLS6g-1; Tue, 31 Mar 2020 10:57:04 -0400
X-MC-Unique: KPSvr1VPNiapxXDe5XLS6g-1
Received: by mail-wm1-f71.google.com with SMTP id s15so802347wmc.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=muzU+wYjkhlwqhSb/6Hfi5D5d8nln1GaBm49ftTglK8=;
 b=Vb7blaUKHo9WGc8tBF2C7p7IANfpLB176tk+w9WsDC2SaJFufZQNhqygHNIytkcBDh
 tTcnguTtcmKiKJlC1ia+xATJzgKq9SPv/djyQC+sZQaiy8DKYfBS7vbXsf2Rs9xLXdFm
 Omk9IKDSJDPlr4+xUNOnxyK4/44uC5aPj1KA0HjNg8kQRBADXl17otlb2AkuNIwEQ71X
 brCC0rsmECIDBKRtASRW1XmaztuYoIQEbWZjZA1SFXk9+JjaSS7ytrWldbgKckaG8436
 nrKRj0HzqtU4CqfF2NvswS81VGxEc2gPgaPq9cZOTlkCzO2gzvNRRRXlpjt4KlWV6cJU
 MZYQ==
X-Gm-Message-State: ANhLgQ1SpgJgK/h/43AsjkmrbcqcURV0i7/gQoDZmaS5BxBM2nzOTF5r
 2WpNGguYN+xgB7UfJAB1kKIuXEWAmwYF5fQ+YI3x/46FX2bZmuzJC9agXUn775fjkVU6OT2M6Xq
 jgw6gjEtxoL/K/vA=
X-Received: by 2002:adf:9f42:: with SMTP id f2mr21461372wrg.246.1585666623072; 
 Tue, 31 Mar 2020 07:57:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvPl9ghByRiQrYQlg+cUEurP8Q5uxhGbJthzEUJ6/1t/7ec8uGatW0BhCHJxXLgUfSG2fT96w==
X-Received: by 2002:adf:9f42:: with SMTP id f2mr21461346wrg.246.1585666622808; 
 Tue, 31 Mar 2020 07:57:02 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id m19sm4097428wml.48.2020.03.31.07.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:57:02 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:57:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] checkpatch: enforce process for expected files
Message-ID: <20200331145631.135630-2-mst@redhat.com>
References: <20200331145631.135630-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331145631.135630-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the process documented in tests/qtest/bios-tables-test.c
is followed, then same patch never touches both expected
files and code. Teach checkpatch to enforce this rule.

Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b27e4ff5e9..e658e6546f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -35,6 +35,8 @@ my $summary_file =3D 0;
 my $root;
 my %debug;
 my $help =3D 0;
+my $acpi_testexpected;
+my $acpi_nontestexpected;
=20
 sub help {
 =09my ($exitcode) =3D @_;
@@ -1256,6 +1258,27 @@ sub WARN {
 =09}
 }
=20
+# According to tests/qtest/bios-tables-test.c: do not
+# change expected file in the same commit with adding test
+sub checkfilename {
+=09my ($name) =3D @_;
+=09if ($name =3D~ m#^tests/data/acpi/# and
+=09=09# make exception for a shell script that rebuilds the files
+=09=09not $name =3D~ m#^\.sh$# or
+=09=09$name =3D~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
+=09=09$acpi_testexpected =3D $name;
+=09} else {
+=09=09$acpi_nontestexpected =3D $name;
+=09}
+=09if (defined $acpi_testexpected and defined $acpi_nontestexpected) {
+=09=09ERROR("Do not add expected files together with tests, " .
+=09=09      "follow instructions in " .
+=09=09      "tests/qtest/bios-tables-test.c: both " .
+=09=09      $acpi_testexpected . " and " .
+=09=09      $acpi_nontestexpected . " found\n");
+=09}
+}
+
 sub process {
 =09my $filename =3D shift;
=20
@@ -1431,9 +1454,11 @@ sub process {
 =09=09if ($line =3D~ /^diff --git.*?(\S+)$/) {
 =09=09=09$realfile =3D $1;
 =09=09=09$realfile =3D~ s@^([^/]*)/@@ if (!$file);
+=09                checkfilename($realfile);
 =09=09} elsif ($line =3D~ /^\+\+\+\s+(\S+)/) {
 =09=09=09$realfile =3D $1;
 =09=09=09$realfile =3D~ s@^([^/]*)/@@ if (!$file);
+=09                checkfilename($realfile);
=20
 =09=09=09$p1_prefix =3D $1;
 =09=09=09if (!$file && $tree && $p1_prefix ne '' &&
--=20
MST


