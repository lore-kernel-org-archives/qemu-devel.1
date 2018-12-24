Received: from eggs.gnu.org ([208.118.235.92]:47423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gbX3c-0003za-K7
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 15:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gbX3X-0005tX-Ld
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 15:42:36 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gbX3X-0005r2-E2
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 15:42:31 -0500
Received: by mail-ua1-f67.google.com with SMTP id n7so4094756uao.7
	for <qemu-devel@nongnu.org>; Mon, 24 Dec 2018 12:42:28 -0800 (PST)
MIME-Version: 1.0
References: <320758d6-012b-0b17-2467-f73bf8f4dcb2@virtuozzo.com>
In-Reply-To: <320758d6-012b-0b17-2467-f73bf8f4dcb2@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 24 Dec 2018 22:42:16 +0200
Message-ID: <CAMRbyytAWPgKJFLfSjq4FD-G0dsTB4mJC8sspMx3ApMJ8rGdVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] do not lseek in qcow2 block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Dec 24, 2018 at 5:50 PM Vladimir Sementsov-Ogievskiy <
vsementsov@virtuozzo.com> wrote:

> Hi all!
>
> bdrv_co_block_status digs bs->file for additional, more accurate search
> for hole
> inside region, reported as DATA by bs since long-ago
>
>    commit 5daa74a6ebce7543aaad178c4061dc087bb4c705
>    Author: Paolo Bonzini <pbonzini@redhat.com>
>    Date:   Wed Sep 4 19:00:38 2013 +0200
>
>        block: look for zero blocks in bs->file
>
> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> knows,
> where are holes and where is data. But every block_status request calls
> lseek
> additionally. Recently (and not the first time) we have faced the
> situation,
> when lseek works slow. Of course, it is more about kernel implementation
> of it,
> but why to involve lseek at all, if we have the information on qcow2 level?
> Assume a big disk, full of data, in any iterative copying block job (or img
> convert) we'll call lseek(HOLE) on every iteration, and each of these
> lseeks
> will have to iterate through all metadata up to the end of file. It's
> obviously
> ineffective behavior.

I'm thinking about, how to properly workaround this thing, and I have some
> questions.
>
> What are the cases, when we really need digging for zeros in bs->file?
>
> Why in mirror we care about discard vs write_zeros, keeping in mind, that
> block_status will return ZERO instead for unallocated regions in some
> cases, not
> related to guest view of disk (bdrv_unallocated_blocks_are_zero, backing
> file is
> smaller than request.start)?
>
> And finally, what to do with the problem?
>
> Obviously, the simplest thing is just revert 5daa74a. What will it break?
>
> Otherwise, I need to "revert" it in some cases, and, may be, it should be a
> user-defined parameter.. Should it?  And what are the cases? We need to
> "free"
> of 5daa74a at least qcow2.. But again, should it be format-specific
> option, or
> something more generic?
>
> Then, if it would be separate parameter, how should it interfere with
> want_zeros, or even, should it be want_zeros, reworked a bit to be
> want_lseek?
>

How about having 2 passes:
1. seek DATA/HOLE for entire image, keep result in memory
2. use the result when modifying ranges

This can also help allocation of clusters in a destination image:
1. seek DATA/HOLE in source image
2. allocate blocks in destination
3. convert using out of order writes *without* causing fragmentation in the
destination image.

Here is an example using this approach when copying images to qem-nbd. This
is a pretty
simplistic single threaded implementation in python, using "qemu-img map"
to find the data
and zero ranges. It is faster than qemu-img convert :-)

https://github.com/oVirt/ovirt-imageio/blob/master/examples/nbd-client
https://github.com/oVirt/ovirt-imageio/commit/bec7cb677e33c6d0a7645c367af3d56b70b666db


Nir
