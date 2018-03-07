Received: from eggs.gnu.org ([2001:4830:134:3::10]:46964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etRLl-00056J-DC
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 00:10:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etRLg-0002Mu-E6
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 00:10:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etRLg-0002Mf-9I
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 00:10:44 -0500
Date: Wed, 7 Mar 2018 13:10:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307051029.GG17720@xz-mi>
References: <20180306173042.24572-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306173042.24572-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Silence migration-test 'bad' test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peter.maydell@linaro.org

On Tue, Mar 06, 2018 at 05:30:42PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> In 2c9bb29703c I added a migration test that purposely fails;
> unfortunately it prints a copy of the failure message to stderr
> which makes the output a bit messy.
> 
> Hide stderr for that test.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/migration-test.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 74f9361bdd..422bf1afdf 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -382,7 +382,7 @@ static void migrate_start_postcopy(QTestState *who)
>  }
>  
>  static void test_migrate_start(QTestState **from, QTestState **to,
> -                               const char *uri)
> +                               const char *uri, bool hide_stderr)
>  {
>      gchar *cmd_src, *cmd_dst;
>      char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
> @@ -427,6 +427,17 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>  
>      g_free(bootpath);
>  
> +    if (hide_stderr) {
> +        gchar *tmp;
> +        tmp = g_strdup_printf("%s 2>/dev/null", cmd_src);
> +        g_free(cmd_src);
> +        cmd_src = tmp;
> +
> +        tmp = g_strdup_printf("%s 2>/dev/null", cmd_dst);
> +        g_free(cmd_dst);
> +        cmd_dst = tmp;

I thought this would affect QTEST_LOG in
qtest_init_without_qmp_handshake() but I was wrong.  I think that's
because that "/dev/fd/2" is a string passed to QEMU process, so only
the stderr of test process is closed while we kept the QTEST_LOG
there, which seems to be ideal.

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
