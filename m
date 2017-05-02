Received: from eggs.gnu.org ([2001:4830:134:3::10]:35586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d5awt-0004XN-DC
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d5awq-0003bg-9R
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:46:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34923
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d5awq-0003Yk-2n
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:46:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42GhvHL061859
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 12:46:46 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a6tn9bqp4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:46:46 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 2 May 2017 12:46:45 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170427215821.19397-11-eblake@redhat.com>
References: <20170427215821.19397-1-eblake@redhat.com>
	<20170427215821.19397-11-eblake@redhat.com>
Date: Tue, 02 May 2017 11:46:36 -0500
Message-Id: <149374359665.32299.11589637295145834940@loki>
Subject: Re: [Qemu-devel] [PATCH v5 10/10] test-qga: Actually test 0xff sync
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

Quoting Eric Blake (2017-04-27 16:58:21)
> Commit 62c39b3 introduced test-qga, and at face value, appears
> to be testing the 'guest-sync' behavior that is recommended for
> guests in sending 0xff to QGA to force the parser to reset.  But
> this aspect of the test has never actually done anything: the
> qmp_fd() call chain converts its string argument into QObject,
> then converts that QObject back to the actual string that is
> sent over the wire - and the conversion process silently drops
> the 0xff byte from the string sent to QGA, thus never resetting
> the QGA parser.
> =

> An upcoming patch will get rid of the wasteful round trip
> through QObject, at which point the string in test-qga will be
> directly sent over the wire.
> =

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

The full re-sync sequence is actually to perform that process,
check if the response matches the client-provided sync token,
and then repeat the procedure if it doesn't (in the odd case
that a previous client initiated a guest-sync-delimited
sequence and never consumed the response). The current
implementation only performs one iteration so it's not quite
a full implementation of the documentation procedure.

For the immediate purpose of improving the handling to deal
with the 0xFF-generated error the patch seems sound though,
maybe just something worth noting in the commit msg or
comments so that we might eventually test the full procedure.

In any case:

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> =

> Ideally, we'd fix the QGA JSON parser to silently ignore 0xff
> rather than sending an error message back, at which point we
> could enhance this test for 'guest-sync' as well as for
> 'guest-sync-delimited'.  But for the sake of this patch, our
> testing of 'guest-sync' is no worse than it was pre-patch,
> because we have never been sending 0xff over the wire in the
> first place.
> =

> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> =

> ---
> v5: add R-b
> v4: no change
> v3: use inline \xff byte rather than %c, add comment
> ---
>  tests/libqtest.c |  8 ++++++++
>  tests/test-qga.c | 34 +++++++++++++++++++++++++++-------
>  2 files changed, 35 insertions(+), 7 deletions(-)
> =

> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 512c150..84ecbd2 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -446,6 +446,14 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list a=
p)
>      va_list ap_copy;
>      QObject *qobj;
> =

> +    /* qobject_from_jsonv() silently eats leading 0xff as invalid
> +     * JSON, but we want to test sending them over the wire to force
> +     * resyncs */
> +    if (*fmt =3D=3D '\377') {
> +        socket_send(fd, fmt, 1);
> +        fmt++;
> +    }
> +
>      /* Going through qobject ensures we escape strings properly.
>       * This seemingly unnecessary copy is required in case va_list
>       * is an array type.
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index c780f00..438c2e7 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -146,14 +146,23 @@ static void test_qga_sync_delimited(gconstpointer f=
ix)
>      QDict *ret;
>      gchar *cmd;
> =

> -    cmd =3D g_strdup_printf("%c{'execute': 'guest-sync-delimited',"
> -                          " 'arguments': {'id': %u } }", 0xff, r);
> +    cmd =3D g_strdup_printf("\xff{'execute': 'guest-sync-delimited',"
> +                          " 'arguments': {'id': %u } }", r);
>      qmp_fd_send(fixture->fd, cmd);
>      g_free(cmd);
> =

> -    v =3D read(fixture->fd, &c, 1);
> -    g_assert_cmpint(v, =3D=3D, 1);
> -    g_assert_cmpint(c, =3D=3D, 0xff);
> +    /*
> +     * Read and ignore garbage until resynchronized.
> +     *
> +     * TODO: The server shouldn't emit so much garbage (among other
> +     * things, it loudly complains about the client's \xff being
> +     * invalid JSON, even though it is a documented part of the
> +     * handshake.
> +     */
> +    do {
> +        v =3D read(fixture->fd, &c, 1);
> +        g_assert_cmpint(v, =3D=3D, 1);
> +    } while (c !=3D 0xff);
> =

>      ret =3D qmp_fd_receive(fixture->fd);
>      g_assert_nonnull(ret);
> @@ -172,8 +181,19 @@ static void test_qga_sync(gconstpointer fix)
>      QDict *ret;
>      gchar *cmd;
> =

> -    cmd =3D g_strdup_printf("%c{'execute': 'guest-sync',"
> -                          " 'arguments': {'id': %u } }", 0xff, r);
> +    /*
> +     * TODO guest-sync is inherently limited: we cannot distinguish
> +     * failure caused by reacting to garbage on the wire prior to this
> +     * command, from failure of this actual command. Clients are
> +     * supposed to be able to send a raw '\xff' byte to at least
> +     * re-synchronize the server's parser prior to this command, but
> +     * we are not in a position to test that here because (at least
> +     * for now) it causes the server to issue an error message about
> +     * invalid JSON. Testing of '\xff' handling is done in
> +     * guest-sync-delimited instead.
> +     */
> +    cmd =3D g_strdup_printf("{'execute': 'guest-sync',"
> +                          " 'arguments': {'id': %u } }", r);
>      ret =3D qmp_fd(fixture->fd, cmd);
>      g_free(cmd);
> =

> -- =

> 2.9.3
> =

>=20
