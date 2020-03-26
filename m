Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48EEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ABF206F8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IksjgUK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ABF206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHTaT-0001TR-Js
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 10:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHTWQ-0004D0-8k
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHTWP-0002zl-1e
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37141)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHTWO-0002zN-T4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585233012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ds3GO1HPvZnBnCHWEUNrKnJOCxbvSIxgAYAkojhjyF8=;
 b=IksjgUK9MRMnXRP4TgzIyo2qrGuvkEUeIwl0dITWitV5HbZQtiyB5j8z2ornJgfpObuMkN
 lkGKIEQt8P3aTMpISXWEU2T42qwt0zACvSOfA18sekAnSvlXehpeGq872TsnfTrcCPcgMo
 d3jOYL+bXuRn0fglqtN5g4169XS9Acw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-Pf533dMcPzqX-C29rgsMRQ-1; Thu, 26 Mar 2020 10:30:10 -0400
X-MC-Unique: Pf533dMcPzqX-C29rgsMRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 319AC189F771;
 Thu, 26 Mar 2020 14:30:09 +0000 (UTC)
Received: from localhost (ovpn-112-132.ams2.redhat.com [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7E165C297;
 Thu, 26 Mar 2020 14:30:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/10] iotests: Add poke_file_[bl]e functions
Date: Thu, 26 Mar 2020 15:29:32 +0100
Message-Id: <20200326142933.625037-10-mreitz@redhat.com>
In-Reply-To: <20200326142933.625037-1-mreitz@redhat.com>
References: <20200326142933.625037-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

Similarly to peek_file_[bl]e, we may want to write binary integers into
a file.  Currently, this often means messing around with poke_file and
raw binary strings.  I hope these functions make it a bit more
comfortable.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Code-suggested-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200324172757.1173824-3-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 4c246c0450..bf3b9fdea0 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -53,6 +53,30 @@ poke_file()
     printf "$3" | dd "of=3D$1" bs=3D1 "seek=3D$2" conv=3Dnotrunc &>/dev/nu=
ll
 }
=20
+# poke_file_le $img_filename $offset $byte_width $value
+# Example: poke_file_le "$TEST_IMG" 512 2 65534
+poke_file_le()
+{
+    local img=3D$1 ofs=3D$2 len=3D$3 val=3D$4 str=3D''
+
+    while ((len--)); do
+        str+=3D$(printf '\\x%02x' $((val & 0xff)))
+        val=3D$((val >> 8))
+    done
+
+    poke_file "$img" "$ofs" "$str"
+}
+
+# poke_file_be $img_filename $offset $byte_width $value
+# Example: poke_file_be "$TEST_IMG" 512 2 65279
+poke_file_be()
+{
+    local img=3D$1 ofs=3D$2 len=3D$3 val=3D$4
+    local str=3D$(printf "%0$((len * 2))x\n" $val | sed 's/\(..\)/\\x\1/g'=
)
+
+    poke_file "$img" "$ofs" "$str"
+}
+
 # peek_file_le 'test.img' 512 2 =3D> 65534
 peek_file_le()
 {
--=20
2.25.1


