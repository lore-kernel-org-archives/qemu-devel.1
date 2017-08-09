Received: from eggs.gnu.org ([2001:4830:134:3::10]:58019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfTMa-00071c-JT
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfTMZ-0004Yw-8Y
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:57:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-18-eblake@redhat.com>
Date: Wed, 09 Aug 2017 17:57:23 +0200
In-Reply-To: <20170804012551.2714-18-eblake@redhat.com> (Eric Blake's message
	of "Thu, 3 Aug 2017 20:25:46 -0500")
Message-ID: <87shh0n38c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 17/22] libqtest: Add qmp_args() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>, Amit Shah <amit@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Eric Blake <eblake@redhat.com> writes:

> Similar to the previous helper, we can reduce the boilerplate
> of most callers by passing the command name separately from
> the interpolated arguments.  Adjust the majority of the callers
> that can use the new helpers; in the process, fixing a few
> places where we would have failed -Wformat-nonliteral.  The
> new helper function already uses GCC_FMT_ATTR to match the
> underlying use of qobject_from_jsonv().
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h               |  20 ++++++
>  tests/libqtest.c               |  29 +++++++++
>  tests/ahci-test.c              |  19 +++---
>  tests/device-introspect-test.c |   4 +-
>  tests/drive_del-test.c         |  10 +--
>  tests/fdc-test.c               |   8 +--
>  tests/libqos/libqos.c          |   7 +--
>  tests/libqos/pci-pc.c          |   8 +--
>  tests/pc-cpu-test.c            |   8 +--
>  tests/postcopy-test.c          |  30 +++------
>  tests/qom-test.c               |   9 +--
>  tests/test-netfilter.c         | 139 ++++++++++++++++-------------------------
>  tests/test-x86-cpuid-compat.c  |   6 +-
>  tests/tmp105-test.c            |   9 +--
>  tests/usb-hcd-uhci-test.c      |  14 ++---
>  tests/usb-hcd-xhci-test.c      |  25 ++------
>  tests/vhost-user-test.c        |  12 +---
>  tests/virtio-blk-test.c        |  12 +---
>  tests/virtio-scsi-test.c       |  13 +---
>  tests/virtio-serial-test.c     |  12 +---
>  20 files changed, 167 insertions(+), 227 deletions(-)
>
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index e0d87d035a..86ca7fa581 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -499,6 +499,26 @@ QDict *qmp_cmd(const char *cmd);
>  void qmp_cmd_async(const char *cmd);
>
>  /**
> + * qmp_args:
> + * @cmd: QMP command to send to QEMU.
> + * @fmt...: Arguments for the command; formats arguments through
> + * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
> + *
> + * Sends a QMP message to QEMU and returns the response.
> + */
> +QDict *qmp_args(const char *cmd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
> +
> +/**
> + * qmp_args_async:
> + * @cmd: QMP command to send to QEMU.
> + * @fmt...: Arguments for the command; formats arguments through
> + * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
> + *
> + * Sends a QMP message to QEMU and leaves the response in the stream.
> + */
> +void qmp_args_async(const char *cmd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
> +
> +/**
>   * qmp_discard_response:
>   *
>   * Read and discard a QMP response, typically after qmp_async().
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 3926a4d481..49786cf2d7 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -869,6 +869,35 @@ void qmp_cmd_async(const char *cmd)
>      qtest_qmp_send(global_qtest, "{'execute':%s}", cmd);
>  }
>
> +static void qmp_args_dict_async(const char *cmd, QDict *args)
> +{
> +    assert(args);
> +    qtest_qmp_send(global_qtest, "{'execute':%s, 'arguments':%p}", cmd, args);
> +}
> +
> +QDict *qmp_args(const char *cmd, const char *fmt, ...)
> +{
> +    va_list ap;
> +    QObject *obj;
> +
> +    va_start(ap, fmt);
> +    obj = qobject_from_jsonv(fmt, ap);
> +    va_end(ap);
> +    qmp_args_dict_async(cmd, qobject_to_qdict(obj));
> +    return qtest_qmp_receive(global_qtest);
> +}
> +
> +void qmp_args_async(const char *cmd, const char *fmt, ...)
> +{
> +    va_list ap;
> +    QObject *obj;
> +
> +    va_start(ap, fmt);
> +    obj = qobject_from_jsonv(fmt, ap);
> +    va_end(ap);
> +    qmp_args_dict_async(cmd, qobject_to_qdict(obj));
> +}
> +

I don't like the qmp_args name.  It's not about arguments, it's about
sending a command with arguments.

I'm afraid I'm getting pretty thorougly confused by the evolving
interface.  So I stop and think how it should look like when done.

We need send and receive.  Convenience functions to do both, and to
receive and throw away are nice to have.

We need qmp_raw().  We haven't found a need for a raw receive function.

Convenience functions to build commands and send are nice to have.  They
come in pairs, without arguments, to avoid -Wno-format-zero-length
(aside: that's one of the sillier warnings).

We used to have almost everything with and without QTestState, but we're
refusing to continue that self-flagellation.

For every function taking ..., we want one taking va_list.

Makes sense?

Can we derive a sensible set of function names from this?

[...]
