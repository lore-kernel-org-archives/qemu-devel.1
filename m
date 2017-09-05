Received: from eggs.gnu.org ([2001:4830:134:3::10]:43865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dpBjy-0002uj-DL
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dpBjr-0007fe-TC
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:09:58 -0400
MIME-Version: 1.0
In-Reply-To: <20170905105804.GL17449@stefanha-x1.localdomain>
References: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
	<20170505135931.GH11350@stefanha-x1.localdomain>
	<CAC2QTZaVWZYmn77LOxxKeukWO70XGNm_GmOoP6ttQOjkm7Ky-Q@mail.gmail.com>
	<CAJSP0QWZ_5gsq06-f=kb+D5VvfjiU5Nt1ZqA2rH1mhQWNn5_Ug@mail.gmail.com>
	<CAC2QTZaei+m5Pp7zeCdf+RJxxLHgS+R+Jxsd83sOU1ZycP8rrw@mail.gmail.com>
	<20170905105804.GL17449@stefanha-x1.localdomain>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Tue, 5 Sep 2017 16:39:49 +0530
Message-ID: <CAC2QTZYqYAMh9XJ=60FgCH+g6o10RycOe2qrQ9G9WziHyHMnAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Refactor DMG driver to have chunk
 size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Wu <peter@lekensteyn.nl>, QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Tue, Sep 5, 2017 at 4:28 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Aug 30, 2017 at 06:32:52PM +0530, Ashijeet Acharya wrote:
> > On Tue, Aug 29, 2017 at 8:55 PM, Stefan Hajnoczi <stefanha@gmail.com>
> wrote:
> >
> > > On Sun, Aug 20, 2017 at 1:47 PM, Ashijeet Acharya
> > > <ashijeetacharya@gmail.com> wrote:
> > > > On Fri, May 5, 2017 at 7:29 PM, Stefan Hajnoczi <stefanha@gmail.com>
> > > wrote:
> > > >>
> > > >> On Thu, Apr 27, 2017 at 01:36:30PM +0530, Ashijeet Acharya wrote:
> > > >> > This series helps to provide chunk size independence for DMG
> driver to
> > > >> > prevent
> > > >> > denial-of-service in cases where untrusted files are being
> accessed by
> > > >> > the user.
> > > >>
> > > >> The core of the chunk size dependence problem are these lines:
> > > >>
> > > >>     s->compressed_chunk = qemu_try_blockalign(bs->file->bs,
> > > >>
>  ds.max_compressed_size +
> > > 1);
> > > >>     s->uncompressed_chunk = qemu_try_blockalign(bs->file->bs,
> > > >>                                                 512 *
> > > >> ds.max_sectors_per_chunk);
> > > >>
> > > >> The refactoring needs to eliminate these buffers because their size
> is
> > > >> controlled by the untrusted input file.
> > > >
> > > >
> > > > Oh okay, I understand now. But wouldn't I still need to allocate some
> > > memory
> > > > for these buffers to be able to use them for the compressed chunks
> case
> > > you
> > > > mentioned below. Instead of letting the DMG images control the size
> of
> > > these
> > > > buffers, maybe I can hard-code the size of these buffers instead?
> > > >
> > > >>
> > > >>
> > > >> After applying your patches these lines remain unchanged and we
> still
> > > >> cannot use input files that have a 250 MB chunk size, for example.
> So
> > > >> I'm not sure how this series is supposed to work.
> > > >>
> > > >> Here is the approach I would take:
> > > >>
> > > >> In order to achieve this dmg_read_chunk() needs to be scrapped.  It
> is
> > > >> designed to read a full chunk.  The new model does not read full
> chunks
> > > >> anymore.
> > > >>
> > > >> Uncompressed reads or zeroes should operate directly on qiov, not
> > > >> s->uncompressed_chunk.  This code will be dropped:
> > > >>
> > > >>     data = s->uncompressed_chunk + sector_offset_in_chunk * 512;
> > > >>     qemu_iovec_from_buf(qiov, i * 512, data, 512);
> > > >
> > > >
> > > > I have never worked with qiov before, are there any places where I
> can
> > > refer
> > > > to inside other drivers to get the idea of how to use it directly (I
> am
> > > > searching by myself in the meantime...)?
> > >
> > > A QEMUIOVector is a utility type for struct iovec iov[] processing.
> > > See util/iov.c.  This is called "vectored" or "scatter-gather" I/O.
> > >
> > > Instead of transferring data to/from a single <buffer, length> tuple,
> > > they take an array [<buffer, length>].  For example, the buffer "Hello
> > > world" could be split into two elements:
> > > [{"Hello ", strlen("Hello ")},
> > >  {"world", strlen("world")}]
> > >
> > > Vectored I/O is often used because it eliminates memory copies.  Say
> > > you have a network packet header struct and also a data payload array.
> > > Traditionally you would have to allocate a new buffer large enough for
> > > both header and payload, copy the header and payload into the buffer,
> > > and finally give this temporary buffer to the I/O function.  This is
> > > inefficient.  With vectored I/O you can create a vector with two
> > > elements, the header and the payload, and the I/O function can process
> > > them without needing a temporary buffer copy.
> > >
> >
> > Thanks for the detailed explanation, I think I understood the concept now
> > and how to use qiov efficiently.
> > Correct me if I am wrong here. In order to use qiov directly for
> > uncompressed chunks:
> >
> > 1. Declare a new local_qiov inside dmg_co_preadv (let's say)
>
> No, the operation should use qiov directly if the chunk is uncompressed.
>
> A temporary buffer is only needed if the data needs to be uncompressed.
>

Yes, I had a chat with John and he cleared most of my doubts on how to
approach it correctly now without using a temporary buffer.


>
> > 2. Initialize it with qemu_iovec_init()
> > 3. Reset it with qemu_iovec_reset() (this is because we will perform this
> > action in a loop and thus need to reset it before every loop?)
> > 4. Declare a buffer "uncompressed_buf" and allocate it with
> > qemu_try_blockalign()
> > 5. Add this buffer to our local_qiov using qemu_iovec_add()
> > 6. Read data from file directly into local_qiov using bdrv_co_preadv()
> > 7. On success concatenate it with the qiov passed into the main
> > dmg_co_preadv() function.
> >
> > I think this method only works for uncompressed chunks. For the
> compressed
> > ones, I believe we will still need to do it in the existing way, i.e.
> read
> > chunk from file -> decompress into output buffer -> use
> > qemu_iovec_from_buf() because we cannot read directly since data is in
> > compressed form. Makes sense?
> >
> >
> > > > I got clearly what you are trying
> > > > to say, but don't know how to implement it. I think, don't we
> already do
> > > > that for the zeroed chunks in DMG in dmg_co_preadv()?
> > >
> > > Yes, dmg_co_preadv() directly zeroes the qiov.  It doesn't use
> > > s->compressed_chunk/s->uncompressed_chunk.
> > >
> > > >
> > > >>
> > > >>
> > > >> Compressed reads still buffers.  I suggest the following buffers:
> > > >>
> > > >> 1. compressed_buf - compressed data is read into this buffer from
> file
> > > >> 2. uncompressed_buf - a place to discard decompressed data while
> > > >>                       simulating a seek operation
> > > >
> > > >
> > > > Yes, these are the buffers whose size I can hard-code as discussed
> above?
> > > > You can suggest the preferred size to me.
> > >
> > > Try starting with 256 KB for both buffers.
> > >
> >
> > Okay, I will do that. But I think we cannot use these buffer sizes for
> bz2
> > chunks (see below)
> >
> >
> > > >> Data is read from compressed chunks by reading a reasonable amount
> > > >> (64k?) into compressed_buf.  If the user wishes to read at an offset
> > > >> into this chunk then a loop decompresses data we are seeking over
> into
> > > >> uncompressed_buf (and refills compressed_buf if it becomes empty)
> until
> > > >> the desired offset is reached.  Then decompression can continue
> > > >> directly into the user's qiov and uncompressed_buf isn't used to
> > > >> decompress the data requested by the user.
> > > >
> > > >
> > > > Yes, this series does exactly that but keeps using the "uncompressed"
> > > buffer
> > > > once we reach the desired offset. Once, I understand to use qiov
> > > directly,
> > > > we can do this. Also, Kevin did suggest me (as I remember vaguely)
> that
> > > in
> > > > reality we never actually get the read request at a particular offset
> > > > because DMG driver is generally used with "qemu-img convert", which
> means
> > > > all read requests are from the top.
> > >
> > > For performance it's fine to assume a sequential access pattern.  The
> > > block driver should still support random access I/O though.
> > >
> >
> > Yes, I agree. But I don't think we can add random access for the bz2
> chunks
> > because they need to be decompressed as a whole and not in parts. I tried
> > to explain it in my cover letter as an important note (
> > https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05327.html).
>
> Here is what you said:
>
>   "bz2 compressed streams do not allow random access midway through a
>   chunk/block as the BZ2_bzDecompress() API in bzlib seeks for the
>   magic key "BZh" before starting decompression.[2] This magic key is
>   present at the start of every chunk/block only and since our cached
>   random access points need not necessarily point to the start of a
>   chunk/block, BZ2_bzDecompress() fails with an error value
>   BZ_DATA_ERROR_MAGIC"
>
> The block driver can simulate random access.  Take a look at the
> BZ2_bzDecompress() API docs:
>
>   "You may provide and remove as little or as much data as you like on
>   each call of BZ2_bzDecompress. In the limit, it is acceptable to
>   supply and remove data one byte at a time, although this would be
>   terribly inefficient. You should always ensure that at least one byte
>   of output space is available at each call.
>
> In other words, bz2 supports streaming.  Therefore you can use the
> buffer sizes I suggested in a loop instead of reading the whole bz2
> block upfront.
>
> If you keep the bz_stream between dmg_uncompress_bz2_do() calls then
> sequential reads can be optimized.  They do not need to reread from the
> beginning of the bz2 block.  That's important because sequential I/O is
> the main access pattern expected by this block driver.
>

Yes, I am trying to implement it exactly like that. It failed the last time
I tried it in v2 but maybe I did something wrong because the docs say
otherwise. As far as the optimization is concerned, I am caching the access
points to resume reading from there in the next call so that should work.

Ashijeet

>
> Stefan
>
