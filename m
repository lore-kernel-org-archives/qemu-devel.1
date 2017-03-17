Received: from eggs.gnu.org ([2001:4830:134:3::10]:41542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coxgH-0003Y4-6B
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 15:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coxgE-0007cy-4C
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 15:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coxgD-0007cu-U0
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 15:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4160F3DBC7
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 19:36:53 +0000 (UTC)
Date: Fri, 17 Mar 2017 19:36:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170317193648.GC3061@work-vm>
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-14-quintela@redhat.com>
	<b1d7d458-d3d3-a396-a048-21eea329a05c@redhat.com>
	<20170317130212.GK2396@work-vm>
	<4e9d3f9a-7e40-7ad6-90cd-63e7befcfe23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e9d3f9a-7e40-7ad6-90cd-63e7befcfe23@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/16] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> 
> 
> On 17/03/2017 14:02, Dr. David Alan Gilbert wrote:
> >>>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
> >>>              fd_num = qemu_get_be16(f);
> >>> -            if (fd_num != 0) {
> >>> -                /* this is yet an unused variable, changed later */
> >>> -                fd_num = fd_num;
> >>> -            }
> >>> +            multifd_recv_page(host, fd_num);
> >>>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> >>>              break;
> >> I still believe this design is a mistake.
> > Is it a use of a separate FD carrying all of the flags/addresses that
> > you object to?
> 
> Yes, it introduces a serialization point unnecessarily, and I don't
> believe the rationale that Juan offered was strong enough.
> 
> This is certainly true on the receive side, but serialization is not
> even necessary on the send side.

Is there an easy way to benchmark it (without writing both) to figure
out if sending (word) (page) on one fd is less efficient than sending
two fd's with the pages and words separate?

> Multiple threads can efficiently split
> the work among themselves and visit the dirty bitmap without a central
> distributor.

I mostly agree; I kind of fancy the idea of having one per NUMA node;
but a central distributor might be a good idea anyway in the cases
where you find the heavy-writer all happens to be in the same area.

> 
> I need to study the code more to understand another issue.  Say you have
> a page that is sent to two different threads in two different
> iterations, like
> 
>     thread 1
>       iteration 1: pages 3, 7
>     thread 2
>       iteration 1: page 3
>       iteration 2: page 7
> 
> Does the code ensure that all threads wait at the end of an iteration?
> Otherwise, thread 2 could process page 7 from iteration 2 before or
> while thread 1 processes the same page from iteration 1.

I think there's a sync at the end of each iteration on Juan's current code
that stops that.

Dave

> 
> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
