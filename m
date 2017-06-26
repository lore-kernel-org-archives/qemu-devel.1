Received: from eggs.gnu.org ([2001:4830:134:3::10]:32992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dPQlr-0003Fo-3Z
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dPQlq-00044X-29
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:57:27 -0400
Date: Mon, 26 Jun 2017 11:57:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170626095719.GB4348@noname.redhat.com>
References: <0f83a15d-66b0-36aa-e5a4-d03cd37757c9@kamp.de>
	<20170626082838.GA4348@noname.redhat.com>
	<0e6586f9-85eb-efcd-4825-20066a7c869a@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6586f9-85eb-efcd-4825-20066a7c869a@kamp.de>
Subject: Re: [Qemu-devel] QCOW2 support for LZO compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu block <qemu-block@nongnu.org>, den@openvz.org, qemu-devel@nongnu.org

Am 26.06.2017 um 11:20 hat Peter Lieven geschrieben:
> >So he chose a different algorithm (zstd). When I asked, he posted a
> >comparison of algorithms (however a generic one and not measured in the
> >context of qemu) that suggests that LZO would be slightly faster, but
> >have a considerable worse compression ratio with the settings that were
> >benchmarked.
> 
> My idea to choose LZO was that it is widely available and available in
> any distro you can think of. We already have probing for it in configure.
> My concern with ZSTD would be that it seems there are no packages
> available for most distros and that it seems to be multi-threaded. I don't
> know if this will cause any trouble?

The availability and that we already link against LZO is a good point. I
think we want to avoid a situation where compressed qcow2 files can't be
read by binaries of popular distributions - after all, downloadable
images are an important use case for compressed images.

> >I think it's clear that if there is any serious interest in compression,
> >we'll want to support at least one more algorithm. What we still need to
> >evaluate is which one(s) to take, and whether a simple incompatible flag
> >in the header like in Den's patch is enough or whether we should add a
> >whole new header field for the compression algorithm (like we already
> >have for encryption).
> 
> From my side there clearly is interest in optimizing the compression. Its
> even possible to speed up zlib by 3-4x times by choosing other parameters
> for deflate which unfortunately are not compatible with our inflate settings.
> 
> I don't know if its worth creating a new header field. Even if we spent to bits
> in the end (one for LZO and one for ZSDT). I think this wouldn't hurt. However,
> there are likely to pop up new compression algorithms in the future and
> a header would be more flexible.

That we could just use different parameters is an important hint that
maybe we don't just need bits to select an algorithm, but also some
space for parameters for the selected algorithm. In this case I think we
need a header change anyway.

> I just don't want to make it too complicated and as you pointed out
> compression is not that interesting for most people - maybe due to its
> speed.

In fact, I think it could be the poor integration in qemu. Compressed
images might be more appealing if you couldn't only write compressed
data with special-case operations like 'qemu-img convert', but just give
an option that you want all writes to be compressed and then use it like
any other image.

Kevin
