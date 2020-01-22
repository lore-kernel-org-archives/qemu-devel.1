Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA1AC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C092253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bavI0jMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C092253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuB2q-00077j-3n
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuB1a-0005nh-Rx
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuB1Z-0006Jz-Ox
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuB1Z-0006Jm-Ku
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579680365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlJnjJ+3ZP4ePljRJ/JkAaxMtB/9rVGyvi25BcNdQGg=;
 b=bavI0jMeqZv+MmCZygyT13Uf5yeZuyr1PuCRUgrb3p6ssECYJpxsjVLAun9co6iH898wtu
 BMiWKN79nZDH0K9iCVsvSu/x8Nj0/MQpha64y0BKc4UwtanzDVKVUFbZsdEHE1myOecD2v
 4fYWuYOst/9wewBZA/1CCQMGNU4wH8E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-7ZZfYgwwP7ypZGOK58MqIw-1; Wed, 22 Jan 2020 03:06:02 -0500
Received: by mail-wm1-f72.google.com with SMTP id q206so1724971wme.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XG/sn9pQFsKpaxx2vC6q2UHSVL54RMJxUz70n6+fTLs=;
 b=GJYVTEFBGVfnD6YGyUgLsyKhy2zQlv3N944dTtlMRl+YRlQ2ZJF26tF/aRMZcZ6k/3
 LAatjEy6zJqVCiXAHVmg2JJxtZvzrZFPWHpst41imiWzwnjtkzGs2AWLmPqWAAs7GyB/
 ImclXmCKbeeVSeCjxK5aw1bDlIsbQRVFlDZB54xK8XC5JHJDzYnykPJOUWZ6KEeNC8ll
 sasO4LKyCTewai9Fr62bQn/vW8aer1vfzF7rZsUk9vRVCh62VfM5MFmNCKZilV3PAkHg
 UzUH4htjDcVqs/mUwvLBh07g3Y0KrXwuxKFNQ36v07WtUk6EbFfK76JK87/i951ydvqz
 TBOA==
X-Gm-Message-State: APjAAAVokt8rMsis8wdfVxTAKVUEcMqs1CKsCSjXdPT/ej6T0HCu6Ip2
 leUeAv2wCTFXDF3xNfcc7MTxiozCns7/AOC1J4Os5pMhd+u3SuQeXrz9KxVBRbD2FJPq/yz0NJx
 v8hwCnymktRwfMsU=
X-Received: by 2002:a7b:c386:: with SMTP id s6mr1524469wmj.105.1579680360939; 
 Wed, 22 Jan 2020 00:06:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwleuJBJphWkqgFJZtCRqq6y5p2J0YH4D5z0h9M8fuS9mP7Ddf+Qn2dYx3QM1NAIrs7vmAa+Q==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr1524449wmj.105.1579680360705; 
 Wed, 22 Jan 2020 00:06:00 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 m10sm57021564wrx.19.2020.01.22.00.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:06:00 -0800 (PST)
Date: Wed, 22 Jan 2020 03:05:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] bios-tables-test: default diff command
Message-ID: <20200122080538.591734-4-mst@redhat.com>
References: <20200122080538.591734-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122080538.591734-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 7ZZfYgwwP7ypZGOK58MqIw-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most people probably just want diff -u. So let's use that
as the default.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index c8db2839b2..6ec1c5be64 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -465,24 +465,17 @@ static void test_acpi_asl(test_data *data)
                         exp_sdt->asl_file, exp_sdt->aml_file);
                 fflush(stderr);
                 if (getenv("V")) {
-                    const char *diff_cmd =3D getenv("DIFF");
-                    if (diff_cmd) {
-                        char *diff =3D g_strdup_printf("%s %s %s", diff_cm=
d,
-                            exp_sdt->asl_file, sdt->asl_file);
-                        int out =3D dup(STDOUT_FILENO);
-                        int ret G_GNUC_UNUSED;
+                    const char *diff_env =3D getenv("DIFF");
+                    const char *diff_cmd =3D diff_env ? diff_env : "diff -=
u";
+                    char *diff =3D g_strdup_printf("%s %s %s", diff_cmd,
+                                                 exp_sdt->asl_file, sdt->a=
sl_file);
+                    int out =3D dup(STDOUT_FILENO);
+                    int ret G_GNUC_UNUSED;
=20
-                        dup2(STDERR_FILENO, STDOUT_FILENO);
-                        ret =3D system(diff) ;
-                        dup2(out, STDOUT_FILENO);
-                        g_free(diff);
-                    } else {
-                        fprintf(stderr, "acpi-test: Warning. not showing "
-                            "difference since no diff utility is specified=
. "
-                            "Set 'DIFF' environment variable to a preferre=
d "
-                            "diff utility and run 'make V=3D1 check' again=
 to "
-                            "see ASL difference.");
-                    }
+                    dup2(STDERR_FILENO, STDOUT_FILENO);
+                    ret =3D system(diff) ;
+                    dup2(out, STDOUT_FILENO);
+                    g_free(diff);
                 }
             }
         }
--=20
MST


