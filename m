Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B84EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E65206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VO+qE1w7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E65206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jld2l-0004fE-2n
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcx0-0004Kz-H0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:38:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwy-0008CB-Ko
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592419096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Spe4DMKm1bF0j02m1UMkUsLjMrwOSGPTH88jlHHP0A=;
 b=VO+qE1w7HKKJ+K+Pcp35cxGxEX0MZz6BFnFvFzLCuFztgJcHIVYe9u4fjWWhN8zj2eosdL
 NZRU5nStI+C9a8V8x/97BnrFxAg0bu1G2/VjSp8NqYzP1bgV6K0lm+3X3TuTOGuysludnS
 2uThrky7GJJiiB//kV9n6FJvYoBZleY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-cSgs3x4WOuq3KbCT3aVdTg-1; Wed, 17 Jun 2020 14:38:13 -0400
X-MC-Unique: cSgs3x4WOuq3KbCT3aVdTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFEDC835B41;
 Wed, 17 Jun 2020 18:38:12 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-115-47.ams2.redhat.com
 [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 372F86ED96;
 Wed, 17 Jun 2020 18:38:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, lvivier@redhat.com,
 maozhongyi@cmss.chinamobile.com, mreitz@redhat.com, pannengyuan@huawei.com
Subject: [PULL 12/12] migration: fix multifd_send_pages() next channel
Date: Wed, 17 Jun 2020 19:37:33 +0100
Message-Id: <20200617183733.186168-13-dgilbert@redhat.com>
In-Reply-To: <20200617183733.186168-1-dgilbert@redhat.com>
References: <20200617183733.186168-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

multifd_send_pages() loops around the available channels,
the next channel to use between two calls to multifd_send_pages() is stored
inside a local static variable, next_channel.

It works well, except if the number of channels decreases between two calls
to multifd_send_pages(). In this case, the loop can try to access the
data of a channel that doesn't exist anymore.

The problem can be triggered if we start a migration with a given number of
channels and then we cancel the migration to restart it with a lower number.
This ends generally with an error like:
qemu-system-ppc64: .../util/qemu-thread-posix.c:77: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.

This patch fixes the error by capping next_channel with the current number
of channels before using it.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20200617113154.593233-1-lvivier@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/multifd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 5a3e4d0d46..d0441202aa 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -415,6 +415,12 @@ static int multifd_send_pages(QEMUFile *f)
     }
 
     qemu_sem_wait(&multifd_send_state->channels_ready);
+    /*
+     * next_channel can remain from a previous migration that was
+     * using more channels, so ensure it doesn't overflow if the
+     * limit is lower now.
+     */
+    next_channel %= migrate_multifd_channels();
     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
         p = &multifd_send_state->params[i];
 
-- 
2.26.2


