Received: from eggs.gnu.org ([2001:4830:134:3::10]:55305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehJRg-0003cY-TO
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehJRb-0002Zw-UT
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:18:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ehJRb-0002YO-Lv
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:18:43 -0500
Date: Thu, 1 Feb 2018 16:18:13 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180201181813.GD26425@localhost.localdomain>
References: <bac4ac10-72ef-679e-69e6-95cdda32d2ab@redhat.com>
	<20180201150254-mutt-send-email-mst@kernel.org>
	<20180201163132.GV26425@localhost.localdomain>
	<20180201184655-mutt-send-email-mst@kernel.org>
	<20180201165739.GY26425@localhost.localdomain>
	<20180201185830-mutt-send-email-mst@kernel.org>
	<20180201170136.GA26425@localhost.localdomain>
	<20180201190902-mutt-send-email-mst@kernel.org>
	<20180201173655.GC26425@localhost.localdomain>
	<b8ff1afe-1f7c-c290-e8ac-27f25683c6ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ff1afe-1f7c-c290-e8ac-27f25683c6ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V8 1/4] mem: add share parameter to
 memory-backend-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On Thu, Feb 01, 2018 at 07:58:10PM +0200, Marcel Apfelbaum wrote:
> On 01/02/2018 19:36, Eduardo Habkost wrote:
> > On Thu, Feb 01, 2018 at 07:12:45PM +0200, Michael S. Tsirkin wrote:
> >> On Thu, Feb 01, 2018 at 03:01:36PM -0200, Eduardo Habkost wrote:
> >>> On Thu, Feb 01, 2018 at 06:59:07PM +0200, Michael S. Tsirkin wrote:
> >>>> On Thu, Feb 01, 2018 at 02:57:39PM -0200, Eduardo Habkost wrote:
> >>>>> On Thu, Feb 01, 2018 at 06:48:54PM +0200, Michael S. Tsirkin wrote:
> >>>>>> On Thu, Feb 01, 2018 at 02:31:32PM -0200, Eduardo Habkost wrote:
> >>>>>>> On Thu, Feb 01, 2018 at 04:24:30PM +0200, Michael S. Tsirkin wrote:
> >>>>>>> [...]
> >>>>>>>> The full fix would be to allow QEMU to map a list of
> >>>>>>>> pages to a guest supplied IOVA.
> >>>>>>>
> >>>>>>> Thanks, that's what I expected.
> >>>>>>>
> >>>>>>> While this is not possible, the only requests I have for this
> >>>>>>> patch is that we clearly document:
> >>>>>>> * What's the only purpose of share=on on a host-memory-backend
> >>>>>>>   object (due to pvrdma limitations).
> >>>>>>> * The potential undesirable side-effects of setting share=on.
> >>>>>>> * On the commit message and other comments, clearly distinguish
> >>>>>>>   HVAs in the QEMU address-space from IOVAs, to avoid confusion.
> >>>>>>
> >>>>>> Looking forward, when we do support it, how will management find out
> >>>>>> it no longer needs to pass the share parameter?
> >>>>>>
> >>>>>> Further, if the side effects of the share parameter go away,
> >>>>>> how will it know these no longer hold?
> >>>>>
> >>>>> A query-host-capabilities or similar QMP command seems necessary
> >>>>> for that.
> >>>>
> >>>> Is anyone working on that?
> >>>
> >>> Not yet.
> >>>
> >>> -- 
> >>> Eduardo
> >>
> >> Do these patches need to wait until we do have that command?
> > 
> > I don't think so.  The command will be needed only when
> > support for pvrdma without share=on gets implemented.
> > 
> > Right now, all we need is clear documentation.
> > 
> >>
> >> I'm thinking it's better to have "share=on required with rdma"
> >> and "hugetlbfs not supported with rdma"
> >> than the reverse, this way new hosts do not need to carry
> >> thus stuff around forever.
> > 
> > What do you mean by "the reverse"?
> > 
> > IIUC, the requirements/limitations are:
> > 
> > * share=on required for pvrdma.  Already documented and enforced
> >   by pvrdma code in this series.
> 
> Right.
> 
> > * hugetlbfs not supported with rdma. Is this detected/reported by
> >   QEMU?  Is it documented?
> 
> Yes, enforced by the pvrdma device initialization and documented in the
> corresponding pvrdma doc.
> 
> > * side-effects of share=on.  This is not detected nor documented,
> >   and probably already applies to other memory backends.
> >   * Nice to have: document when share=on is useful (answer:
> >     because of pvrdma), when adding share=on support to
> >     host-memory-backend.
> > 
> 
> The documentation is part of the pvrdma doc.
> What are the side-effects of share=on? I missed that.
> (share=on is new for the memory backed RAM, the file
> backed RAM already had the share parameter)
> 
> One can just grep for "share=on" in the docs directory
> and can easily see the only current usage. But maybe will
> be more, maybe we don't want to limit it for now.
> 
> I am planning to re-spin today/tomorrow before sending
> a pull-request, can you please point me on what documentation
> to add and what side-effects I should document?
> 

The full list of side-effects is not clear to me.  For some of
them, see Documentation/vm/numa_memory_policy.txt on the kernel
tree.

The documentation for memory backend options is at
qemu-options.hx.  Maybe something like this, extending the
existing paragraph:

  The @option{share} boolean option determines whether the memory
  region is marked as private to QEMU, or shared (mapped using
  the MAP_SHARED flag).  The latter allows a co-operating
  external process to access the QEMU memory region.

  @option{share} is also required for pvrdma devices due to
  limitations in the RDMA API provided by Linux.

  Setting share=on might affect the ability to configure NUMA
  bindings for the memory backend under some circumstances, see
  Documentation/vm/numa_memory_policy.txt on the Linux kernel
  source tree for additional details.

I hate to point users to low-level documentation on the kernel
tree, but it's better than nothing.

We also need to list "share" as a valid option at the
"@item -object memory-backend-ram,[...]" line.

-- 
Eduardo
