Received: from eggs.gnu.org ([209.51.188.92]:56008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hImjJ-0008Cc-1u
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 00:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hImiD-0003SQ-O2
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 00:07:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hImi6-0003Lq-LG
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 00:07:12 -0400
Date: Tue, 23 Apr 2019 00:07:03 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1744824090.22901808.1555992423081.JavaMail.zimbra@redhat.com>
In-Reply-To: <x49ef5t7nwp.fsf@segfault.boston.devel.redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
	<20190418161833.GA22970@infradead.org>
	<CAPcyv4jPOF_+R6U17J_+88+X8LC-LSPCugA6gbKxuphuuFB2gg@mail.gmail.com>
	<x497ebm82d4.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4gGmN2LLMPy6BzWpYhRyV7fFNVgh=xAWSAdnnAWu5APtg@mail.gmail.com>
	<x49ef5t7nwp.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/6] libnvdimm: nd_region flush callback
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM list <kvm@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Ross Zwisler <zwisler@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, "Darrick J. Wong" <darrick.wong@oracle.com>, lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, david <david@fromorbit.com>, cohuck@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, kilobyte@angband.pl, yuval shaia <yuval.shaia@oracle.com>


> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > On Mon, Apr 22, 2019 at 8:59 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >>
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >>
> >> > On Thu, Apr 18, 2019 at 9:18 AM Christoph Hellwig <hch@infradead.org>
> >> > wrote:
> >> >>
> >> >> On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
> >> >> > > > I'd either add a comment about avoiding retpoline overhead here
> >> >> > > > or just
> >> >> > > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that
> >> >> > > > people don't
> >> >> > > > get confused by the code.
> >> >> > >
> >> >> > > Isn't this premature optimization?  I really don't like adding
> >> >> > > things
> >> >> > > like this without some numbers to show it's worth it.
> >> >> >
> >> >> > I don't think it's premature given this optimization technique is
> >> >> > already being deployed elsewhere, see:
> >> >> >
> >> >> > https://lwn.net/Articles/774347/
> >> >>
> >> >> For one this one was backed by numbers, and second after feedback
> >> >> from Linux we switched to the NULL pointer check instead.
> >> >
> >> > Ok I should have noticed the switch to NULL pointer check. However,
> >> > the question still stands do we want everyone to run numbers to
> >> > justify this optimization, or make it a new common kernel coding
> >> > practice to do:
> >> >
> >> >     if (!object->op)
> >> >         generic_op(object);
> >> >     else
> >> >         object->op(object);
> >> >
> >> > ...in hot paths?
> >>
> >> I don't think nvdimm_flush is a hot path.  Numbers of some
> >> representative workload would prove one of us right.
> >
> > I'd rather say that the if "if (!op) do_generic()" pattern is more
> > readable in the general case, saves grepping for who set the op in the
> > common case. The fact that it has the potential to be faster is gravy
> > at that point.
> 
> If the primary motivation is performance, then I'd expect performance
> numbers to back it up.  If that isn't the primary motivation, then
> choose whichever way you feel is appropriate.

Agree. This change enhances the code readability. Will add this change in
v6 with other changes.

Thank you! 

Pankaj

> 
> Cheers,
> Jeff
> 
