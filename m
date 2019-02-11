Received: from eggs.gnu.org ([209.51.188.92]:53946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtBTD-0008Dx-Pe
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtBT8-0002iD-Dw
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:17:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gtBT8-0002hp-5C
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:17:54 -0500
Date: Mon, 11 Feb 2019 13:17:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190211131731.GE2627@work-vm>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
	<20190204130958.18904-4-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204130958.18904-4-yury-kotov@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] tests/migration-test: Add a test
 for ignore-shared capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, wrfsh@yandex-team.ru

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  tests/migration-test.c | 109 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 89 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 8352612364..485f42b2d2 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -332,6 +332,13 @@ static void cleanup(const char *filename)
>      g_free(path);
>  }
>  
> +static char *get_shmem_opts(const char *mem_size, const char *shmem_path)
> +{
> +    return g_strdup_printf("-object memory-backend-file,id=mem0,size=%s"
> +                           ",mem-path=%s,share=on -numa node,memdev=mem0",
> +                           mem_size, shmem_path);
> +}
> +
>  static void migrate_check_parameter(QTestState *who, const char *parameter,
>                                      long long value)
>  {
> @@ -430,73 +437,91 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
>  }
>  
>  static int test_migrate_start(QTestState **from, QTestState **to,
> -                               const char *uri, bool hide_stderr)
> +                               const char *uri, bool hide_stderr,
> +                               bool use_shmem)
>  {
>      gchar *cmd_src, *cmd_dst;
>      char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
> +    char *extra_opts = NULL;
> +    char *shmem_path = NULL;
>      const char *arch = qtest_get_arch();
>      const char *accel = "kvm:tcg";
>  
>      got_stop = false;
>  
> +    if (use_shmem) {
> +        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
> +    }

I think /dev/shm is non-portable; so I think you'll need to have a way
to skip the test on OSs that don't have it.

>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          init_bootfile(bootpath, x86_bootsect);
> +        extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
>          cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name source,debug-threads=on"
>                                    " -serial file:%s/src_serial"
> -                                  " -drive file=%s,format=raw",
> -                                  accel, tmpfs, bootpath);
> +                                  " -drive file=%s,format=raw %s",
> +                                  accel, tmpfs, bootpath,
> +                                  extra_opts ? extra_opts : "");

It's painful to have to use the ?: here as well as above where you set
extra_opts, but I guess you need to, to allow you to free extra_opts
below.

>          cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name target,debug-threads=on"
>                                    " -serial file:%s/dest_serial"
>                                    " -drive file=%s,format=raw"
> -                                  " -incoming %s",
> -                                  accel, tmpfs, bootpath, uri);
> +                                  " -incoming %s %s",
> +                                  accel, tmpfs, bootpath, uri,
> +                                  extra_opts ? extra_opts : "");
>          start_address = X86_TEST_MEM_START;
>          end_address = X86_TEST_MEM_END;
>      } else if (g_str_equal(arch, "s390x")) {
>          init_bootfile_s390x(bootpath);
> +        extra_opts = use_shmem ? get_shmem_opts("128M", shmem_path) : NULL;
>          cmd_src = g_strdup_printf("-machine accel=%s -m 128M"
>                                    " -name source,debug-threads=on"
> -                                  " -serial file:%s/src_serial -bios %s",
> -                                  accel, tmpfs, bootpath);
> +                                  " -serial file:%s/src_serial -bios %s %s",
> +                                  accel, tmpfs, bootpath,
> +                                  extra_opts ? extra_opts : "");
>          cmd_dst = g_strdup_printf("-machine accel=%s -m 128M"
>                                    " -name target,debug-threads=on"
>                                    " -serial file:%s/dest_serial -bios %s"
> -                                  " -incoming %s",
> -                                  accel, tmpfs, bootpath, uri);
> +                                  " -incoming %s %s",
> +                                  accel, tmpfs, bootpath, uri,
> +                                  extra_opts ? extra_opts : "");
>          start_address = S390_TEST_MEM_START;
>          end_address = S390_TEST_MEM_END;
>      } else if (strcmp(arch, "ppc64") == 0) {
> +        extra_opts = use_shmem ? get_shmem_opts("256M", shmem_path) : NULL;
>          cmd_src = g_strdup_printf("-machine accel=%s -m 256M -nodefaults"
>                                    " -name source,debug-threads=on"
>                                    " -serial file:%s/src_serial"
>                                    " -prom-env 'use-nvramrc?=true' -prom-env "
>                                    "'nvramrc=hex .\" _\" begin %x %x "
>                                    "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
> -                                  "until'",  accel, tmpfs, end_address,
> -                                  start_address);
> +                                  "until' %s",  accel, tmpfs, end_address,
> +                                  start_address, extra_opts ? extra_opts : "");
>          cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
>                                    " -name target,debug-threads=on"
>                                    " -serial file:%s/dest_serial"
> -                                  " -incoming %s",
> -                                  accel, tmpfs, uri);
> +                                  " -incoming %s %s",
> +                                  accel, tmpfs, uri,
> +                                  extra_opts ? extra_opts : "");
>  
>          start_address = PPC_TEST_MEM_START;
>          end_address = PPC_TEST_MEM_END;
>      } else if (strcmp(arch, "aarch64") == 0) {
>          init_bootfile(bootpath, aarch64_kernel);
> +        extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
>          cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
>                                    "-name vmsource,debug-threads=on -cpu max "
>                                    "-m 150M -serial file:%s/src_serial "
> -                                  "-kernel %s ",
> -                                  accel, tmpfs, bootpath);
> +                                  "-kernel %s %s",
> +                                  accel, tmpfs, bootpath,
> +                                  extra_opts ? extra_opts : "");
>          cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
>                                    "-name vmdest,debug-threads=on -cpu max "
>                                    "-m 150M -serial file:%s/dest_serial "
>                                    "-kernel %s "
> -                                  "-incoming %s ",
> -                                  accel, tmpfs, bootpath, uri);
> +                                  "-incoming %s %s",
> +                                  accel, tmpfs, bootpath, uri,
> +                                  extra_opts ? extra_opts : "");
>  
>          start_address = ARM_TEST_MEM_START;
>          end_address = ARM_TEST_MEM_END;
> @@ -507,6 +532,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      }
>  
>      g_free(bootpath);
> +    g_free(extra_opts);
>  
>      if (hide_stderr) {
>          gchar *tmp;
> @@ -524,6 +550,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>  
>      *to = qtest_init(cmd_dst);
>      g_free(cmd_dst);
> +
> +    /*
> +     * Remove shmem file immediately to avoid memory leak in test failed case.
> +     * It's valid becase QEMU has already opened this file
> +     */
> +    if (use_shmem) {
> +        unlink(shmem_path);
> +        g_free(shmem_path);
> +    }
> +
>      return 0;
>  }
>  
> @@ -603,7 +639,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>  
> -    if (test_migrate_start(&from, &to, uri, hide_error)) {
> +    if (test_migrate_start(&from, &to, uri, hide_error, false)) {
>          return -1;
>      }
>  
> @@ -720,7 +756,7 @@ static void test_baddest(void)
>      char *status;
>      bool failed;
>  
> -    if (test_migrate_start(&from, &to, "tcp:0:0", true)) {
> +    if (test_migrate_start(&from, &to, "tcp:0:0", true, false)) {
>          return;
>      }
>      migrate(from, "tcp:0:0", "{}");
> @@ -745,7 +781,7 @@ static void test_precopy_unix(void)
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>  
> -    if (test_migrate_start(&from, &to, uri, false)) {
> +    if (test_migrate_start(&from, &to, uri, false, false)) {
>          return;
>      }
>  
> @@ -781,6 +817,38 @@ static void test_precopy_unix(void)
>      g_free(uri);
>  }
>  
> +static void test_ignore_shared(void)
> +{
> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +    QTestState *from, *to;
> +
> +    if (test_migrate_start(&from, &to, uri, false, true)) {
> +        return;
> +    }
> +
> +    migrate_set_capability(from, "x-ignore-shared", true);
> +    migrate_set_capability(to, "x-ignore-shared", true);
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    migrate(from, uri, "{}");
> +
> +    wait_for_migration_pass(from);
> +
> +    if (!got_stop) {
> +        qtest_qmp_eventwait(from, "STOP");
> +    }
> +
> +    qtest_qmp_eventwait(to, "RESUME");
> +
> +    wait_for_serial("dest_serial");
> +    wait_for_migration_complete(from);
> +
> +    test_migrate_end(from, to, true);
> +    g_free(uri);

Can we reliably look at the migration stats and see if we've
not transferred the shared data to make sure?

Dave

> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -832,6 +900,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/deprecated", test_deprecated);
>      qtest_add_func("/migration/bad_dest", test_baddest);
>      qtest_add_func("/migration/precopy/unix", test_precopy_unix);
> +    qtest_add_func("/migration/ignore_shared", test_ignore_shared);
>  
>      ret = g_test_run();
>  
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
