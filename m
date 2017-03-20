Received: from eggs.gnu.org ([2001:4830:134:3::10]:57999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq4a5-0005Z4-UD
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq4a2-0008OW-Ly
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:11:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40393
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq4a2-0008Nj-FE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:11:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KL8iiR138994
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 17:11:05 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29aj6q5rr2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 17:11:05 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:11:04 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1490026424-11330-3-git-send-email-armbru@redhat.com>
References: <1490026424-11330-1-git-send-email-armbru@redhat.com>
	<1490026424-11330-3-git-send-email-armbru@redhat.com>
Date: Mon, 20 Mar 2017 16:10:54 -0500
Message-Id: <149004425464.3910.12993880446909288314@loki>
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] Revert "hostmem: fix QEMU
 crash by 'info memdev'"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, eblake@redhat.com, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>

Quoting Markus Armbruster (2017-03-20 11:13:44)
> This reverts commit 1454d33f0507cb54d62ed80f494884157c9e7130.
> =

> The string input visitor regression fixed in the previous commit made
> visit_type_uint16List() fail on empty input.  query_memdev() calls it
> via object_property_get_uint16List().  Because it doesn't expect it to
> fail, it passes &error_abort, and duly crashes.
> =

> Commit 1454d33 "fixes" this crash by making
> host_memory_backend_get_host_nodes() return a list containing just
> MAX_NODES instead of the empty list.  Papers over the regression, and
> leads to bogus "info memdev" output, as shown below; revert.
> =

> I suspect that if we had bisected the crash back then, we would have
> found and fixed the actual bug instead of papering over it.
> =

> To reproduce, run HMP command "info memdev" with
> =

>     $ qemu-system-x86_64 --nodefaults -S -display none -monitor stdio -ob=
ject memory-backend-ram,id=3Dmem1,size=3D4k
> =

> With this commit, "info memdev" prints
> =

>     memory backend: mem1
>       size:  4096
>       merge: true
>       dump: true
>       prealloc: false
>       policy: default
>       host nodes:
> =

> exactly like before commit 74f24cb.
> =

> Between commit 1454d33 and this commit, it prints
> =

>     memory backend: mem1
>       size:  4096
>       merge: true
>       dump: true
>       prealloc: false
>       policy: default
>       host nodes: 128
> =

> The last line is bogus.
> =

> Between commit 74f24cb and 1454d33, it crashes like this:
> =

>     Unexpected error in parse_str() at /work/armbru/tmp/qemu/qapi/string-=
input-visitor.c:126:
>     Parameter 'null' expects an int64 value or range
>     Aborted (core dumped)
> =

> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  backends/hostmem.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> =

> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 162c218..89feb9e 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -64,14 +64,6 @@ out:
>      error_propagate(errp, local_err);
>  }
> =

> -static uint16List **host_memory_append_node(uint16List **node,
> -                                            unsigned long value)
> -{
> -     *node =3D g_malloc0(sizeof(**node));
> -     (*node)->value =3D value;
> -     return &(*node)->next;
> -}
> -
>  static void
>  host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *=
name,
>                                     void *opaque, Error **errp)
> @@ -82,23 +74,25 @@ host_memory_backend_get_host_nodes(Object *obj, Visit=
or *v, const char *name,
>      unsigned long value;
> =

>      value =3D find_first_bit(backend->host_nodes, MAX_NODES);
> -
> -    node =3D host_memory_append_node(node, value);
> -
>      if (value =3D=3D MAX_NODES) {
> -        goto out;
> +        return;
>      }
> =

> +    *node =3D g_malloc0(sizeof(**node));
> +    (*node)->value =3D value;
> +    node =3D &(*node)->next;
> +
>      do {
>          value =3D find_next_bit(backend->host_nodes, MAX_NODES, value + =
1);
>          if (value =3D=3D MAX_NODES) {
>              break;
>          }
> =

> -        node =3D host_memory_append_node(node, value);
> +        *node =3D g_malloc0(sizeof(**node));
> +        (*node)->value =3D value;
> +        node =3D &(*node)->next;
>      } while (true);
> =

> -out:
>      visit_type_uint16List(v, name, &host_nodes, errp);
>  }
> =

> -- =

> 2.7.4
>=20
