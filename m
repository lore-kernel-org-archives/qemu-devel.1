Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D53FC4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8764A20702
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZyPWRQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8764A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3A7-0003Jf-Fs
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc34r-0005qt-9d
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc34p-0004np-6G
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604912582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CNFOjdwy6RTVjG5pmjUPvHSYD9LspsvcyqoPOXwxS8=;
 b=cZyPWRQtwQDtRQbipekVCeVAx8p55Ea3xvbnRJoxLYoAnCg5CwFLc8fxnYdcaAg060M6Er
 48pu4XL5Jv9g8ay1eP2uQvygOO51m14rUua+ceD5iIgFufI0NfhPdlyBoeFBFUndhKmC8I
 NGKGMwEXl1Jlgv7OapnHs+iJgNVBxJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-8KS4_5WGMVigyhJ5_1XI4w-1; Mon, 09 Nov 2020 04:02:24 -0500
X-MC-Unique: 8KS4_5WGMVigyhJ5_1XI4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C84BE1868416;
 Mon,  9 Nov 2020 09:02:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9658375124;
 Mon,  9 Nov 2020 09:02:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C92F5116B844; Mon,  9 Nov 2020 10:02:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] block: Remove unused BlockDeviceMapEntry
Date: Mon,  9 Nov 2020 10:02:20 +0100
Message-Id: <20201109090220.825764-6-armbru@redhat.com>
In-Reply-To: <20201109090220.825764-1-armbru@redhat.com>
References: <20201109090220.825764-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BlockDeviceMapEntry has never been used.  It was added in commit
facd6e2 "so that it is published through the introspection mechanism."
What exactly introspecting types that aren't used for anything could
accomplish isn't clear.  What "introspection mechanism" to use is also
nebulous.  To the best of my knowledge, there has never been one that
covered this type.  Certainly not query-qmp-schema, which includes
only types that are actually used in QMP.

Not being able to introspect BlockDeviceMapEntry hasn't bothered
anyone enough to complain in almost four years.  Get rid of it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20201104165513.72720-3-mreitz@redhat.com>
---
 qapi/block-core.json | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3f86675357..04ad80bc1e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -426,35 +426,6 @@
 ##
 { 'enum': 'BlockDeviceIoStatus', 'data': [ 'ok', 'failed', 'nospace' ] }
 
-##
-# @BlockDeviceMapEntry:
-#
-# Entry in the metadata map of the device (returned by "qemu-img map")
-#
-# @start: Offset in the image of the first byte described by this entry
-#         (in bytes)
-#
-# @length: Length of the range described by this entry (in bytes)
-#
-# @depth: Number of layers (0 = top image, 1 = top image's backing file, etc.)
-#         before reaching one for which the range is allocated.  The value is
-#         in the range 0 to the depth of the image chain - 1.
-#
-# @zero: the sectors in this range read as zeros
-#
-# @data: reading the image will actually read data from a file (in particular,
-#        if @offset is present this means that the sectors are not simply
-#        preallocated, but contain actual data in raw format)
-#
-# @offset: if present, the image file stores the data for this range in
-#          raw format at the given offset.
-#
-# Since: 1.7
-##
-{ 'struct': 'BlockDeviceMapEntry',
-  'data': { 'start': 'int', 'length': 'int', 'depth': 'int', 'zero': 'bool',
-            'data': 'bool', '*offset': 'int' } }
-
 ##
 # @DirtyBitmapStatus:
 #
-- 
2.26.2


