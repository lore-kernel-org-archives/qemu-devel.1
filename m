Received: from eggs.gnu.org ([2001:4830:134:3::10]:53272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnkh0-00012Z-IF
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnkgx-0000AN-QM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cnkgx-00009P-Jr
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:39 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3AF080461
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 11:32:39 +0000 (UTC)
Date: Tue, 14 Mar 2017 11:32:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170314113234.GE2445@work-vm>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-7-eblake@redhat.com>
	<20170313200752.GG5512@work-vm>
	<89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/30] trace: Fix parameter types in
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Juan Quintela <quintela@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 03/13/2017 03:07 PM, Dr. David Alan Gilbert wrote:
> > * Eric Blake (eblake@redhat.com) wrote:
> >> An upcoming patch will let the compiler warn us when we are silently
> >> losing precision in traces; update the trace definitions to pass
> >> through the full value at the callsite.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> ---
> >>  migration/trace-events | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> 
> >> -postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
> >> +postcopy_ram_fault_thread_request(unsigned long long hostaddr, const char *ramblock, size_t offset) "Request for HVA=%llx rb=%s offset=%zx"
> > 
> > Hmm - why?
> > That's called as:
> >         trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
> >                                                 qemu_ram_get_idstr(rb),
> >                                                 rb_offset);
> >     struct uffd_msg msg;
> > struct uffd_msg {
> > ..
> >         union {
> >                 struct {
> >                         __u64   flags;
> >                         __u64   address;
> >                 } pagefault;
> > ..
> >         } arg;
> > }
> > 
> > So why is a PRIx64 not the right way to print a __u64 ?
> 
> Because __u64 is not the same type as uint64_t.  On 64-bit Linux, __u64
> is 'unsigned long long', while uint64_t is 'unsigned long'.
> 
> > (I prefer %llx to the horrid PRIx64 syntax, but it still seems weird in this case)
> 
> As it is, I'm not sure if __u64 is always 'unsigned long long' in ALL
> Linux clients; an even-more-conservative patch would be to switch all
> callers to use explicit casts to something (like uint64_t or unsigned
> long long) that we have full control over, rather than passing __u64
> where we have no control over what type it ultimately resolves to.

That would be my preference - casting to (uint64_t) at the caller and
keep this as PRIx64.  We know it's a 64bit value so we should never
use unsigned long long anywhere for it.

Dave

> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
