Received: from eggs.gnu.org ([2001:4830:134:3::10]:42546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW2SB-0002yf-AC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW2SA-0002DU-Fi
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:11 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 14:51:38 +0000
Message-Id: <20170124145152.22980-4-berrange@redhat.com>
In-Reply-To: <20170124145152.22980-1-berrange@redhat.com>
References: <20170124145152.22980-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/17] qcow: document another weakness of
 qcow AES encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Document that use of guest virtual sector numbers as the basis for
the initialization vectors is a potential weakness, when combined
with internal snapshots or multiple images using the same passphrase.
This fixes the formatting of the itemized list too.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img.texi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index 174aae3..db4534b 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -544,16 +544,29 @@ The use of encryption in qcow and qcow2 images is considered to be flawed by
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
2.9.3
