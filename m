Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B202FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE0120732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKkH80yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE0120732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnR5g-00039S-QN
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnR30-0000F5-Qo
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:19:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58085
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnR2z-0005vq-6R
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592849996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=omyDk/w3DO0jLjvOBn6Rg7kmxPFEub/szn3Q3gQLoeI=;
 b=hKkH80yvftz9UCTn4M2/6WCUMp6XJCoCOHwL6tZRge7LdR49zEBmE0trFZD0YqdQqfFS/f
 JyrmMCv6Ec8chIJ3cmtZdNt9F4zWh5dZWHtuB9kViuMw+f7dIQDvV4KUASLUgjg/Ehb0hW
 +6pBMLN9/MVO608JSkTFcST46QutUrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-ZzNKig6zMMOU_8B67gyYMw-1; Mon, 22 Jun 2020 14:19:45 -0400
X-MC-Unique: ZzNKig6zMMOU_8B67gyYMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 636D4464;
 Mon, 22 Jun 2020 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0505E610AF;
 Mon, 22 Jun 2020 18:19:42 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] qga: Ditch g_get_host_name()
Date: Mon, 22 Jun 2020 20:19:34 +0200
Message-Id: <cover.1592849834.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: pbonzini@redhat.com, vfeenstr@redhat.com, marcandre.lureau@gmail.com,
 mdroth@linux.vnet.ibm.com, sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3 of:

https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg06913.html

diff to v2:
- don't leak @hostname in util/oslib-posix.c:qemu_get_host_name()
- document why we are allocating one byte more than needed
- switch to g_new0() from g_malloc0().

Michal Privoznik (2):
  util: Introduce qemu_get_host_name()
  qga: Use qemu_get_host_name() instead of g_get_host_name()

 include/qemu/osdep.h | 10 ++++++++++
 qga/commands.c       | 17 +++++++++++++----
 util/oslib-posix.c   | 35 +++++++++++++++++++++++++++++++++++
 util/oslib-win32.c   | 13 +++++++++++++
 4 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.26.2


