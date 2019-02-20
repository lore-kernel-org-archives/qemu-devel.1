Received: from eggs.gnu.org ([209.51.188.92]:41012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwVPt-0007m0-OW
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwVPp-00084Q-9N
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:12:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwVPl-0007zu-6c
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:12:11 -0500
Date: Wed, 20 Feb 2019 17:12:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190220171200.GL2608@work-vm>
References: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
	<20190215174548.2630-5-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215174548.2630-5-yury-kotov@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] tests/migration-test: Add a test
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, wrfsh@yandex-team.ru, jiangshanlai@gmail.com, qemu-devel@lists.ewheeler.net, peter.maydell@linaro.org

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/migration-test.c | 131 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 106 insertions(+), 25 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 8352612364..dd604c4f21 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -215,10 +215,10 @@ static gchar *migrate_query_status(QTestState *who)
>   * events suddenly appearing confuse the qmp()/hmp() responses.
>   */
>  
> -static uint64_t get_migration_pass(QTestState *who)
> +static int64_t read_ram_property_int(QTestState *who, const char *property)
>  {
>      QDict *rsp_return, *rsp_ram;
> -    uint64_t result;
> +    int64_t result;
>  
>      rsp_return = migrate_query(who);
>      if (!qdict_haskey(rsp_return, "ram")) {
> @@ -226,12 +226,17 @@ static uint64_t get_migration_pass(QTestState *who)
>          result = 0;
>      } else {
>          rsp_ram = qdict_get_qdict(rsp_return, "ram");
> -        result = qdict_get_try_int(rsp_ram, "dirty-sync-count", 0);
> +        result = qdict_get_try_int(rsp_ram, property, 0);
>      }
>      qobject_unref(rsp_return);
>      return result;
>  }
>  
> +static uint64_t get_migration_pass(QTestState *who)
> +{
> +    return read_ram_property_int(who, "dirty-sync-count");
> +}
> +
>  static void read_blocktime(QTestState *who)
>  {
>      QDict *rsp_return;
> @@ -332,6 +337,13 @@ static void cleanup(const char *filename)
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
> @@ -430,73 +442,95 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
>  }
>  
>  static int test_migrate_start(QTestState **from, QTestState **to,
> -                               const char *uri, bool hide_stderr)
> +                               const char *uri, bool hide_stderr,
> +                               bool use_shmem)
>  {
>      gchar *cmd_src, *cmd_dst;
> -    char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
> +    char *bootpath = NULL;
> +    char *extra_opts = NULL;
> +    char *shmem_path = NULL;
>      const char *arch = qtest_get_arch();
>      const char *accel = "kvm:tcg";
>  
> -    got_stop = false;
> +    if (use_shmem) {
> +        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> +            g_test_skip("/dev/shm is not supported");
> +            return -1;
> +        }
> +        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
> +    }
>  
> +    got_stop = false;
> +    bootpath = g_strdup_printf("%s/bootsect", tmpfs);
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
> @@ -507,6 +541,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      }
>  
>      g_free(bootpath);
> +    g_free(extra_opts);
>  
>      if (hide_stderr) {
>          gchar *tmp;
> @@ -524,6 +559,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
> @@ -603,7 +648,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>  
> -    if (test_migrate_start(&from, &to, uri, hide_error)) {
> +    if (test_migrate_start(&from, &to, uri, hide_error, false)) {
>          return -1;
>      }
>  
> @@ -720,7 +765,7 @@ static void test_baddest(void)
>      char *status;
>      bool failed;
>  
> -    if (test_migrate_start(&from, &to, "tcp:0:0", true)) {
> +    if (test_migrate_start(&from, &to, "tcp:0:0", true, false)) {
>          return;
>      }
>      migrate(from, "tcp:0:0", "{}");
> @@ -745,7 +790,7 @@ static void test_precopy_unix(void)
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>  
> -    if (test_migrate_start(&from, &to, uri, false)) {
> +    if (test_migrate_start(&from, &to, uri, false, false)) {
>          return;
>      }
>  
> @@ -781,6 +826,41 @@ static void test_precopy_unix(void)
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
> +    /* Check whether shared RAM has been really skipped */
> +    g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
> +
> +    test_migrate_end(from, to, true);
> +    g_free(uri);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -832,6 +912,7 @@ int main(int argc, char **argv)
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
