Received: from eggs.gnu.org ([209.51.188.92]:39313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gufDE-0005jh-6b
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gufDD-000391-H7
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:15:36 -0500
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <773f6c81-d159-97ba-7bbe-d10a5e62b177@redhat.com>
Date: Fri, 15 Feb 2019 16:14:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190215133005.15955-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 1/6] cpus: Properly release
 the iothread lock when killing a dummy VCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 15/02/2019 14.30, David Hildenbrand wrote:
> This enables CPU unplug under qtest.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  cpus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/cpus.c b/cpus.c
> index 154daf57dc..e83f72b48b 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1333,6 +1333,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
>          qemu_wait_io_event(cpu);
>      } while (!cpu->unplug);
>  
> +    qemu_mutex_unlock_iothread();
>      rcu_unregister_thread();
>      return NULL;
>  #endif

That's definitely a bug that you fix here.

Reviewed-by: Thomas Huth <thuth@redhat.com>
