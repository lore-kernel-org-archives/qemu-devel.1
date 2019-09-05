Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613CBC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF08620820
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF08620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tbV-0001Ot-Pd
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5ta1-0008T4-NL
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5ta0-0007au-5K
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5tZz-0007a6-Uw
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:21:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2039307D915;
 Thu,  5 Sep 2019 15:21:46 +0000 (UTC)
Received: from localhost (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B50C619C69;
 Thu,  5 Sep 2019 15:21:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Date: Thu,  5 Sep 2019 16:21:33 +0100
Message-Id: <20190905152136.30637-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 05 Sep 2019 15:21:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 0/3] virtiofsd: get/set log level via DBus
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
 Eryu Guan <eguan@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is likely that virtiofsd will need to support "management commands" fo=
r
reconfiguring it at runtime.  The first use case was proposed by Eryu Gua=
n for
getting/setting the current log level.

I promised to try out DBus as the management interface because it has a r=
ich
feature set and is accessible from most programming languages.  It should=
 be
able to support all the use cases we come up with.

This patch series is a prototype that implements the get-log-level and
set-log-level management commands via DBus.  Use the new virtiofsctl tool=
 to
talk to a running virtiofsd process:

  # dbus-run-session ./virtiofsd ...
  ...
  Using dbus address unix:abstract=3D/tmp/dbus-H9WBbpjk3O,guid=3D0be16ace=
fb868e6025a8737f5d7124d2
  # export DBUS_SESSION_BUS_ADDRESS=3Dunix:abstract=3D/tmp/dbus-H9WBbpjk3=
O,guid=3D0be16acefb868e6025a8737f5d7124d2
  # ./virtiofsctl set-log-level err

Most of the work is done by gdbus-codegen(1).  It generates code for the
org.qemu.Virtiofsd.xml interface definition.  Our code can use the simple
virtiofsd_get/set_log_level() APIs and it will make corresponding DBus ca=
lls.

I'm pretty happy with this approach because the code is straightforward. =
 It
hasn't even triggered seccomp failures yet :).

Error handling is a little problematic.  I noticed that virtiofsctl silen=
tly
returns success even if it cannot talk to virtiofsd.  This is due to the =
code
generated by gdbus-codegen(1) which has no error reporting :(.  This can =
be
solved by writing more low-level GDBus code instead of using the high-lev=
el
generated bindings.

What do you think about this approach?

Stefan Hajnoczi (3):
  virtiofsd: add org.qemu.Virtiofsd interface
  virtiofsd: add DBus server to handle log level changes
  virtiofsd: add virtiofsctl command-line management tool

 configure                                |   7 +
 Makefile                                 |  16 +++
 Makefile.objs                            |   1 +
 contrib/virtiofsd/Makefile.objs          |  10 +-
 contrib/virtiofsd/dbus.h                 |   9 ++
 contrib/virtiofsd/dbus.c                 | 162 +++++++++++++++++++++++
 contrib/virtiofsd/passthrough_ll.c       |   8 +-
 contrib/virtiofsd/virtiofsctl.c          |  55 ++++++++
 .gitignore                               |   1 +
 contrib/virtiofsd/org.qemu.Virtiofsd.xml |   7 +
 10 files changed, 274 insertions(+), 2 deletions(-)
 create mode 100644 contrib/virtiofsd/dbus.h
 create mode 100644 contrib/virtiofsd/dbus.c
 create mode 100644 contrib/virtiofsd/virtiofsctl.c
 create mode 100644 contrib/virtiofsd/org.qemu.Virtiofsd.xml

--=20
2.21.0


