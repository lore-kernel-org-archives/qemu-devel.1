Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9927DC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B1C2074B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cL3fwcas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B1C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPRO-0001Zf-Rm
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kXP9A-0003ip-IX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kXP98-0001Ef-RT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603805777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H2ON/cyileiUV83ZXL2JvjVHIwG/VHc51YanSmuA8GQ=;
 b=cL3fwcas11R0mAspc1+jfAnsIH09hpXUL0puKXf7wvNlCq30Fr1eenza5OaVqK1NVR9qqi
 hx8U5ZBCOTyc/7UcRmFXBSyn6ldT5fYjuXNNlfeQ2PmWuKcsM3yJbmYxSZBQXH5G6kxgbM
 FU58WqvaRnLvHSFxN0JvG6gvPmE5Lc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-wzlZ4S29N5-aa5Ib82_jNw-1; Tue, 27 Oct 2020 09:36:15 -0400
X-MC-Unique: wzlZ4S29N5-aa5Ib82_jNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A08009CC02
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:36:14 +0000 (UTC)
Received: from localhost (unknown [10.36.110.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FCE85C1C5;
 Tue, 27 Oct 2020 13:36:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] console: make QMP screendump use coroutine
Date: Tue, 27 Oct 2020 17:35:59 +0400
Message-Id: <20201027133602.3038018-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kraxel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
Thanks to recent work by Kevin, it becomes possible to run HMP/QMP commands=
 i=3D=0D
n a=0D
coroutine. The screendump command is a good target, as it requires to re-en=
ter=0D
the main-loop in ordre to flush the display, and write to file. Ideally, IO=
=0D
would be done with a non-blocking fd, however it's not currently enabled. T=
his=0D
is left for a future work.=0D
=0D
v2:=0D
 - change summary to not falsly claim non-blocking write support=0D
 - code styles fixes=0D
 - rebased, add reviewed-by tags=0D
=0D
Marc-Andr=3DC3=3DA9 Lureau (3):=0D
  coroutine: let CoQueue wake up outside a coroutine=0D
  console: modify ppm_save to take a pixman image ref=0D
  console: make QMP/HMP screendump run in coroutine=0D
=0D
 hmp-commands.hx            |  1 +=0D
 monitor/hmp-cmds.c         |  3 ++-=0D
 qapi/ui.json               |  3 ++-=0D
 ui/console.c               | 47 ++++++++++++++++++++++++++++++--------=0D
 ui/trace-events            |  2 +-=0D
 util/qemu-coroutine-lock.c |  6 ++---=0D
 6 files changed, 45 insertions(+), 17 deletions(-)=0D
=0D
--=3D20=0D
2.29.0=0D
=0D


