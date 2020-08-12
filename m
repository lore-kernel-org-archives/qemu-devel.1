Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A671206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="TlgP1ruD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A671206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nOC-0005yZ-M6
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHh-0002Yi-G4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:43:01 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:40930
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHf-0006lF-FD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:43:01 -0400
Received: from MattGorko-Laptop.localdomain (unknown [78.194.154.81])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 281764162F;
 Wed, 12 Aug 2020 11:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1597225368; bh=WhUfeKytyuCUL59PtsGUkPGPstr2XF/LWbWzGaMaN3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TlgP1ruDZhrskORF3WMrQ+J6/xN91PDIjJ6cKrkwoK9EvK1NXXOWBZ34Lw7zf3i/z
 2PHkmtt2MclhRViBrWldPEFJdsO7cG9B3mz6peDHjFVLUJevsL/9XuQ5/jIcj5MZR6
 DuByUr4BPmwUCzFH+3gPnm4qQcrDpUveGcetNL88=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/13] scripts: Add u2f-setup-gen script
Date: Wed, 12 Aug 2020 11:41:33 +0200
Message-Id: <20200812094135.20550-12-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
References: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 05:42:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds the script used to generate setup directories, needed
for the device u2f-emulated configuration in directory mode:

    python u2f-setup-gen.py $DIR
    qemu -usb -device u2f-emulated,dir=$DIR

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 scripts/u2f-setup-gen.py | 170 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100755 scripts/u2f-setup-gen.py

diff --git a/scripts/u2f-setup-gen.py b/scripts/u2f-setup-gen.py
new file mode 100755
index 0000000000..2122598fed
--- /dev/null
+++ b/scripts/u2f-setup-gen.py
@@ -0,0 +1,170 @@
+#!/usr/bin/env python3
+#
+# Libu2f-emu setup directory generator for USB U2F key emulation.
+#
+# Copyright (c) 2020 César Belley <cesar.belley@lse.epita.fr>
+# Written by César Belley <cesar.belley@lse.epita.fr>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or, at your option, any later version.  See the COPYING file in
+# the top-level directory.
+
+import sys
+import os
+from random import randint
+from typing import Tuple
+
+from cryptography.hazmat.backends import default_backend
+from cryptography.hazmat.primitives.asymmetric import ec
+from cryptography.hazmat.primitives.serialization import Encoding, \
+    NoEncryption, PrivateFormat, PublicFormat
+from OpenSSL import crypto
+
+
+def write_setup_dir(dirpath: str, privkey_pem: bytes, cert_pem: bytes,
+                    entropy: bytes, counter: int) -> None:
+    """
+    Write the setup directory.
+
+    Args:
+        dirpath: The directory path.
+        key_pem: The private key PEM.
+        cert_pem: The certificate PEM.
+        entropy: The 48 bytes of entropy.
+        counter: The counter value.
+    """
+    # Directory
+    os.mkdir(dirpath)
+
+    # Private key
+    with open(f'{dirpath}/private-key.pem', 'bw') as f:
+        f.write(privkey_pem)
+
+    # Certificate
+    with open(f'{dirpath}/certificate.pem', 'bw') as f:
+        f.write(cert_pem)
+
+    # Entropy
+    with open(f'{dirpath}/entropy', 'wb') as f:
+        f.write(entropy)
+
+    # Counter
+    with open(f'{dirpath}/counter', 'w') as f:
+        f.write(f'{str(counter)}\n')
+
+
+def generate_ec_key_pair() -> Tuple[str, str]:
+    """
+    Generate an ec key pair.
+
+    Returns:
+        The private and public key PEM.
+    """
+    # Key generation
+    privkey = ec.generate_private_key(ec.SECP256R1, default_backend())
+    pubkey = privkey.public_key()
+
+    # PEM serialization
+    privkey_pem = privkey.private_bytes(encoding=Encoding.PEM,
+                                        format=PrivateFormat.TraditionalOpenSSL,
+                                        encryption_algorithm=NoEncryption())
+    pubkey_pem = pubkey.public_bytes(encoding=Encoding.PEM,
+                                     format=PublicFormat.SubjectPublicKeyInfo)
+    return privkey_pem, pubkey_pem
+
+
+def generate_certificate(privkey_pem: str, pubkey_pem: str) -> str:
+    """
+    Generate a x509 certificate from a key pair.
+
+    Args:
+        privkey_pem: The private key PEM.
+        pubkey_pem: The public key PEM.
+
+    Returns:
+        The certificate PEM.
+    """
+    # Convert key pair
+    privkey = crypto.load_privatekey(crypto.FILETYPE_PEM, privkey_pem)
+    pubkey = crypto.load_publickey(crypto.FILETYPE_PEM, pubkey_pem)
+
+    # New x509v3 certificate
+    cert = crypto.X509()
+    cert.set_version(0x2)
+
+    # Serial number
+    cert.set_serial_number(randint(1, 2 ** 64))
+
+    # Before / After
+    cert.gmtime_adj_notBefore(0)
+    cert.gmtime_adj_notAfter(4 * (365 * 24 * 60 * 60))
+
+    # Public key
+    cert.set_pubkey(pubkey)
+
+    # Subject name and issueer
+    cert.get_subject().CN = "U2F emulated"
+    cert.set_issuer(cert.get_subject())
+
+    # Extensions
+    cert.add_extensions([
+        crypto.X509Extension(b"subjectKeyIdentifier",
+                             False, b"hash", subject=cert),
+    ])
+    cert.add_extensions([
+        crypto.X509Extension(b"authorityKeyIdentifier",
+                             False, b"keyid:always", issuer=cert),
+    ])
+    cert.add_extensions([
+        crypto.X509Extension(b"basicConstraints", True, b"CA:TRUE")
+    ])
+
+    # Signature
+    cert.sign(privkey, 'sha256')
+
+    return crypto.dump_certificate(crypto.FILETYPE_PEM, cert)
+
+
+def generate_setup_dir(dirpath: str) -> None:
+    """
+    Generates the setup directory.
+
+    Args:
+        dirpath: The directory path.
+    """
+    # Key pair
+    privkey_pem, pubkey_pem = generate_ec_key_pair()
+
+    # Certificate
+    certificate_pem = generate_certificate(privkey_pem, pubkey_pem)
+
+    # Entropy
+    entropy = os.urandom(48)
+
+    # Counter
+    counter = 0
+
+    # Write
+    write_setup_dir(dirpath, privkey_pem, certificate_pem, entropy, counter)
+
+
+def main() -> None:
+    """
+    Main function
+    """
+    # Dir path
+    if len(sys.argv) != 2:
+        sys.stderr.write(f'Usage: {sys.argv[0]} <setup_dir>\n')
+        exit(2)
+    dirpath = sys.argv[1]
+
+    # Dir non existence
+    if os.path.exists(dirpath):
+        sys.stderr.write(f'Directory: {dirpath} already exists.\n')
+        exit(1)
+
+    generate_setup_dir(dirpath)
+
+
+if __name__ == '__main__':
+    main()
-- 
2.28.0


