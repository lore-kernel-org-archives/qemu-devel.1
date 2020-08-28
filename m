Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F6C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B072098B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMiInzWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B072098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBZST-0002D9-OM
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRU-0000Wo-43
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRR-0003S0-Vu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598602137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wq5Pda4Lt5SRqI7o7hjLCdVq24fwCUMV/EoS3UXA+x0=;
 b=QMiInzWI8hpZ66lIFMDmj/n6fmeXXkkXvIUR7d0SP8Qm62nAnRCsMw7DFhJxeCp/LANCRO
 0c8bGB1FxoGBJTmFc6at46rkTyN2zulyKfO2flW4n7gAWQAiT7W9uc35R6l6vgxeUeTndL
 I4gggYizq1bR4peX4Y4lOIMYh33BEdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-XAhWLOpNOnWABZPyBsbQPA-1; Fri, 28 Aug 2020 04:08:53 -0400
X-MC-Unique: XAhWLOpNOnWABZPyBsbQPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1223C801FDB;
 Fri, 28 Aug 2020 08:08:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 311697D4EC;
 Fri, 28 Aug 2020 08:08:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6E96131E88; Fri, 28 Aug 2020 10:08:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] scripts: Add u2f-setup-gen script
Date: Fri, 28 Aug 2020 10:08:41 +0200
Message-Id: <20200828080845.28287-15-kraxel@redhat.com>
In-Reply-To: <20200828080845.28287-1-kraxel@redhat.com>
References: <20200828080845.28287-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 02:09:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: César Belley <cesar.belley@lse.epita.fr>

This patch adds the script used to generate setup directories, needed
for the device u2f-emulated configuration in directory mode:

    python u2f-setup-gen.py $DIR
    qemu -usb -device u2f-emulated,dir=$DIR

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
Message-id: 20200826114209.28821-11-cesar.belley@lse.epita.fr
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 scripts/u2f-setup-gen.py | 170 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100755 scripts/u2f-setup-gen.py

diff --git a/scripts/u2f-setup-gen.py b/scripts/u2f-setup-gen.py
new file mode 100755
index 000000000000..2122598fed8e
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
2.27.0


