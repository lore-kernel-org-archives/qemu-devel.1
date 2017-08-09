Received: from eggs.gnu.org ([2001:4830:134:3::10]:50045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfT6Y-0000sR-LI
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfT6X-0004mz-B2
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:41:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-17-eblake@redhat.com>
Date: Wed, 09 Aug 2017 17:40:52 +0200
In-Reply-To: <20170804012551.2714-17-eblake@redhat.com> (Eric Blake's message
	of "Thu, 3 Aug 2017 20:25:45 -0500")
Message-ID: <87zib8n3zv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 16/22] libqtest: Add qmp_cmd() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, "open
	list:IDE" <qemu-block@nongnu.org>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Eric Blake <eblake@redhat.com> writes:

> Now that we've asserted that all of our interpolated QMP commands
> include 'execute', we can reduce some of the caller boilerplate
> by providing a helpr function to wrap commands with no arguments

helper

I don't get the dependency on asserting "contains 'execute'".

> (later patches will cover commands with arguments).
>
> Adjust all callers that can use the new helpers; in the process,
> fixing a couple of places where we would have failed
> -Wformat-nonliteral.  Likewise, libqos.c no longer needs
> qmp_execute(), which in turn fixes the fact that it is better
> to interpolate JSON strings through qobject_from_json() than
> through sprintf().
>
> The current name is long, but temporary: later patches will
> remove all other uses of qmp(), and then make the mass rename
> of qmp_cmd() down to qmp().
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h               | 16 ++++++++++++++++
>  tests/libqtest.c               | 13 ++++++++++++-
>  tests/ahci-test.c              |  4 +---
>  tests/boot-order-test.c        |  2 +-
>  tests/ide-test.c               |  2 +-
>  tests/libqos/ahci.c            |  4 ++--
>  tests/libqos/libqos.c          | 16 ++--------------
>  tests/numa-test.c              |  2 +-
>  tests/postcopy-test.c          |  8 ++++----
>  tests/q35-test.c               |  2 +-
>  tests/qmp-test.c               |  8 ++++----
>  tests/qom-test.c               |  2 +-
>  tests/test-filter-mirror.c     |  2 +-
>  tests/test-filter-redirector.c |  4 ++--
>  tests/test-x86-cpuid-compat.c  |  2 +-
>  tests/virtio-net-test.c        | 13 ++++++-------
>  tests/vmgenid-test.c           |  2 +-
>  tests/wdt_ib700-test.c         |  2 +-
>  18 files changed, 58 insertions(+), 46 deletions(-)
>
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 684cfb3507..e0d87d035a 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -483,6 +483,22 @@ QDict *qmp_raw(const char *msg);
>  void qmp_async(const char *fmt, ...);
>
>  /**
> + * qmp_cmd:
> + * @cmd: QMP command, with no arguments.
> + *
> + * Sends a QMP message to QEMU and returns the response.
> + */
> +QDict *qmp_cmd(const char *cmd);
> +
> +/**
> + * qmp_cmd_async:
> + * @cmd: QMP command, with no arguments.
> + *
> + * Sends a QMP message to QEMU and leaves the response in the stream.
> + */
> +void qmp_cmd_async(const char *cmd);
> +
> +/**
>   * qmp_discard_response:
>   *
>   * Read and discard a QMP response, typically after qmp_async().
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 2df01682c0..3926a4d481 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -858,6 +858,17 @@ void qmp_async(const char *fmt, ...)
>      va_end(ap);
>  }
>
> +QDict *qmp_cmd(const char *cmd)
> +{
> +    qmp_cmd_async(cmd);
> +    return qtest_qmp_receive(global_qtest);
> +}
> +
> +void qmp_cmd_async(const char *cmd)
> +{
> +    qtest_qmp_send(global_qtest, "{'execute':%s}", cmd);
> +}
> +

Hmm.  A possibly saner naming scheme:

    FOO_send(): send a command
    FOO_receive(): receive a reply
    FOO: both

>  void qmp_discard_response(void)
>  {
>      QDict *response = qtest_qmp_receive(global_qtest);
[...]
