Received: from eggs.gnu.org ([2001:4830:134:3::10]:34025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dbAOi-0006qJ-34
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dbAOh-0005W4-7g
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:54:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-9-eblake@redhat.com>
Date: Fri, 28 Jul 2017 20:53:55 +0200
In-Reply-To: <20170725211523.3998-9-eblake@redhat.com> (Eric Blake's message
	of "Tue, 25 Jul 2017 16:15:19 -0500")
Message-ID: <87k22sjsu4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 08/12] qtests: convert tests to use
 qmp_cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>, stefanha@redhat.com

Eric Blake <eblake@redhat.com> writes:

> Now that we have the qmp_cmd() helper, we can further simplify
> some of the tests by using it.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/device-introspect-test.c |  3 +--
>  tests/ide-test.c               |  2 +-
>  tests/libqos/libqos.c          |  5 +++--
>  tests/libqos/pci-pc.c          |  4 ++--
>  tests/libqos/usb.c             | 18 +++++++++---------
>  tests/pc-cpu-test.c            | 10 +++++-----
>  tests/postcopy-test.c          |  9 +++++----
>  tests/vhost-user-test.c        | 12 ++++++------
>  8 files changed, 32 insertions(+), 31 deletions(-)
>
> diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
> index f7162c023f..fc6d559e14 100644
> --- a/tests/device-introspect-test.c
> +++ b/tests/device-introspect-test.c
> @@ -36,8 +36,7 @@ static QList *qom_list_types(const char *implements, bool abstract)
>      if (implements) {
>          qdict_put_str(args, "implements", implements);
>      }
> -    resp = qmp("{'execute': 'qom-list-types',"
> -               " 'arguments': %p }", args);
> +    resp = qmp_cmd("qom-list-types", QOBJECT(args));

This one's a clear win.

>      g_assert(qdict_haskey(resp, "return"));
>      ret = qdict_get_qlist(resp, "return");
>      QINCREF(ret);
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index ea2657d3d1..75dc472e6a 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -651,7 +651,7 @@ static void test_retry_flush(const char *machine)
>      qmp_eventwait("STOP");
>
>      /* Complete the command */
> -    qmp_discard_response("{'execute':'cont' }");
> +    qmp_cmd_discard_response("cont", NULL);

This one isn't.

>
>      /* Check registers */
>      data = qpci_io_readb(dev, ide_bar, reg_device);
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index 42c5315423..18844617ae 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -4,6 +4,7 @@
>  #include "libqtest.h"
>  #include "libqos/libqos.h"
>  #include "libqos/pci.h"
> +#include "qapi/qmp/qjson.h"
>
>  /*** Test Setup & Teardown ***/
>
> @@ -86,7 +87,7 @@ void set_context(QOSState *s)
>
>  static QDict *qmp_execute(const char *command)
>  {
> -    return qmp("{ 'execute': %s }", command);
> +    return qmp_cmd(command, NULL);

Marginal.

>  }
>
>  void migrate(QOSState *from, QOSState *to, const char *uri)
> @@ -106,7 +107,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
>      QDECREF(rsp);
>
>      /* Issue the migrate command. */
> -    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
> +    rsp = qmp_cmd("migrate", qobject_from_jsonf("{ 'uri': %s }", uri));

Not a simplification.  The opposite, I'm afraid.

I could become one if qmp_cmd() worked like this:

       rsp = qmp_cmd("migrate", "{ 'uri': %s }", uri));

Even better if qmp_cmd("cont", "") just works.  Hmm, unles gcc whines
about the empty format string.

>      g_assert(qdict_haskey(rsp, "return"));
>      QDECREF(rsp);
>
[More of the same snipped...]
