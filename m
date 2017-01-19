Received: from eggs.gnu.org ([2001:4830:134:3::10]:44470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU9Hc-0000rV-Ku
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU9HZ-0003W7-IW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:45:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cU9HZ-0003VH-As
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:45:25 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76AEB7F368
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:45:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-6-eblake@redhat.com>
Date: Thu, 19 Jan 2017 10:45:22 +0100
In-Reply-To: <20170118161653.19296-6-eblake@redhat.com> (Eric Blake's message
	of "Wed, 18 Jan 2017 10:16:52 -0600")
Message-ID: <878tq7fknh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 5/6] test-qga: Actually test 0xff sync
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> Commit 62c39b3 introduced test-qga, and at face value, appears
> to be testing the 'guest-sync' behavior that is recommended for
> guests in sending 0xff to QGA to force the parser to reset.  But
> this aspect of the test has never actually done anything: the
> qmp_fd() call chain converts its string argument into QObject,
> then converts that QObject back to the actual string that is
> sent over the wire - and the conversion process silently drops
> the 0xff byte from the string sent to QGA,

This isn't immediately obvious from the code, but I assume you observed
it carefully.

>                                            thus never resetting
> the QGA parser.
>
> An upcoming patch will get rid of the wasteful round trip
> through QObject, at which point the string in test-qga will be
> directly sent over the wire.
>
> But fixing qmp_fd() to actually send 0xff over the wire is not
> all we have to do - the actual QMP parser loudly complains that
> 0xff is not valid JSON, and sends an error message _prior_ to
> actually parsing the 'guest-sync' or 'guest-sync-delimited'
> command.  With 'guest-sync', we cannot easily tell if this error
> message is a result of our command - which is WHY we invented
> the 'guest-sync-delimited' command.  So for the testsuite, fix
> things to only check 0xff behavior on 'guest-sync-delimited',
> and to loop until we've consumed all garbage prior to the
> requested delimiter, which matches the documented actions that
> a real QGA client is supposed to do.
>
> Ideally, we'd fix the QGA JSON parser to silently ignore 0xff
> rather than sending an error message back, at which point we
> could enhance this test for 'guest-sync' as well as for
> 'guest-sync-delimited'.  But for the sake of this patch, our
> testing of 'guest-sync' is no worse than it was pre-patch,
> because we have never been sending 0xff over the wire in the
> first place.

Is this worth a TODO comment, perhaps in test_qga_sync()?

>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.c |  8 ++++++++
>  tests/test-qga.c | 12 +++++++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index d8fba66..3912e3e 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -430,6 +430,14 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>      va_list ap_copy;
>      QObject *qobj;
>
> +    /* qobject_from_jsonv() silently eats leading 0xff as invalid
> +     * JSON, but we want to test sending them over the wire to force
> +     * resyncs */
> +    if (*fmt == '\377') {
> +        socket_send(fd, fmt, 1);
> +        fmt++;
> +    }
> +
>      /* Going through qobject ensures we escape strings properly.
>       * This seemingly unnecessary copy is required in case va_list
>       * is an array type.
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index 868b02a..4b64630 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -151,9 +151,11 @@ static void test_qga_sync_delimited(gconstpointer fix)
       cmd = g_strdup_printf("%c{'execute': 'guest-sync-delimited',"
                             " 'arguments': {'id': %u } }", 0xff, r);

Simplification opportunity:

       cmd = g_strdup_printf("\xff{'execute': 'guest-sync-delimited',"
                             " 'arguments': {'id': %u } }", r);

>      qmp_fd_send(fixture->fd, cmd);
>      g_free(cmd);
>
> -    v = read(fixture->fd, &c, 1);
> -    g_assert_cmpint(v, ==, 1);
> -    g_assert_cmpint(c, ==, 0xff);
> +    /* Read and ignore garbage until resynchronized */
> +    do {
> +        v = read(fixture->fd, &c, 1);
> +        g_assert_cmpint(v, ==, 1);
> +    } while (c != 0xff);

Slow as molasses, but it'll do for this test.

>
>      ret = qmp_fd_receive(fixture->fd);
>      g_assert_nonnull(ret);
> @@ -172,8 +174,8 @@ static void test_qga_sync(gconstpointer fix)
>      QDict *ret;
>      gchar *cmd;
>
> -    cmd = g_strdup_printf("%c{'execute': 'guest-sync',"
> -                          " 'arguments': {'id': %u } }", 0xff, r);
> +    cmd = g_strdup_printf("{'execute': 'guest-sync',"
> +                          " 'arguments': {'id': %u } }", r);
>      ret = qmp_fd(fixture->fd, cmd);
>      g_free(cmd);

Reviewed-by: Markus Armbruster <armbru@redhat.com>
