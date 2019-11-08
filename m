Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA15FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8050215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwRm17Sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8050215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5nt-0003pM-An
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5lc-0002Ra-6S
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5la-0003Bs-Db
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:01:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5la-0003BM-3q
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4Kg4YoKWk8215DGBZ61EfFtdBmhVEjwNz3VE/HN4tPw=;
 b=BwRm17Sj4V2Vm+3bEgkQydILWkEPoc0HTRd7qHuvTNQBUkOHZ+Yww9D3SG4rHwDrBihqA9
 Gx8kWap/MwffeQkW92naXfN63yB9MemWrxSLF/Mwmx+C7eC/yZrEtjf89cppbkalZqrhAD
 QRkgdZOjfOLBGeWS1AoWs8QGTjhjoSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-tYoS62LwNwq00DeH-06rFg-1; Fri, 08 Nov 2019 10:01:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DC158017DD
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:01:35 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 216575C1BB;
 Fri,  8 Nov 2019 15:01:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/25] monitor: add asynchronous command type
Date: Fri,  8 Nov 2019 19:00:58 +0400
Message-Id: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: tYoS62LwNwq00DeH-06rFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

HMP and QMP commands are handled synchronously in qemu today. But
there are benefits allowing the command handler to re-enter the main
loop if the command cannot be handled synchronously, or if it is
long-lasting. Some bugs such as rhbz#1230527 are difficult to solve
without it.

The common solution is to use a pair of command+event in this case.
But this approach has a number of issues:
- you can't "fix" an existing command: you need a new API, and ad-hoc
  documentation for that command+signal association, and old/broken
  command deprecation
- since the reply event is broadcasted and 'id' is used for matching the
  request, it may conflict with other clients request 'id' space
- it is arguably less efficient and elegant (weird API, useless return
  in most cases, broadcast reply, no cancelling on disconnect etc)

The following series implements an internal async command solution
instead. By introducing a session context and a command return
handler, QMP handlers can:
- defer the return, allowing the mainloop to reenter
- return only to the caller (instead of the broadcast event reply)
- optionnally allow cancellation when the client is gone
- track on-going qapi command(s) per session

This does not introduce new QMP APIs or client visible changes, the
command are handled in order, and the reply still come in order (even
when handlers finish out of order).

Existing qemu commands can be gradually replaced by async:true
variants when needed, while carefully reviewing the concurrency
aspects. The async:true commands marshaller helpers are splitted in
half, the calling and return functions. The command is called with a
QmpReturn context, that can return immediately or later, using the
generated return helper.

The screendump command is converted to an async:true version to solve
rhbz#1230527. The command shows basic cancellation (this could be
extended if needed). It could be further improved to do asynchronous
IO writes as well.

v6:
- includes PPM save code improvements (will be sent seperatly,
  included for convenience for now)
- remove qmp_return_get_monitor() need, which is problematic with the
  QMP session over HMP monitor ("monitor: teach HMP about asynchronous
  commands")
- rebased

v5:
- rebased

v4:
- rebased, mostly adapting to new OOB code
  (there was not much feedback in v3 for the async command part,
   but preliminary patches got merged!)
- drop the RFC status

v3:
- complete rework, dropping the asynchronous commands visibility from
  the protocol side entirely (until there is a real need for it)
- rebased, with a few preliminary cleanup patches
- teach asynchronous commands to HMP

v2:
- documentation fixes and improvements
- fix calling async commands sync without id
- fix bad hmp monitor assert
- add a few extra asserts
- add async with no-id failure and screendump test

Marc-Andr=C3=A9 Lureau (25):
  qmp: constify QmpCommand and list
  json-lexer: make it safe to call destroy multiple times
  qmp: add QmpSession
  QmpSession: add a return callback
  QmpSession: add json parser and use it in qga
  monitor: use qmp session to parse json feed
  qga: simplify dispatch_return_cb
  QmpSession: introduce QmpReturn
  qmp: simplify qmp_return_error()
  QmpSession: keep a queue of pending commands
  QmpSession: return orderly
  qmp: introduce asynchronous command type
  scripts: learn 'async' qapi commands
  qmp: add qmp_return_is_cancelled()
  console: add graphic_hw_update_done()
  ppm-save: pass opened fd
  ui: add pixman image g_autoptr support
  object: add g_autoptr support
  screendump: replace FILE with QIOChannel and fix close()/qemu_close()
  osdep: add qemu_unlink()
  screendump: use qemu_unlink()
  console: make screendump asynchronous
  monitor: start making qmp_human_monitor_command() asynchronous
  monitor: teach HMP about asynchronous commands
  hmp: call the asynchronous QMP screendump to fix outdated/glitches

 hmp-commands.hx                         |   3 +-
 hw/display/qxl-render.c                 |   9 +-
 hw/display/qxl.c                        |   1 +
 include/qapi/qmp/dispatch.h             |  89 +++++++++-
 include/qapi/qmp/json-parser.h          |   7 +-
 include/qemu/osdep.h                    |   1 +
 include/qom/object.h                    |   3 +
 include/ui/console.h                    |   4 +
 include/ui/qemu-pixman.h                |   2 +
 monitor/hmp-cmds.c                      |   6 +-
 monitor/hmp.c                           | 110 +++++++++++-
 monitor/misc.c                          |  46 +----
 monitor/monitor-internal.h              |  12 +-
 monitor/monitor.c                       |   2 +-
 monitor/qmp.c                           |  64 +++----
 qapi/misc.json                          |   3 +-
 qapi/qmp-dispatch.c                     | 214 +++++++++++++++++++-----
 qapi/qmp-registry.c                     |  33 +++-
 qapi/ui.json                            |   3 +-
 qga/commands.c                          |   2 +-
 qga/main.c                              |  51 ++----
 qobject/json-lexer.c                    |   5 +-
 qobject/json-streamer.c                 |   3 +-
 scripts/qapi/commands.py                | 149 ++++++++++++++---
 scripts/qapi/doc.py                     |   2 +-
 scripts/qapi/expr.py                    |   4 +-
 scripts/qapi/introspect.py              |   2 +-
 scripts/qapi/schema.py                  |  11 +-
 tests/qapi-schema/qapi-schema-test.json |   5 +
 tests/qapi-schema/qapi-schema-test.out  |   8 +
 tests/qapi-schema/test-qapi.py          |   7 +-
 tests/test-qmp-cmds.c                   | 206 +++++++++++++++++++----
 ui/console.c                            | 165 ++++++++++++------
 ui/trace-events                         |   2 +-
 util/osdep.c                            |  15 ++
 35 files changed, 937 insertions(+), 312 deletions(-)

--=20
2.24.0


