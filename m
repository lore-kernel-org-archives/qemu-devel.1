Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23968C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0569205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdNdVwaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0569205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6uu-0001VA-0l
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pE-00052k-0a
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pD-0001bs-4T
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyA/Tt4ZyIMFTx1MNg4wxDf19QwSyBh8NoJX+MNs9n0=;
 b=YdNdVwaN4JzSWu29fzYIDuViW2qhDOjTFUAmL/ACOuvw2vlHftZPcvC+e5aLh00kpC2Dwf
 fYpBHDnsq15rNjVzHYF+YtsGrVgWkg6Bz2PNyE4cFtjTWMyxFOAgwa0eOi8c+tndIRCzrY
 MgC8bFjRWOQ4BCwkolODOHW5lDiUEtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-x93rqQLHPMiz7vgfg5a9dQ-1; Thu, 14 May 2020 01:54:28 -0400
X-MC-Unique: x93rqQLHPMiz7vgfg5a9dQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F22CE80183C;
 Thu, 14 May 2020 05:54:26 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 048876A977;
 Thu, 14 May 2020 05:54:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 10/32] python/qemu: Add flake8 to Pipfile
Date: Thu, 14 May 2020 01:53:41 -0400
Message-Id: <20200514055403.18902-11-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Pipfile      |  1 +
 python/Pipfile.lock | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/python/Pipfile b/python/Pipfile
index ddb2b5a518..e396e56e06 100644
--- a/python/Pipfile
+++ b/python/Pipfile
@@ -5,6 +5,7 @@ verify_ssl = true
 
 [dev-packages]
 pylint = "==2.5.0"
+flake8 = "*"
 
 [packages]
 
diff --git a/python/Pipfile.lock b/python/Pipfile.lock
index e6faa832e4..15cd8a918f 100644
--- a/python/Pipfile.lock
+++ b/python/Pipfile.lock
@@ -1,7 +1,7 @@
 {
     "_meta": {
         "hash": {
-            "sha256": "7815dedfd7481b645389153dd45e9adb82c72956d0efc74d8f087497624b75e4"
+            "sha256": "58115144ace0f646b5c62da260fb4867ac0a0e485de3f5b0a56c7854afa21f5b"
         },
         "pipfile-spec": 6,
         "requires": {
@@ -24,6 +24,21 @@
             ],
             "version": "==2.4.1"
         },
+        "entrypoints": {
+            "hashes": [
+                "sha256:589f874b313739ad35be6e0cd7efde2a4e9b6fea91edcc34e58ecbb8dbe56d19",
+                "sha256:c70dd71abe5a8c85e55e12c19bd91ccfeec11a6e99044204511f9ed547d48451"
+            ],
+            "version": "==0.3"
+        },
+        "flake8": {
+            "hashes": [
+                "sha256:45681a117ecc81e870cbf1262835ae4af5e7a8b08e40b944a8a6e6b895914cfb",
+                "sha256:49356e766643ad15072a789a20915d3c91dc89fd313ccd71802303fd67e4deca"
+            ],
+            "index": "pypi",
+            "version": "==3.7.9"
+        },
         "isort": {
             "hashes": [
                 "sha256:54da7e92468955c4fceacd0c86bd0ec997b0e1ee80d97f67c35a78b719dccab1",
@@ -64,6 +79,20 @@
             ],
             "version": "==0.6.1"
         },
+        "pycodestyle": {
+            "hashes": [
+                "sha256:95a2219d12372f05704562a14ec30bc76b05a5b297b21a5dfe3f6fac3491ae56",
+                "sha256:e40a936c9a450ad81df37f549d676d127b1b66000a6c500caa2b085bc0ca976c"
+            ],
+            "version": "==2.5.0"
+        },
+        "pyflakes": {
+            "hashes": [
+                "sha256:17dbeb2e3f4d772725c777fabc446d5634d1038f234e77343108ce445ea69ce0",
+                "sha256:d976835886f8c5b31d47970ed689944a0262b5f3afa00a5a7b4dc81e5449f8a2"
+            ],
+            "version": "==2.1.1"
+        },
         "pylint": {
             "hashes": [
                 "sha256:588e114e3f9a1630428c35b7dd1c82c1c93e1b0e78ee312ae4724c5e1a1e0245",
-- 
2.21.1


