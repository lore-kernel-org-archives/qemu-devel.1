Received: from eggs.gnu.org ([209.51.188.92]:35197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1guesI-0007yF-Rf
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1guesH-00049Y-UI
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:53:58 -0500
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:55929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1guesH-00046R-L1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:53:57 -0500
Received: from player715.ha.ovh.net (unknown [10.109.160.12])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 224851FC4BB
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 15:53:55 +0100 (CET)
Date: Fri, 15 Feb 2019 15:53:36 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190215155336.0432e393@bahia.lan>
In-Reply-To: <20190215133005.15955-2-david@redhat.com>
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] cpus: Properly release the iothread
 lock when killing a dummy VCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 15 Feb 2019 14:30:00 +0100
David Hildenbrand <david@redhat.com> wrote:

> This enables CPU unplug under qtest.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

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
