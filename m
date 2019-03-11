Received: from eggs.gnu.org ([209.51.188.92]:35525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3I9Y-0005rG-CC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3I80-0007CC-Ep
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:25:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3I80-00079n-7u
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:25:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id w2so4404293wrt.11
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 03:25:52 -0700 (PDT)
References: <20190310160227.103090-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d2f633f-97c8-9577-742c-a78a0603f2d5@redhat.com>
Date: Mon, 11 Mar 2019 11:09:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190310160227.103090-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: test-qgraph: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com, e.emanuelegiuseppe@gmail.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org

On 3/10/19 5:02 PM, Li Qiang wrote:
> Spotted by ASAN when 'make check'.
> 

Fixes: fc281c80202

> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
