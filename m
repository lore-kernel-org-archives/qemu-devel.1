Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AEDFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D192064B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D192064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKp3L-0001ng-E9
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 15:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKouy-0001jy-FN
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKoux-0002W5-2i
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:25:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1iKouu-0002UI-8Z; Wed, 16 Oct 2019 15:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D08F877A61;
 Wed, 16 Oct 2019 19:25:03 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 179145C1D4;
 Wed, 16 Oct 2019 19:24:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/10] image-fuzzer: Return bytes objects on string fuzzing
 functions
Date: Wed, 16 Oct 2019 16:24:26 -0300
Message-Id: <20191016192430.25098-7-ehabkost@redhat.com>
In-Reply-To: <20191016192430.25098-1-ehabkost@redhat.com>
References: <20191016192430.25098-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 16 Oct 2019 19:25:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No caller of fuzzer functions is interested in unicode string values,
so replace them with bytes sequences.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/image-fuzzer/qcow2/fuzz.py | 42 ++++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tests/image-fuzzer/qcow2/fuzz.py b/tests/image-fuzzer/qcow2/=
fuzz.py
index 154dc06cc0..c58bf11005 100644
--- a/tests/image-fuzzer/qcow2/fuzz.py
+++ b/tests/image-fuzzer/qcow2/fuzz.py
@@ -36,11 +36,11 @@ UINT32_V =3D [0, 0x100, 0x1000, 0x10000, 0x100000, UI=
NT32//4, UINT32//2 - 1,
 UINT64_V =3D UINT32_V + [0x1000000, 0x10000000, 0x100000000, UINT64//4,
                        UINT64//2 - 1, UINT64//2, UINT64//2 + 1, UINT64 -=
 1,
                        UINT64]
-STRING_V =3D ['%s%p%x%d', '.1024d', '%.2049d', '%p%p%p%p', '%x%x%x%x',
-            '%d%d%d%d', '%s%s%s%s', '%99999999999s', '%08x', '%%20d', '%=
%20n',
-            '%%20x', '%%20s', '%s%s%s%s%s%s%s%s%s%s', '%p%p%p%p%p%p%p%p%=
p%p',
-            '%#0123456x%08x%x%s%p%d%n%o%u%c%h%l%q%j%z%Z%t%i%e%g%f%a%C%S%=
08x%%',
-            '%s x 129', '%x x 257']
+BYTES_V =3D [b'%s%p%x%d', b'.1024d', b'%.2049d', b'%p%p%p%p', b'%x%x%x%x=
',
+           b'%d%d%d%d', b'%s%s%s%s', b'%99999999999s', b'%08x', b'%%20d'=
, b'%%20n',
+           b'%%20x', b'%%20s', b'%s%s%s%s%s%s%s%s%s%s', b'%p%p%p%p%p%p%p=
%p%p%p',
+           b'%#0123456x%08x%x%s%p%d%n%o%u%c%h%l%q%j%z%Z%t%i%e%g%f%a%C%S%=
08x%%',
+           b'%s x 129', b'%x x 257']
=20
=20
 def random_from_intervals(intervals):
@@ -76,12 +76,12 @@ def random_bits(bit_ranges):
     return val
=20
=20
-def truncate_string(strings, length):
-    """Return strings truncated to specified length."""
-    if type(strings) =3D=3D list:
-        return [s[:length] for s in strings]
+def truncate_bytes(sequences, length):
+    """Return sequences truncated to specified length."""
+    if type(sequences) =3D=3D list:
+        return [s[:length] for s in sequences]
     else:
-        return strings[:length]
+        return sequences[:length]
=20
=20
 def validator(current, pick, choices):
@@ -110,12 +110,12 @@ def bit_validator(current, bit_ranges):
     return validator(current, random_bits, bit_ranges)
=20
=20
-def string_validator(current, strings):
-    """Return a random string value from the list not equal to the curre=
nt.
+def bytes_validator(current, sequences):
+    """Return a random bytes value from the list not equal to the curren=
t.
=20
     This function is useful for selection from valid values except curre=
nt one.
     """
-    return validator(current, random.choice, strings)
+    return validator(current, random.choice, sequences)
=20
=20
 def selector(current, constraints, validate=3Dint_validator):
@@ -283,9 +283,9 @@ def header_length(current):
 def bf_name(current):
     """Fuzz the backing file name."""
     constraints =3D [
-        truncate_string(STRING_V, len(current))
+        truncate_bytes(BYTES_V, len(current))
     ]
-    return selector(current, constraints, string_validator)
+    return selector(current, constraints, bytes_validator)
=20
=20
 def ext_magic(current):
@@ -303,10 +303,10 @@ def ext_length(current):
 def bf_format(current):
     """Fuzz backing file format in the corresponding header extension.""=
"
     constraints =3D [
-        truncate_string(STRING_V, len(current)),
-        truncate_string(STRING_V, (len(current) + 7) & ~7)  # Fuzz paddi=
ng
+        truncate_bytes(BYTES_V, len(current)),
+        truncate_bytes(BYTES_V, (len(current) + 7) & ~7)  # Fuzz padding
     ]
-    return selector(current, constraints, string_validator)
+    return selector(current, constraints, bytes_validator)
=20
=20
 def feature_type(current):
@@ -324,10 +324,10 @@ def feature_bit_number(current):
 def feature_name(current):
     """Fuzz feature name field of a feature name table header extension.=
"""
     constraints =3D [
-        truncate_string(STRING_V, len(current)),
-        truncate_string(STRING_V, 46)  # Fuzz padding (field length =3D =
46)
+        truncate_bytes(BYTES_V, len(current)),
+        truncate_bytes(BYTES_V, 46)  # Fuzz padding (field length =3D 46=
)
     ]
-    return selector(current, constraints, string_validator)
+    return selector(current, constraints, bytes_validator)
=20
=20
 def l1_entry(current):
--=20
2.21.0


