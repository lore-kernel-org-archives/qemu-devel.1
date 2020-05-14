Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF56C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2197D206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8XBv00z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2197D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ78Y-0003Ql-Al
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pr-0006KV-5b
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:55:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57365
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pq-0001qL-B5
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2iMQPqEdXKj37G1Gsxqv6/OjI7WeI3/6pF7Qq/RZtcQ=;
 b=M8XBv00zXq5vs8kRmmcYvW4anQPFwr4P+VO4K8JAgCnsii4ngADWDmJ6wjuZD2fXwbeg/1
 HgcvBN166sTkJBca9PDtActYRQyoa23g1oXeA28KJL5ib0xaUM7CgOxEd2aHUb/sDUwEj6
 S18MyRiXyTQVpFpPciU3R5pWSQzryMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-exeRrRpUMNuCCLWu5SSvUw-1; Thu, 14 May 2020 01:55:04 -0400
X-MC-Unique: exeRrRpUMNuCCLWu5SSvUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 489C41054F8F;
 Thu, 14 May 2020 05:55:03 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6BDD6A977;
 Thu, 14 May 2020 05:55:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 31/32] python/qemu: add mypy to Pipfile
Date: Thu, 14 May 2020 01:54:02 -0400
Message-Id: <20200514055403.18902-32-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 python/Pipfile.lock | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/python/Pipfile b/python/Pipfile
index e396e56e06..80bd6c3188 100644
--- a/python/Pipfile
+++ b/python/Pipfile
@@ -6,6 +6,7 @@ verify_ssl = true
 [dev-packages]
 pylint = "==2.5.0"
 flake8 = "*"
+mypy = "*"
 
 [packages]
 
diff --git a/python/Pipfile.lock b/python/Pipfile.lock
index 15cd8a918f..085f23fe8a 100644
--- a/python/Pipfile.lock
+++ b/python/Pipfile.lock
@@ -1,7 +1,7 @@
 {
     "_meta": {
         "hash": {
-            "sha256": "58115144ace0f646b5c62da260fb4867ac0a0e485de3f5b0a56c7854afa21f5b"
+            "sha256": "17a30ead8719d80349ff5473bda3133fd4559a4e83d3f9d669631ac4b2171502"
         },
         "pipfile-spec": 6,
         "requires": {
@@ -79,6 +79,33 @@
             ],
             "version": "==0.6.1"
         },
+        "mypy": {
+            "hashes": [
+                "sha256:15b948e1302682e3682f11f50208b726a246ab4e6c1b39f9264a8796bb416aa2",
+                "sha256:219a3116ecd015f8dca7b5d2c366c973509dfb9a8fc97ef044a36e3da66144a1",
+                "sha256:3b1fc683fb204c6b4403a1ef23f0b1fac8e4477091585e0c8c54cbdf7d7bb164",
+                "sha256:3beff56b453b6ef94ecb2996bea101a08f1f8a9771d3cbf4988a61e4d9973761",
+                "sha256:7687f6455ec3ed7649d1ae574136835a4272b65b3ddcf01ab8704ac65616c5ce",
+                "sha256:7ec45a70d40ede1ec7ad7f95b3c94c9cf4c186a32f6bacb1795b60abd2f9ef27",
+                "sha256:86c857510a9b7c3104cf4cde1568f4921762c8f9842e987bc03ed4f160925754",
+                "sha256:8a627507ef9b307b46a1fea9513d5c98680ba09591253082b4c48697ba05a4ae",
+                "sha256:8dfb69fbf9f3aeed18afffb15e319ca7f8da9642336348ddd6cab2713ddcf8f9",
+                "sha256:a34b577cdf6313bf24755f7a0e3f3c326d5c1f4fe7422d1d06498eb25ad0c600",
+                "sha256:a8ffcd53cb5dfc131850851cc09f1c44689c2812d0beb954d8138d4f5fc17f65",
+                "sha256:b90928f2d9eb2f33162405f32dde9f6dcead63a0971ca8a1b50eb4ca3e35ceb8",
+                "sha256:c56ffe22faa2e51054c5f7a3bc70a370939c2ed4de308c690e7949230c995913",
+                "sha256:f91c7ae919bbc3f96cd5e5b2e786b2b108343d1d7972ea130f7de27fdd547cf3"
+            ],
+            "index": "pypi",
+            "version": "==0.770"
+        },
+        "mypy-extensions": {
+            "hashes": [
+                "sha256:090fedd75945a69ae91ce1303b5824f428daf5a028d2f6ab8a299250a846f15d",
+                "sha256:2d82818f5bb3e369420cb3c4060a7970edba416647068eb4c5343488a6c604a8"
+            ],
+            "version": "==0.4.3"
+        },
         "pycodestyle": {
             "hashes": [
                 "sha256:95a2219d12372f05704562a14ec30bc76b05a5b297b21a5dfe3f6fac3491ae56",
@@ -142,6 +169,14 @@
             "markers": "implementation_name == 'cpython' and python_version < '3.8'",
             "version": "==1.4.1"
         },
+        "typing-extensions": {
+            "hashes": [
+                "sha256:6e95524d8a547a91e08f404ae485bbb71962de46967e1b71a0cb89af24e761c5",
+                "sha256:79ee589a3caca649a9bfd2a8de4709837400dfa00b6cc81962a1e6a1815969ae",
+                "sha256:f8d2bd89d25bc39dabe7d23df520442fa1d8969b82544370e03d88b5a591c392"
+            ],
+            "version": "==3.7.4.2"
+        },
         "wrapt": {
             "hashes": [
                 "sha256:b62ffa81fb85f4332a4f609cab4ac40709470da05643a082ec1eb88e6d9b97d7"
-- 
2.21.1


