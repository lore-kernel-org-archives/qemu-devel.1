Received: from eggs.gnu.org ([209.51.188.92]:41821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gttu0-0001hm-Q6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gttty-00034B-G7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:44:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gttty-00032u-9k
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:44:34 -0500
Date: Wed, 13 Feb 2019 13:44:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190213134428.11b03224@redhat.com>
In-Reply-To: <1549377087-205549-1-git-send-email-imammedo@redhat.com>
References: <1549377087-205549-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hostmem: fix crash when querying empty
 host-nodes property via QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, Eric Blake <eblake@redhat.com>, mdroth@linux.vnet.ibm.com

On Tue,  5 Feb 2019 15:31:27 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> QEMU will crashes with
>  qapi/qobject-output-visitor.c:210: qobject_output_complete: Assertion `qov->root && ((&qov->stack)->slh_first == ((void *)0))' failed
> when trying to get value of empty hostmem.host-nodes property.
> 
> Fix it by calling visitor even if host-nodes wasn't set
> before exiting from property getter to return empty list.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  backends/hostmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 0c8ef17..fe14be5 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -86,7 +86,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
>  
>      value = find_first_bit(backend->host_nodes, MAX_NODES);
>      if (value == MAX_NODES) {
> -        return;
> +        goto ret;
>      }
>  
>      *node = g_malloc0(sizeof(**node));
> @@ -104,6 +104,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
>          node = &(*node)->next;
>      } while (true);
>  
> +ret:
>      visit_type_uint16List(v, name, &host_nodes, errp);
>  }
>  

Markus/Michael,

does this patch make sense from QAPI point of view?
