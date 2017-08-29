Received: from eggs.gnu.org ([2001:4830:134:3::10]:45203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmiOr-0006kx-Cu
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmiOq-00012G-7W
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:25:57 -0400
MIME-Version: 1.0
In-Reply-To: <CAC2QTZaVWZYmn77LOxxKeukWO70XGNm_GmOoP6ttQOjkm7Ky-Q@mail.gmail.com>
References: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
	<20170505135931.GH11350@stefanha-x1.localdomain>
	<CAC2QTZaVWZYmn77LOxxKeukWO70XGNm_GmOoP6ttQOjkm7Ky-Q@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 29 Aug 2017 16:25:53 +0100
Message-ID: <CAJSP0QWZ_5gsq06-f=kb+D5VvfjiU5Nt1ZqA2rH1mhQWNn5_Ug@mail.gmail.com>
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
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Wu <peter@lekensteyn.nl>, QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Sun, Aug 20, 2017 at 1:47 PM, Ashijeet Acharya
<ashijeetacharya@gmail.com> wrote:
> On Fri, May 5, 2017 at 7:29 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Thu, Apr 27, 2017 at 01:36:30PM +0530, Ashijeet Acharya wrote:
>> > This series helps to provide chunk size independence for DMG driver to
>> > prevent
>> > denial-of-service in cases where untrusted files are being accessed by
>> > the user.
>>
>> The core of the chunk size dependence problem are these lines:
>>
>>     s->compressed_chunk = qemu_try_blockalign(bs->file->bs,
>>                                               ds.max_compressed_size + 1);
>>     s->uncompressed_chunk = qemu_try_blockalign(bs->file->bs,
>>                                                 512 *
>> ds.max_sectors_per_chunk);
>>
>> The refactoring needs to eliminate these buffers because their size is
>> controlled by the untrusted input file.
>
>
> Oh okay, I understand now. But wouldn't I still need to allocate some memory
> for these buffers to be able to use them for the compressed chunks case you
> mentioned below. Instead of letting the DMG images control the size of these
> buffers, maybe I can hard-code the size of these buffers instead?
>
>>
>>
>> After applying your patches these lines remain unchanged and we still
>> cannot use input files that have a 250 MB chunk size, for example.  So
>> I'm not sure how this series is supposed to work.
>>
>> Here is the approach I would take:
>>
>> In order to achieve this dmg_read_chunk() needs to be scrapped.  It is
>> designed to read a full chunk.  The new model does not read full chunks
>> anymore.
>>
>> Uncompressed reads or zeroes should operate directly on qiov, not
>> s->uncompressed_chunk.  This code will be dropped:
>>
>>     data = s->uncompressed_chunk + sector_offset_in_chunk * 512;
>>     qemu_iovec_from_buf(qiov, i * 512, data, 512);
>
>
> I have never worked with qiov before, are there any places where I can refer
> to inside other drivers to get the idea of how to use it directly (I am
> searching by myself in the meantime...)?

A QEMUIOVector is a utility type for struct iovec iov[] processing.
See util/iov.c.  This is called "vectored" or "scatter-gather" I/O.

Instead of transferring data to/from a single <buffer, length> tuple,
they take an array [<buffer, length>].  For example, the buffer "Hello
world" could be split into two elements:
[{"Hello ", strlen("Hello ")},
 {"world", strlen("world")}]

Vectored I/O is often used because it eliminates memory copies.  Say
you have a network packet header struct and also a data payload array.
Traditionally you would have to allocate a new buffer large enough for
both header and payload, copy the header and payload into the buffer,
and finally give this temporary buffer to the I/O function.  This is
inefficient.  With vectored I/O you can create a vector with two
elements, the header and the payload, and the I/O function can process
them without needing a temporary buffer copy.

> I got clearly what you are trying
> to say, but don't know how to implement it. I think, don't we already do
> that for the zeroed chunks in DMG in dmg_co_preadv()?

Yes, dmg_co_preadv() directly zeroes the qiov.  It doesn't use
s->compressed_chunk/s->uncompressed_chunk.

>
>>
>>
>> Compressed reads still buffers.  I suggest the following buffers:
>>
>> 1. compressed_buf - compressed data is read into this buffer from file
>> 2. uncompressed_buf - a place to discard decompressed data while
>>                       simulating a seek operation
>
>
> Yes, these are the buffers whose size I can hard-code as discussed above?
> You can suggest the preferred size to me.

Try starting with 256 KB for both buffers.

>> Data is read from compressed chunks by reading a reasonable amount
>> (64k?) into compressed_buf.  If the user wishes to read at an offset
>> into this chunk then a loop decompresses data we are seeking over into
>> uncompressed_buf (and refills compressed_buf if it becomes empty) until
>> the desired offset is reached.  Then decompression can continue
>> directly into the user's qiov and uncompressed_buf isn't used to
>> decompress the data requested by the user.
>
>
> Yes, this series does exactly that but keeps using the "uncompressed" buffer
> once we reach the desired offset. Once, I understand to use qiov directly,
> we can do this. Also, Kevin did suggest me (as I remember vaguely) that in
> reality we never actually get the read request at a particular offset
> because DMG driver is generally used with "qemu-img convert", which means
> all read requests are from the top.

For performance it's fine to assume a sequential access pattern.  The
block driver should still support random access I/O though.
