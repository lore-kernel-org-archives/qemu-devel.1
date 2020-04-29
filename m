Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D0C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E4B20775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekRl+AdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E4B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTh3o-0001E5-U7
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1m-0007tK-QL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1b-0003tD-W5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1b-0003qO-Bc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUehSluyCfYKVpllec9HGLDt3XECTdSIT8Fz2eXmjrM=;
 b=ekRl+AdR8Yj0Qec4hYp0vNNLHnC2VIUe+vU1aLnkV2wSi1tsG8Pt+OVJWJ4yARu2UEKrrL
 36Pc6M+TOfSW6aDGq1WFMYwijfOTfntplexT0wzDCAFk9NEKpsmFDTNqwreoM5v/cLQTFm
 mNXMYERZKIg9vnG/RCOY4Fli7uz3WmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-C1Vv83YfNUagfZNF-Z8baQ-1; Wed, 29 Apr 2020 03:20:53 -0400
X-MC-Unique: C1Vv83YfNUagfZNF-Z8baQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24A5B1895A2E
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9FBD5D9F1;
 Wed, 29 Apr 2020 07:20:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE3CB11358C6; Wed, 29 Apr 2020 09:20:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/32] qemu-img: Reject broken -o ""
Date: Wed, 29 Apr 2020 09:20:26 +0200
Message-Id: <20200429072048.29963-11-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-img create, convert, amend, and measure use accumulate_options()
to merge multiple -o options.  This is broken for -o "":

    $ qemu-img create -f qcow2 -o backing_file=3Da -o "" -o backing_fmt=3Dr=
aw,size=3D1M new.qcow2
    qemu-img: warning: Could not verify backing image. This may become an e=
rror in future versions.
    Could not open 'a,backing_fmt=3Draw': No such file or directory
    Formatting 'new.qcow2', fmt=3Dqcow2 size=3D1048576 backing_file=3Da,,ba=
cking_fmt=3Draw cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
    $ qemu-img info new.qcow2
    image: new.qcow2
    file format: qcow2
    virtual size: 1 MiB (1048576 bytes)
    disk size: 196 KiB
    cluster_size: 65536
--> backing file: a,backing_fmt=3Draw
    Format specific information:
        compat: 1.1
        lazy refcounts: false
        refcount bits: 16
        corrupt: false

Merging these three -o the obvious way is wrong, because it results in
an unwanted ',' escape:

    backing_file=3Da,,backing_fmt=3Draw,size=3D1M
                  ~~

We could silently drop -o "", but Kevin asked me to reject it instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200415074927.19897-10-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index cc51db7ed4..a2369766f0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -229,14 +229,16 @@ static bool qemu_img_object_print_help(const char *ty=
pe, QemuOpts *opts)
  * To make that work, @optarg must not start with ',' (or else a
  * separating ',' preceding it gets escaped), and it must not end with
  * an odd number of ',' (or else a separating ',' following it gets
- * escaped).
+ * escaped), or be empty (or else a separating ',' preceding it can
+ * escape a separating ',' following it).
+ *=20
  */
 static bool is_valid_option_list(const char *optarg)
 {
     size_t len =3D strlen(optarg);
     size_t i;
=20
-    if (optarg[0] =3D=3D ',') {
+    if (!optarg[0] || optarg[0] =3D=3D ',') {
         return false;
     }
=20
--=20
2.21.1


