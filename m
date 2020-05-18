Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1403EC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D824B20826
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qr3cp6Fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D824B20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jak6M-0006MI-1B
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 14:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jak4g-00059v-2H
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:01:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54657
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jak4e-00033K-Ao
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589824869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=xXTL4VofIDoDUT9v56y3hD2J9MkT8ufCD/pAMj99lgI=;
 b=Qr3cp6FrEL/rrbbVUwQjjwn5HGzybGM6cUt1aM8eJaJ+SlLsC8YK8UEVQSZOwDuhD9rHmB
 Zl2uRUD1/BRsjD14zJEp0fO5trzzwlo36eN340zb7IJG5amXiuX/aTaH46n5WTJogeKhBa
 MHHeKhedvNutROZlwjwM4uF5vVBxUCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-6QWWRRDBN9WF17YPqtiWAA-1; Mon, 18 May 2020 14:01:07 -0400
X-MC-Unique: 6QWWRRDBN9WF17YPqtiWAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFBC4180071D
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 18:01:06 +0000 (UTC)
Received: from thuth.com (ovpn-112-242.ams2.redhat.com [10.36.112.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 715EC1001B2C;
 Mon, 18 May 2020 18:01:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] net: Drop legacy "name" from -net and remove NetLegacy
Date: Mon, 18 May 2020 20:01:01 +0200
Message-Id: <20200518180103.32484-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit b4983c570c7a ("net: Remove deprecated [hub_id name] tuple of
'hostfwd_add' / 'hostfwd_remove'"), the "name" parameter is not used
internally anymore. And it's been marked as deprecated since QEMU v3.1,
so it is time to remove the "name" parameter from -net now. Once this
has been done, we can also drop the obsolete NetLegacy structure since
there is no major difference between Netdev and NetLegacy anymore.

v3:
 - Do not make "id" in Netdev optional, but rather assign a temporary
   "id" for -net before we call the options visitor function.
 - Changed some "void *" to "Netdev *" now

v2:
 - Rebased to master (use the deprecated.rst instead of qemu-deprecated.texi)

Thomas Huth (2):
  net: Drop the legacy "name" parameter from the -net option
  net: Drop the NetLegacy structure, always use Netdev instead

 docs/system/deprecated.rst | 15 ++++---
 net/net.c                  | 87 ++++++--------------------------------
 qapi/net.json              | 49 ---------------------
 3 files changed, 23 insertions(+), 128 deletions(-)

-- 
2.18.1


