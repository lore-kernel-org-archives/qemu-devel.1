Received: from eggs.gnu.org ([2001:4830:134:3::10]:49720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edUra-00040w-Kz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 00:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edUrX-0007lW-J2
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 00:41:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1edUrX-0007kd-Cv
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 00:41:43 -0500
Date: Mon, 22 Jan 2018 13:41:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180122054132.GB16542@xz-mi>
References: <20180119084219.31187-1-peterx@redhat.com>
	<b84e60fb-a527-204b-f355-b051e30d519f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b84e60fb-a527-204b-f355-b051e30d519f@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/2] memory/vfio: notify region_del() when
 unregister listeners
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Jan 19, 2018 at 12:41:01PM +0100, Paolo Bonzini wrote:
> On 19/01/2018 09:42, Peter Xu wrote:
> > I encountered an event loss problem during unplugging vfio devices:
> > 
> >   https://bugzilla.redhat.com/show_bug.cgi?id=1531393
> > 
> > I thought it should be a simple VT-d issue but I was wrong.  The whole
> > debugging leads me to these patches.
> > 
> > Basically I think what we missed is that when unregistering memory
> > listeners, we don't really call region_del() at all.  Instead we just
> > remove ourselves from the listener list.  IMHO that's not enough.  A
> > clean unregister should undo all possible changes that have done
> > during region_add().  That's patch 1.
> > 
> > Patch 2 fixes a vfio issue when patch 1 is applied.
> 
> It makes sense, though of course patch 1 must come second for
> bisectability.  Of the other listeners, most do not implement
> region_del, but commit must be audited as well.  What matters is whether
> the listener is unregistered, and only few are:
> 
> - kvm_arm_machine_init_done must unregister the listener after the
> QSLIST_FOREACH_SAFE loop.

I'll add another patch for this.  I noticed that we haven't really do
the list cleanup on kvm_devices_head.  Say, the items are still on the
list even after they are freed in kvm_arm_machine_init_done():

    QSLIST_FOREACH_SAFE(kd, &kvm_devices_head, entries, tkd) {
        if (kd->kda.addr != -1) {
            kvm_arm_set_device_addr(kd);
        }
        memory_region_unref(kd->mr);
        g_free(kd);
    }

I think it's pretty safe as long as we don't access kvm_devices_head
any more (that's what we did), but would it be better to clean the
list head too?  (CC PeterM too)

Anyway, I'll ignore this for my series and only do what's needed for
the memory listener fix.

> 
> - Xen seems okay
> 
> - vhost needs to remove the memory_region_unref loop after unregistering
> the listener - and this must be done at the same time as patch 1, not before

Noted.  I'll also fix the begin() missing problem you pointed out in
the other comment.  Thanks!

> 
> - virtio seems okay
> 
> Thanks,
> 
> Paolo

-- 
Peter Xu
