Received: from eggs.gnu.org ([2001:4830:134:3::10]:53376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1faFNl-0008Jo-MC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1faFNk-0006YR-Ff
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:05:49 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:53290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1faFNk-0006YI-8A
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:05:48 -0400
Received: by mail-wm0-x235.google.com with SMTP id b188-v6so1069496wme.3
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 00:05:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Jul 2018 09:05:46 +0200
Message-ID: <CAJ+F1CK2AXagKO5-Qsb3nc4xBfc_Scr+pOyM+Vn8EynZYFsqAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/32] qmp: Fixes and cleanups around OOB
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Mon, Jul 2, 2018 at 6:21 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> We're trying to get the out-of-band execution feature ready.  This
> series fixes a number of issues, and marks a design flaw FIXME.  More
> work is needed.

They are several related worthy cleanups in the qapi-async series.

They will now conflict with your changes though.

Please take a look roughly from 4/38 to 17/38, and let me know if you
want me to rebase it for 3.0.

>
> Markus Armbruster (32):
>   qmp: Say "out-of-band" instead of "Out-Of-Band"
>   monitor: Spell "I/O thread" consistently in comments
>   docs/interop/qmp: Improve OOB documentation
>   qmp: Document COMMAND_DROPPED design flaw
>   qmp: Get rid of x-oob-test command
>   tests/qmp-test: Test in-band command doesn't overtake
>   qmp: Make "id" optional again even in "oob" monitors
>   tests/test-qga: Demonstrate the guest-agent ignores "id"
>   qmp qemu-ga: Revert change that accidentally made qemu-ga accept "id"
>   tests/test-qga: Demonstrate the guest-agent ignores "control"
>   qmp qemu-ga: Fix qemu-ga not to accept "control"
>   qmp: Redo how the client requests out-of-band execution
>   qmp: Revert change to handle_qmp_command tracepoint
>   qmp: Always free QMPRequest with qmp_request_free()
>   qmp: Simplify code around monitor_qmp_dispatch_one()
>   tests/qmp-test: Demonstrate QMP errors jumping the queue
>   qmp: Don't let malformed in-band commands jump the queue
>   qmp: Don't let JSON errors jump the queue
>   monitor: Rename use_io_thr to use_io_thread
>   monitor: Peel off @mon_global wrapper
>   qobject: New qdict_from_jsonf_nofail()
>   qmp: De-duplicate error response building
>   qmp: Use QDict * instead of QObject * for response objects
>   qmp: Replace monitor_json_emitter{,raw}() by
>     qmp_{queue,send}_response()
>   qmp: Replace get_qmp_greeting() by qmp_greeting()
>   qmp: Simplify monitor_qmp_respond()
>   qmp: Add some comments around null responses
>   qmp: Switch timestamp_put() to qdict_from_jsonf_nofail()
>   qobject: Let qobject_from_jsonf() fail instead of abort
>   qmp: Clean up capability negotiation after commit 02130314d8c
>   monitor: Improve some comments
>   qapi: Polish command flags documentation in qapi-code-gen.txt
>
>  docs/devel/qapi-code-gen.txt            |  63 ++-
>  docs/interop/qmp-intro.txt              |  13 +-
>  docs/interop/qmp-spec.txt               |  81 ++--
>  include/qapi/qmp/dispatch.h             |   6 +-
>  include/qapi/qmp/qjson.h                |   2 +
>  monitor.c                               | 507 ++++++++++--------------
>  qapi/misc.json                          |  23 +-
>  qapi/qmp-dispatch.c                     |  97 ++---
>  qapi/qmp-event.c                        |  10 +-
>  qga/main.c                              |  18 +-
>  qmp.c                                   |  16 -
>  qobject/qjson.c                         |  23 +-
>  tests/qapi-schema/qapi-schema-test.json |   2 +-
>  tests/qmp-test.c                        | 103 +++--
>  tests/test-qga.c                        |  34 ++
>  tests/test-qmp-cmds.c                   |  23 +-
>  16 files changed, 499 insertions(+), 522 deletions(-)
>
> --
> 2.17.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
