Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB0CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88C2222CD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eez6JMfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88C2222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO06A-0000yf-Lx
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNzvJ-0005so-DG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNzvI-0000Gm-79
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNzvI-00005s-3S
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572011185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8me1QXcEFkB4bLdIZ9pA+yTAk+SPcjKqs5vhVTIibU=;
 b=Eez6JMfYOmmjIGwgAPbhAtazXAYl3ns83F/d3W7qMXDTHE4PT+SC7YI91ZmxtApryFwWaq
 H520ubwdWGINT7CwRLCPaex9tT96Hfo+OJpcrogc+/9id/ERYgfVRojWtaus/QXUu6P7DK
 nINGhiOdCQsNv6cCFBhCKfru+tfGz4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-4vHAmZznO5KnaDXYaKLJTg-1; Fri, 25 Oct 2019 09:46:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAA6D47B;
 Fri, 25 Oct 2019 13:46:18 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F08CB5D70E;
 Fri, 25 Oct 2019 13:46:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/7] qapi: add support for blkreplay driver
Date: Fri, 25 Oct 2019 15:46:05 +0200
Message-Id: <20191025134611.25920-2-kwolf@redhat.com>
In-Reply-To: <20191025134611.25920-1-kwolf@redhat.com>
References: <20191025134611.25920-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4vHAmZznO5KnaDXYaKLJTg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>

This patch adds support for blkreplay driver to the blockdev options.
Now blkreplay can be used with -blockdev command line option
in the following format:
-blockdev driver=3Dblkreplay,image=3Dfile-node-name,node-name=3Dreplay-node=
-name

This option makes possible implementation of the better command
line support for record/replay invocations.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b274aef713..aa97ee2641 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2883,12 +2883,13 @@
 # @nvme: Since 2.12
 # @copy-on-read: Since 3.0
 # @blklogwrites: Since 3.0
+# @blkreplay: Since 4.2
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
-  'data': [ 'blkdebug', 'blklogwrites', 'blkverify', 'bochs', 'cloop',
-            'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
+  'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
+            'cloop', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluste=
r',
             'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
             'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qco=
w',
             'qcow2', 'qed', 'quorum', 'raw', 'rbd',
@@ -3501,6 +3502,18 @@
   'data': { 'test': 'BlockdevRef',
             'raw': 'BlockdevRef' } }
=20
+##
+# @BlockdevOptionsBlkreplay:
+#
+# Driver specific block device options for blkreplay.
+#
+# @image:     disk image which should be controlled with blkreplay
+#
+# Since: 4.2
+##
+{ 'struct': 'BlockdevOptionsBlkreplay',
+  'data': { 'image': 'BlockdevRef' } }
+
 ##
 # @QuorumReadPattern:
 #
@@ -4028,6 +4041,7 @@
       'blkdebug':   'BlockdevOptionsBlkdebug',
       'blklogwrites':'BlockdevOptionsBlklogwrites',
       'blkverify':  'BlockdevOptionsBlkverify',
+      'blkreplay':  'BlockdevOptionsBlkreplay',
       'bochs':      'BlockdevOptionsGenericFormat',
       'cloop':      'BlockdevOptionsGenericFormat',
       'copy-on-read':'BlockdevOptionsGenericFormat',
--=20
2.20.1


