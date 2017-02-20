Received: from eggs.gnu.org ([2001:4830:134:3::10]:60820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cfuOK-0001Dg-Qx
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cfuOH-0000lr-Ff
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:17:00 -0500
Date: Mon, 20 Feb 2017 20:16:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170220201647.GL2372@work-vm>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-24-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487067971-10443-24-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/24] util/cutils: Change qemu_strtosz*()
 from int64_t to uint64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> This will permit its use in parse_option_size().
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
> Cc: qemu-block@nongnu.org (open list:Block layer core)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c                 |  5 +++--
>  hw/misc/ivshmem.c     |  2 +-
>  include/qemu/cutils.h |  6 +++---
>  monitor.c             |  4 ++--
>  qapi/opts-visitor.c   |  6 ++----
>  qemu-img.c            |  5 ++++-
>  qemu-io-cmds.c        |  5 ++++-
>  target/i386/cpu.c     |  4 ++--
>  tests/test-cutils.c   | 40 ++++++++++++++++++++--------------------
>  util/cutils.c         | 14 +++++++++-----
>  10 files changed, 50 insertions(+), 41 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 9846fa4..5b9e461 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1338,7 +1338,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>  {
>      const char *param = qdict_get_str(qdict, "parameter");
>      const char *valuestr = qdict_get_str(qdict, "value");
> -    int64_t valuebw = 0;
> +    uint64_t valuebw = 0;
>      long valueint = 0;
>      Error *err = NULL;
>      bool use_int_value = false;
> @@ -1379,7 +1379,8 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>              case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>                  p.has_max_bandwidth = true;
>                  ret = qemu_strtosz_mebi(valuestr, NULL, &valuebw);
> -                if (ret < 0 || (size_t)valuebw != valuebw) {
> +                if (ret < 0 || valuebw > INT64_MAX
> +                    || (size_t)valuebw != valuebw) {

We should probably just turn all of the parameters into size_t's - although that's
more work and there's some int64_t's in qemu_file for no good reason.

>                      error_setg(&err, "Invalid size %s", valuestr);
>                      goto cleanup;
>                  }
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 3dc04f4..ba0cc22 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -1268,7 +1268,7 @@ static void ivshmem_realize(PCIDevice *dev, Error **errp)
>          s->legacy_size = 4 << 20; /* 4 MB default */
>      } else {
>          int ret;
> -        int64_t size;
> +        uint64_t size;
>  
>          ret = qemu_strtosz_mebi(s->sizearg, NULL, &size);
>          if (ret < 0 || (size_t)size != size || !is_power_of_2(size)) {
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index c91649b..476d274 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -139,9 +139,9 @@ int parse_uint(const char *s, unsigned long long *value, char **endptr,
>                 int base);
>  int parse_uint_full(const char *s, unsigned long long *value, int base);
>  
> -int qemu_strtosz(const char *nptr, char **end, int64_t *result);
> -int qemu_strtosz_mebi(const char *nptr, char **end, int64_t *result);
> -int qemu_strtosz_metric(const char *nptr, char **end, int64_t *result);
> +int qemu_strtosz(const char *nptr, char **end, uint64_t *result);
> +int qemu_strtosz_mebi(const char *nptr, char **end, uint64_t *result);
> +int qemu_strtosz_metric(const char *nptr, char **end, uint64_t *result);
>  
>  #define K_BYTE     (1ULL << 10)
>  #define M_BYTE     (1ULL << 20)
> diff --git a/monitor.c b/monitor.c
> index 85b1b61..1008ced 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -2774,7 +2774,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>          case 'o':
>              {
>                  int ret;
> -                int64_t val;
> +                uint64_t val;
>                  char *end;
>  
>                  while (qemu_isspace(*p)) {
> @@ -2787,7 +2787,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      }
>                  }
>                  ret = qemu_strtosz_mebi(p, &end, &val);
> -                if (ret < 0) {
> +                if (ret < 0 || val > INT64_MAX) {
>                      monitor_printf(mon, "invalid size\n");
>                      goto fail;
>                  }
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index aac2e09..a0a7c0e 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -481,7 +481,6 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
>  {
>      OptsVisitor *ov = to_ov(v);
>      const QemuOpt *opt;
> -    int64_t val;
>      int err;
>  
>      opt = lookup_scalar(ov, name, errp);
> @@ -489,14 +488,13 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
>          return;
>      }
>  
> -    err = qemu_strtosz(opt->str ? opt->str : "", NULL, &val);
> +    err = qemu_strtosz(opt->str ? opt->str : "", NULL, obj);
>      if (err < 0) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
> -                   "a size value representible as a non-negative int64");
> +                   "a size value");
>          return;
>      }
>  
> -    *obj = val;
>      processed(ov, name);
>  }
>  
> diff --git a/qemu-img.c b/qemu-img.c
> index 89ced5a..b10ea66 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -371,12 +371,15 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
>  static int64_t cvtnum(const char *s)
>  {
>      int err;
> -    int64_t value;
> +    uint64_t value;
>  
>      err = qemu_strtosz(s, NULL, &value);
>      if (err < 0) {
>          return err;
>      }
> +    if (value > INT64_MAX) {
> +        return -ERANGE;
> +    }
>      return value;
>  }
>  
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index d9f3e93..1b01160 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -138,12 +138,15 @@ static char **breakline(char *input, int *count)
>  static int64_t cvtnum(const char *s)
>  {
>      int err;
> -    int64_t value;
> +    uint64_t value;
>  
>      err = qemu_strtosz(s, NULL, &value);
>      if (err < 0) {
>          return err;
>      }
> +    if (value > INT64_MAX) {
> +        return -ERANGE;
> +    }
>      return value;
>  }
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5f85410..e15f6bf 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2034,10 +2034,10 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
>          /* Special case: */
>          if (!strcmp(name, "tsc-freq")) {
>              int ret;
> -            int64_t tsc_freq;
> +            uint64_t tsc_freq;
>  
>              ret = qemu_strtosz_metric(val, NULL, &tsc_freq);
> -            if (ret < 0) {
> +            if (ret < 0 || tsc_freq > INT64_MAX) {
>                  error_setg(errp, "bad numerical value %s", val);
>                  return;
>              }
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index 9c2eed3..ebc1da2 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -1374,7 +1374,7 @@ static void test_qemu_strtosz_simple(void)
>      const char *str;
>      char *endptr = NULL;
>      int err;
> -    int64_t res = 0xbaadf00d;
> +    uint64_t res = 0xbaadf00d;
>  
>      str = "0";
>      err = qemu_strtosz(str, &endptr, &res);
> @@ -1412,17 +1412,17 @@ static void test_qemu_strtosz_simple(void)
>      g_assert_cmpint(res, ==, 0x20000000000000); /* rounded to 53 bits */
>      g_assert(endptr == str + 16);
>  
> -    str = "9223372036854774784"; /* 0x7ffffffffffffc00 (53 msbs set) */
> +    str = "18446744073709549568"; /* 0xfffffffffffff800 (53 msbs set) */
>      err = qemu_strtosz(str, &endptr, &res);
>      g_assert_cmpint(err, ==, 0);
> -    g_assert_cmpint(res, ==, 0x7ffffffffffffc00);
> -    g_assert(endptr == str + 19);
> +    g_assert_cmpint(res, ==, 0xfffffffffffff800);
> +    g_assert(endptr == str + 20);
>  
> -    str = "9223372036854775295"; /* 0x7ffffffffffffdff */
> +    str = "18446744073709550591"; /* 0xfffffffffffffbff */
>      err = qemu_strtosz(str, &endptr, &res);
>      g_assert_cmpint(err, ==, 0);
> -    g_assert_cmpint(res, ==, 0x7ffffffffffffc00); /* rounded to 53 bits */
> -    g_assert(endptr == str + 19);
> +    g_assert_cmpint(res, ==, 0xfffffffffffff800); /* rounded to 53 bits */
> +    g_assert(endptr == str + 20);
>  
>      /* 0x7ffffffffffffe00..0x7fffffffffffffff get rounded to
>       * 0x8000000000000000, thus -ERANGE; see test_qemu_strtosz_erange() */
> @@ -1440,7 +1440,7 @@ static void test_qemu_strtosz_units(void)
>      const char *e = "1E";
>      int err;
>      char *endptr = NULL;
> -    int64_t res = 0xbaadf00d;
> +    uint64_t res = 0xbaadf00d;
>  
>      /* default is M */
>      err = qemu_strtosz_mebi(none, &endptr, &res);
> @@ -1489,7 +1489,7 @@ static void test_qemu_strtosz_float(void)
>      const char *str = "12.345M";
>      int err;
>      char *endptr = NULL;
> -    int64_t res = 0xbaadf00d;
> +    uint64_t res = 0xbaadf00d;
>  
>      err = qemu_strtosz(str, &endptr, &res);
>      g_assert_cmpint(err, ==, 0);
> @@ -1502,7 +1502,7 @@ static void test_qemu_strtosz_invalid(void)
>      const char *str;
>      char *endptr = NULL;
>      int err;
> -    int64_t res = 0xbaadf00d;
> +    uint64_t res = 0xbaadf00d;
>  
>      str = "";
>      err = qemu_strtosz(str, &endptr, &res);
> @@ -1525,7 +1525,7 @@ static void test_qemu_strtosz_trailing(void)
>      const char *str;
>      char *endptr = NULL;
>      int err;
> -    int64_t res = 0xbaadf00d;
> +    uint64_t res = 0xbaadf00d;
>  
>      str = "123xxx";
>      err = qemu_strtosz_mebi(str, &endptr, &res);
> @@ -1550,29 +1550,29 @@ static void test_qemu_strtosz_erange(void)
>      const char *str;
>      char *endptr = NULL;
>      int err;
> -    int64_t res = 0xbaadf00d;
> +    uint64_t res = 0xbaadf00d;
>  
>      str = "-1";
>      err = qemu_strtosz(str, &endptr, &res);
>      g_assert_cmpint(err, ==, -ERANGE);
>      g_assert(endptr == str + 2);
>  
> -    str = "9223372036854775296"; /* 0x7ffffffffffffe00 */
> +    str = "18446744073709550592"; /* 0xfffffffffffffc00 */
>      err = qemu_strtosz(str, &endptr, &res);
>      g_assert_cmpint(err, ==, -ERANGE);
> -    g_assert(endptr == str + 19);
> +    g_assert(endptr == str + 20);
>  
> -    str = "9223372036854775807"; /* 2^63-1 */
> +    str = "18446744073709551615"; /* 2^64-1 */
>      err = qemu_strtosz(str, &endptr, &res);
>      g_assert_cmpint(err, ==, -ERANGE);
> -    g_assert(endptr == str + 19);
> +    g_assert(endptr == str + 20);
>  
> -    str = "9223372036854775808"; /* 2^63 */
> +    str = "18446744073709551616"; /* 2^64 */
>      err = qemu_strtosz(str, &endptr, &res);
>      g_assert_cmpint(err, ==, -ERANGE);
> -    g_assert(endptr == str + 19);
> +    g_assert(endptr == str + 20);
>  
> -    str = "10E";
> +    str = "20E";
>      err = qemu_strtosz(str, &endptr, &res);
>      g_assert_cmpint(err, ==, -ERANGE);
>      g_assert(endptr == str + 3);
> @@ -1583,7 +1583,7 @@ static void test_qemu_strtosz_metric(void)
>      const char *str = "12345k";
>      int err;
>      char *endptr = NULL;
> -    int64_t res = 0xbaadf00d;
> +    uint64_t res = 0xbaadf00d;
>  
>      err = qemu_strtosz_metric(str, &endptr, &res);
>      g_assert_cmpint(err, ==, 0);
> diff --git a/util/cutils.c b/util/cutils.c
> index 08effe6..888c0fd 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -207,7 +207,7 @@ static int64_t suffix_mul(char suffix, int64_t unit)
>   */
>  static int do_strtosz(const char *nptr, char **end,
>                        const char default_suffix, int64_t unit,
> -                      int64_t *result)
> +                      uint64_t *result)
>  {
>      int retval;
>      char *endptr;
> @@ -237,7 +237,11 @@ static int do_strtosz(const char *nptr, char **end,
>          retval = -EINVAL;
>          goto out;
>      }
> -    if ((val * mul >= INT64_MAX) || val < 0) {
> +    /*
> +     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
> +     * through double (53 bits of precision).
> +     */
> +    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {

It would be great to get rid of the double's at some point.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>          retval = -ERANGE;
>          goto out;
>      }
> @@ -254,17 +258,17 @@ out:
>      return retval;
>  }
>  
> -int qemu_strtosz(const char *nptr, char **end, int64_t *result)
> +int qemu_strtosz(const char *nptr, char **end, uint64_t *result)
>  {
>      return do_strtosz(nptr, end, 'B', 1024, result);
>  }
>  
> -int qemu_strtosz_mebi(const char *nptr, char **end, int64_t *result)
> +int qemu_strtosz_mebi(const char *nptr, char **end, uint64_t *result)
>  {
>      return do_strtosz(nptr, end, 'M', 1024, result);
>  }
>  
> -int qemu_strtosz_metric(const char *nptr, char **end, int64_t *result)
> +int qemu_strtosz_metric(const char *nptr, char **end, uint64_t *result)
>  {
>      return do_strtosz(nptr, end, 'B', 1000, result);
>  }
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
