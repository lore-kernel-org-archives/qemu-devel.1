Received: from eggs.gnu.org ([2001:4830:134:3::10]:56028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwT7R-0002cu-02
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwT7N-0006sB-OR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:08:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwT7N-0006rz-Hw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:08:13 -0400
Date: Mon, 25 Sep 2017 15:08:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170925150805.3143397d.cohuck@redhat.com>
In-Reply-To: <20170925102302.60587-3-borntraeger@de.ibm.com>
References: <20170925102302.60587-1-borntraeger@de.ibm.com>
	<20170925102302.60587-3-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390/kvm: Support for get/set of
 extended TOD-Clock for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

On Mon, 25 Sep 2017 12:23:02 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
> 
> Provides an interface for getting and setting the guest's extended
> TOD-Clock via a single ioctl to kvm. If the ioctl fails because it
> is not support by kvm, then we fall back to the old style of
> retrieving the clock via two ioctls.
> 
> If kvm fails to set a nonzero epoch index, then we ultimately fail
> the migration altogether and the guest will resume normally on the
> original host machine.

I'd prefer to have that part split off, as it is a change in behaviour
and I don't think we should mix it with adding support for an improved
interface.

> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c |  8 +++-----
>  target/s390x/cpu.c         | 26 +++++++++++++++++++-------
>  target/s390x/kvm-stub.c    | 10 ++++++++++
>  target/s390x/kvm.c         | 35 +++++++++++++++++++++++++++++++++++
>  target/s390x/kvm_s390x.h   |  2 ++
>  5 files changed, 69 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fafbc6d..bad09f5 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -213,13 +213,11 @@ static int gtod_load(QEMUFile *f, void *opaque, int version_id)
>  
>      r = s390_set_clock(&tod_high, &tod_low);
>      if (r) {
> -        warn_report("Unable to set guest clock for migration: %s",
> -                    strerror(-r));
> -        error_printf("Guest clock will not be restored "
> -                     "which could cause the guest to hang.");
> +        error_report("Unable to set guest clock value. "
> +                     "s390_get_clock returned error %d.\n", r);

Please keep to a single phrase in error_report(). Also, I find
strerror() often more useful.

>      }
>  
> -    return 0;
> +    return r;
>  }
>  
>  static SaveVMHandlers savevm_gtod = {

Otherwise looks good.
