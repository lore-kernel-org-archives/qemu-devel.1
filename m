Received: from eggs.gnu.org ([2001:4830:134:3::10]:49442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPRwJ-0002Jl-C4
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPRwH-0001NC-Uf
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:12:19 -0400
Date: Mon, 26 Jun 2017 12:12:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170626111205.GK495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <0f83a15d-66b0-36aa-e5a4-d03cd37757c9@kamp.de>
	<20170626082838.GA4348@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170626082838.GA4348@noname.redhat.com>
Subject: Re: [Qemu-devel] QCOW2 support for LZO compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, den@openvz.org, Laszlo Ersek <lersek@redhat.com>

On Mon, Jun 26, 2017 at 10:28:38AM +0200, Kevin Wolf wrote:
> [ Cc: qemu-devel; don't post to qemu-block only! ]
> 
> Am 26.06.2017 um 09:57 hat Peter Lieven geschrieben:
> > Hi,
> > 
> > I am currently working on optimizing speed for compressed QCOW2
> > images. We use them for templates and would also like to use them for
> > backups, but the latter is almost infeasible because using gzip for
> > compression is horribly slow. I tried to experiment with different
> > options to deflate, but in the end I think its better to use a
> > different compression algorithm for cases where speed matters. As we
> > already have probing for it in configure and as it is widely used I
> > would like to use LZO for that purpose. I think it would be best to
> > have a flag to indicate that compressed blocks use LZO compression,
> > but I would need a little explaination which of the feature fields I
> > have to use to prevent an older (incompatible) Qemu opening LZO
> > compressed QCOW2 images.
> > 
> > I also have already some numbers. I converted a fresh Debian 9 Install
> > which has an uncomressed QCOW2 size of 1158 MB with qemu-img to a
> > compressed QCOW2.  With GZIP compression the result is 356MB whereas
> > the LZO version is 452MB. However, the current GZIP variant uses 35
> > seconds for this operation where LZO only needs 4 seconds. I think is
> > is a good trade in especially when its optional so the user can
> > choose.
> > 
> > What are your thoughts?
> 
> We had a related RFC patch by Den earlier this year, which never
> received many comment and never got out of RFC:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04682.html
> 
> So he chose a different algorithm (zstd). When I asked, he posted a
> comparison of algorithms (however a generic one and not measured in the
> context of qemu) that suggests that LZO would be slightly faster, but
> have a considerable worse compression ratio with the settings that were
> benchmarked.
> 
> I think it's clear that if there is any serious interest in compression,
> we'll want to support at least one more algorithm. What we still need to
> evaluate is which one(s) to take, and whether a simple incompatible flag
> in the header like in Den's patch is enough or whether we should add a
> whole new header field for the compression algorithm (like we already
> have for encryption).

We might also want to consider whether doing compression on individual
qcow2 clusters is the best approach for desired usage scenarios, as
compared to adding a general purpose compression block driver in between
the qcow2 driver and the file driver. eg akin to just running 'gzip' over
the entire qcow2 file. The relatively small size of qcow2 clusters limits
the effectiveness of all compression algorithms we might choose between.
By adding a separate compression driver below qcow2, we can choose a much
larger compression block size, independant of qcow2 cluster size.

Taking a random disk image I have with 1 GB of data. If I tell 'xz' to
compress using 65 KB block sizes (to simulate compression attained if
compressing individual qcow2 clusters in isolation), then I get a file
124 MB in size, which is barely better than that attained with qcow2's
built-in gzip compression. If I tell 'xz' to compress with 16 MB block
sizes though, the output is 114 MB in size, which is a massive win over
gzip.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
