Received: from eggs.gnu.org ([2001:4830:134:3::10]:37692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9aef-00059W-T9
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9aeb-0006oE-03
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9aea-0006lQ-Qb
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:31 -0300
Message-Id: <20180420181951.7252-5-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 04/24] avocado_qemu: Be lenient towards poluted
 serial console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

The serial console is frequently spammed kernel messages, let's not be
so strict and match lines also containing other parts.

There is still possibility of failure in case kernel injects message on
a new line after the expected output producing non-matching last_line.
Anyway checking for any-line would be a bit too prone to false-positives
so let's just go with this at this point.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/avocado_qemu/test.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_q=
emu/test.py
index 9cc163b3a8..fb16785a20 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -131,9 +131,9 @@ def _handle_prompts(session, username, password, prom=
pt, timeout=3D10,
             match, text =3D session.read_until_last_line_matches(
                 [r"[Aa]re you sure", r"[Pp]assword:\s*",
                  # Prompt of rescue mode for Red Hat.
-                 r"\(or (press|type) Control-D to continue\):\s*$",
-                 r"[Gg]ive.*[Ll]ogin:\s*$",  # Prompt of rescue mode for=
 SUSE.
-                 r"(?<![Ll]ast )[Ll]ogin:\s*$",  # Don't match "Last Log=
in:"
+                 r"\(or (press|type) Control-D to continue\):\s*",
+                 r"[Gg]ive.*[Ll]ogin:\s*",  # Prompt of rescue mode for =
SUSE.
+                 r"(?<![Ll]ast )[Ll]ogin:\s*",  # Don't match "Last Logi=
n:"
                  r"[Cc]onnection.*closed", r"[Cc]onnection.*refused",
                  r"[Pp]lease wait", r"[Ww]arning", r"[Ee]nter.*username"=
,
                  r"[Ee]nter.*password", r"[Cc]onnection timed out", prom=
pt,
--=20
2.14.3
