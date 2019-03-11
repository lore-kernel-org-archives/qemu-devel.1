Received: from eggs.gnu.org ([209.51.188.92]:42215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3Mvi-0005vi-Be
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3Mvh-000325-M8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3Mvh-00031U-Bp
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:33:29 -0400
References: <20190310160227.103090-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7e2b946-b903-0dee-a362-58c394551a2f@redhat.com>
Date: Mon, 11 Mar 2019 16:33:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190310160227.103090-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: test-qgraph: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, e.emanuelegiuseppe@gmail.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

On 10/03/19 17:02, Li Qiang wrote:
> Spotted by ASAN when 'make check'.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/test-qgraph.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/test-qgraph.c b/tests/test-qgraph.c
> index f6a6565e31..5c7e457075 100644
> --- a/tests/test-qgraph.c
> +++ b/tests/test-qgraph.c
> @@ -122,7 +122,7 @@ static void check_driver(const char *driver)
>  static void check_test(const char *test, const char *interface)
>  {
>      QOSGraphEdge *edge;
> -    const char *full_name = g_strdup_printf("%s-tests/%s", interface, test);
> +    char *full_name = g_strdup_printf("%s-tests/%s", interface, test);
>  
>      qos_add_test(test, interface, testfunct, NULL);
>      g_assert_cmpint(qos_graph_has_machine(test), ==, FALSE);
> @@ -138,6 +138,7 @@ static void check_test(const char *test, const char *interface)
>      g_assert_cmpint(qos_graph_get_node_availability(full_name), ==, TRUE);
>      qos_graph_node_set_availability(full_name, FALSE);
>      g_assert_cmpint(qos_graph_get_node_availability(full_name), ==, FALSE);
> +    g_free(full_name);
>  }
>  
>  static void count_each_test(QOSGraphNode *path, int len)
> 

Queued, thanks.

Paolo
