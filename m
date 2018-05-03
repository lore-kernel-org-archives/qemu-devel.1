Received: from eggs.gnu.org ([2001:4830:134:3::10]:58726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fEDy9-00035c-1I
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fEDy7-0000Lf-8W
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:08:20 -0400
MIME-Version: 1.0
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
	<44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
In-Reply-To: <44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
From: =?UTF-8?B?5Y+25q6L6aOO?= <renyime@gmail.com>
Date: Thu, 03 May 2018 13:08:08 +0000
Message-ID: <CA+6E1=nHu1RgDD3OFthjj278RBRJAej4jWzr3TU8prWCt9czRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com

> The whole implementation reminds me a lot of qcow2's check function,
> which basically just recalculates the refcounts.  So I'm wondering
> whether you could just count how many clusters with non-0 refcount there
> are and thus simplify the implementation dramatically.

Thanks for your review, Max.

Yes, just get the highest non-0 refcount cluster index can simply get the
end offset. But in some situations(such as some errors happen), a cluster
is indexed in index table, but the refcount may be 0 error, just like the
qcow2 check inconsistency. So I traverse the whole index part, include L1,
L2, snapshot and so on.
I try to reuse the qcow2 check code, but the check routine limit the
avaliable
end to SIZE_MAX which work well in file situation, however the block device
has
a fix end. And the check routine print a lot check info which I don't need.



>> +static int64_t qcow2_get_allocated_file_size(BlockDriverState *bs)
>> +{
>> +    struct stat st;
>> +    if (stat(bs->filename, &st) < 0 || !S_ISBLK(st.st_mode)) {
>> +        goto get_file_size;
>> +    }
>
> This definitely doesn't work because nobody guarantees that bs->filename
> is something that stat() can work with.  I'm aware that you need to do
> the S_ISBLK() check somewhere, but the qcow2 driver is not the right
place.
>
> I don't really have a good way around this, though.  These things come
> to mind:
> ...

Yea, thank you for your suggestion. I think a hack to
qcow2_get_allocated_file_size
will work well.
> (3) As a hack, qcow2_get_allocated_file_size() could first always call
> bdrv_get_allocated_file_size(bs->file->bs), and if that returns 0 (which
> is absolutely impossible for qcow2 files because they have an image
> header that takes up some space), we fall back to
> qcow2_get_block_allocated_size().  While I consider it a hack, I can't
> come up with a scenario where it wouldn't work.


Max Reitz <mreitz@redhat.com> =E4=BA=8E2018=E5=B9=B45=E6=9C=882=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:37=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> [replying to this version because the previous mail doesn't seem to have
> made it to the mailing lists for whatever reason]
>
> On 2018-05-02 15:34, Ivan Ren wrote:
> > qemu-img info with a block device which has a qcow2 format always
> > return 0 for disk size, and this can not reflect the qcow2 size
> > and the used space of the block device. This patch return the
> > allocated size of qcow2 as the disk size.
>
> I'm not quite sure whether you really need this information for block
> devices (I tend to agree with Eric that wr_highest_cluster is the more
> important information there), but I can imagine it just being nice to hav=
e.
>
> So the basic idea makes sense to me, but I think the implementation can
> be simplified and the reporting in qemu-img should be done differently.
>
> >
> > Signed-off-by: Ivan Ren <ivanren@tencent.com>
> > ---
> >  block/qcow2-bitmap.c |  69 +++++++++++++++++
> >  block/qcow2.c        | 212
> +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  block/qcow2.h        |  42 ++++++++++
> >  3 files changed, 323 insertions(+)
>
> The whole implementation reminds me a lot of qcow2's check function,
> which basically just recalculates the refcounts.  So I'm wondering
> whether you could just count how many clusters with non-0 refcount there
> are and thus simplify the implementation dramatically.
>
> [...]
>
> > +static int64_t qcow2_get_allocated_file_size(BlockDriverState *bs)
> > +{
> > +    struct stat st;
> > +    if (stat(bs->filename, &st) < 0 || !S_ISBLK(st.st_mode)) {
> > +        goto get_file_size;
> > +    }
>
> This definitely doesn't work because nobody guarantees that bs->filename
> is something that stat() can work with.  I'm aware that you need to do
> the S_ISBLK() check somewhere, but the qcow2 driver is not the right plac=
e.
>
> I don't really have a good way around this, though.  These things come
> to mind:
>
> (1) We could let file-posix report an error for S_ISBLK because the
> information is known to be usually useless -- but I think that is not
> quite the right thing to do because maybe some block devices do report
> useful information there, I don't know.
>
> (2) Or we introduce a new field in qemu-img info (and thus in ImageInfo,
> too, I suppose?).  qemu-img info (or rather bdrv_query_image_info())
> could detect whether the format layer supports
> bdrv_get_allocated_file_size, and if so, it emits that information
> separately from the allocated size of bs->file->bs.  But that would
> break vmdk...
>
> (3) As a hack, qcow2_get_allocated_file_size() could first always call
> bdrv_get_allocated_file_size(bs->file->bs), and if that returns 0 (which
> is absolutely impossible for qcow2 files because they have an image
> header that takes up some space), we fall back to
> qcow2_get_block_allocated_size().  While I consider it a hack, I can't
> come up with a scenario where it wouldn't work.
>
> Max
>
> > +
> > +    return qcow2_get_block_allocated_size(bs);
> > +
> > +get_file_size:
> > +    if (bs->file) {
> > +        return bdrv_get_allocated_file_size(bs->file->bs);
> > +    }
> > +    return -ENOTSUP;
> > +}
> > +
>
>
