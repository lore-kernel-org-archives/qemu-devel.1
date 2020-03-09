Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC57C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0415A20727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSxKqduC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0415A20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHsC-0000UX-7t
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBHnc-0003J9-U4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBHna-0003g9-Tw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBHna-0003eW-Qr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583757982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E8payL5s+10rc7kxHEuBGEKw4JwKFNTqewLbbgio3m4=;
 b=HSxKqduCWu+CtQXYsaSXuX5pTRZNoOMFLWyU5BJt3kfTs/EYvOmm8AKPxe+YBvW7A2oCe3
 Z1qQkYHCAVhna2bMtJNpVdWLdpCbn8iYpzqQWW8ZYB9EvsvvQhHKJM05280KZ8WskF5MRx
 0Y7uUcCmt0tzT5iO0yduF0zYWGIIUNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-nlLdzh2DNoSnCIc1mKO26A-1; Mon, 09 Mar 2020 08:46:18 -0400
X-MC-Unique: nlLdzh2DNoSnCIc1mKO26A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC59C18A6EC0
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 12:46:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E7E5261CF
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 12:46:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2979D11386A6; Mon,  9 Mar 2020 13:46:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Error reporting patches for 2020-03-09
Date: Mon,  9 Mar 2020 13:46:12 +0100
Message-Id: <20200309124616.4372-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The following changes since commit 67f17e23baca5dd545fe98b01169cc351a70fe35=
:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into stagi=
ng (2020-03-06 17:15:36 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-03-09

for you to fetch changes up to d1eddab86f92e7e060c8a473695c7f24ec00c9ab:

  qga: Fix a memory leak (2020-03-09 13:36:15 +0100)

----------------------------------------------------------------
Error reporting patches for 2020-03-09

* Improve error reporting on Windows

----------------------------------------------------------------
Philippe Mathieu-Daud=C3=A9 (4):
      chardev: Improve error report by calling error_setg_win32()
      util/osdep: Improve error report by calling error_setg_win32()
      qga: Improve error report by calling error_setg_win32()
      qga: Fix a memory leak

 chardev/char-pipe.c  | 2 +-
 chardev/char-win.c   | 2 +-
 qga/channel-win32.c  | 7 ++++---
 qga/commands-win32.c | 8 +++++---
 util/osdep.c         | 4 ++--
 5 files changed, 13 insertions(+), 10 deletions(-)

--=20
2.21.1


