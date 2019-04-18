Received: from eggs.gnu.org ([209.51.188.92]:49830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hHBZ6-0005Yq-N2
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hHBZ5-000131-Hm
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:15:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hHBZ5-00011w-3u
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:15:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id f10so2474782otb.6
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 11:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<20190412083230.GA29850@quack2.suse.cz>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
	<20190418161833.GA22970@infradead.org>
In-Reply-To: <20190418161833.GA22970@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Apr 2019 11:14:59 -0700
Message-ID: <CAPcyv4jPOF_+R6U17J_+88+X8LC-LSPCugA6gbKxuphuuFB2gg@mail.gmail.com>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Jan Kara <jack@suse.cz>, Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM list <kvm@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Ross Zwisler <zwisler@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, "Darrick J. Wong" <darrick.wong@oracle.com>, lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, david <david@fromorbit.com>, cohuck@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, kilobyte@angband.pl, yuval shaia <yuval.shaia@oracle.com>

On Thu, Apr 18, 2019 at 9:18 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
> > > > I'd either add a comment about avoiding retpoline overhead here or just
> > > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
> > > > get confused by the code.
> > >
> > > Isn't this premature optimization?  I really don't like adding things
> > > like this without some numbers to show it's worth it.
> >
> > I don't think it's premature given this optimization technique is
> > already being deployed elsewhere, see:
> >
> > https://lwn.net/Articles/774347/
>
> For one this one was backed by numbers, and second after feedback
> from Linux we switched to the NULL pointer check instead.

Ok I should have noticed the switch to NULL pointer check. However,
the question still stands do we want everyone to run numbers to
justify this optimization, or make it a new common kernel coding
practice to do:

    if (!object->op)
        generic_op(object);
    else
        object->op(object);

...in hot paths? I agree with not doing premature optimization in
principle, but this hack is minimally intrusive from a readability
perspective similar to likely()/unlikely() usage which also don't come
with numbers on a per patch basis.
