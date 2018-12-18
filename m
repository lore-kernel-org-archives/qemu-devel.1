Received: from eggs.gnu.org ([2001:4830:134:3::10]:50500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZM5K-0006K0-Ih
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZM5J-0005G5-GX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:35:22 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZM5J-0005B1-84
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:35:21 -0500
Received: by mail-wr1-x443.google.com with SMTP id t27so17285512wra.6
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:35:21 -0800 (PST)
MIME-Version: 1.0
References: <20181218182234.28876-1-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 19 Dec 2018 00:35:07 +0400
Message-ID: <CAJ+F1CLo4YRnGWHsyoUWDrPU1X2z-5+eDmdGsw-zp7ihTpD_+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/15] qapi: add #if pre-processor
 conditions to generated code (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Dec 18, 2018 at 10:26 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> Marc-Andr=C3=A9 posted v1 that relies on a QAPI schema language extension
> 'top-unit' to permit splitting the generated code.  Here is his cover
> letter:
>
>     The thrid and last part (of "[PATCH v2 00/54] qapi: add #if
>     pre-processor conditions to generated code") is about adding schema
>     conditions based on the target.
>
>     For now, the qapi code is compiled in common objects (common to all
>     targets). This makes it impossible to add #if TARGET_ARM for example.
>
>     The patch "RFC: qapi: learn to split the schema by 'top-unit'"
>     proposes to split the schema by "top-unit", so that generated code ca=
n
>     be built either in common objects or per-target. That patch is a bit
>     rough, I would like to get some feedback about the approach before
>     trying to improve it. The following patches demonstrate usage of
>     target-based #if conditions, and getting rid of the
>     qmp_unregister_command() hack.
>
> We already have a way to split generated code: QAPI modules.  I took
> the liberty to rework Marc-Andr=C3=A9's series to use a target module
> instead.  Less code, no change to the QAPI language.
>
> One of the patches (marked WIP) is a total hack.  Fixable, but I want
> to get this out for discussion first.

The approach you propose includes -target.h header in the top headers,
effectively making all the qapi code target-dependent, no?
I am actually a bit surprised there are no poisoined define errors.
Possibly because the top-level header is rarely included.

By contrast, my approach has the advantage of a clean split between
target and non-target dependent code, which I would feel more
confident about.

That's the reason why I promptly discarded the QAPI modules approach
without having second thoughts at least. Now you force me to
reconsider it though.

>
> Marc-Andr=C3=A9 Lureau (9):
>   build-sys: move qmp-introspect per target
>   qapi: make rtc-reset-reinjection and SEV depend on TARGET_I386
>   qapi: make s390 commands depend on TARGET_S390X
>   target.json: add a note about query-cpu* not being s390x-specific
>   qapi: make query-gic-capabilities depend on TARGET_ARM
>   qapi: make query-cpu-model-expansion depend on s390 or x86
>   qapi: make query-cpu-definitions depend on specific targets
>   qapi: remove qmp_unregister_command()
>   qapi: move RTC_CHANGE to the target schema
>
> Markus Armbruster (6):
>   qapi: Belatedly update docs for commit 9c2f56e9f9d
>   qapi: Eliminate indirection through qmp_event_get_func_emit()
>   qapi: Generate QAPIEvent stuff into separate files WIP
>   qapi: New module target.json
>   Revert "qapi-events: add 'if' condition to implicit event enum"
>   qmp: Deprecate query-events in favor of query-qmp-schema
>
>  Makefile                                |   1 +
>  Makefile.objs                           |  22 +-
>  Makefile.target                         |  12 +
>  docs/devel/qapi-code-gen.txt            |  12 +-
>  hw/ppc/spapr_rtc.c                      |   2 +-
>  hw/s390x/s390-skeys.c                   |   2 +-
>  hw/timer/mc146818rtc.c                  |   4 +-
>  include/qapi/qmp-event.h                |   6 -
>  include/qapi/qmp/dispatch.h             |   1 -
>  include/sysemu/arch_init.h              |  11 -
>  monitor.c                               |  92 +----
>  qapi/misc.json                          | 485 +---------------------
>  qapi/qapi-schema.json                   |   1 +
>  qapi/qmp-event.c                        |  12 -
>  qapi/qmp-registry.c                     |   8 -
>  qapi/target.json                        | 514 ++++++++++++++++++++++++
>  qemu-deprecated.texi                    |   5 +
>  qmp.c                                   |  26 --
>  scripts/qapi/events.py                  |  51 ++-
>  stubs/Makefile.objs                     |   4 -
>  stubs/arch-query-cpu-def.c              |  11 -
>  stubs/arch-query-cpu-model-baseline.c   |  13 -
>  stubs/arch-query-cpu-model-comparison.c |  13 -
>  stubs/arch-query-cpu-model-expansion.c  |  13 -
>  stubs/monitor.c                         |   5 +
>  target/arm/helper.c                     |   3 +-
>  target/arm/monitor.c                    |   2 +-
>  target/i386/cpu.c                       |   7 +-
>  target/i386/sev_i386.h                  |   2 +-
>  target/ppc/translate_init.inc.c         |   3 +-
>  target/s390x/cpu_models.c               |   9 +-
>  tests/Makefile.include                  |   4 +-
>  tests/test-qmp-event.c                  |   7 +-
>  tests/test-qobject-input-visitor.c      |   1 -
>  ui/vnc.c                                |   3 +-
>  35 files changed, 623 insertions(+), 744 deletions(-)
>  create mode 100644 qapi/target.json
>  delete mode 100644 stubs/arch-query-cpu-def.c
>  delete mode 100644 stubs/arch-query-cpu-model-baseline.c
>  delete mode 100644 stubs/arch-query-cpu-model-comparison.c
>  delete mode 100644 stubs/arch-query-cpu-model-expansion.c
>
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
