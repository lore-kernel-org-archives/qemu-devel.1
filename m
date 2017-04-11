Received: from eggs.gnu.org ([2001:4830:134:3::10]:33731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxxVT-0001n2-Vl
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxxVQ-0000oN-Qe
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cxxVQ-0000nn-KU
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:14:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 17:14:53 +0200
In-Reply-To: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
	(Peter Maydell's message of "Fri, 31 Mar 2017 13:36:41 +0100")
Message-ID: <87lgr77z82.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tests/libqtest.c: Delete possible stale
 unix sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org

Peter Maydell <peter.maydell@linaro.org> writes:

> Occasionally if a test crashes or is interrupted by the user
> at the wrong moment it could leave behind a stale UNIX
> socket in /tmp/. This will then cause a subsequent test
> run to fail spuriously with
>  tests/libqtest.c:70:init_socket: assertion failed (ret != -1): (-1 != -1)
> if it happens to reuse the same PID.
>
> Defend against this by deleting any stray stale socket before
> trying to open the new ones for this test.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This seems like an easy way to shut up this infrequent but irritating
> error case...
>
>  tests/libqtest.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index a5c3d2b..99b1195 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -167,6 +167,14 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>      socket_path = g_strdup_printf("/tmp/qtest-%d.sock", getpid());
>      qmp_socket_path = g_strdup_printf("/tmp/qtest-%d.qmp", getpid());
>  
> +    /* It's possible that if an earlier test run crashed it might
> +     * have left a stale unix socket lying around. Delete any
> +     * stale old socket to avoid spurious test failures with
> +     * tests/libqtest.c:70:init_socket: assertion failed (ret != -1): (-1 != -1)
> +     */
> +    unlink(socket_path);
> +    unlink(qmp_socket_path);
> +
>      sock = init_socket(socket_path);
>      qmpsock = init_socket(qmp_socket_path);

No objection to this work-around for tests leaving crap behind, but I
think we should also try harder not to leave crap behind.  Say give each
test its own scratch directory, make sure no test writes outside it, and
have the harness remove it afterwards.
