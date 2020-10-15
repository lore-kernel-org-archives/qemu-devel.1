Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B967C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC67821D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk/IxrT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC67821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5r9-00052P-LT
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT5o5-0000ti-NM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT5o0-00040g-W5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602778111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y+JhKPsh6SiQDzKAEUkVhCVw2RyYGV+ydamyOVj3Rr0=;
 b=Fk/IxrT0YPpQGfaEpF9O78WDvdLG1xD5Wc2LMpoeLgr2JFolYVKSAYEg7x8CujaQlqyK/w
 QL1bX0wSJJGH9V3lDLSmgU+0DgG4eaK0vs/rkQQvfKdXehV1E0VBUXUcBpP1EhtsKQlJvJ
 oWSYtjYZlVFqPPPvVF0CAXpQ1avN4PM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-SfBiU0-tMqOJMPF27JrY1g-1; Thu, 15 Oct 2020 12:08:29 -0400
X-MC-Unique: SfBiU0-tMqOJMPF27JrY1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E7F10A0B85;
 Thu, 15 Oct 2020 16:08:28 +0000 (UTC)
Received: from localhost (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F054061177;
 Thu, 15 Oct 2020 16:08:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] qemu-ga: add ssh-{add,remove}-authorized-keys
Date: Thu, 15 Oct 2020 20:08:17 +0400
Message-Id: <20201015160819.1471144-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
Add two new commands to help modify ~/.ssh/authorized_keys.=0D
=0D
Although it's possible already to modify the authorized_keys files via=0D
file-{read,write} or exec, the commands are often denied by default, and th=
e=0D
logic is left to the client. Let's add specific commands for this job.=0D
=0D
Fixes:=0D
https://bugzilla.redhat.com/show_bug.cgi?id=3D1885332=0D
=0D
v2:=0D
 - misc doc improvements=0D
 - various warnings fixes=0D
 - fix build for !unix=0D
 - added reviewed-by=0D
=0D
Marc-Andr=C3=A9 Lureau (2):=0D
  glib-compat: add g_unix_get_passwd_entry_qemu()=0D
  qga: add ssh-{add,remove}-authorized-keys=0D
=0D
 include/glib-compat.h    |  26 +++=0D
 qga/commands-posix-ssh.c | 400 +++++++++++++++++++++++++++++++++++++++=0D
 qga/commands-win32.c     |  12 ++=0D
 qga/meson.build          |  20 +-=0D
 qga/qapi-schema.json     |  33 ++++=0D
 5 files changed, 490 insertions(+), 1 deletion(-)=0D
 create mode 100644 qga/commands-posix-ssh.c=0D
=0D
--=20=0D
2.28.0=0D
=0D


