Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D9AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81192067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwlsJF3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81192067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgH6q-0002Z5-0Z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4L-0007Lf-67
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4K-0005mJ-0v
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591143343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sQ3/Uw6N4EwY5Jro8moBBBYDGmAFrlWPKnBcpuIYdQ=;
 b=DwlsJF3yZt5I9vjZ1uOGmYqQBDpQu6GyzSrvO0+yWFoeYMeKJIwg/QBAqnsmbxRi0La0DM
 s6q4oA9BajQfRx+JXpe2f6FOP3hNY5MUmWjxI/CtZkl3YuGVPEV5of/DwuL++hZ59WH+YH
 PGvPFieSSHakL35INzhi00kycU2yAY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-q2OZUSaiNQuplWLuRHaLIA-1; Tue, 02 Jun 2020 20:15:41 -0400
X-MC-Unique: q2OZUSaiNQuplWLuRHaLIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97188107ACCA;
 Wed,  3 Jun 2020 00:15:40 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16B1978B56;
 Wed,  3 Jun 2020 00:15:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] python/qemu: add mypy to pipenv
Date: Tue,  2 Jun 2020 20:15:23 -0400
Message-Id: <20200603001523.18085-8-jsnow@redhat.com>
In-Reply-To: <20200603001523.18085-1-jsnow@redhat.com>
References: <20200603001523.18085-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 17:45:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

0.730 appears to be about the oldest version that works with the
features we want, including nice human readable output (to make sure
iotest 297 passes), and type-parameterized Popen generics.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Pipfile      |  1 +
 python/Pipfile.lock | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/python/Pipfile b/python/Pipfile
index fc92038ff7a..117dd859c57 100644
--- a/python/Pipfile
+++ b/python/Pipfile
@@ -6,6 +6,7 @@ verify_ssl = true
 [dev-packages]
 pylint = "==2.5.0"
 flake8 = ">=3.6.0"
+mypy = ">=0.730"
 
 [packages]
 
diff --git a/python/Pipfile.lock b/python/Pipfile.lock
index 95b942bd383..fe2af682427 100644
--- a/python/Pipfile.lock
+++ b/python/Pipfile.lock
@@ -1,7 +1,7 @@
 {
     "_meta": {
         "hash": {
-            "sha256": "30d00455625882e5e23868450487697f75d54474f6912091684d570c5c518c11"
+            "sha256": "773ac04fca007642cbe681368f20b74fea2d74443c14e16d221cb2582344d7bd"
         },
         "pipfile-spec": 6,
         "requires": {
@@ -80,6 +80,33 @@
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
                 "sha256:2295e7b2f6b5bd100585ebcb1f616591b652db8a741695b3d8f5d28bdc934367",
@@ -143,6 +170,14 @@
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
2.21.3


