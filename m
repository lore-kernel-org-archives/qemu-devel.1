Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC04CC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D68206F8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLRIeLus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D68206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHTfZ-0007ft-SU
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHTWX-0004Sn-71
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHTWR-000316-QP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22377)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHTWR-00030s-NK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585233015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LhZ9DHL7T1jkRWFOkyzETAnfc6tl8ZcA30FqNDULC4=;
 b=hLRIeLusosDLoURgAAt0zNaw8HGAK2xApyOhybtq37lZvIN4Ku5PtnHsWtFpfZ2Lz9Bouz
 tEqi5UJvWLQ1wDmX6J2rJxJlIKDD4rlz/YTCY8nP1MtafutNDzW6D4EKx6Zcl/JeyB29Rv
 3/kSQsxUxo5BzHLzd4iXNc+jfvOXH3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Qe3kNC_hMKqZA3FARhL0OA-1; Thu, 26 Mar 2020 10:30:13 -0400
X-MC-Unique: Qe3kNC_hMKqZA3FARhL0OA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C068018B1;
 Thu, 26 Mar 2020 14:30:12 +0000 (UTC)
Received: from localhost (ovpn-112-132.ams2.redhat.com [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0E4E5D9CD;
 Thu, 26 Mar 2020 14:30:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/10] iotests/138: Test leaks/corruptions fixed report
Date: Thu, 26 Mar 2020 15:29:33 +0100
Message-Id: <20200326142933.625037-11-mreitz@redhat.com>
In-Reply-To: <20200326142933.625037-1-mreitz@redhat.com>
References: <20200326142933.625037-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test that qemu-img check reports the number of leaks and corruptions
fixed in its JSON report (after a successful run).

While touching the _unsupported_imgopts line, adjust the note on why
data_file does not work with this test: The current comment sounds a bit
like it is a mistake for qemu-img check not to check external data
files' refcounts.  But there are no such refcounts, so it is no mistake.
Just say that qemu-img check does not do much for external data files,
and this is why this test does not work with them.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200324172757.1173824-4-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/138     | 41 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/138.out | 14 +++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 54b01046ad..1d5b0bed6d 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -41,8 +41,10 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
 # With an external data file, data clusters are not refcounted
-# (and so qemu-img check does not check their refcount)
-_unsupported_imgopts data_file
+# (so qemu-img check would not do much);
+# we want to modify the refcounts, so we need them to have a specific
+# format (namely u16)
+_unsupported_imgopts data_file 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
=20
 echo
 echo '=3D=3D=3D Check on an image with a multiple of 2^32 clusters =3D=3D=
=3D'
@@ -65,6 +67,41 @@ poke_file "$TEST_IMG" $((2048 + 8)) "\x00\x80\x00\x00\x0=
0\x00\x00\x00"
 # allocate memory", we have an error showing that l2 entry is invalid.
 _check_test_img
=20
+echo
+echo '=3D=3D=3D Check leaks-fixed/corruptions-fixed report'
+echo
+
+# After leaks and corruptions were fixed, those numbers should be
+# reported by qemu-img check
+_make_test_img 64k
+
+# Allocate data cluster
+$QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
+
+reftable_ofs=3D$(peek_file_be "$TEST_IMG" 48 8)
+refblock_ofs=3D$(peek_file_be "$TEST_IMG" $reftable_ofs 8)
+
+# Introduce a leak: Make the image header's refcount 2
+poke_file_be "$TEST_IMG" "$refblock_ofs" 2 2
+
+l1_ofs=3D$(peek_file_be "$TEST_IMG" 40 8)
+
+# Introduce a corruption: Drop the COPIED flag from the (first) L1 entry
+l1_entry=3D$(peek_file_be "$TEST_IMG" $l1_ofs 8)
+l1_entry=3D$((l1_entry & ~(1 << 63)))
+poke_file_be "$TEST_IMG" $l1_ofs 8 $l1_entry
+
+echo
+# Should print the number of corruptions and leaks fixed
+# (Filter out all JSON fields (recognizable by their four-space
+# indentation), but keep the "-fixed" fields (by removing two spaces
+# from their indentation))
+# (Also filter out the L1 entry, because why not)
+_check_test_img -r all --output=3Djson \
+    | sed -e 's/^  \(.*\)-fixed"/\1-fixed"/' \
+          -e '/^    /d' \
+          -e "s/\\([^0-9a-f]\\)$(printf %x $l1_entry)\\([^0-9a-f]\\)/\1L1_=
ENTRY_VALUE\2/"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/138.out b/tests/qemu-iotests/138.out
index aca7d47a80..79681e7cc9 100644
--- a/tests/qemu-iotests/138.out
+++ b/tests/qemu-iotests/138.out
@@ -9,4 +9,18 @@ ERROR: counting reference for region exceeding the end of =
the file by one cluste
=20
 1 errors were found on the image.
 Data may be corrupted, or further writes to the image may corrupt it.
+
+=3D=3D=3D Check leaks-fixed/corruptions-fixed report
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Leaked cluster 0 refcount=3D2 reference=3D1
+Repairing cluster 0 refcount=3D2 reference=3D1
+Repairing OFLAG_COPIED L2 cluster: l1_index=3D0 l1_entry=3DL1_ENTRY_VALUE =
refcount=3D1
+{
+  "corruptions-fixed": 1,
+  "leaks-fixed": 1,
+}
 *** done
--=20
2.25.1


