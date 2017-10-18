Received: from eggs.gnu.org ([2001:4830:134:3::10]:42806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e4kBQ-0002EX-4F
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e4kBP-0006aI-3V
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:58:36 -0400
References: <1508247148-25240-1-git-send-email-thuth@redhat.com>
	<1508247148-25240-5-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fc201879-57fe-c798-fdfd-0a5631a41919@redhat.com>
Date: Wed, 18 Oct 2017 10:58:29 +0200
MIME-Version: 1.0
In-Reply-To: <1508247148-25240-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] tests/cpu-plug-test: Test CPU
 hot-plugging on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 17.10.2017 15:32, Thomas Huth wrote:
> CPU hot-plugging on s390x is possible with both, "cpu-add"
> and "device_add", so test both.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include |  1 +
>  tests/cpu-plug-test.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index cbec19f..85cf9ea 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -368,6 +368,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
>  check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
> +check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
>  
>  check-qtest-generic-y += tests/qom-test$(EXESUF)
>  check-qtest-generic-y += tests/test-hmp$(EXESUF)
> diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
> index 714a69c..58edaf6 100644
> --- a/tests/cpu-plug-test.c
> +++ b/tests/cpu-plug-test.c
> @@ -207,6 +207,42 @@ static void add_pseries_test_case(const char *mname)
>      g_free(path);
>  }
>  
> +static void add_s390x_test_case(const char *mname)
> +{
> +    char *path;
> +    PlugTestData *data, *data2;
> +
> +    if (!g_str_has_prefix(mname, "s390-ccw-virtio-")) {
> +        return;
> +    }
> +
> +    data = g_new(PlugTestData, 1);
> +    data->machine = g_strdup(mname);
> +    data->cpu_model = "qemu";
> +    data->device_model = "qemu-s390-cpu";
> +    data->sockets = 1;
> +    data->cores = 3;
> +    data->threads = 1;
> +    data->maxcpus = data->sockets * data->cores * data->threads * 2;
> +
> +    data2 = g_memdup(data, sizeof(PlugTestData));
> +    data2->machine = g_strdup(mname);
> +
> +    path = g_strdup_printf("cpu-plug/%s/cpu-add/%ux%ux%u&maxcpus=%u",
> +                           mname, data->sockets, data->cores,
> +                           data->threads, data->maxcpus);
> +    qtest_add_data_func_full(path, data, test_plug_with_cpu_add,
> +                             test_data_free);
> +    g_free(path);
> +
> +    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
> +                           mname, data2->sockets, data2->cores,
> +                           data2->threads, data2->maxcpus);
> +    qtest_add_data_func_full(path, data2, test_plug_with_device_add_coreid,
> +                             test_data_free);
> +    g_free(path);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      const char *arch = qtest_get_arch();
> @@ -217,6 +253,8 @@ int main(int argc, char **argv)
>          qtest_cb_for_every_machine(add_pc_test_case);
>      } else if (g_str_equal(arch, "ppc64")) {
>          qtest_cb_for_every_machine(add_pseries_test_case);
> +    } else if (g_str_equal(arch, "s390x")) {
> +        qtest_cb_for_every_machine(add_s390x_test_case);
>      }
>  
>      return g_test_run();
> 

Looks sane to me, haven't tested it, though.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
