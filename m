Received: from eggs.gnu.org ([2001:4830:134:3::10]:52538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f11Nf-0001ut-8C
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f11Nc-000473-5K
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:04:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f11Nb-00046v-Vq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:04:04 -0400
Date: Wed, 28 Mar 2018 11:03:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180328030351.GU17789@xz-mi>
References: <201803280843566488166@zte.com.cn>
	<be4636a8-1450-388e-e225-f96c66fe9741@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be4636a8-1450-388e-e225-f96c66fe9741@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] migration: support to
 detectcompression and decompression errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: jiang.biao2@zte.com.cn, kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com, xiaoguangrong@tencent.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Mar 27, 2018 at 10:35:29PM +0800, Xiao Guangrong wrote:
> 
> 
> On 03/28/2018 08:43 AM, jiang.biao2@zte.com.cn wrote:
> > > On 03/27/2018 07:17 PM, Peter Xu wrote:
> > > > On Tue, Mar 27, 2018 at 03:42:32AM +0800, Xiao Guangrong wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > It'll be understandable to me if the problem is that the compress()
> > > > > > API does not allow the input buffer to be changed during the whole
> > > > > > period of the call.  If that is a must, this patch for sure helps.
> > > > > 
> > > > > Yes, that is exactly what i want to say. :)
> > > > 
> > > > So I think now I know what this patch is for. :) And yeah, it makes
> > > > sense.
> > > > 
> > > > Though another question would be: if the buffer is updated during
> > > > compress() and compress() returned error, would that pollute the whole
> > > > z_stream or it only fails the compress() call?
> > > > 
> > > 
> > > I guess deflateReset() can recover everything, i.e, keep z_stream as
> > > it is init'ed by deflate_init().
> > > 
> > > > (Same question applies to decompress().)
> > > > 
> > > > If it's only a compress() error and it won't pollute z_stream (or say,
> > > > it can be recovered after a deflateReset() and then we can continue to
> > > > call deflate() without problem), then we'll actually have two
> > > > alternatives to solve this "buffer update" issue:
> > > > 
> > > > 1. Use the approach of current patch: we copy the page every time, so
> > > >      deflate() never fails because update never happens.  But it's slow
> > > >      since we copy the pages every time.
> > > > 
> > > > 2. Use the old approach, and when compress() fail, we just ignore that
> > > >      page (since now we know that error _must_ be caused by page update,
> > > >      then we are 100% sure that we'll send that page again so it'll be
> > > >      perfectly fine).
> > > > 
> > > 
> > > No, we can't make the assumption that "error _must_ be caused by page update".
> > > No document/ABI about compress/decompress promised it. :)

Indeed, I found no good documents about below errors that jiang.biao
pointed out.

> > So, as I metioned before, can we just distingush the decompress/compress errors
> > from errors caused by page update by the return code of inflate/deflate?
> > According to the zlib manual, there seems to be several error codes for different
> > cases,
> > #define Z_ERRNO        (-1)
> > #define Z_STREAM_ERROR (-2)
> > #define Z_DATA_ERROR   (-3)
> > #define Z_MEM_ERROR    (-4)
> > #define Z_BUF_ERROR    (-5)
> > #define Z_VERSION_ERROR (-6)
> > Did you check the return code when silent failure(not caused by page update)
> > happened before? :)
> 
> I am afraid there is no such error code and i guess zlib is not designed to
> compress the data which is being modified.

So I agree with you, maybe the only right way to do now is copy the
page, until we know better about zlib and find something useful.

Thanks!

-- 
Peter Xu
