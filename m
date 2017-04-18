Received: from eggs.gnu.org ([2001:4830:134:3::10]:54688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0QO7-0007ft-Fx
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0QO3-0001iD-Dz
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:29:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1d0QO3-0001hq-8E
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:29:31 -0400
Date: Tue, 18 Apr 2017 12:29:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170418102921.GA9236@noname.redhat.com>
References: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
Subject: Re: [Qemu-devel] DMG chunk size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Am 15.04.2017 um 10:38 hat Ashijeet Acharya geschrieben:
> Hi,
> 
> Some of you are already aware but for the benefit of the open list,
> this mail is regarding the task mentioned
> Here -> http://wiki.qemu-project.org/ToDo/Block/DmgChunkSizeIndependence
> 
> I had a chat with Fam regarding this and he suggested a solution where
> we fix the output buffer size to a max of say "64K" and keep inflating
> until we reach the end of the input stream. We extract the required
> data when we enter the desired range and discard the rest. Fam however
> termed this as only a  "quick fix".

You can cache the current position for a very easy optimisation of
sequential reads.

> The ideal fix would obviously be if we can somehow predict the exact
> location inside the compressed stream relative to the desired offset
> in the output decompressed stream, such as a specific sector in a
> chunk. Unfortunately this is not possible without doing a first pass
> over the decompressed stream as answered on the zlib FAQ page
> Here -> http://zlib.net/zlib_faq.html#faq28
> 
> AFAICT after reading the zran.c example in zlib, the above mentioned
> ideal fix would ultimately lead us to decompress the whole chunk in
> steps at least once to maintain an access point lookup table. This
> solution is better if we get several random access requests over
> different read requests, otherwise it ends up being equal to the fix
> suggested by Fam plus some extra effort needed in building and
> maintaining access points.

I'm not sure if it's worth the additional effort.

If we take a step back, what the dmg driver is used for in practice is
converting images into a different format, that is strictly sequential
I/O. The important thing is that images with large chunk sizes can be
read at all, performance (with sequential I/O) is secondary, and
performance with random I/O is almost irrelevant, as far as I am
concerned.

Kevin
