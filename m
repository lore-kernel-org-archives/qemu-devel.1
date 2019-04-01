Received: from eggs.gnu.org ([209.51.188.92]:33253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hB13V-0003nF-6s
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hB13U-0004jO-7p
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:49:09 -0400
Date: Mon, 1 Apr 2019 19:48:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190401194857.681f65d6.cohuck@redhat.com>
In-Reply-To: <20190328113458.8405-1-david@redhat.com>
References: <20190328113458.8405-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] s390x/kvm: Properly detect page
 size of initial memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 28 Mar 2019 12:34:56 +0100
David Hildenbrand <david@redhat.com> wrote:

> This is based on the patch
>     [PATCH for-4.0?] exec: Only count mapped memory backends for
>     qemu_getrampagesize()
> 
> While the detection on s390x of the maximum ram pagesize works by pure luck,
> we should try to do better. Especially, once "-mem-path" is replaced
> by memory backends, the current approach will break.
> 
> Configure the maximum page size after configuring initital memory. Provide
> a function to detect the maximum ram pagesize
> 
> I think this can be deferred to 4.1 as I don't think anything is actually
> broken right now.

I agree.

> 
> v1 -> v2:
> - Add a better comment describing that only initial memory is considered
> - Add "exec: Introduce qemu_getmaxrampagesize() and rename
>   qemu_getrampagesize()"
> 
> David Hildenbrand (2):
>   s390x/kvm: Configure page size after memory has actually been
>     initialized

I can queue that one to s390-next (not s390-fixes)... has this been tested?

>   exec: Introduce qemu_getmaxrampagesize() and rename
>     qemu_getrampagesize()
> 
>  exec.c                     | 39 ++++++++++++++++++++++++++++++++++----
>  hw/ppc/spapr_caps.c        |  4 ++--
>  hw/s390x/s390-virtio-ccw.c | 12 ++++++++++++
>  hw/vfio/spapr.c            |  2 +-
>  target/ppc/kvm.c           |  2 +-
>  target/s390x/cpu.c         |  7 +++++++
>  target/s390x/cpu.h         |  1 +
>  target/s390x/kvm-stub.c    |  4 ++++
>  target/s390x/kvm.c         | 35 ++++++++++++++--------------------
>  target/s390x/kvm_s390x.h   |  1 +
>  10 files changed, 78 insertions(+), 29 deletions(-)
> 
