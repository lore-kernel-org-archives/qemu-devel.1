Received: from eggs.gnu.org ([2001:4830:134:3::10]:54800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eR1ra-0001Le-66
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eR1rF-0005xX-A7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:18:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eR1rE-0005ve-Ls
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:17:52 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIKDlJX121796
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 15:17:50 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2exkmsjd31-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 15:17:49 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 15:17:47 -0500
References: <1513597251-21942-1-git-send-email-thuth@redhat.com>
	<1513597251-21942-3-git-send-email-thuth@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 18:17:38 -0200
MIME-Version: 1.0
In-Reply-To: <1513597251-21942-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <68e8045d-1369-9fbd-7996-7f849586db81@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] tests/cpu-plug-test: Check the CPU
 hot-plugging with device_add, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, david@redhat.com



On 12/18/2017 09:40 AM, Thomas Huth wrote:
> Using 'device_add' instead of 'cpu-add' is the new way for
> hot-plugging CPUs, so we should test this regularly, too.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


>   tests/cpu-plug-test.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
> index 4579119..1e622cb 100644
> --- a/tests/cpu-plug-test.c
> +++ b/tests/cpu-plug-test.c
> @@ -16,6 +16,7 @@
>   struct PlugTestData {
>       char *machine;
>       const char *cpu_model;
> +    char *device_model;
>       unsigned sockets;
>       unsigned cores;
>       unsigned threads;
> @@ -71,11 +72,40 @@ static void test_plug_without_cpu_add(gconstpointer data)
>       g_free(args);
>   }
>
> +static void test_plug_with_device_add_x86(gconstpointer data)
> +{
> +    const PlugTestData *td = data;
> +    char *args;
> +    unsigned int s, c, t;
> +
> +    args = g_strdup_printf("-machine %s -cpu %s "
> +                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
> +                           td->machine, td->cpu_model,
> +                           td->sockets, td->cores, td->threads, td->maxcpus);
> +    qtest_start(args);
> +
> +    for (s = td->sockets; s < td->maxcpus / td->cores / td->threads; s++) {
> +        for (c = 0; c < td->cores; c++) {
> +            for (t = 0; t < td->threads; t++) {
> +                char *id = g_strdup_printf("id-%i-%i-%i", s, c, t);
> +                qtest_qmp_device_add(td->device_model, id, "'socket-id':'%i', "
> +                                     "'core-id':'%i', 'thread-id':'%i'",
> +                                     s, c, t);
> +                g_free(id);
> +            }
> +        }
> +    }
> +
> +    qtest_end();
> +    g_free(args);
> +}
> +
>   static void test_data_free(gpointer data)
>   {
>       PlugTestData *pc = data;
>
>       g_free(pc->machine);
> +    g_free(pc->device_model);
>       g_free(pc);
>   }
>
> @@ -90,6 +120,8 @@ static void add_pc_test_case(const char *mname)
>       data = g_new(PlugTestData, 1);
>       data->machine = g_strdup(mname);
>       data->cpu_model = "Haswell"; /* 1.3+ theoretically */
> +    data->device_model = g_strdup_printf("%s-%s-cpu", data->cpu_model,
> +                                         qtest_get_arch());
>       data->sockets = 1;
>       data->cores = 3;
>       data->threads = 2;
> @@ -105,19 +137,30 @@ static void add_pc_test_case(const char *mname)
>           (strcmp(mname, "pc-0.12") == 0) ||
>           (strcmp(mname, "pc-0.11") == 0) ||
>           (strcmp(mname, "pc-0.10") == 0)) {
> -        path = g_strdup_printf("cpu/%s/init/%ux%ux%u&maxcpus=%u",
> +        path = g_strdup_printf("cpu-plug/%s/init/%ux%ux%u&maxcpus=%u",
>                                  mname, data->sockets, data->cores,
>                                  data->threads, data->maxcpus);
>           qtest_add_data_func_full(path, data, test_plug_without_cpu_add,
>                                    test_data_free);
>           g_free(path);
>       } else {
> -        path = g_strdup_printf("cpu/%s/add/%ux%ux%u&maxcpus=%u",
> +        PlugTestData *data2 = g_memdup(data, sizeof(PlugTestData));
> +
> +        data2->machine = g_strdup(data->machine);
> +        data2->device_model = g_strdup(data->device_model);
> +
> +        path = g_strdup_printf("cpu-plug/%s/cpu-add/%ux%ux%u&maxcpus=%u",
>                                  mname, data->sockets, data->cores,
>                                  data->threads, data->maxcpus);
>           qtest_add_data_func_full(path, data, test_plug_with_cpu_add,
>                                    test_data_free);
>           g_free(path);
> +        path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
> +                               mname, data2->sockets, data2->cores,
> +                               data2->threads, data2->maxcpus);
> +        qtest_add_data_func_full(path, data2, test_plug_with_device_add_x86,
> +                                 test_data_free);
> +        g_free(path);
>       }
>   }
>
