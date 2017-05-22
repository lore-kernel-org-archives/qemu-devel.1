Received: from eggs.gnu.org ([2001:4830:134:3::10]:54815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dChhR-00049s-JV
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dChhO-0008G3-FO
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:24:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1495238065-15846-1-git-send-email-thuth@redhat.com>
Date: Mon, 22 May 2017 09:24:10 +0200
In-Reply-To: <1495238065-15846-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Sat, 20 May 2017 01:54:25 +0200")
Message-ID: <87r2zh2w2t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tests/libqtest: Print error instead of
 aborting when env variable is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> When you currently try to run a test directly from the command line
> without setting the QTEST_QEMU_BINARY environment variable first,
> you are presented with an unhelpful assertion message like this:
>
>  ERROR:tests/libqtest.c:163:qtest_init_without_qmp_handshake:
>  assertion failed: (qemu_binary != NULL)
>  Aborted (core dumped)
>
> Let's replace the assert() with a more user friendly error message
> instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqtest.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 84ecbd2..f0fd682 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -160,7 +160,11 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>      const char *qemu_binary;
>  
>      qemu_binary = getenv("QTEST_QEMU_BINARY");
> -    g_assert(qemu_binary != NULL);
> +    if (!qemu_binary) {
> +        fprintf(stderr, "The environment variable QTEST_QEMU_BINARY has to be "
> +                        "set before running the test.\n");

Nitpick: error messages usually don't end with a period.

I'm fine with the message itself, although I'd have written somehing
more laconic like "Environment variable QTEST_QEMU_BINARY required".
Your choice.

> +        exit(1);
> +    }
>  
>      s = g_malloc(sizeof(*s));

Reviewed-by: Markus Armbruster <armbru@redhat.com>
