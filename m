Received: from eggs.gnu.org ([2001:4830:134:3::10]:53774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqVUu-0006SQ-50
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 22:00:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqVUo-00061l-He
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 22:00:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqVUo-000601-CV
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 22:00:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C92081A8124
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 02:59:51 +0000 (UTC)
Date: Tue, 27 Feb 2018 10:59:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180227025941.GQ18962@xz-mi>
References: <20180131092835.GA31397@xz-mi>
	<20180131160214-mutt-send-email-mst@kernel.org>
	<20180201021853.GD31397@xz-mi>
	<20180201042234-mutt-send-email-mst@kernel.org>
	<20180201023350.GF31397@xz-mi>
	<20180201144449-mutt-send-email-mst@kernel.org>
	<20180202101140.GC4666@xz-mi>
	<CAA2ifQzRFsZ_=mr9WrFjieTS7YuzQdz5xhoEWOE-5pWWBhBD7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA2ifQzRFsZ_=mr9WrFjieTS7YuzQdz5xhoEWOE-5pWWBhBD7Q@mail.gmail.com>
Subject: Re: [Qemu-devel] Windows balloon driver PFN issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gal Hammer <ghammer@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, Feb 26, 2018 at 10:54:11AM +0200, Gal Hammer wrote:
> Hi Peter,
> 
> On Fri, Feb 2, 2018 at 12:11 PM, Peter Xu <peterx@redhat.com> wrote:
> > On Thu, Feb 01, 2018 at 02:48:20PM +0200, Michael S. Tsirkin wrote:
> >
> > [...]
> >
> >> > > > > PFN is GPA>>12.  Do you have more than 1<<44 bytes of memory in this VM then?
> >> > > >
> >> > > > No.  But isn't it still not good to drop the page at offset zero (and
> >> > > > drop it NNN times)?
> >> > >
> >> > > Absolutely - looks like a bug. I just don't know why does this happen.
> >> >
> >> > IMHO if we are using a PFN array like this:
> >> >
> >> >    u64 pfn_array[];
> >> >
> >> > In the windows guest driver, then we'll see this (as mentioned
> >> > above).  But for sure this is wild guess of mine.
> >>
> >> I don't see code like this anywhere in the windows balloon
> >> driver. It's here:
> >> https://github.com/virtio-win/kvm-guest-drivers-windows.git
> >
> > Thanks for the pointer.  I had a quick glance, the PFN array is
> > defined as:
> >
> >     PPFN_NUMBER             pfns_table;
> >
> > But I don't know what's sizeof(PPFN_NUMBER). :(
> 
> sizeof(PPFN_NUMBER) = sizeof(void*)
> 
> PFN_NUMBER is of an unsigned long type. Although it doesn't matter, as
> a pointer to it is always the same size, 4 bytes in a 32-bit CPU and 8
> bytes in 64-bit one.

Ah, it's not really PPFN_NUMBER that matters, it should be
PFN_NUMBER.  This is how the PFNs are copied in windows driver:

    RtlCopyMemory(ctx->pfns_table, MmGetMdlPfnArray(pPageMdl),
        ctx->num_pfns * sizeof(PFN_NUMBER));

I don't know these APIs, but it looks like MmGetMdlPfnArray() is
returning an PFN_NUMBER array.

And I don't know how the balloon spec says, but in QEMU it's always
using uint32_t as PFN.  See virtio_balloon_handle_output():

    while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4)

So I guess only if sizeof(PFN_NUMBER)==4 is true on both 32/64 bits
platforms of windows, otherwise there might be a problem.

Thanks,

-- 
Peter Xu
