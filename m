Received: from eggs.gnu.org ([2001:4830:134:3::10]:55183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGpRZ-0003Wu-GP
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGpRU-0007Hx-MQ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:01:13 -0500
Date: Mon, 20 Nov 2017 18:01:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171120180102.67205a37.cohuck@redhat.com>
In-Reply-To: <84eddd46-e843-8d4a-5905-1e6956187f4e@de.ibm.com>
References: <20171120123525.147663-1-borntraeger@de.ibm.com>
	<20171120123525.147663-3-borntraeger@de.ibm.com>
	<20171120140052.48c7f646.cohuck@redhat.com>
	<84eddd46-e843-8d4a-5905-1e6956187f4e@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/kvm: use valgrind annotations
 for kvm device attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

On Mon, 20 Nov 2017 14:11:03 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11/20/2017 02:00 PM, Cornelia Huck wrote:
> > On Mon, 20 Nov 2017 13:35:25 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> the KVM_GET/SET_DEVICE_ATTR calls have non-self-describing
> >> side effects. Use valgrind annotations to properly mark
> >> all storage changes instead of using memset or designated
> >> initializers.
> >>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  hw/s390x/s390-skeys-kvm.c    | 12 ++++++++++-
> >>  hw/s390x/s390-stattrib-kvm.c |  7 ++++++
> >>  target/s390x/kvm.c           | 51 ++++++++++++++++++++++++++++++++++++++++----
> >>  3 files changed, 65 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
> >> index dc54ed8..0986795 100644
> >> --- a/hw/s390x/s390-skeys-kvm.c
> >> +++ b/hw/s390x/s390-skeys-kvm.c
> >> @@ -13,6 +13,9 @@
> >>  #include "hw/s390x/storage-keys.h"
> >>  #include "sysemu/kvm.h"
> >>  #include "qemu/error-report.h"
> >> +#ifdef CONFIG_VALGRIND_H
> >> +#include <valgrind/memcheck.h>
> >> +#endif
> >>  
> >>  static int kvm_s390_skeys_enabled(S390SKeysState *ss)
> >>  {
> >> @@ -35,8 +38,15 @@ static int kvm_s390_skeys_get(S390SKeysState *ss, uint64_t start_gfn,
> >>          .count = count,
> >>          .skeydata_addr = (__u64)keys
> >>      };
> >> +    int ret;
> >>  
> >> -    return kvm_vm_ioctl(kvm_state, KVM_S390_GET_SKEYS, &args);
> >> +    ret = kvm_vm_ioctl(kvm_state, KVM_S390_GET_SKEYS, &args);
> >> +    if (!ret) {
> >> +#ifdef CONFIG_VALGRIND_H
> >> +        VALGRIND_MAKE_MEM_DEFINED(keys, count);
> >> +#endif  
> > 
> > This looks ugly :(
> > 
> > Is s390x the only one hitting those side effects?  
> 
> Almost nobody else uses the device attributes. And when they use it they
> have the same problem

Makes sense.

> We papered over some bugs by zero-initializing structs but I think marking
> only the really changed memory will help to detect real bugs (e.g. if code
> reads ioctl data but the ioctl fails we will not detect this when pre-zeroing.

Yes, from a "finding bugs" standpoint that's definitely an
improvement. Maybe a wrapper would improve the readability.
