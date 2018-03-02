Received: from eggs.gnu.org ([2001:4830:134:3::10]:36011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akpm@linux-foundation.org>) id 1erqXD-0007dU-8Z
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akpm@linux-foundation.org>) id 1erqX9-0005bS-UN
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:40:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akpm@linux-foundation.org>)
	id 1erqX9-0005a4-O0
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:39:59 -0500
Date: Fri, 2 Mar 2018 11:39:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20180302113956.0c0763f6c7cd47e104a59118@linux-foundation.org>
In-Reply-To: <20180302174343.5421-2-aarcange@redhat.com>
References: <20180302174343.5421-1-aarcange@redhat.com>
	<20180302174343.5421-2-aarcange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] mm: gup: teach get_user_pages_unlocked
 to handle FOLL_NOWAIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, linux-mm@kvack.org

On Fri,  2 Mar 2018 18:43:43 +0100 Andrea Arcangeli <aarcange@redhat.com> wrote:

> KVM is hanging during postcopy live migration with userfaultfd because
> get_user_pages_unlocked is not capable to handle FOLL_NOWAIT.
> 
> Earlier FOLL_NOWAIT was only ever passed to get_user_pages.
> 
> Specifically faultin_page (the callee of get_user_pages_unlocked
> caller) doesn't know that if FAULT_FLAG_RETRY_NOWAIT was set in the
> page fault flags, when VM_FAULT_RETRY is returned, the mmap_sem wasn't
> actually released (even if nonblocking is not NULL). So it sets
> *nonblocking to zero and the caller won't release the mmap_sem
> thinking it was already released, but it wasn't because of
> FOLL_NOWAIT.
> 
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>

I added

Fixes: ce53053ce378c ("kvm: switch get_user_page_nowait() to get_user_pages_unlocked()")
Cc: <stable@vger.kernel.org>
