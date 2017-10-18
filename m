Received: from eggs.gnu.org ([2001:4830:134:3::10]:54262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4tjY-0004Dx-OL
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 15:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4tjV-00037G-Bn
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 15:10:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e4tjV-00034q-2E
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 15:10:25 -0400
Date: Wed, 18 Oct 2017 20:09:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171018190953.GF2339@work-vm>
References: <1507202170-22619-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171005111625eucas1p28ad35b246e6f964ca7d642cfa60df10d@eucas1p2.samsung.com>
	<1507202170-22619-6-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507202170-22619-6-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v11 5/6] migration: add blocktime
 calculation into postcopy-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> This patch just requests blocktime calculation,
> and check it in case when UFFD_FEATURE_THREAD_ID feature is set
> on the host.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(I preferred the bool got_stop and explicitly initialising it, because
if we add a 2nd test then it gets reset OK).

Dave
> ---
>  tests/postcopy-test.c | 63 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
> index 8142f2a..4231cce 100644
> --- a/tests/postcopy-test.c
> +++ b/tests/postcopy-test.c
> @@ -24,7 +24,8 @@
>  
>  const unsigned start_address = 1024 * 1024;
>  const unsigned end_address = 100 * 1024 * 1024;
> -bool got_stop;
> +static bool got_stop;
> +static bool uffd_feature_thread_id;
>  
>  #if defined(__linux__)
>  #include <sys/syscall.h>
> @@ -54,6 +55,7 @@ static bool ufd_version_check(void)
>          g_test_message("Skipping test: UFFDIO_API failed");
>          return false;
>      }
> +    uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
>  
>      ioctl_mask = (__u64)1 << _UFFDIO_REGISTER |
>                   (__u64)1 << _UFFDIO_UNREGISTER;
> @@ -265,22 +267,48 @@ static uint64_t get_migration_pass(void)
>      return result;
>  }
>  
> -static void wait_for_migration_complete(void)
> +static bool get_src_status(void)
>  {
>      QDict *rsp, *rsp_return;
> +    const char *status;
> +    bool result;
> +
> +    rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
> +    rsp_return = qdict_get_qdict(rsp, "return");
> +    status = qdict_get_str(rsp_return, "status");
> +    g_assert_cmpstr(status, !=,  "failed");
> +    result = strcmp(status, "completed") == 0;
> +    QDECREF(rsp);
> +    return result;
> +}
> +
> +static void read_blocktime(void)
> +{
> +    QDict *rsp, *rsp_return;
> +
> +    rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
> +    rsp_return = qdict_get_qdict(rsp, "return");
> +    g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
> +    QDECREF(rsp);
> +}
> +
> +static void wait_for_migration_complete(QTestState *from, QTestState *to)
> +{
>      bool completed;
>  
>      do {
> -        const char *status;
> -
> -        rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
> -        rsp_return = qdict_get_qdict(rsp, "return");
> -        status = qdict_get_str(rsp_return, "status");
> -        completed = strcmp(status, "completed") == 0;
> -        g_assert_cmpstr(status, !=,  "failed");
> -        QDECREF(rsp);
> +
> +        /* test src state */
> +        global_qtest = from;
> +        completed = get_src_status();
> +
>          usleep(1000 * 100);
>      } while (!completed);
> +
> +    if (uffd_feature_thread_id) {
> +        global_qtest = to;
> +        read_blocktime();
> +    }
>  }
>  
>  static void wait_for_migration_pass(void)
> @@ -364,8 +392,6 @@ static void test_migrate(void)
>      char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
>      const char *arch = qtest_get_arch();
>  
> -    got_stop = false;
> -
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          init_bootfile_x86(bootpath);
>          cmd_src = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
> @@ -425,6 +451,15 @@ static void test_migrate(void)
>      g_assert(qdict_haskey(rsp, "return"));
>      QDECREF(rsp);
>  
> +    global_qtest = to;
> +    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
> +                  "'arguments': { "
> +                      "'capabilities': [ {"
> +                          "'capability': 'postcopy-blocktime',"
> +                          "'state': true } ] } }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
>      /* We want to pick a speed slow enough that the test completes
>       * quickly, but that it doesn't complete precopy even on a slow
>       * machine, so also set the downtime.
> @@ -441,7 +476,6 @@ static void test_migrate(void)
>      g_assert(qdict_haskey(rsp, "return"));
>      QDECREF(rsp);
>  
> -
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> @@ -467,8 +501,7 @@ static void test_migrate(void)
>      qmp_eventwait("RESUME");
>  
>      wait_for_serial("dest_serial");
> -    global_qtest = from;
> -    wait_for_migration_complete();
> +    wait_for_migration_complete(from, to);
>  
>      qtest_quit(from);
>  
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
