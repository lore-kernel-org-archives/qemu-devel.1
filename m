Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7816C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7EB2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPQo74DZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7EB2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MbF-0005sv-Ld
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j7MYw-0001mT-Si
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j7MYv-0000TQ-RE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:03:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54115
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j7MYv-0000TG-LC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582822981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNNuMeUDHOCcalcEBI6sJ90tiH3NcqHgqyX/YOhqAdw=;
 b=DPQo74DZvW+RV6NMG55h30CLmUAFCpPJ5yuZBFl15qz+OR+QDiiUUffcIifie1hsctdn0v
 bNP5UNctJTMaOvzxVM0eDDguPjgBOju72mA4dSEuYuPXiIWWYkxOYJMyK6um3wIAFczrUv
 kryqWP1E/16IUrgsJvNX2DFyTOZm+DY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-guzpLXHePfOHKh2fpUTGew-1; Thu, 27 Feb 2020 12:02:58 -0500
X-MC-Unique: guzpLXHePfOHKh2fpUTGew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C332185EE7B;
 Thu, 27 Feb 2020 17:02:57 +0000 (UTC)
Received: from localhost (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6546C60C18;
 Thu, 27 Feb 2020 17:02:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] iotests: Add poke_file_[bl]e functions
Date: Thu, 27 Feb 2020 18:02:50 +0100
Message-Id: <20200227170251.86113-3-mreitz@redhat.com>
In-Reply-To: <20200227170251.86113-1-mreitz@redhat.com>
References: <20200227170251.86113-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to peek_file_[bl]e, we may want to write binary integers into
a file.  Currently, this often means messing around with poke_file and
raw binary strings.  I hope these functions make it a bit more
comfortable.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 4c246c0450..604f837668 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -53,6 +53,43 @@ poke_file()
     printf "$3" | dd "of=3D$1" bs=3D1 "seek=3D$2" conv=3Dnotrunc &>/dev/nu=
ll
 }
=20
+# poke_file_le 'test.img' 512 2 65534
+poke_file_le()
+{
+    local img=3D$1 ofs=3D$2 len=3D$3 val=3D$4 str=3D''
+
+    for i in $(seq 0 $((len - 1))); do
+        byte=3D$((val & 0xff))
+        if [ $byte !=3D 0 ]; then
+            chr=3D"$(printf "\x$(printf %x $byte)")"
+        else
+            chr=3D"\0"
+        fi
+        str+=3D"$chr"
+        val=3D$((val >> 8))
+    done
+
+    poke_file "$img" "$ofs" "$str"
+}
+
+# poke_file_be 'test.img' 512 2 65279
+poke_file_be()
+{
+    local img=3D$1 ofs=3D$2 len=3D$3 val=3D$4 str=3D''
+
+    for i in $(seq 0 $((len - 1))); do
+        byte=3D$(((val >> ((len - 1 - i) * 8)) & 0xff))
+        if [ $byte !=3D 0 ]; then
+            chr=3D"$(printf "\x$(printf %x $byte)")"
+        else
+            chr=3D"\0"
+        fi
+        str+=3D$chr
+    done
+
+    poke_file "$img" "$ofs" "$str"
+}
+
 # peek_file_le 'test.img' 512 2 =3D> 65534
 peek_file_le()
 {
--=20
2.24.1


