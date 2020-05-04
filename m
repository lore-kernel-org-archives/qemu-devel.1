Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C364C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1732C206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdJK3YUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1732C206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVa6N-0006w7-7I
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVZkb-0004Mh-2Z
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:59:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48635
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVZka-0002ve-3T
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588593547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbQJE8U0g9/taY1UGB+Es2fg0Z+KJRLr1l0iTS5yKYw=;
 b=UdJK3YUgQuS/cv9v6rWBfFSYCWcFO9c4MzhpLdWoIjyWX/z/KPlArocdEUJOygmL1v5dYe
 IRwWJOG2gsOl0Srp2fyxfRD9HaT7RcinozYqXZj+Z3ie51mycuYGRV32gR900OYEeeH9Nu
 5MnUFe7U1HdrBJGbl045sEBcGobsDhw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-ZLF1LVB2Nmaaftc4W8qbXg-1; Mon, 04 May 2020 07:59:02 -0400
X-MC-Unique: ZLF1LVB2Nmaaftc4W8qbXg-1
Received: by mail-wm1-f71.google.com with SMTP id o26so3368551wmh.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 04:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bcYO/D8ZBtkupiZf8L7h1wjpZYqhLskCmEjZ4tplteM=;
 b=XPt4/V4Su8rbpw0ydtSHj+T2nM7COd5n0OLYlGSjUlSWCCoqIiNtzGCCToswpyE9uy
 OQ9zAFmBUNZFjKLVISC+zVIMGycYciyMR3ySWafOGPau1je01bRUs6HnuXFWhGd9V4mo
 xzP5GTXiRjfvM4h9VAklvqCjA4RQmuMWsHg4hfqdtn+08SoerHXu9PumdTIX1Dm9DF7X
 75+Un3yx9pgaUs0sQTAaTBzK4fhagGkRb5LPreNwPwByNB2P3wD7TO3/hPwCcxGleiiV
 CSOLBQ2ay9uO9boeO8T6l7yiNHvqmJFpRwIxm+RpJQ4ZgiW/wem+7qeqedFXv3r6SJOL
 ODnA==
X-Gm-Message-State: AGi0PuZvrfzamsYH2Hv+BtRBD2grl3PBQdLZxFhmWdIO8xicsTTPrvOV
 MXUxhDZ1V+TcTExKpL7u97twGsUANuchiyC2xnDEULxv9ek/fvi16uWxdUiKl23Rc0xBd1xCfXJ
 gday0pYSAQ/uXGYk=
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr9976376wrt.251.1588593540663; 
 Mon, 04 May 2020 04:59:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypLfmb/j5FeF1BME42FpVRXU3QSoDM69pe+udfIAq3W07au5Ij0q7LcAQPA6+c/uzqT1llQVyA==
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr9976352wrt.251.1588593540421; 
 Mon, 04 May 2020 04:59:00 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 32sm17110071wrg.19.2020.05.04.04.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 04:59:00 -0700 (PDT)
Date: Mon, 4 May 2020 07:58:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] checkpatch: fix acpi check with multiple file name
Message-ID: <20200504115848.34410-2-mst@redhat.com>
References: <20200504115848.34410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504115848.34410-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using global expected/nonexpected values causes
false positives when testing multiple patches in one
checkpatch run: one patch can change expected,
another one non-expected.

Use local variables within process() to fix that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e658e6546f..c3d08aa99f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -35,8 +35,6 @@ my $summary_file =3D 0;
 my $root;
 my %debug;
 my $help =3D 0;
-my $acpi_testexpected;
-my $acpi_nontestexpected;
=20
 sub help {
 =09my ($exitcode) =3D @_;
@@ -1261,21 +1259,22 @@ sub WARN {
 # According to tests/qtest/bios-tables-test.c: do not
 # change expected file in the same commit with adding test
 sub checkfilename {
-=09my ($name) =3D @_;
+=09my ($name, $acpi_testexpected, $acpi_nontestexpected) =3D @_;
+
 =09if ($name =3D~ m#^tests/data/acpi/# and
 =09=09# make exception for a shell script that rebuilds the files
 =09=09not $name =3D~ m#^\.sh$# or
 =09=09$name =3D~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
-=09=09$acpi_testexpected =3D $name;
+=09=09$$acpi_testexpected =3D $name;
 =09} else {
-=09=09$acpi_nontestexpected =3D $name;
+=09=09$$acpi_nontestexpected =3D $name;
 =09}
-=09if (defined $acpi_testexpected and defined $acpi_nontestexpected) {
+=09if (defined $$acpi_testexpected and defined $$acpi_nontestexpected) {
 =09=09ERROR("Do not add expected files together with tests, " .
 =09=09      "follow instructions in " .
 =09=09      "tests/qtest/bios-tables-test.c: both " .
-=09=09      $acpi_testexpected . " and " .
-=09=09      $acpi_nontestexpected . " found\n");
+=09=09      $$acpi_testexpected . " and " .
+=09=09      $$acpi_nontestexpected . " found\n");
 =09}
 }
=20
@@ -1325,6 +1324,9 @@ sub process {
 =09my %suppress_whiletrailers;
 =09my %suppress_export;
=20
+        my $acpi_testexpected;
+        my $acpi_nontestexpected;
+
 =09# Pre-scan the patch sanitizing the lines.
=20
 =09sanitise_line_reset();
@@ -1454,11 +1456,11 @@ sub process {
 =09=09if ($line =3D~ /^diff --git.*?(\S+)$/) {
 =09=09=09$realfile =3D $1;
 =09=09=09$realfile =3D~ s@^([^/]*)/@@ if (!$file);
-=09                checkfilename($realfile);
+=09                checkfilename($realfile, \$acpi_testexpected, \$acpi_no=
ntestexpected);
 =09=09} elsif ($line =3D~ /^\+\+\+\s+(\S+)/) {
 =09=09=09$realfile =3D $1;
 =09=09=09$realfile =3D~ s@^([^/]*)/@@ if (!$file);
-=09                checkfilename($realfile);
+=09                checkfilename($realfile, \$acpi_testexpected, \$acpi_no=
ntestexpected);
=20
 =09=09=09$p1_prefix =3D $1;
 =09=09=09if (!$file && $tree && $p1_prefix ne '' &&
--=20
MST


