Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EA9C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF94205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjf3EOJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF94205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxuL-0004qt-Fp
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 18:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDxJg-0006c2-Ps
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDxJf-0007E9-F9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:30:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40921)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDxJf-00078c-8X
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RvegJ88q70bON/LohdWsxFm4RI480T8ytw4ZvouggGw=;
 b=hjf3EOJSuePAbojHODSbASxqL7DcH+6CQBa2c1xbyuP3qdjZJHcdwUhgCbrqxL0NPSBxcB
 gv6mila1weusjHVUuh7eeFfdGXoWaAR3sFIpBMIUnXOcjBsjgKqKcRputLyGkpL8vD+rUW
 Rx+uxr77SjmeQWviSxj69C1hXtfDjuw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-FWfJVSHBPAij-F8FF4f79Q-1; Mon, 16 Mar 2020 17:30:28 -0400
X-MC-Unique: FWfJVSHBPAij-F8FF4f79Q-1
Received: by mail-wr1-f70.google.com with SMTP id u18so9572832wrn.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 14:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=muzU+wYjkhlwqhSb/6Hfi5D5d8nln1GaBm49ftTglK8=;
 b=pMm6XLKLwcdILyK5jhkAwYHOZH2i6ACDS8nUw90mmAjcb/oGFqGPZk89d7oHAs0qy6
 za5appFVubmPmyQVElOvwSPnNYJuuyaZTIu02Jp+U5MoYwfWc5XzfC+rc1jbm12KYpS9
 9bnGgSQ0lYlezqLTyDJ4XU9QfbHzMenZhGjVGUmssks0X5FrysGoEYin9swKIpSLVDlM
 vPjuJxC9yPw589mY4RLFAzjdO48OOxxIpL5ZPc57dktdIbEmpHO+KKUCPW4UTtVkYc7v
 yOBjDXoksxLoOVRPUPkivS+OgOWIRFNpJpCc7OLfSiDFqScHb+kgLXLAck4Hc1meZ7UU
 ra4g==
X-Gm-Message-State: ANhLgQ3zOmWEDLzb8nfSox6yEo4BnLddK9LvBp6v47i+opHHePxas7Hu
 vQdTT8Q/NoeQUGPcsiGHepqZ8OtROj8+3AzEyqY9Yfq+D57D2gqTF/K/J6Nn6EBx5+6bv9REWtV
 iUHPEP0nboAQiubo=
X-Received: by 2002:a5d:658f:: with SMTP id q15mr1391218wru.110.1584394226940; 
 Mon, 16 Mar 2020 14:30:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs930wP7+QYV5gzenk0bfT8/td5Vdq02IzYnA4BvZYqs4KZCopo49L5hyBTVPfaAjoE4I9qeg==
X-Received: by 2002:a5d:658f:: with SMTP id q15mr1391198wru.110.1584394226692; 
 Mon, 16 Mar 2020 14:30:26 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 r9sm1227253wma.47.2020.03.16.14.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 14:30:23 -0700 (PDT)
Date: Mon, 16 Mar 2020 17:30:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] checkpatch: enforce process for expected files
Message-ID: <20200316212834.664247-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, imammedo@redhat.com,
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


