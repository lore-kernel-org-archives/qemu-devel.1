Received: from eggs.gnu.org ([2001:4830:134:3::10]:59083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv7Qd-0004s9-P0
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv7QY-0003Y8-Nh
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:14:15 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv7QY-0003Xw-JL
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:14:10 -0400
Received: by mail-qk0-x243.google.com with SMTP id v75so441684qkb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:14:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490860207-8302-1-git-send-email-thuth@redhat.com>
	<1490860207-8302-3-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <417e9955-40fc-5e5d-ea65-084bb5ba9e5e@amsat.org>
Date: Mon, 3 Apr 2017 16:14:06 -0300
MIME-Version: 1.0
In-Reply-To: <1490860207-8302-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] libqtest: Add a generic function to
 run a callback function for every machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 03/30/2017 04:50 AM, Thomas Huth wrote:
> Some tests need to run single tests for every available machine of the
> current QEMU binary. To avoid code duplication, let's extract this
> code that deals with 'query-machines' into a separate function.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/libqtest.c    | 30 +++++++++++++++++
>  tests/libqtest.h    |  8 +++++
>  tests/pc-cpu-test.c | 95 ++++++++++++++++++++---------------------------------
>  tests/qom-test.c    | 36 ++++----------------
>  4 files changed, 80 insertions(+), 89 deletions(-)
>
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index c9b2d76..d8b8066 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -938,3 +938,33 @@ bool qtest_big_endian(QTestState *s)
>  {
>      return s->big_endian;
>  }
> +
> +void qtest_cb_for_every_machine(void (*cb)(const char *machine))
> +{
> +    QDict *response, *minfo;
> +    QList *list;
> +    const QListEntry *p;
> +    QObject *qobj;
> +    QString *qstr;
> +    const char *mname;
> +
> +    qtest_start("-machine none");
> +    response = qmp("{ 'execute': 'query-machines' }");
> +    g_assert(response);
> +    list = qdict_get_qlist(response, "return");
> +    g_assert(list);
> +
> +    for (p = qlist_first(list); p; p = qlist_next(p)) {
> +        minfo = qobject_to_qdict(qlist_entry_obj(p));
> +        g_assert(minfo);
> +        qobj = qdict_get(minfo, "name");
> +        g_assert(qobj);
> +        qstr = qobject_to_qstring(qobj);
> +        g_assert(qstr);
> +        mname = qstring_get_str(qstr);
> +        cb(mname);
> +    }
> +
> +    qtest_end();
> +    QDECREF(response);
> +}
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 2c9962d..43ffadd 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -917,4 +917,12 @@ void qmp_fd_send(int fd, const char *fmt, ...);
>  QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
>  QDict *qmp_fd(int fd, const char *fmt, ...);
>
> +/**
> + * qtest_cb_for_every_machine:
> + * @cb: Pointer to the callback function
> + *
> + *  Call a callback function for every name of all available machines.
> + */
> +void qtest_cb_for_every_machine(void (*cb)(const char *machine));
> +
>  #endif
> diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
> index c3a2633..c4211a4 100644
> --- a/tests/pc-cpu-test.c
> +++ b/tests/pc-cpu-test.c
> @@ -79,69 +79,46 @@ static void test_data_free(gpointer data)
>      g_free(pc);
>  }
>
> -static void add_pc_test_cases(void)
> +static void add_pc_test_case(const char *mname)
>  {
> -    QDict *response, *minfo;
> -    QList *list;
> -    const QListEntry *p;
> -    QObject *qobj;
> -    QString *qstr;
> -    const char *mname;
>      char *path;
>      PCTestData *data;
>
> -    qtest_start("-machine none");
> -    response = qmp("{ 'execute': 'query-machines' }");
> -    g_assert(response);
> -    list = qdict_get_qlist(response, "return");
> -    g_assert(list);
> -
> -    for (p = qlist_first(list); p; p = qlist_next(p)) {
> -        minfo = qobject_to_qdict(qlist_entry_obj(p));
> -        g_assert(minfo);
> -        qobj = qdict_get(minfo, "name");
> -        g_assert(qobj);
> -        qstr = qobject_to_qstring(qobj);
> -        g_assert(qstr);
> -        mname = qstring_get_str(qstr);
> -        if (!g_str_has_prefix(mname, "pc-")) {
> -            continue;
> -        }
> -        data = g_malloc(sizeof(PCTestData));
> -        data->machine = g_strdup(mname);
> -        data->cpu_model = "Haswell"; /* 1.3+ theoretically */
> -        data->sockets = 1;
> -        data->cores = 3;
> -        data->threads = 2;
> -        data->maxcpus = data->sockets * data->cores * data->threads * 2;
> -        if (g_str_has_suffix(mname, "-1.4") ||
> -            (strcmp(mname, "pc-1.3") == 0) ||
> -            (strcmp(mname, "pc-1.2") == 0) ||
> -            (strcmp(mname, "pc-1.1") == 0) ||
> -            (strcmp(mname, "pc-1.0") == 0) ||
> -            (strcmp(mname, "pc-0.15") == 0) ||
> -            (strcmp(mname, "pc-0.14") == 0) ||
> -            (strcmp(mname, "pc-0.13") == 0) ||
> -            (strcmp(mname, "pc-0.12") == 0) ||
> -            (strcmp(mname, "pc-0.11") == 0) ||
> -            (strcmp(mname, "pc-0.10") == 0)) {
> -            path = g_strdup_printf("cpu/%s/init/%ux%ux%u&maxcpus=%u",
> -                                   mname, data->sockets, data->cores,
> -                                   data->threads, data->maxcpus);
> -            qtest_add_data_func_full(path, data, test_pc_without_cpu_add,
> -                                     test_data_free);
> -            g_free(path);
> -        } else {
> -            path = g_strdup_printf("cpu/%s/add/%ux%ux%u&maxcpus=%u",
> -                                   mname, data->sockets, data->cores,
> -                                   data->threads, data->maxcpus);
> -            qtest_add_data_func_full(path, data, test_pc_with_cpu_add,
> -                                     test_data_free);
> -            g_free(path);
> -        }
> +    if (!g_str_has_prefix(mname, "pc-")) {
> +        return;
> +    }
> +    data = g_malloc(sizeof(PCTestData));
> +    data->machine = g_strdup(mname);
> +    data->cpu_model = "Haswell"; /* 1.3+ theoretically */
> +    data->sockets = 1;
> +    data->cores = 3;
> +    data->threads = 2;
> +    data->maxcpus = data->sockets * data->cores * data->threads * 2;
> +    if (g_str_has_suffix(mname, "-1.4") ||
> +        (strcmp(mname, "pc-1.3") == 0) ||
> +        (strcmp(mname, "pc-1.2") == 0) ||
> +        (strcmp(mname, "pc-1.1") == 0) ||
> +        (strcmp(mname, "pc-1.0") == 0) ||
> +        (strcmp(mname, "pc-0.15") == 0) ||
> +        (strcmp(mname, "pc-0.14") == 0) ||
> +        (strcmp(mname, "pc-0.13") == 0) ||
> +        (strcmp(mname, "pc-0.12") == 0) ||
> +        (strcmp(mname, "pc-0.11") == 0) ||
> +        (strcmp(mname, "pc-0.10") == 0)) {
> +        path = g_strdup_printf("cpu/%s/init/%ux%ux%u&maxcpus=%u",
> +                               mname, data->sockets, data->cores,
> +                               data->threads, data->maxcpus);
> +        qtest_add_data_func_full(path, data, test_pc_without_cpu_add,
> +                                 test_data_free);
> +        g_free(path);
> +    } else {
> +        path = g_strdup_printf("cpu/%s/add/%ux%ux%u&maxcpus=%u",
> +                               mname, data->sockets, data->cores,
> +                               data->threads, data->maxcpus);
> +        qtest_add_data_func_full(path, data, test_pc_with_cpu_add,
> +                                 test_data_free);
> +        g_free(path);
>      }
> -    QDECREF(response);
> -    qtest_end();
>  }
>
>  int main(int argc, char **argv)
> @@ -151,7 +128,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> -        add_pc_test_cases();
> +        qtest_cb_for_every_machine(add_pc_test_case);
>      }
>
>      return g_test_run();
> diff --git a/tests/qom-test.c b/tests/qom-test.c
> index d48f890..ab0595d 100644
> --- a/tests/qom-test.c
> +++ b/tests/qom-test.c
> @@ -107,46 +107,22 @@ static void test_machine(gconstpointer data)
>      g_free((void *)machine);
>  }
>
> -static void add_machine_test_cases(void)
> +static void add_machine_test_case(const char *mname)
>  {
>      const char *arch = qtest_get_arch();
> -    QDict *response, *minfo;
> -    QList *list;
> -    const QListEntry *p;
> -    QObject *qobj;
> -    QString *qstr;
> -    const char *mname;
>
> -    qtest_start("-machine none");
> -    response = qmp("{ 'execute': 'query-machines' }");
> -    g_assert(response);
> -    list = qdict_get_qlist(response, "return");
> -    g_assert(list);
> -
> -    for (p = qlist_first(list); p; p = qlist_next(p)) {
> -        minfo = qobject_to_qdict(qlist_entry_obj(p));
> -        g_assert(minfo);
> -        qobj = qdict_get(minfo, "name");
> -        g_assert(qobj);
> -        qstr = qobject_to_qstring(qobj);
> -        g_assert(qstr);
> -        mname = qstring_get_str(qstr);
> -        if (!is_blacklisted(arch, mname)) {
> -            char *path = g_strdup_printf("qom/%s", mname);
> -            qtest_add_data_func(path, g_strdup(mname), test_machine);
> -            g_free(path);
> -        }
> +    if (!is_blacklisted(arch, mname)) {
> +        char *path = g_strdup_printf("qom/%s", mname);
> +        qtest_add_data_func(path, g_strdup(mname), test_machine);
> +        g_free(path);
>      }
> -
> -    qtest_end();
> -    QDECREF(response);
>  }
>
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
>
> -    add_machine_test_cases();
> +    qtest_cb_for_every_machine(add_machine_test_case);
>
>      return g_test_run();
>  }
>
