Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D18CC282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F0120652
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F0120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ2tt-0005AE-Hw
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:24:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sQ-0004Hl-K8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sP-0007eA-NK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJ2sN-0007ZB-Mt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26E603001C86;
	Tue, 23 Apr 2019 21:22:49 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9F41660C64;
	Tue, 23 Apr 2019 21:22:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 18:22:43 -0300
Message-Id: <20190423212246.3542-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 23 Apr 2019 21:22:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423212243.gJzKwaD1Fl83q_QfuaPzd645Kq38ylpLQTNT_kTFoKo@z>

This series adds machine type deprecation information to the
output of the `query-machines` QMP command.  With this, libvirt
and management software will be able to show this information to
users and/or suggest changes to VM configuration to avoid
deprecated machine types.

Eduardo Habkost (3):
  qapi: SupportStatusInfo struct
  machine: Use SupportStatusInfo for deprecation info
  qmp: Add deprecation information to query-machines

 qapi/common.json                   | 24 ++++++++++++++++++++++++
 qapi/misc.json                     |  5 ++++-
 include/hw/boards.h                |  7 ++++---
 hw/i386/pc_piix.c                  |  4 +++-
 hw/ppc/prep.c                      |  4 +++-
 vl.c                               | 19 +++++++++++++++----
 tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
 7 files changed, 80 insertions(+), 10 deletions(-)
 create mode 100644 tests/acceptance/query_machines.py

-- 
2.18.0.rc1.1.g3f1ff2140


