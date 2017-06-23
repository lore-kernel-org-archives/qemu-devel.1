Received: from eggs.gnu.org ([2001:4830:134:3::10]:45562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dOTXs-0002Z6-3x
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dOTXm-0002Kd-QO
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dOTXm-0002It-HU
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:42:58 -0400
Date: Fri, 23 Jun 2017 11:42:55 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <594CEBEF0200007800166189@prv-mh.provo.novell.com>
Message-ID: <alpine.DEB.2.10.1706231131570.12819@sstabellini-ThinkPad-X260>
References: <59492D1C0200007800164AA3@prv-mh.provo.novell.com>
	<59492D1C0200007800164AA3@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706201421210.12819@sstabellini-ThinkPad-X260>
	<594A2A1C0200007800164F2A@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706211108530.12819@sstabellini-ThinkPad-X260>
	<594B8493020000780016595C@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706221146320.12819@sstabellini-ThinkPad-X260>
	<594CEBEF0200007800166189@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] xen/disk: don't leak stack data via
 response ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien.grall@arm.com>, xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org

On Fri, 23 Jun 2017, Jan Beulich wrote:
> >>> On 22.06.17 at 20:52, <sstabellini@kernel.org> wrote:
> > On Thu, 22 Jun 2017, Jan Beulich wrote:
> >> >>> On 21.06.17 at 20:46, <sstabellini@kernel.org> wrote:
> >> > On Wed, 21 Jun 2017, Jan Beulich wrote:
> >> >> >>> On 20.06.17 at 23:48, <sstabellini@kernel.org> wrote:
> >> >> > On Tue, 20 Jun 2017, Jan Beulich wrote:
> >> >> >> @@ -36,13 +33,7 @@ struct blkif_x86_32_request_discard {
> >> >> >>      blkif_sector_t sector_number;    /* start sector idx on disk (r/w 
> >> > only)  */
> >> >> >>      uint64_t       nr_sectors;       /* # of contiguous sectors to discard 
> >> >   */
> >> >> >>  };
> >> >> >> -struct blkif_x86_32_response {
> >> >> >> -    uint64_t        id;              /* copied from request */
> >> >> >> -    uint8_t         operation;       /* copied from request */
> >> >> >> -    int16_t         status;          /* BLKIF_RSP_???       */
> >> >> >> -};
> >> >> >>  typedef struct blkif_x86_32_request blkif_x86_32_request_t;
> >> >> >> -typedef struct blkif_x86_32_response blkif_x86_32_response_t;
> >> >> >>  #pragma pack(pop)
> >> >> >>  
> >> >> >>  /* x86_64 protocol version */
> >> >> >> @@ -62,20 +53,14 @@ struct blkif_x86_64_request_discard {
> >> >> >>      blkif_sector_t sector_number;    /* start sector idx on disk (r/w 
> >> > only)  */
> >> >> >>      uint64_t       nr_sectors;       /* # of contiguous sectors to discard 
> >> >   */
> >> >> >>  };
> >> >> >> -struct blkif_x86_64_response {
> >> >> >> -    uint64_t       __attribute__((__aligned__(8))) id;
> >> >> >> -    uint8_t         operation;       /* copied from request */
> >> >> >> -    int16_t         status;          /* BLKIF_RSP_???       */
> >> >> >> -};
> >> >> >>
> >> >> >>  typedef struct blkif_x86_64_request blkif_x86_64_request_t;
> >> >> >> -typedef struct blkif_x86_64_response blkif_x86_64_response_t;
> >> >> >>  
> >> >> >>  DEFINE_RING_TYPES(blkif_common, struct blkif_common_request,
> >> >> >> -                  struct blkif_common_response);
> >> >> >> +                  struct blkif_response);
> >> >> >>  DEFINE_RING_TYPES(blkif_x86_32, struct blkif_x86_32_request,
> >> >> >> -                  struct blkif_x86_32_response);
> >> >> >> +                  struct blkif_response QEMU_PACKED);
> >> >> > 
> >> >> > In my test, the previous sizes and alignments of the response structs
> >> >> > were (on both x86_32 and x86_64):
> >> >> > 
> >> >> > sizeof(blkif_x86_32_response)=12   sizeof(blkif_x86_64_response)=16
> >> >> > align(blkif_x86_32_response)=4     align(blkif_x86_64_response)=8
> >> >> > 
> >> >> > While with these changes are now, when compiled on x86_64:
> >> >> > sizeof(blkif_x86_32_response)=11   sizeof(blkif_x86_64_response)=16
> >> >> > align(blkif_x86_32_response)=1     align(blkif_x86_64_response)=8
> >> >> > 
> >> >> > when compiled on x86_32:
> >> >> > sizeof(blkif_x86_32_response)=11   sizeof(blkif_x86_64_response)=12
> >> >> > align(blkif_x86_32_response)=1     align(blkif_x86_64_response)=4
> >> >> > 
> >> >> > Did I do my tests wrong?
> >> >> > 
> >> >> > QEMU_PACKED is not the same as #pragma pack(push, 4). In fact, it is the
> >> >> > same as #pragma pack(push, 1), causing the struct to be densely packed,
> >> >> > leaving no padding whatsever.
> >> >> > 
> >> >> > In addition, without __attribute__((__aligned__(8))),
> >> >> > blkif_x86_64_response won't be 8 bytes aligned when built on x86_32.
> >> >> > 
> >> >> > Am I missing something?
> >> >> 
> >> >> Well, you're mixing attribute application upon structure
> >> >> declaration with attribute application upon structure use. It's
> >> >> the latter here, and hence the attribute doesn't affect
> >> >> structure layout at all. All it does is avoid the _containing_
> >> >> 32-bit union to become 8-byte aligned (and tail padding to be
> >> >> inserted).
> >> > 
> >> > Thanks for the explanation. I admit it's the first time I see the
> >> > aligned attribute being used at structure usage only. I think it's the
> >> > first time QEMU_PACKED is used this way in QEMU too.
> >> > 
> >> > Anyway, even taking that into account, things are still not completely
> >> > right: the alignment of struct blkif_x86_32_response QEMU_PACKED is 4
> >> > bytes as you wrote, but the size of struct blkif_x86_32_response is
> >> > still 16 bytes instead of 12 bytes in my test. I suspect it worked for
> >> > you because the other member of the union (blkif_x86_32_request) is
> >> > larger than that. However, I think is not a good idea to rely on this
> >> > implementation detail. The implementation of DEFINE_RING_TYPES should be
> >> > opaque from our point of view. We shouldn't have to know that there is a
> >> > union there.
> >> 
> >> I don't follow - why should we not rely on this? It is a fundamental
> >> aspect of the shared ring model that requests and responses share
> >> space.
> >> 
> >> > Moreover, the other problem is still unaddressed: the size and alignment
> >> > of blkif_x86_64_response when built on x86_32 are 12 and 4 instead of 16
> >> > and 8 bytes. Is that working also because it's relying on the other
> >> > member of the union to enforce the right alignment and bigger size?
> >> 
> >> Yes. For these as well as your comments further up - sizeof() and
> >> alignof() are completely uninteresting as long as we don't
> >> instantiate objects of those types _and then use them for
> >> communication_. The patch specifically removes instantiation,
> >> switching to a purely pointer based approach. And that is ...
> > 
> > As long as we don't instantiate objects of those types and we use them
> > for communication? This is basically a death trap hidden in an innocuous
> > looking header file.
> 
> I'm sorry, but - what? Neither frontend nor backend are supposed
> to have local instantiations of the structure _and_ use those for
> communication. Doing just one of the two is fine, with the caveat
> of risking to re-introduce the issue being fixed here if done so in a
> backend. Of course the same would apply to request structures
> used by a frontend if it cares to not leak information to the
> backend.
> 
> To outright prevent such issues to occur, it would be a good thing
> if the structures could be marked such that the compiler would
> refuse to create instantiations (i.e. only pointers to the structure
> would be allowed). But since we'd have to arrange for that at
> structure declaration point, and since standard C89 doesn't have
> ways to arrange for that (and I'd have to see whether there's a
> gcc or C99 extension allowing to do so, as I can't think of one
> right away), we simply can't do so.

Yes, you are right that if we could, we would do that. It would make it
safer.


> >> In the end I'm surprised the qemu side is proving so much more
> >> difficult to get accepted compared to the Linux one.
> > 
> > I am happy to write the code and/or the commit message. Would a simple
> > cast like below work to fix the security issue?
> 
> I suppose so, but you do realize that this is _exactly_ what
> my patch does, except you use dangerous casts while I play
> type-safe?

Why is the cast dangerous? Both your patch and my version of it rely on
inner knowledge of the way the rings are laid out in memory, but at
least my patch doesn't introduce the risk of instantiating broken
structs. Besides, type safety checks don't add much value, given that we
rely on the way the ring.h macros have been written, which weren't even
imported in the QEMU project until March this year.

These are the reasons why I prefer my version, but I would consider your
version with clear in-code comments that warn users to avoid
instantiating the structs because they are not ABI compliant.

How do you want to proceed?
