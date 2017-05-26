Received: from eggs.gnu.org ([2001:4830:134:3::10]:46395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dEDU5-0005xo-IF
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dEDU2-0003Mb-Fj
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:32:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dEDU2-0003MG-9r
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:32:42 -0400
Date: Fri, 26 May 2017 13:32:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170526113238.GH7211@noname.str.redhat.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
	<20170526081147.GC7211@noname.str.redhat.com>
	<ca0a0ede-013d-7281-40e0-5592d0d56ae6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0a0ede-013d-7281-40e0-5592d0d56ae6@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 01/13] qcow2: alloc space for COW in one
 chunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, mreitz@redhat.com, "Denis V. Lunev" <den@openvz.org>

Am 26.05.2017 um 12:57 hat Denis V. Lunev geschrieben:
> On 05/26/2017 11:11 AM, Kevin Wolf wrote:
> >
> > No. This is what you bypass:
> some analysis for the record.
> [...]

> anyway, this is a good list of things to take into account
> within bdrv_allocate. But it is important, that from the
> guest point of view the content of COW areas is not
> changed and thus we can have some important shortcuts.

Yes, not everything in this list is an actual problem for this specific
case. Some things are, though, and if you have to make an analysis like
this, that's already a sign that something is wrong.

The real point I wanted to make is that the bdrv_*() wrappers do a whole
lot of useful things (half of which everyone, including me, would
probably forget when listing them without looking at the code) - and on
top of this, when making changes to the block layer, we have an
expectation that every request consistently goes through the block/io.c
functions. So not wanting one of these useful things in a special case
isn't a good enough reason to completey bypass them.

If we really need to avoid some part of a function, we can always add
another flag or something that makes that part optional.

Kevin
