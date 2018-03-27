Received: from eggs.gnu.org ([2001:4830:134:3::10]:60447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0mbd-0008OI-96
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0mbY-0004GU-Ft
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:17:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0mbY-0004EH-9F
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:17:28 -0400
Date: Tue, 27 Mar 2018 19:17:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327111717.GN17789@xz-mi>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-4-xiaoguangrong@tencent.com>
	<20180321100043.GA30634@xz-mi>
	<48da6d2b-f5f4-a077-f282-ed52392c17f9@gmail.com>
	<20180327072204.GJ17789@xz-mi>
	<51b59c4c-b153-e711-d78a-8611780b2874@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51b59c4c-b153-e711-d78a-8611780b2874@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] migration: support to detect
 compression and decompression errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Tue, Mar 27, 2018 at 03:42:32AM +0800, Xiao Guangrong wrote:

[...]

> > It'll be understandable to me if the problem is that the compress()
> > API does not allow the input buffer to be changed during the whole
> > period of the call.  If that is a must, this patch for sure helps.
> 
> Yes, that is exactly what i want to say. :)

So I think now I know what this patch is for. :) And yeah, it makes
sense.

Though another question would be: if the buffer is updated during
compress() and compress() returned error, would that pollute the whole
z_stream or it only fails the compress() call?

(Same question applies to decompress().)

If it's only a compress() error and it won't pollute z_stream (or say,
it can be recovered after a deflateReset() and then we can continue to
call deflate() without problem), then we'll actually have two
alternatives to solve this "buffer update" issue:

1. Use the approach of current patch: we copy the page every time, so
   deflate() never fails because update never happens.  But it's slow
   since we copy the pages every time.

2. Use the old approach, and when compress() fail, we just ignore that
   page (since now we know that error _must_ be caused by page update,
   then we are 100% sure that we'll send that page again so it'll be
   perfectly fine).

If you see, IMHO method 2 has its advantage, since actually it
"detects" the page update operation by getting a failure in
compress(), then we don't really need to send that page at all (since
we'll send it later again, for sure).  Then, we not only saved the
memcpy() CPU time for every single page, meanwhile we might save some
bandwidth since we won't bother to send the page when we know the page
is modified.

But all these depend on the assumption that:

1. compress() will fail only because of buffer update, and

2. compress() failures won't pollute the whole z_stream.

Same thing would apply to decompress() side - we drop the corrupted
page (when decompress() returned errors) since we know another one
will come soon.

It's a bit tricky, but I'm still curious about it, since actually
that's mostly the old code before this patch except that we don't
really drop corrputed pages but we still use them (which won't hurt
too IMHO).

Thanks,

-- 
Peter Xu
