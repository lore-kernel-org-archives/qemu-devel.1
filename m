Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B320DC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E33420838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWLo5Ocf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E33420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00iz-0000fL-OG
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j00i5-0007oK-RX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j00i4-0008Ia-3J
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:18:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j00i3-0008Hl-Vw
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581070683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wZVfmWa3Tk0OtZcF8zGnMZ9rxTFCvx+JI8m9OiB5Jxc=;
 b=XWLo5OcfZQgGW02/miiGCe103fDo1Gk9aJWKekSUFVT7I0QE/boQtOVzBzJlH+6tEXJRYi
 0EQ1Pjg1PucLG5TC4mSPzMDFAQjYdShP2KcvedTE3V50e62JIYx/dpG6o1/s0R1ObGPmY1
 +fIPwJMJ2Fe8OLYytvr7hlQlOhy3v+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-82YxjycMOmqx5MFkUeGzJQ-1; Fri, 07 Feb 2020 05:18:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A420189F760;
 Fri,  7 Feb 2020 10:17:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2948B87B1C;
 Fri,  7 Feb 2020 10:17:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6AA711747D; Fri,  7 Feb 2020 11:17:53 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] ui: rework -show-cursor option
Date: Fri,  7 Feb 2020 11:17:46 +0100
Message-Id: <20200207101753.25812-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 82YxjycMOmqx5MFkUeGzJQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jtomko@redhat.com,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 jpewhacker@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add -display {sdl,gtk,cocoa},show-cursor=3Don as replacement for
-show-cursor.  sdl + cocoa are switched over (no change in behavior),
gtk support is added.

Gerd Hoffmann (7):
  ui: add show-cursor option
  ui: wire up legacy -show-cursor option
  ui/sdl: switch to new show-cursor option
  ui/cocoa: switch to new show-cursor option
  ui/gtk: implement show-cursor option
  ui: drop curor_hide global variable.
  ui: deprecate legacy -show-cursor option

 include/sysemu/sysemu.h |  1 -
 ui/gtk.c                |  8 ++++++--
 ui/sdl2.c               | 16 ++++++++--------
 vl.c                    | 16 ++++++++++++++--
 qapi/ui.json            |  3 +++
 qemu-deprecated.texi    |  5 +++++
 ui/cocoa.m              |  4 ++++
 7 files changed, 40 insertions(+), 13 deletions(-)

--=20
2.18.1


