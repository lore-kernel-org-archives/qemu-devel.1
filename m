Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A6C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0674C20752
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N52C2mCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0674C20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAiF-0003KV-Vg
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 19:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jCAhb-0002cs-0T
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jCAhZ-0005oF-Px
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:23:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jCAhZ-0005n1-Mi
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583969029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qYdLV55UsUUzkbxfnEdi7dxE9cxCxDLr2NjHuObzkdQ=;
 b=N52C2mCKLmjqVarZsrruDteHRsgyrgkjrUlCUcbyfcY882TE10Z7riLX3WWxgmyFj6Ai5R
 PHZWf9LoK9uTC0Uc/UIWphqpPgtuHOwwxVYHHF62nDuhHarDzlbc/8LXQysFMFuHpE6nCg
 CZV7QwhWXP39R5l29viB38DE96+aKoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-8B4MEmUFPcSwlcsCd7F5Ug-1; Wed, 11 Mar 2020 19:23:47 -0400
X-MC-Unique: 8B4MEmUFPcSwlcsCd7F5Ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05F7413EA;
 Wed, 11 Mar 2020 23:23:46 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50ACF73895;
 Wed, 11 Mar 2020 23:23:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Fix MAP_SYNC support when host has older glibc version
Date: Wed, 11 Mar 2020 19:23:40 -0400
Message-Id: <20200311232342.1614944-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, jingqi.liu@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, jtomko@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes v1 -> v2:=0D
* Use -isystem for $PWD/linux-headers too=0D
  Reported-by: "Michael S. Tsirkin" <mst@redhat.com>=0D
=0D
This is an alternative to the patch submitted at:=0D
=0D
  From: Jingqi Liu <jingqi.liu@intel.com>=0D
  Subject: [PATCH] util: fix to get configuration macros in util/mmap-alloc=
.c=0D
  Date: Thu,  5 Mar 2020 23:41:42 +0800=0D
  Message-Id: <20200305154142.63070-1-jingqi.liu@intel.com>=0D
=0D
Before moving the osdep.h include to the top of the file, we had=0D
to address warnings triggered when <linux/mman.h> was included=0D
after <sys/mman.h> (done in patch 1/2).=0D
=0D
Eduardo Habkost (2):=0D
  Use -isystem for linux-headers dir=0D
  mmap-alloc: Include osdep.h before checking CONFIG_LINUX=0D
=0D
 Makefile.target   | 2 +-=0D
 configure         | 2 +-=0D
 util/mmap-alloc.c | 7 +++----=0D
 3 files changed, 5 insertions(+), 6 deletions(-)=0D
=0D
--=20=0D
2.24.1=0D
=0D


