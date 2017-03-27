Received: from eggs.gnu.org ([2001:4830:134:3::10]:49026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csVZO-00069L-Ry
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csVZL-0005qJ-KE
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1csVZL-0005q3-BG
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:24:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 639A285547
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 14:24:26 +0000 (UTC)
Date: Mon, 27 Mar 2017 15:24:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170327142421.GF2373@work-vm>
References: <1490092792-30957-1-git-send-email-thuth@redhat.com>
	<1490092792-30957-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490092792-30957-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] libqtest: Add a generic function to
 run a callback function for every machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

* Thomas Huth (thuth@redhat.com) wrote:
> Some tests need to run single tests for every available machine of the
> current QEMU binary. To avoid code duplication, let's extract this
> code that deals with 'query-machines' into a separate function.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Having queued it, it's failing my test.

The reason is that qom-tests.c has a blacklist which blacklists Xen;
however your new generic function doesn't have the blacklist, so when
you run HMP commands on all machines it tries to run it on Xen since
my PC has the Xen libraries installed (so builds with Xen support) but
isn't a Xen guest.

It fails with:
xen be core: xen be core: can't connect to xenstored
can't connect to xenstored
xen_init_pv: xen backend core setup failed
Broken pipe

I suggest you probably need to share the blacklist as well.

(Unqueued)

Dave

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
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
