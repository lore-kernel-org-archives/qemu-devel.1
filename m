Received: from eggs.gnu.org ([2001:4830:134:3::10]:45636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dN0b6-0004se-FM
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dN0b5-0001Wz-8u
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:36:20 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 19 Jun 2017 18:34:55 +0100
Message-Id: <20170619173455.18805-21-berrange@redhat.com>
In-Reply-To: <20170619173455.18805-1-berrange@redhat.com>
References: <20170619173455.18805-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v9 20/20] docs: document encryption options for
 qcow, qcow2 and luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "Daniel P. Berrange" <berrange@redhat.com>

Expand the image format docs to cover the new options for
the qcow, qcow2 and luks disk image formats

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-doc.texi | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 115 insertions(+), 8 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 965ba59..3c3081f 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -541,10 +541,20 @@ File name of a base image (see @option{create} subcommand)
 @item backing_fmt
 Image format of the base image
 @item encryption
-If this option is set to @code{on}, the image is encrypted with 128-bit AES-CBC.
+This option is deprecated and equivalent to @code{encrypt.format=aes}
 
-The use of encryption in qcow and qcow2 images is considered to be flawed by
-modern cryptography standards, suffering from a number of design problems:
+@item encrypt.format
+
+If this is set to @code{luks}, it requests that the qcow2 payload (not
+qcow2 header) be encrypted using the LUKS format. The passphrase to
+use to unlock the LUKS key slot is given by the @code{encrypt.key-secret}
+parameter. LUKS encryption parameters can be tuned with the other
+@code{encrypt.*} parameters.
+
+If this is set to @code{aes}, the image is encrypted with 128-bit AES-CBC.
+The encryption key is given by the @code{encrypt.key-secret} parameter.
+This encryption format is considered to be flawed by modern cryptography
+standards, suffering from a number of design problems:
 
 @itemize @minus
 @item The AES-CBC cipher is used with predictable initialization vectors based
@@ -559,10 +569,45 @@ original file must then be securely erased using a program like shred,
 though even this is ineffective with many modern storage technologies.
 @end itemize
 
-Use of qcow / qcow2 encryption with QEMU is deprecated, and support for
-it will go away in a future release.  Users are recommended to use an
-alternative encryption technology such as the Linux dm-crypt / LUKS
-system.
+The use of this is no longer supported in system emulators. Support only
+remains in the command line utilities, for the purposes of data liberation
+and interoperability with old versions of QEMU. The @code{luks} format
+should be used instead.
+
+@item encrypt.key-secret
+
+Provides the ID of a @code{secret} object that contains the passphrase
+(@code{encrypt.format=luks}) or encryption key (@code{encrypt.format=aes}).
+
+@item encrypt.cipher-alg
+
+Name of the cipher algorithm and key length. Currently defaults
+to @code{aes-256}. Only used when @code{encrypt.format=luks}.
+
+@item encrypt.cipher-mode
+
+Name of the encryption mode to use. Currently defaults to @code{xts}.
+Only used when @code{encrypt.format=luks}.
+
+@item encrypt.ivgen-alg
+
+Name of the initialization vector generator algorithm. Currently defaults
+to @code{plain64}. Only used when @code{encrypt.format=luks}.
+
+@item encrypt.ivgen-hash-alg
+
+Name of the hash algorithm to use with the initialization vector generator
+(if required). Defaults to @code{sha256}. Only used when @code{encrypt.format=luks}.
+
+@item encrypt.hash-alg
+
+Name of the hash algorithm to use for PBKDF algorithm
+Defaults to @code{sha256}. Only used when @code{encrypt.format=luks}.
+
+@item encrypt.iter-time
+
+Amount of time, in milliseconds, to use for PBKDF algorithm per key slot.
+Defaults to @code{2000}. Only used when @code{encrypt.format=luks}.
 
 @item cluster_size
 Changes the qcow2 cluster size (must be between 512 and 2M). Smaller cluster
@@ -637,7 +682,69 @@ Supported options:
 @item backing_file
 File name of a base image (see @option{create} subcommand)
 @item encryption
-If this option is set to @code{on}, the image is encrypted.
+This option is deprecated and equivalent to @code{encrypt.format=aes}
+
+@item encrypt.format
+If this is set to @code{aes}, the image is encrypted with 128-bit AES-CBC.
+The encryption key is given by the @code{encrypt.key-secret} parameter.
+This encryption format is considered to be flawed by modern cryptography
+standards, suffering from a number of design problems enumerated previously
+against the @code{qcow2} image format.
+
+The use of this is no longer supported in system emulators. Support only
+remains in the command line utilities, for the purposes of data liberation
+and interoperability with old versions of QEMU.
+
+Users requiring native encryption should use the @code{qcow2} format
+instead with @code{encrypt.format=luks}.
+
+@item encrypt.key-secret
+
+Provides the ID of a @code{secret} object that contains the encryption
+key (@code{encrypt.format=aes}).
+
+@end table
+
+@item luks
+
+LUKS v1 encryption format, compatible with Linux dm-crypt/cryptsetup
+
+Supported options:
+@table @code
+
+@item key-secret
+
+Provides the ID of a @code{secret} object that contains the passphrase.
+
+@item cipher-alg
+
+Name of the cipher algorithm and key length. Currently defaults
+to @code{aes-256}.
+
+@item cipher-mode
+
+Name of the encryption mode to use. Currently defaults to @code{xts}.
+
+@item ivgen-alg
+
+Name of the initialization vector generator algorithm. Currently defaults
+to @code{plain64}.
+
+@item ivgen-hash-alg
+
+Name of the hash algorithm to use with the initialization vector generator
+(if required). Defaults to @code{sha256}.
+
+@item hash-alg
+
+Name of the hash algorithm to use for PBKDF algorithm
+Defaults to @code{sha256}.
+
+@item iter-time
+
+Amount of time, in milliseconds, to use for PBKDF algorithm per key slot.
+Defaults to @code{2000}.
+
 @end table
 
 @item vdi
-- 
2.9.3
