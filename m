Received: from eggs.gnu.org ([209.51.188.92]:51644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hH9Xb-0007Z6-Sd
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hH9Xa-0004Vu-BS
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:05:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hH9XZ-0004Ht-Uu
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:05:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id f196so2005835oib.7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 09:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<20190412083230.GA29850@quack2.suse.cz>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x494l73z7th.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Apr 2019 09:05:05 -0700
Message-ID: <CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Jan Kara <jack@suse.cz>, Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM list <kvm@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Ross Zwisler <zwisler@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Christoph Hellwig <hch@infradead.org>, Len Brown <lenb@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, "Darrick J. Wong" <darrick.wong@oracle.com>, lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, david <david@fromorbit.com>, cohuck@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, kilobyte@angband.pl, yuval shaia <yuval.shaia@oracle.com>

On Fri, Apr 12, 2019 at 6:12 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Jan Kara <jack@suse.cz> writes:
>
> > On Thu 11-04-19 07:51:48, Dan Williams wrote:
> >> On Tue, Apr 9, 2019 at 9:09 PM Pankaj Gupta <pagupta@redhat.com> wrote:
> >> > +       } else {
> >> > +               if (nd_region->flush(nd_region))
> >> > +                       rc = -EIO;
> >>
> >> Given the common case wants to be fast and synchronous I think we
> >> should try to avoid retpoline overhead by default. So something like
> >> this:
> >>
> >> if (nd_region->flush == generic_nvdimm_flush)
> >>     rc = generic_nvdimm_flush(...);
> >
> > I'd either add a comment about avoiding retpoline overhead here or just
> > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
> > get confused by the code.
>
> Isn't this premature optimization?  I really don't like adding things
> like this without some numbers to show it's worth it.

I don't think it's premature given this optimization technique is
already being deployed elsewhere, see:

https://lwn.net/Articles/774347/
