Received: from eggs.gnu.org ([2001:4830:134:3::10]:34707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcdVS-000862-9C
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcdVN-00025z-CG
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:15:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fcdVN-00025Y-6n
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:15:33 -0400
References: <20180706143105.93472-1-dgilbert@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <43caff66-b806-cef7-3b4a-0ca1d875f8ec@redhat.com>
Date: Mon, 9 Jul 2018 23:15:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180706143105.93472-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] tests/migration: Skip tests for ppc
 tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, quintela@redhat.com, lvivier@redhat.com

On 06.07.2018 16:31, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> PPC tcg seems to be failing migration tests quite regularly;
> we believe this is TCG bugs in dirty bit updating; it's
> not clear why PPC fails more but lets skip for the moment.
> 
> $ ./tests/migration-test
> /ppc64/migration/deprecated: OK
> /ppc64/migration/bad_dest: Skipping test: kvm_hv not available OK
> /ppc64/migration/postcopy/unix: Skipping test: kvm_hv not available OK
> /ppc64/migration/precopy/unix: Skipping test: kvm_hv not available OK
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/migration-test.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> v2
>   use a print rather than g_test_skip since gtester is broken in
> some version
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 3a85446f95..331efb0fe5 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -360,7 +360,7 @@ static void migrate_start_postcopy(QTestState *who)
>      qobject_unref(rsp);
>  }
>  
> -static void test_migrate_start(QTestState **from, QTestState **to,
> +static int test_migrate_start(QTestState **from, QTestState **to,
>                                 const char *uri, bool hide_stderr)
>  {
>      gchar *cmd_src, *cmd_dst;
> @@ -385,9 +385,13 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>                                    accel, tmpfs, bootpath, uri);
>      } else if (strcmp(arch, "ppc64") == 0) {
>  
> -        /* On ppc64, the test only works with kvm-hv, but not with kvm-pr */
> +        /* On ppc64, the test only works with kvm-hv, but not with kvm-pr
> +         * and TCG is touchy due to race conditions on dirty bits
> +         * (especially on PPC for some reason)
> +         */
>          if (access("/sys/module/kvm_hv", F_OK)) {
> -            accel = "tcg";
> +            g_print("Skipping test: kvm_hv not available ");
> +            return -1;

That "Skipping test: ..." message is now popping up a couple of times
during "make check-qtest" here on my x86 laptop. That's kind of ugly.
Could you maybe turn that into a g_debug() instead?

 Thomas
