Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6072C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BFA20749
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N24SqNkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BFA20749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCADL-0005xO-SP
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jCACV-00058Q-Uf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jCACU-0001AM-9t
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:51:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47770
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jCACU-00017l-6I
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583967101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xc/e/5zA6a4lIgzI5GKftLABtgREQjemveEtUOLS6Dc=;
 b=N24SqNkMVnz9nHD4PyAlWdBB2W7F1y8wLQxaVzCgU1jPaykucHsEP0P8v77t3BeHIBDyem
 BrPUNA1U20NPMqCfXqNu629TdvuF5jzXjqu9ztRorI2bas/glqish4LgDD86I2lcnByBGi
 qj3UGq8D1nXIiVNr2uJmpnPIhXIg9q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Rve6wL_SO2e9PZKGGi4KoA-1; Wed, 11 Mar 2020 18:51:35 -0400
X-MC-Unique: Rve6wL_SO2e9PZKGGi4KoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A3A18010E3;
 Wed, 11 Mar 2020 22:51:34 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 943DB7386F;
 Wed, 11 Mar 2020 22:51:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix MAP_SYNC support when host has older glibc version
Date: Wed, 11 Mar 2020 18:51:28 -0400
Message-Id: <20200311225130.1599619-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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


