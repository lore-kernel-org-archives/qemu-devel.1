Received: from eggs.gnu.org ([2001:4830:134:3::10]:35132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1Thq-0006rt-1N
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1Thm-0000x0-1l
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:18:49 -0400
Date: Thu, 29 Mar 2018 11:18:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180329111831.2ffad2bd.cohuck@redhat.com>
In-Reply-To: <152231458624.69730.1752893648612848392.stgit@bahia.lan>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
	<152231458624.69730.1752893648612848392.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] exec: fix memory leak in
 find_max_supported_pagesize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On Thu, 29 Mar 2018 11:09:46 +0200
Greg Kurz <groug@kaod.org> wrote:

> The string returned by object_property_get_str() is dynamically allocated.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  exec.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/exec.c b/exec.c
> index c09bd93df31e..02b1efebb7c3 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1495,6 +1495,7 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
>          mem_path = object_property_get_str(obj, "mem-path", NULL);
>          if (mem_path) {
>              long hpsize = qemu_mempath_getpagesize(mem_path);
> +            g_free(mem_path);
>              if (hpsize < *hpsize_min) {
>                  *hpsize_min = hpsize;
>              }
> 

Personally, I'd probably do the g_free() at the end of the if
(mem_path) branch, but this works as well.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
