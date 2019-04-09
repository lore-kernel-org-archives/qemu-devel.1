Received: from eggs.gnu.org ([209.51.188.92]:53581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDml7-0004JB-ED
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDml5-0003Rg-FK
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:09:37 -0400
Date: Tue, 9 Apr 2019 10:09:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190409090922.GC2964@work-vm>
References: <20190409085245.31548-1-thuth@redhat.com>
	<20190409085245.31548-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409085245.31548-5-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1 4/5] tests/test-hmp: Use
 qtest_init() instead of qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, Hannes Reinecke <hare@suse.com>

* Thomas Huth (thuth@redhat.com) wrote:
> qtest_start() + qtest_end() should be avoided, since they use the
> global_qtest variable that we want to get rid of in the long run
> Use qtest_init() and qtest_quit() instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/test-hmp.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 54a01824dc..f0d843e34a 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -72,13 +72,13 @@ static const char *hmp_cmds[] = {
>  };
>  
>  /* Run through the list of pre-defined commands */
> -static void test_commands(void)
> +static void test_commands(QTestState *qts)
>  {
>      char *response;
>      int i;
>  
>      for (i = 0; hmp_cmds[i] != NULL; i++) {
> -        response = hmp("%s", hmp_cmds[i]);
> +        response = qtest_hmp(qts, "%s", hmp_cmds[i]);
>          if (verbose) {
>              fprintf(stderr,
>                      "\texecute HMP command: %s\n"
> @@ -91,11 +91,11 @@ static void test_commands(void)
>  }
>  
>  /* Run through all info commands and call them blindly (without arguments) */
> -static void test_info_commands(void)
> +static void test_info_commands(QTestState *qts)
>  {
>      char *resp, *info, *info_buf, *endp;
>  
> -    info_buf = info = hmp("help info");
> +    info_buf = info = qtest_hmp(qts, "help info");
>  
>      while (*info) {
>          /* Extract the info command, ignore parameters and description */
> @@ -107,7 +107,7 @@ static void test_info_commands(void)
>          if (verbose) {
>              fprintf(stderr, "\t%s\n", info);
>          }
> -        resp = hmp("%s", info);
> +        resp = qtest_hmp(qts, "%s", info);
>          g_free(resp);
>          /* And move forward to the next line */
>          info = strchr(endp + 1, '\n');
> @@ -124,14 +124,15 @@ static void test_machine(gconstpointer data)
>  {
>      const char *machine = data;
>      char *args;
> +    QTestState *qts;
>  
>      args = g_strdup_printf("-S -M %s", machine);
> -    qtest_start(args);
> +    qts = qtest_init(args);
>  
> -    test_info_commands();
> -    test_commands();
> +    test_info_commands(qts);
> +    test_commands(qts);
>  
> -    qtest_end();
> +    qtest_quit(qts);
>      g_free(args);
>      g_free((void *)data);
>  }
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
