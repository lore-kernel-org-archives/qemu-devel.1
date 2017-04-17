Received: from eggs.gnu.org ([2001:4830:134:3::10]:33235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0DHA-0002aH-NR
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0DH6-0003ix-Os
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:29:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1d0DH6-0003ih-FH
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:29:28 -0400
References: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4ea264eb-128c-569a-264c-8ffa3956dca2@redhat.com>
Date: Mon, 17 Apr 2017 16:29:24 -0400
MIME-Version: 1.0
In-Reply-To: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] DMG chunk size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 04/15/2017 04:38 AM, Ashijeet Acharya wrote:
> Hi,
> 
> Some of you are already aware but for the benefit of the open list,
> this mail is regarding the task mentioned
> Here -> http://wiki.qemu-project.org/ToDo/Block/DmgChunkSizeIndependence
> 

OK, so the idea here is that we should be able to read portions of
chunks instead of buffering entire chunks, because chunks can be quite
large and an unverified DMG file should not be able to cause QEMU to
allocate large portions of memory.

Currently, QEMU has a maximum chunk size and it will not open DMG files
that have chunks that exceed that size, correct?

> I had a chat with Fam regarding this and he suggested a solution where
> we fix the output buffer size to a max of say "64K" and keep inflating
> until we reach the end of the input stream. We extract the required
> data when we enter the desired range and discard the rest. Fam however
> termed this as only a  "quick fix".
> 

So it looks like your problem now is how to allow reads to subsets while
tolerating zipped chunks, right?

We can't predict where the data we want is going to appear mid-stream,
but I'm not that familiar with the DMG format, so what does the data
look like and how do we seek to it in general?

We've got the mish blocks stored inside of the ResouceFork (right?), and
each mish block contains one-or-more chunk records. So given any offset
into the virtual file, we at least know which chunk it belongs to, but
thanks to zlib, we can't just read the bits we care about.

(Correct so far?)

> The ideal fix would obviously be if we can somehow predict the exact
> location inside the compressed stream relative to the desired offset
> in the output decompressed stream, such as a specific sector in a
> chunk. Unfortunately this is not possible without doing a first pass
> over the decompressed stream as answered on the zlib FAQ page
> Here -> http://zlib.net/zlib_faq.html#faq28
> 

Yeah, I think you need to start reading the data from the beginning of
each chunk -- but it depends on the zlib data. It COULD be broken up
into different pieces, but there's no way to know without scanning it in
advance.

(Unrelated:

Do we have a zlib format driver?

It might be cute to break up such DMG files and offload zlib
optimization to another driver, like this:

[dmg]-->[zlib]-->[raw]

And we could pretend that each zlib chunk in this file is virtually its
own zlib "file" and access it with modified offsets as appropriate.

Any optimizations we make could just apply to this driver.

[anyway...])


Pre-scanning for these sync points is probably a waste of time as
there's no way to know (*I THINK*) how big each sync-block would be
decompressed, so there's still no way this helps you seek within a
compressed block...

> AFAICT after reading the zran.c example in zlib, the above mentioned
> ideal fix would ultimately lead us to decompress the whole chunk in
> steps at least once to maintain an access point lookup table. This
> solution is better if we get several random access requests over
> different read requests, otherwise it ends up being equal to the fix
> suggested by Fam plus some extra effort needed in building and
> maintaining access points.
> 

Yeah, probably not worth it overall... I have to imagine that most uses
of DMG files are for iso-like cases for installers where accesses are
going to be either sequential (or mostly sequential) and most data will
not be read twice.

I could be wrong, but that's my hunch.

Maybe you can cache the state of the INFLATE process such that once you
fill the cache with data, we can simply resume the INFLATE procedure
when the guest almost inevitably asks for the next subsequent bytes.

That'd probably be efficient /enough/ in most cases without having to
worry about a metadata cache for zlib blocks or a literal data cache for
inflated data.

Or maybe I'm full of crap, I don't know -- I'd probably try a few
approaches and see which one empirically worked better.

> I have not explored the bzip2 compressed chunks yet but have naively
> assumed that we will face the same situation there?
> 

Not sure.

> I would like the community's opinion on this and add their suggestions
> if possible to give me some new thinking points.
> 
> Thanks
> Ashijeet
> 
