Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA892C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A447E2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kd2mRUZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A447E2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLEI-00034H-RO
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjLCr-0001l8-4x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:17:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22757
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjLCp-0003zR-7o
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591874230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6IXxP0qK4X80XIQsZDuejXNu76QU/50J1X5Sv3H+SKE=;
 b=Kd2mRUZjjIF88kOngD0XPX2P6pxzAxdHjrQSK/u2bNuNKDN+j+SNQoa4o31Mh3fMENyHA6
 SuUPIxr9ZtpOY4FbFUHne6wbqoS6NIadYTHj/W0TOOeX5RGcIcHnEgf5rOw0Kz8O1atMqU
 VdgPV/0uTk7/x58BF8W9GeXOezks360=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-UEZ0btzPNBiwS_SsoKfX6w-1; Thu, 11 Jun 2020 07:17:08 -0400
X-MC-Unique: UEZ0btzPNBiwS_SsoKfX6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABF79107ACCA
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 11:17:07 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-116.ams2.redhat.com
 [10.36.114.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A774E60BF3;
 Thu, 11 Jun 2020 11:17:06 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, armbru@redhat.com, thuth@redhat.com,
 quintela@redhat.com
Subject: [PATCH 0/2] monitor openfd commands
Date: Thu, 11 Jun 2020 12:17:01 +0100
Message-Id: <20200611111703.159590-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The monitors currently have a 'getfd' command that lets you pass an fd
via the monitor socket.  'openfd' is a new command that opens a file
and puts the fd in the same fd pool.  The file is opened RW and created
if it doesn't exist.
It makes it easy to test migration to and from a file.

Dr. David Alan Gilbert (2):
  qmp: Add 'openfd' command
  hmp: Add 'openfd' command

 hmp-commands.hx        | 16 +++++++++++++-
 include/monitor/hmp.h  |  1 +
 monitor/hmp-cmds.c     | 10 +++++++++
 monitor/misc.c         | 48 +++++++++++++++++++++++++++++++++---------
 qapi/misc.json         | 23 +++++++++++++++++++-
 tests/qtest/test-hmp.c |  2 ++
 6 files changed, 88 insertions(+), 12 deletions(-)

-- 
2.26.2


