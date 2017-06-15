Received: from eggs.gnu.org ([2001:4830:134:3::10]:55433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLPUD-0002fL-3X
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLPU9-0000Lx-UI
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:46:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:63054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dLPU9-0000LR-M9
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:46:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORK00HTHW9EYL10@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:46:26 +0100 (BST)
Date: Thu, 15 Jun 2017 10:46:23 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170615074334.GA6638@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <87fuf2egf0.fsf@secure.mitica>
References: <1497346593-8791-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170613093801eucas1p1e2b34c1a72b7150a28007d5b187da82e@eucas1p1.samsung.com>
	<1497346593-8791-3-git-send-email-a.perevalov@samsung.com>
	<87tw3kjer9.fsf@secure.mitica>
	<4edcfe43-115c-ffa5-d63a-ffcabb0bfc6a@samsung.com>
	<87fuf2egf0.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On Wed, Jun 14, 2017 at 05:29:39PM +0200, Juan Quintela wrote:
> Alexey Perevalov <a.perevalov@samsung.com> wrote:
> > On 06/13/2017 02:42 PM, Juan Quintela wrote:
> >> Alexey Perevalov <a.perevalov@samsung.com> wrote:
> >>
> >> Hi
> >>
> >> I think that it would make things clearer if we do a s/copied/received/
> >> As what we are tracking here are the pages that have already been
> >> received.
> >>
> >>
> >>> This patch adds ability to track down already copied
> >>> pages, it's necessary for calculation vCPU block time in
> >>> postcopy migration feature, maybe for restore after
> >>> postcopy migration failure.
> >>> Also it's necessary to solve shared memory issue in
> >>> postcopy livemigration. Information about copied pages
> >>> will be transferred to the software virtual bridge
> >>> (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> >>> already copied pages. fallocate syscall is required for
> >>> remmaped shared memory, due to remmaping itself blocks
> >>> ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> >>> error (struct page is exists after remmap).
> >>>
> >>> Bitmap is placed into RAMBlock as another postcopy/precopy
> >>> related bitmaps.
> >> Why are we not using the TARGET_PAGE_SIZE as units of the bitmap?
> >>
> >>
> >>> copied bitmap is not releasing due to ramblocks is not releasing
> >>> too.
> >> RAMBlocks are used for other reasons, not only migration.  This bitmaps
> >> can be released on the ram_load_cleanup() function.  See my patches on
> >> list about how to use it.
> > I saw patch "migration: Convert ram to use new load_setup()/load_cleanup()",
> > second version
> >
> > ram_load_cleanup - IIUC, calls as load_cleanup callback, from 2 use cases:
> > 	1. QEMU_OPTION_loadvm
> > 	2. hmp_loadvm
> >
> > in both cases: load_snapshot, qemu_loadvm_state,
> > qemu_loadvm_state_cleanup, load_cleanup callback
> 
> Hi
> 
> Are you looking at v2?
> 
Yes, I took v2.
> On my tree:
> 
> int qemu_loadvm_state(QEMUFile *f)
> {
> 
> ....
it presents, but listen thread still exists
and on mis->have_listen_thread condition we're returning
from qemu_loadvm_state, before qemu_loadvm_state_cleanup invocation.
> 
>     qemu_loadvm_state_cleanup();
>     cpu_synchronize_all_post_init();
> 
>     return ret;
> }
> 
> And everything that counts call qemu_loadvm_state() to load the state,
> no?
yes, in my case qemu_loadvm_state is calling.
> 
> Later, Juan.
> 

-- 

BR
Alexey
