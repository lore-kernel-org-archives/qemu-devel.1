Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266A3C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3344222206
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMJ3+ltr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3344222206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYNrt-0000BF-T6
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 02:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYNqA-0007zI-Fa
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 02:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYNq6-000617-0V
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 02:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604039080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vXfS+zDZWrTTPkNDgDyaNwmgy1jEnhqX+mnDWTgg37A=;
 b=NMJ3+ltrk8PjXFgSY0ULr4pdj8s7vu674qqeiqqUfJ0J0ry2ZVz3fuS7RRjK5h2S+ZVLk+
 JzKjGNEAfUvKENh1vsUN6g/kgC65kwb8A+jjKFVbk85KWWBeB0OZObX80sWL+zxLDhyexR
 BExZQYQANYjv8ameVzLCln/ESUt8qAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-bVGP2nm1NQS4cS9eUs1aWg-1; Fri, 30 Oct 2020 02:24:37 -0400
X-MC-Unique: bVGP2nm1NQS4cS9eUs1aWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46293805EF4;
 Fri, 30 Oct 2020 06:24:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E550C19647;
 Fri, 30 Oct 2020 06:24:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 55084113865F; Fri, 30 Oct 2020 07:24:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] block: Remove unused BlockDeviceMapEntry
Date: Fri, 30 Oct 2020 07:24:34 +0100
Message-Id: <20201030062434.3629438-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 mreitz@redhat.com
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
---
I found an old patch I neglected to merge.

Max replied to a remark in Eric's review of v1:

    Max Reitz <mreitz@redhat.com> writes:

    > On 2017-07-28 20:10, Eric Blake wrote:
    >> This type is the schema for 'qemu-img map --output=json'.  And I had a
    >> patch once (that I need to revive) that added a JSON Output visitor; at
    >> which point I fixed qemu-img to convert from QAPI to JSON instead of
    >> open-coding its construction of its output string, at which point the
    >> QAPI generated code for this type is useful.
    > (Very late reply, I know, I just stumbled over *MapEntry when looking
    > over block-core.json what we might want to deprecate in 3.0)
    >
    > We already use MapEntry there -- why don't we output just that instead?
    > The only difference seems to be an additional @filename parameter which
    > would probably be actually nice to include in the output.
    >
    > Except that BlockDeviceMapEntry's documentation is better, so we should
    > merge that into MapEntry before removing the former.
    >
    > Max

https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02933.html

Me doing the doc update Max suggested could take more than one
iteration, as I know nothing about this stuff.  Max, could you give it
a try?  Feel free to take over my patch.

 qapi/block-core.json | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e00fc27b5e..2aa499a72e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -418,35 +418,6 @@
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


