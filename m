Received: from eggs.gnu.org ([2001:4830:134:3::10]:55368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0iw1-0002eq-3O
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0ivx-0004Cl-Pt
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:22:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0ivx-0004CL-Ik
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:22:17 -0400
Date: Tue, 27 Mar 2018 15:22:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327072204.GJ17789@xz-mi>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-4-xiaoguangrong@tencent.com>
	<20180321100043.GA30634@xz-mi>
	<48da6d2b-f5f4-a077-f282-ed52392c17f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48da6d2b-f5f4-a077-f282-ed52392c17f9@gmail.com>
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

On Thu, Mar 22, 2018 at 08:03:53PM +0800, Xiao Guangrong wrote:
> 
> 
> On 03/21/2018 06:00 PM, Peter Xu wrote:
> > On Tue, Mar 13, 2018 at 03:57:34PM +0800, guangrong.xiao@gmail.com wrote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > 
> > > Currently the page being compressed is allowed to be updated by
> > > the VM on the source QEMU, correspondingly the destination QEMU
> > > just ignores the decompression error. However, we completely miss
> > > the chance to catch real errors, then the VM is corrupted silently
> > > 
> > > To make the migration more robuster, we copy the page to a buffer
> > > first to avoid it being written by VM, then detect and handle the
> > > errors of both compression and decompression errors properly
> > 
> > Not sure I missed anything important, but I'll just shoot my thoughts
> > as questions (again)...
> > 
> > Actually this is a more general question? Say, even without
> > compression, we can be sending a page that is being modified.
> > 
> > However, IMHO we don't need to worry that, since if that page is
> > modified, we'll definitely send that page again, so the new page will
> > replace the old.  So on destination side, even if decompress() failed
> > on a page it'll be fine IMHO.  Though now we are copying the corrupted
> > buffer.  On that point, I fully agree that we should not - maybe we
> > can just drop the page entirely?
> > 
> > For non-compress pages, we can't detect that, so we'll copy the page
> > even if corrupted.
> > 
> > The special part for compression would be: would the deflate() fail if
> > there is concurrent update to the buffer being compressed?  And would
> > that corrupt the whole compression stream, or it would only fail the
> > deflate() call?
> 
> It is not the same for normal page and compressed page.
> 
> For the normal page, the dirty-log mechanism in QEMU and the infrastructure
> of the network (e.g, TCP) can make sure that the modified memory will
> be posted to the destination without corruption.
> 
> However, nothing can guarantee compression/decompression is BUG-free,
> e,g, consider the case, in the last step, vCPUs & dirty-log are paused and
> the memory is compressed and posted to destination, if there is any error
> in compression/decompression, VM dies silently.

Here do you mean the compression error even if the VM is halted?  I'd
say in that case IMHO the extra memcpy() would still help little since
the coiped page should exactly be the same as the source page?

I'd say I don't know what we can really do if there are zlib bugs. I
was assuming we'll definitely fail in a strange way if there is any,
which should be hard to be detected from QEMU's POV (maybe a
destination VM crash, as you mentioned).  It'll be easy for us to
detect errors when we got error code returned from compress(), however
IMHO when we say "zlib bug" it can also mean that data is corrputed
even compress() and decompress() both returned with good state.

It'll be understandable to me if the problem is that the compress()
API does not allow the input buffer to be changed during the whole
period of the call.  If that is a must, this patch for sure helps.

Thanks,

-- 
Peter Xu
