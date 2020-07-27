Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB4EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C9E20786
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guAxAkKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C9E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ALm-0007gu-3j
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAn-0005qA-Jj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAl-00052h-QD
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRI3td16T7P/hRiIt2yR87EFEmDjt2EHrQN/juIKf6A=;
 b=guAxAkKP2Ogxf6QiLGO5Q02YYNr3XworlfNL4GqyCBZsOa/gJYyOhnod0zFIPnoNYq8nvm
 apGBAfB6plVQXJQDpEDosB1iRab9BhcjjJfxuMtNNkwz9fyITZPOFcYNvwPuGcpYaW2up/
 BgeCGDY2dXRmYZwC4oRqs2JcXUkzvho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-WFZVNi3jP1S77bdu2aOTnQ-1; Mon, 27 Jul 2020 16:56:32 -0400
X-MC-Unique: WFZVNi3jP1S77bdu2aOTnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB3B679EC8;
 Mon, 27 Jul 2020 20:56:31 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D7DD19C66;
 Mon, 27 Jul 2020 20:56:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/24] iotests: Adjust which migration tests are quick
Date: Mon, 27 Jul 2020 15:55:42 -0500
Message-Id: <20200727205543.206624-24-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A quick run of './check -qcow2 -g migration' shows that test 169 is
NOT quick, but meanwhile several other tests ARE quick.  Let's adjust
the test designations accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727195117.132151-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/group | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1d0252e1f051..806044642c69 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -112,7 +112,7 @@
 088 rw quick
 089 rw auto quick
 090 rw auto quick
-091 rw migration
+091 rw migration quick
 092 rw quick
 093 throttle
 094 rw quick
@@ -186,7 +186,7 @@
 162 quick
 163 rw
 165 rw quick
-169 rw quick migration
+169 rw migration
 170 rw auto quick
 171 rw quick
 172 auto
@@ -197,9 +197,9 @@
 177 rw auto quick
 178 img
 179 rw auto quick
-181 rw auto migration
+181 rw auto migration quick
 182 rw quick
-183 rw migration
+183 rw migration quick
 184 rw auto quick
 185 rw
 186 rw auto
@@ -216,9 +216,9 @@
 198 rw
 199 rw migration
 200 rw
-201 rw migration
+201 rw migration quick
 202 rw quick
-203 rw auto migration
+203 rw auto migration quick
 204 rw quick
 205 rw quick
 206 rw
-- 
2.27.0


