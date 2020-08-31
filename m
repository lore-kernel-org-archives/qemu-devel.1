Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E3DC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE2020767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4E7tWKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE2020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfBZ-0001vY-J6
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kCfAg-0001IF-2R
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kCfAe-0005ne-3b
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZNy4Aw0aKZd+GoXjNxDyc4kLU0GVUwC+YhBDCcYH+AI=;
 b=Y4E7tWKKVAb3AWnZK5bKWU5XQio+aImMtDi+J6PPyYNr4ZmzsWms6iDiBlqYCghs7WpVy4
 GE75o21kTqgBNjvobnbaRrRgk7AWwy6UDEMhI+IubA6D+OhjlzljdFlXScxOevZJZOVTgj
 6hUi1Nfg47rjoTVM/0jBHo7KDl3SaKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-r3ujiORqNfe-_3ghfjPHlg-1; Mon, 31 Aug 2020 04:28:02 -0400
X-MC-Unique: r3ujiORqNfe-_3ghfjPHlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 667AC18BA2A9
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 08:28:01 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-88.pek2.redhat.com [10.72.12.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68D695D9D5;
 Mon, 31 Aug 2020 08:27:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 0/9] refine vhost-vdpa initialization
Date: Mon, 31 Aug 2020 16:27:28 +0800
Message-Id: <20200831082737.10983-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: lulu@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all:

This series refine vhost-vdpa initialization by:

- fixing SIGSEV when vhostdev is not specificed
- tweak the codes for vhost-vdpa initialization
- allow to accept preopen vhost-vdpa file descriptor

Please review.

Thanks

Jason Wang (9):
  vhost-vdpa: remove the default devname
  vhost-vdpa: mandate vhostdev
  vhost-vdpa: remove the unnecessary assert(s->vhost_net)
  vhost-vdpa: refine info string
  vhost-vdpa: remove the unnecessary initialization
  vhost-vdpa: remove the unnecessary queue index assignment
  vhost-vdpa: squash net_vhost_vdpa_init() into net_init_vhost_vdpa()
  vhost-vdpa: add accurate error string when fail to open vhost vDPA
    device
  vhost-vdpa: allow pre-opend file descriptor

 net/vhost-vdpa.c | 63 ++++++++++++++++++++++++++++++------------------
 qapi/net.json    |  6 +++--
 2 files changed, 43 insertions(+), 26 deletions(-)

-- 
2.20.1


