Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECED2C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 11:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA234206EB
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 11:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Krz1oRtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA234206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDRZy-00072G-On
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 07:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDRYj-0006cQ-5b
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 07:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDRYh-0005EA-Tr
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 07:35:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDRYh-0005AH-Nn
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 07:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584272155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RjdB9XcGgG/dFT3rZPnXe/qxzZfls3cE6swBtV2krPs=;
 b=Krz1oRtVXkz6ukByOw5vlknGoFjNEgt66WBKXSk5bNGz9bEa44QXErmhXnAHk2OfcIl+1L
 SDJQq1TCHT5OL0hp4HXRdGzewPD18npdo8RTS84h/IwUkDvD4MTmin1XCm0M3qa1z6ozWd
 xzTxnRr40OVokhh1mXCXz0nMKF7jJ7A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-zw7ufqfkMye-sKXUI2EEkg-1; Sun, 15 Mar 2020 07:35:53 -0400
X-MC-Unique: zw7ufqfkMye-sKXUI2EEkg-1
Received: by mail-qk1-f200.google.com with SMTP id a21so14156902qkg.6
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 04:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=eK4MVihWNVcAO0TRQlIG3t5TCKOqRslNJy/UTzxk9sI=;
 b=nPtdEdq0q1QMa4PMJMXwduHcs8tvjnQ+ojQV6+SdueKygUDFqln9Oxp3Ey0UJXDHTT
 dT+OnFHI/0MgyG6FeLYB+6N+JsI4809b8KZJYO+UhHYF61MwGYsdMNXWVBquqn3NSQSx
 O1zDKah/472maYe09+ncMfREkH67Pyi2EmRaahA9IqoZi1qp+xQTfkqXsB0ncArlu31o
 4+AzLQwCczjXH9azIpqN0HJovEGPpPCuscNwYHP5GQoo3scMvHgH+EPAtfd6zSpQpzef
 T72m62skQjBLT5cudaPk6Ycl4rg3KM/5Vq/E/KI8Hz7khSRsbGo5GlBCE/abkIa3SeBj
 7KOA==
X-Gm-Message-State: ANhLgQ2sWZy6CdDyGq8kKq4p1WN+OWt5+FcwyEQWX9kLeAFPEFF4sZxM
 A+qghMi8UsFCwpvcyRPt3yxlzkcXttLHrWljS4ow8AID5Vy0FbTB5rV4biBOam8emO1AB/V45ES
 Onpb8RUsU/Px7lkk=
X-Received: by 2002:a37:a08b:: with SMTP id
 j133mr22666377qke.265.1584272152822; 
 Sun, 15 Mar 2020 04:35:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsaTD6YCrcRI5JRuivMcwgFPz+OpZpuNiO60mFyd4qqKXZroL1/wvvpiy0xzGgD0GzU/Wvd5Q==
X-Received: by 2002:a37:a08b:: with SMTP id
 j133mr22666357qke.265.1584272152577; 
 Sun, 15 Mar 2020 04:35:52 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 x11sm19485332qkf.67.2020.03.15.04.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 04:35:51 -0700 (PDT)
Date: Sun, 15 Mar 2020 07:35:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] checkpatch: enforce process for expected files
Message-ID: <20200315113323.526984-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Peter, Igor what do you think?

 scripts/checkpatch.pl | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b27e4ff5e9..96583e3fff 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -35,6 +35,8 @@ my $summary_file =3D 0;
 my $root;
 my %debug;
 my $help =3D 0;
+my $testexpected;
+my $nontestexpected;
=20
 sub help {
 =09my ($exitcode) =3D @_;
@@ -1256,6 +1258,26 @@ sub WARN {
 =09}
 }
=20
+# According to tests/qtest/bios-tables-test.c: do not
+# change expected file in the same commit with adding test
+sub checkfilename {
+=09my ($name) =3D @_;
+        if ($name =3D~ m#^tests/data/acpi/# and
+            # make exception for a shell script that rebuilds the files
+            not $name =3D~ m#^\.sh$# or
+            $name =3D~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
+            $testexpected =3D $name;
+        } else {
+            $nontestexpected =3D $name;
+        }
+        if (defined $testexpected and defined $nontestexpected) {
+            ERROR("Do not add expected files together with tests, " .
+                  "follow instructions in " .
+                  "tests/qtest/bios-tables-test.c: both " .
+                  $testexpected . " and " . $nontestexpected . " found\n")=
;
+        }
+}
+
 sub process {
 =09my $filename =3D shift;
=20
@@ -1431,9 +1453,11 @@ sub process {
 =09=09if ($line =3D~ /^diff --git.*?(\S+)$/) {
 =09=09=09$realfile =3D $1;
 =09=09=09$realfile =3D~ s@^([^/]*)/@@ if (!$file);
+                        checkfilename($realfile);
 =09=09} elsif ($line =3D~ /^\+\+\+\s+(\S+)/) {
 =09=09=09$realfile =3D $1;
 =09=09=09$realfile =3D~ s@^([^/]*)/@@ if (!$file);
+                        checkfilename($realfile);
=20
 =09=09=09$p1_prefix =3D $1;
 =09=09=09if (!$file && $tree && $p1_prefix ne '' &&
--=20
MST


