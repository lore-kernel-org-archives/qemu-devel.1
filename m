Received: from eggs.gnu.org ([2001:4830:134:3::10]:43961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxiG-00068S-BE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxiF-0004ri-Bd
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:36 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:06:52 +0200
Message-Id: <20170711160814.20941-4-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 03/85] qcow: document another weakness of qcow
 AES encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Document that use of guest virtual sector numbers as the basis for
the initialization vectors is a potential weakness, when combined
with internal snapshots or multiple images using the same passphrase.
This fixes the formatting of the itemized list too.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-4-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.texi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index 5b925ec..f335139 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -567,16 +567,29 @@ The use of encryption in qcow and qcow2 images is considered to be flawed by
 modern cryptography standards, suffering from a number of design problems:
 
 @itemize @minus
-@item The AES-CBC cipher is used with predictable initialization vectors based
+@item
+The AES-CBC cipher is used with predictable initialization vectors based
 on the sector number. This makes it vulnerable to chosen plaintext attacks
 which can reveal the existence of encrypted data.
-@item The user passphrase is directly used as the encryption key. A poorly
+@item
+The user passphrase is directly used as the encryption key. A poorly
 chosen or short passphrase will compromise the security of the encryption.
-@item In the event of the passphrase being compromised there is no way to
+@item
+In the event of the passphrase being compromised there is no way to
 change the passphrase to protect data in any qcow images. The files must
 be cloned, using a different encryption passphrase in the new file. The
 original file must then be securely erased using a program like shred,
 though even this is ineffective with many modern storage technologies.
+@item
+Initialization vectors used to encrypt sectors are based on the
+guest virtual sector number, instead of the host physical sector. When
+a disk image has multiple internal snapshots this means that data in
+multiple physical sectors is encrypted with the same initialization
+vector. With the CBC mode, this opens the possibility of watermarking
+attacks if the attack can collect multiple sectors encrypted with the
+same IV and some predictable data. Having multiple qcow2 images with
+the same passphrase also exposes this weakness since the passphrase
+is directly used as the key.
 @end itemize
 
 Use of qcow / qcow2 encryption is thus strongly discouraged. Users are
-- 
2.9.4
