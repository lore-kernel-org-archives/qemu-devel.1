Received: from eggs.gnu.org ([2001:4830:134:3::10]:57187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePRFQ-00036Q-Om
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePRFM-0001xk-Hk
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:00:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePRFM-0001vP-Bk
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:00:12 -0500
Date: Thu, 14 Dec 2017 11:00:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171214110005.GB4458@work-vm>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
	<20171023151310.6462-5-vadim.galitsyn@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023151310.6462-5-vadim.galitsyn@profitbricks.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] tests: test-hmp: print command
 execution result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

* Vadim Galitsyn (vadim.galitsyn@profitbricks.com) wrote:
> Provide HMP monitor command execution result as it would be seen
> by user who established an HMP monitor session.
> 
> Currently many commands may silently fail without any sign of that.
> This patch let this info to be printed once test is running in
> verbose mode.
> 
> For the future it might be useful to fail the test if command has
> failed, however it would require a bit of rework inside test
> engine itself.
> 
> A simple example of silent failure without reporting it would to
> add some non-existent HMP command into 'hmp_cmds' list. In this case
> test will report it successfully passed without error.
> 
> Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: qemu-devel@nongnu.org

This test patch is useful without the rest of the series;

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued for HMP

Although I do also need to go and fix this tests idea of verbose to get
it from GTester rather than it's own env - I'll do that.

For the rest of the set, you need to convince Markus why
it's safe.

Dave


> ---
>  tests/test-hmp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 8e21eee61c..1fd8e44eff 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -79,10 +79,13 @@ static void test_commands(void)
>      int i;
>  
>      for (i = 0; hmp_cmds[i] != NULL; i++) {
> +        response = hmp("%s", hmp_cmds[i]);
>          if (verbose) {
> -            fprintf(stderr, "\t%s\n", hmp_cmds[i]);
> +            fprintf(stderr,
> +                    "\texecute HMP command: %s\n"
> +                    "\tresult             : %s\n",
> +                    hmp_cmds[i], response);
>          }
> -        response = hmp("%s", hmp_cmds[i]);
>          g_free(response);
>      }
>  
> -- 
> 2.13.1.394.g41dd433
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
