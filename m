Received: from eggs.gnu.org ([2001:4830:134:3::10]:47101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0VsP-0008G0-3F
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0Vrk-0001ju-HQ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:25:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f0Vrj-0001hG-EL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:25:03 -0400
Date: Mon, 26 Mar 2018 18:24:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180326172457.GH3232@work-vm>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/38] RFC: monitor: add asynchronous
 command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Hi,

Without having gone too deep here, it looks like you've got a mix
of cleanups and adding the async stuff.
You might want to split it into the set of simple cleanups first.

Dave

> One of initial design goals of QMP was to have "asynchronous command
> completion" (http://wiki.qemu.org/Features/QAPI). Unfortunately, that
> goal was not fully achieved, and some broken bits left were removed
> progressively until commit 65207c59d that removed async command
> support.
>=20
> Yet there are clear benefits allowing the command handler to re-enter
> the main loop if the command cannot be handled synchronously, or if it
> is long-lasting. This is currently not possible and make some bugs
> such as rhbz#1230527 difficult to solve.  Furthermore, many QMP
> commands do IO and could be considered 'slow' and blocking the main
> loop today. The unwritten solution so far is to use a pair of
> command+event. But this approach has a number of issues, in particular
> to fix existing commands, and inadequacy since the event is
> broadcasted and may thus have command 'id' conflict, beside being
> rather inefficient and incorrect.
>=20
> The following series implements an async command solution instead. By
> introducing a session context and a command return handler, it can:
> - defer the return, allowing the mainloop to reenter
> - return only to the caller (no broadcasted event)
> - optionnally allow cancellation when the client is gone
> - track on-going qapi command(s) per client/session
>=20
> Existing qemu commands can be gradually replaced by async:true
> variants when needed, and by carefully reviewing the concurrency
> aspects. The async:true commands marshaller helpers are splitted in
> half, the calling and return functions. The command is called with a
> QmpReturn context, that can return immediately or later, using the
> generated return helper, which allows for step-by-step conversion.
>=20
> The screendump command is converted to an async:true version to solve
> rhbz#1230527. The command shows basic cancellation (this could be
> extended if needed). It could be further improved to do asynchronous
> IO write as well.
>=20
> v3:
> - complete rework, dropping the asynchronous commands visibility from
>   the protocol side entirely (until there is a real need for it)
> - rebased, with a few preliminary cleanup patches
> - teach asynchronous commands to HMP
>=20
> v2:
> - documentation fixes and improvements
> - fix calling async commands sync without id
> - fix bad hmp monitor assert
> - add a few extra asserts
> - add async with no-id failure and screendump test
>=20
> Marc-Andr=E9 Lureau (38):
>   HACK: add back OOB
>   qmp-shell: learn to send commands with quoted arguments
>   Revert "qmp: isolate responses into io thread"
>   monitor: no need to save need_resume
>   monitor: further simplify previous patch
>   monitor: no need to remove desc before replacing it
>   json-parser: always set an error if return NULL
>   json-lexer: make it safe to call multiple times
>   json: remove useless return value from lexer/parser
>   tests: add a few qemu-qmp tests
>   tests: change /0.15/* tests to /qmp/*
>   tests: add a qmp success-response test
>   qga: process_event() simplification
>   monitor: simplify monitor_qmp_respond()
>   qmp: pass and return a QDict to qmp_dispatch()
>   qmp: move 'id' copy to qmp_dispatch()
>   qmp: constify qmp_is_oob()
>   qmp: add QmpSession
>   QmpSession: add a return_cb
>   QmpSession: add json parser and use it in qga
>   QmpSession: add a dispatch callback
>   monitor: use QmpSession parsing and common dispatch code
>   QmpSession: introduce QmpReturn
>   qmp: remove qmp_build_error_object()
>   qmp: remove need for qobject_from_jsonf()
>   qmp: fold do_qmp_dispatch() in qmp_dispatch()
>   QmpSession: keep a queue of pending commands
>   QmpSession: return orderly
>   qmp: introduce asynchronous command type
>   scripts: learn 'async' qapi commands
>   qmp: add qmp_return_is_cancelled()
>   monitor: add qmp_return_get_monitor()
>   console: graphic_hw_update return true if async
>   console: add graphic_hw_update_done()
>   console: make screendump asynchronous
>   monitor: start making qmp_human_monitor_command() asynchronous
>   monitor: teach HMP about asynchronous commands
>   hmp: call the asynchronous QMP screendump to fix outdated/glitches
>=20
>  qapi/misc.json                          |   3 +-
>  qapi/ui.json                            |   3 +-
>  scripts/qapi/commands.py                | 149 +++++++--
>  scripts/qapi/common.py                  |  12 +-
>  scripts/qapi/doc.py                     |   2 +-
>  scripts/qapi/introspect.py              |   2 +-
>  hmp.h                                   |   3 +-
>  hw/display/qxl.h                        |   2 +-
>  include/monitor/monitor.h               |   3 +
>  include/qapi/qmp/dispatch.h             |  85 ++++-
>  include/qapi/qmp/json-lexer.h           |   4 +-
>  include/qapi/qmp/json-streamer.h        |   4 +-
>  include/ui/console.h                    |   7 +-
>  hmp.c                                   |   6 +-
>  hw/display/qxl-render.c                 |  14 +-
>  hw/display/qxl.c                        |   8 +-
>  migration/postcopy-ram.c                |   1 +
>  monitor.c                               | 393 +++++++++---------------
>  qapi/qmp-dispatch.c                     | 234 +++++++++++---
>  qapi/qmp-registry.c                     |  27 +-
>  qga/main.c                              |  73 +----
>  qobject/json-lexer.c                    |  28 +-
>  qobject/json-parser.c                   |   7 +-
>  qobject/json-streamer.c                 |   8 +-
>  tests/qmp-test.c                        | 146 ++++++++-
>  tests/test-qmp-cmds.c                   | 206 +++++++++++--
>  ui/console.c                            | 106 ++++++-
>  hmp-commands.hx                         |   3 +-
>  scripts/qmp/qmp-shell                   |   3 +-
>  tests/Makefile.include                  |   6 +-
>  tests/qapi-schema/qapi-schema-test.json |   7 +
>  tests/qapi-schema/qapi-schema-test.out  |  10 +
>  tests/qapi-schema/test-qapi.py          |   7 +-
>  33 files changed, 1078 insertions(+), 494 deletions(-)
>  mode change 100644 =3D> 100755 scripts/qapi/doc.py
>=20
> --=20
> 2.17.0.rc1.1.g4c4f2b46a3
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
