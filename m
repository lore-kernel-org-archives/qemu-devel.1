Received: from eggs.gnu.org ([2001:4830:134:3::10]:37447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fq1os-0003DG-F6
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fq1oo-0000qV-0R
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:51:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34726 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fq1on-0000qH-RL
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:50:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC1CD8197020
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 19:50:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 15 Aug 2018 21:50:50 +0200
Message-Id: <20180815195051.24586-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] qemu-option: add help fallback to print
 the list of options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

QDev options accept '?' or 'help' in the list of parameters, which is
really handy to list the available options.

Unfortunately, this isn't built in QemuOpts. qemu_opts_parse_noisily()
seems to be the common path for command line options, so place a
fallback to check for '?' and print help listing available options.

This is very handy, for example with qemu "-spice ?".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/qemu-option.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 01886efe90..8839ee6523 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -889,7 +889,12 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list=
, const char *params,
=20
     opts =3D opts_parse(list, params, permit_abbrev, false, &err);
     if (err) {
-        error_report_err(err);
+        if (has_help_option(params)) {
+            qemu_opts_print_help(list);
+            error_free(err);
+        } else {
+            error_report_err(err);
+        }
     }
     return opts;
 }
--=20
2.18.0.547.g1d89318c48
