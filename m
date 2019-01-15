Received: from eggs.gnu.org ([209.51.188.92]:48318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQCK-00020b-Kw
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQCE-0007Qm-SO
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:00:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjQCE-0007QJ-Mi
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:00:06 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 15 Jan 2019 14:52:49 +0000
Message-Id: <20190115145256.9593-6-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-1-berrange@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/12] chardev: ensure qemu_chr_parse_compat
 reports missing driver error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

If no valid char driver was identified the qemu_chr_parse_compat method
was silent, leaving callers no clue what failed.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index ccba36bafb..b99f3692f7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -490,6 +490,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
         return opts;
     }
=20
+    error_report("'%s' is not a valid char driver", filename);
+
 fail:
     qemu_opts_del(opts);
     return NULL;
--=20
2.20.1
