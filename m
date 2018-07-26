Received: from eggs.gnu.org ([2001:4830:134:3::10]:55360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fibzo-0003UK-K4
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 04:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fibzl-0003Ri-Ly
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 04:51:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fibzl-0003RI-Cm
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 04:51:37 -0400
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
	<20180629115359.GH2568@work-vm> <20180725101836.GI2479@xz-mi>
	<20180725191736.GE2365@work-vm> <20180725200456.GM18452@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1c85e53-1b94-b1df-b7ee-6d93bb43caf6@redhat.com>
Date: Thu, 26 Jul 2018 10:51:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180725200456.GM18452@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v0 0/7] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org, quintela@redhat.com

On 25/07/2018 22:04, Andrea Arcangeli wrote:
> 
> It may look like the uffd-wp model is wish-feature similar to an
> optimization, but without the uffd-wp model when the WP fault is
> triggered by kernel code, the sigsegv model falls apart and requires
> all kind of ad-hoc changes just for this single feature. Plus uffd-wp
> has other benefits: it makes it all reliable in terms of not
> increasing the number of vmas in use during the snapshot. Finally it
> makes it faster too with no mmap_sem for reading and no sigsegv
> signals.
> 
> The non cooperative features got merged first because there was much
> activity on the kernel side on that front, but this is just an ideal
> time to nail down the remaining issues in uffd-wp I think. That I
> believe is time better spent than trying to emulate it with sigsegv
> and changing all drivers to send new events down to qemu specific to
> the sigsegv handling. We considered this before doing uffd for
> postcopy too but overall it's unreliable and more work (no single
> change was then needed to KVM code with uffd to handle postcopy and
> here it should be the same).

I totally agree.  The hard part in userfaultfd was the changes to the
kernel get_user_pages API, but the payback was huge because _all_ kernel
uses (KVM, vhost-net, syscalls, etc.) just work with userfaultfd.  Going
back to mprotect would be a huge mistake.

Paolo
