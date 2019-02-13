Received: from eggs.gnu.org ([209.51.188.92]:51030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtud7-0007g8-Nb
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtud4-0005fG-9M
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:31:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtucv-0005Ly-9f
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:31:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AA3381F18
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 13:30:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1549377087-205549-1-git-send-email-imammedo@redhat.com>
Date: Wed, 13 Feb 2019 14:30:55 +0100
In-Reply-To: <1549377087-205549-1-git-send-email-imammedo@redhat.com> (Igor
	Mammedov's message of "Tue, 5 Feb 2019 15:31:27 +0100")
Message-ID: <877ee36cj4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

Igor Mammedov <imammedo@redhat.com> writes:

> QEMU will crashes with
>  qapi/qobject-output-visitor.c:210: qobject_output_complete: Assertion `qov->root && ((&qov->stack)->slh_first == ((void *)0))' failed
> when trying to get value of empty hostmem.host-nodes property.
>
> Fix it by calling visitor even if host-nodes wasn't set
> before exiting from property getter to return empty list.

host-nodes or host_nodes?

If local variable host_nodes: that one's always set.  The case you fix
has it set to NULL.

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

Yes, an empty list needs to be visited just like a non-empty list.

Patch looks good.
