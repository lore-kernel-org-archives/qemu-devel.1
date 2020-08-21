Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A461C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C5B20791
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJzodmFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C5B20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9DmN-0005b6-E2
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 16:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k9Dlk-0005Al-Ie
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:36:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31652
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k9Dlh-0007si-Gq
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598042167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SR3vcY5aC2UJrh/5LPWmaGHz/FBlg4l4heK1aWr6cHY=;
 b=QJzodmFl1BHolM/Aud57MPxw+lua8pvsrgKeOFIBu+KA1kAZBCpkcG1UFDAS/DDMmJYP7Y
 XV0tUsnLwC4MZud/6rtNboo5EC0+gugAtm+LteXUtt/kWWugKYh/Huu8tCBURcCTAtJ1o8
 gSVcsn8tKNH25XYCFfTjJkbdvkiEHWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-gNnv8cpoO-eNn5_J5St4mQ-1; Fri, 21 Aug 2020 16:36:05 -0400
X-MC-Unique: gNnv8cpoO-eNn5_J5St4mQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DBF685C705;
 Fri, 21 Aug 2020 20:36:04 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-112-45.ams2.redhat.com
 [10.36.112.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC8E11002382;
 Fri, 21 Aug 2020 20:35:59 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] configure: silence 'shift' error message in version_ge()
Date: Fri, 21 Aug 2020 22:35:58 +0200
Message-Id: <20200821203558.10338-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If there are less than 2 arguments in version_ge(), the second
'shift' prints this error:
    ../configure: line 232: shift: shift count out of range

As Eric suggested, we can use 'shift ${2:+2}' which works out to
'shift 2' if $2 is set, or 'shift' (implicitly shift 1) if $2
is not set.

This patch replaces both 'shift; shift' occurrences in version_ge()
with 'shift ${2:+2}'.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- use Eric's one-liner solution
v2:
- do not shift if there are no more arguments [Peter]
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 4e5fe33211..d9ca87fbbb 100755
--- a/configure
+++ b/configure
@@ -228,15 +228,15 @@ version_ge () {
     while true; do
         set x $local_ver1
         local_first=${2-0}
-        # shift 2 does nothing if there are less than 2 arguments
-        shift; shift
+        # 'shift 2' if $2 is set, or 'shift' if $2 is not set
+        shift ${2:+2}
         local_ver1=$*
         set x $local_ver2
         # the second argument finished, the first must be greater or equal
         test $# = 1 && return 0
         test $local_first -lt $2 && return 1
         test $local_first -gt $2 && return 0
-        shift; shift
+        shift ${2:+2}
         local_ver2=$*
     done
 }
-- 
2.26.2


