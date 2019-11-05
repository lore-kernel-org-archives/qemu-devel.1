Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DA8C47E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804EF217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0aEcBU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804EF217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS19G-00061f-FV
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iS10W-0004u8-JN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iS10V-0002vQ-A5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iS10U-0002tj-4w
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572968672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2peWpe8yZjTvWvIo/qzdltRAb37JmLexvToJHFRtHNQ=;
 b=e0aEcBU1fWRIZBlr4CRHezzDDmW0ZPbZpUKbzOBjO3sBBN56ySza6/FIemd9r4dAD94a/x
 vnLSCBTEyrj2OBQF/DKElPrywLwtvJoNdolh+4r0ZUcCJVneb9Q4Qebrd8OUCf1+4vXk3C
 v3wsVQzsq03trdSUKQ+yQVTeJn049tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-B1FV7bHLN7OUwDKsXRwspQ-1; Tue, 05 Nov 2019 10:44:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 685531800D4A;
 Tue,  5 Nov 2019 15:44:27 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17469608AC;
 Tue,  5 Nov 2019 15:44:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] image-fuzzer: Return bytes objects on string fuzzing
 functions
Date: Tue,  5 Nov 2019 16:43:27 +0100
Message-Id: <20191105154332.181417-7-stefanha@redhat.com>
In-Reply-To: <20191105154332.181417-1-stefanha@redhat.com>
References: <20191105154332.181417-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: B1FV7bHLN7OUwDKsXRwspQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

No caller of fuzzer functions is interested in unicode string values,
so replace them with bytes sequences.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20191016192430.25098-7-ehabkost@redhat.com
Message-Id: <20191016192430.25098-7-ehabkost@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/image-fuzzer/qcow2/fuzz.py | 42 ++++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tests/image-fuzzer/qcow2/fuzz.py b/tests/image-fuzzer/qcow2/fu=
zz.py
index 154dc06cc0..c58bf11005 100644
--- a/tests/image-fuzzer/qcow2/fuzz.py
+++ b/tests/image-fuzzer/qcow2/fuzz.py
@@ -36,11 +36,11 @@ UINT32_V =3D [0, 0x100, 0x1000, 0x10000, 0x100000, UINT=
32//4, UINT32//2 - 1,
 UINT64_V =3D UINT32_V + [0x1000000, 0x10000000, 0x100000000, UINT64//4,
                        UINT64//2 - 1, UINT64//2, UINT64//2 + 1, UINT64 - 1=
,
                        UINT64]
-STRING_V =3D ['%s%p%x%d', '.1024d', '%.2049d', '%p%p%p%p', '%x%x%x%x',
-            '%d%d%d%d', '%s%s%s%s', '%99999999999s', '%08x', '%%20d', '%%2=
0n',
-            '%%20x', '%%20s', '%s%s%s%s%s%s%s%s%s%s', '%p%p%p%p%p%p%p%p%p%=
p',
-            '%#0123456x%08x%x%s%p%d%n%o%u%c%h%l%q%j%z%Z%t%i%e%g%f%a%C%S%08=
x%%',
-            '%s x 129', '%x x 257']
+BYTES_V =3D [b'%s%p%x%d', b'.1024d', b'%.2049d', b'%p%p%p%p', b'%x%x%x%x',
+           b'%d%d%d%d', b'%s%s%s%s', b'%99999999999s', b'%08x', b'%%20d', =
b'%%20n',
+           b'%%20x', b'%%20s', b'%s%s%s%s%s%s%s%s%s%s', b'%p%p%p%p%p%p%p%p=
%p%p',
+           b'%#0123456x%08x%x%s%p%d%n%o%u%c%h%l%q%j%z%Z%t%i%e%g%f%a%C%S%08=
x%%',
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
-    """Return a random string value from the list not equal to the current=
.
+def bytes_validator(current, sequences):
+    """Return a random bytes value from the list not equal to the current.
=20
     This function is useful for selection from valid values except current=
 one.
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
     """Fuzz backing file format in the corresponding header extension."""
     constraints =3D [
-        truncate_string(STRING_V, len(current)),
-        truncate_string(STRING_V, (len(current) + 7) & ~7)  # Fuzz padding
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
     """Fuzz feature name field of a feature name table header extension.""=
"
     constraints =3D [
-        truncate_string(STRING_V, len(current)),
-        truncate_string(STRING_V, 46)  # Fuzz padding (field length =3D 46=
)
+        truncate_bytes(BYTES_V, len(current)),
+        truncate_bytes(BYTES_V, 46)  # Fuzz padding (field length =3D 46)
     ]
-    return selector(current, constraints, string_validator)
+    return selector(current, constraints, bytes_validator)
=20
=20
 def l1_entry(current):
--=20
2.23.0


