Received: from eggs.gnu.org ([2001:4830:134:3::10]:58411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g9tUV-0007ZZ-Dt
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g9tUP-0006eu-U3
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1g9tUM-0006ZQ-V4
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:00 -0400
Date: Tue, 9 Oct 2018 16:59:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181009165950.007ddd3c.cohuck@redhat.com>
In-Reply-To: <20181009135932.GF29982@rkaganb.sw.ru>
References: <20181008112726.16140-1-vkuznets@redhat.com>
	<20181008112726.16140-2-vkuznets@redhat.com>
	<20181009122046.GC29982@rkaganb.sw.ru>
	<87va6bqnon.fsf@vitty.brq.redhat.com>
	<20181009131738.GE29982@rkaganb.sw.ru>
	<87sh1fqlrw.fsf@vitty.brq.redhat.com>
	<20181009135932.GF29982@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-headers: update to pre-4.20
 (kvm/queue)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 9 Oct 2018 13:59:36 +0000
Roman Kagan <rkagan@virtuozzo.com> wrote:

> On Tue, Oct 09, 2018 at 03:42:27PM +0200, Vitaly Kuznetsov wrote:
> > Roman Kagan <rkagan@virtuozzo.com> writes:
> >   
> > > On Tue, Oct 09, 2018 at 03:01:12PM +0200, Vitaly Kuznetsov wrote:  
> > >> Roman Kagan <rkagan@virtuozzo.com> writes:
> > >>   
> > >> > On Mon, Oct 08, 2018 at 01:27:25PM +0200, Vitaly Kuznetsov wrote:  
> > >> >> This brings us three new defines: KVM_CAP_ARM_INJECT_SERROR_ESR,
> > >> >> KVM_CAP_MSR_PLATFORM_INFO and KVM_CAP_HYPERV_SEND_IPI.
> > >> >> 
> > >> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > >> >> ---
> > >> >>  linux-headers/linux/kvm.h | 7 +++++--
> > >> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> > >> >> 
> > >> >> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > >> >> index 66790724f1..043f1e58b6 100644
> > >> >> --- a/linux-headers/linux/kvm.h
> > >> >> +++ b/linux-headers/linux/kvm.h
> > >> >> @@ -9,7 +9,7 @@
> > >> >>   */
> > >> >>  
> > >> >>  #include <linux/types.h>
> > >> >> -
> > >> >> +#include <linux/compiler.h>
> > >> >>  #include <linux/ioctl.h>
> > >> >>  #include <asm/kvm.h>
> > >> >>  
> > >> >> @@ -481,7 +481,7 @@ struct kvm_dirty_log {
> > >> >>  	__u32 slot;
> > >> >>  	__u32 padding1;
> > >> >>  	union {
> > >> >> -		void *dirty_bitmap; /* one bit per page */
> > >> >> +		void __user *dirty_bitmap; /* one bit per page */  
> > >> >
> > >> > Hmm, I thought "__user" and friends are supposed to get stripped while
> > >> > "make headers_install".  
> > >> 
> > >> ... and of course I forgot about this, will send v2, thanks!  
> > >
> > > Are you trying to say you didn't follow the regular linux header
> > > harvesting process, which is to use scripts/update-linux-headers.sh
> > > (which does 'make headers_install' and then applies further sanitizing,
> > > so that problems like this wouldn't have popped up)?  I think you
> > > should, unless this is an interim patchset pending the merge of the
> > > corresponding KVM changes in the mainline kernel.  
> > 
> > Honestly I didn't know about the standard process but looking at the
> > output:
> > 
> > $ scripts/update-linux-headers.sh PATH/TO/LINUX
> > ...
> > $ git diff --stat
> >  include/standard-headers/linux/input.h |  9 +++++----
> >  linux-headers/asm-arm/kvm.h            | 13 +++++++++++++
> >  linux-headers/asm-arm64/kvm.h          | 13 +++++++++++++
> >  linux-headers/asm-s390/kvm.h           |  2 ++
> >  linux-headers/asm-x86/kvm.h            |  1 +
> >  linux-headers/linux/kvm.h              |  3 +++
> >  linux-headers/linux/vfio.h             |  2 ++
> >  linux-headers/linux/vhost.h            |  2 +-
> >  8 files changed, 40 insertions(+), 5 deletions(-)
> > 
> > I'm not sure if it would make sense to do this instead: the definition I
> > need is currently in kvm/queue and I'm not exactly sure that updating
> > other headers from there (e.g. linux/input.h) makes any sense.  
> 
> Another possible problem is that constants may change on their way from
> kvm/queue to mainline, so people tend to avoid pulling headers from
> anything but Linus' tree.
> 
> Anyway that's not my call.  Paolo, Eduardo, what's your take on this?

I'm neither Paolo nor Eduardo, but my take is that we can sync headers
against something that we can reasonably expect to end up in mainline
soon. So, I think syncing against current kvm/next would be fine (we're
in the late -rc phase), but I'd avoid syncing against kvm/queue.
