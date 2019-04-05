Received: from eggs.gnu.org ([209.51.188.92]:60588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hCWCx-0003Qx-W7
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hCWCw-0006yn-UD
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:17:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hCWCv-0006rw-Kn
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:17:06 -0400
References: <20190405184037.16799-1-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29aaecc0-8dff-9506-6d1b-88e80d121437@redhat.com>
Date: Fri, 5 Apr 2019 23:16:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190405184037.16799-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] test qgraph.c: Fix segs due to out of
 scope default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, e.emanuelegiuseppe@gmail.com

On 05/04/19 20:40, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The test uses the trick:
>    if (!opts) {
>      opts = &(QOSGraph...Options) { };
>    }
> 
>   in a couple of places, however the temporary created
> by the &() {}  goes out of scope at the bottom of the if,
> and results in a seg or assert when opts-> fields are
> used (on fedora 30's gcc 9).
> 
> Fixes: fc281c802022cb3a73a5
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thomas, can you pick this up?

Paolo

> ---
>  tests/libqos/qgraph.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/libqos/qgraph.c b/tests/libqos/qgraph.c
> index 122efc1b7b..b149caaaa9 100644
> --- a/tests/libqos/qgraph.c
> +++ b/tests/libqos/qgraph.c
> @@ -77,6 +77,7 @@ static void add_edge(const char *source, const char *dest,
>  {
>      char *key;
>      QOSGraphEdgeList *list = g_hash_table_lookup(edge_table, source);
> +    QOSGraphEdgeOptions def_opts = { };
>  
>      if (!list) {
>          list = g_new0(QOSGraphEdgeList, 1);
> @@ -85,7 +86,7 @@ static void add_edge(const char *source, const char *dest,
>      }
>  
>      if (!opts) {
> -        opts = &(QOSGraphEdgeOptions) { };
> +        opts = &def_opts;
>      }
>  
>      QOSGraphEdge *edge = g_new0(QOSGraphEdge, 1);
> @@ -590,9 +591,10 @@ void qos_add_test(const char *name, const char *interface,
>  {
>      QOSGraphNode *node;
>      char *test_name = g_strdup_printf("%s-tests/%s", interface, name);;
> +    QOSGraphTestOptions def_opts = { };
>  
>      if (!opts) {
> -        opts = &(QOSGraphTestOptions) { };
> +        opts = &def_opts;
>      }
>      node = create_node(test_name, QNODE_TEST);
>      node->u.test.function = test_func;
> 
