Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588BCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2267A20705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCXTeMoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2267A20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcF4-0004tQ-A3
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6O-0005aK-OZ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6N-0006CL-Qu
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbQJE8U0g9/taY1UGB+Es2fg0Z+KJRLr1l0iTS5yKYw=;
 b=MCXTeMozrscsRpo6MpLofvvSSHF2WLCuBXkeuFeMpqVW6NPNw+Y3Bkgnmno0EnQcukwlMs
 UKETtYXAT0uAznVeXQP2n+sBjmXJm6uPhfqKAiYwCW2igIZxrq0zR8xDVD1tzvF8AoLDeL
 Wj7B0IFYjYuQwIN+OtY8lfv1s4ptkE0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-vWrqXNiVMN6IwB7M45jcqg-1; Mon, 04 May 2020 10:29:45 -0400
X-MC-Unique: vWrqXNiVMN6IwB7M45jcqg-1
Received: by mail-wm1-f70.google.com with SMTP id d134so89698wmd.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bcYO/D8ZBtkupiZf8L7h1wjpZYqhLskCmEjZ4tplteM=;
 b=lUjrXjsL9tghZRFXlIOX4fE04HTLMUw1RgnU1qcx5oKZ7U8z2OV9vKjkHqKL4nJ+Rq
 NdLH5VQZSfVOY8YeFVevUcP7JjIXzTRjvJuZs7JEa63a3P6rjjw2w6org4Yt+RQOrnWQ
 CbEQIINEDINR3b9LXJEzIbZrvI9CbKI5dgrTKs6tfC1tQbBkieOi7EmGyU7ljtfgmEwT
 I02j6p7jTZaUPd4wcehLOaTQwrElLubBv6mTGt01Uq293WlRds4A8/E9UxWbzb3QbH+9
 06tPiWsdon+1hY8y86USFbF+SHn7agugCUTMby2m2qyNY67a5lUee2zS42/ijr4Z/UJ4
 toEQ==
X-Gm-Message-State: AGi0PuZM6D0UAqiVjK+ZlMzW+UOu9Yk54MFdzkVPXc+JMhrbRLmQgdga
 0nPpPH84qMzZDvBa6KYAv1hNrrxmcB5o5wDIWNKFgd/qRLFX+ZAUx5O+0nzeDLnVkcql0GgIRD7
 C9tBesfYc6uU6Oag=
X-Received: by 2002:a5d:494a:: with SMTP id r10mr18396919wrs.136.1588602584177; 
 Mon, 04 May 2020 07:29:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypLMVZTX9H1M4Eo+2/PqOXrl37se+gPoorHIkLZYidnheaCnONpaBfkmPXUPmlmQOLyrvzHfvA==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr18396904wrs.136.1588602583998; 
 Mon, 04 May 2020 07:29:43 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 x5sm1965587wro.12.2020.05.04.07.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:43 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/29] checkpatch: fix acpi check with multiple file name
Message-ID: <20200504142814.157589-13-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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


