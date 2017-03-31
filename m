Received: from eggs.gnu.org ([2001:4830:134:3::10]:47469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ctwfS-0001VK-KT
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ctwfP-0005LS-CW
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:32:42 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ctwfP-0005LG-8t
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:32:39 -0400
Received: by mail-qk0-x243.google.com with SMTP id 10so10423644qkh.1
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 06:32:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <55b16636-c7ba-def8-53e1-6fc0ec0ca36d@amsat.org>
Date: Fri, 31 Mar 2017 10:32:35 -0300
MIME-Version: 1.0
In-Reply-To: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, patches@linaro.org

On 03/31/2017 09:36 AM, Peter Maydell wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
>
