Received: from eggs.gnu.org ([209.51.188.92]:47929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gx7hi-0005em-Dt
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gx7hd-0000ra-OW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:05:13 -0500
Date: Fri, 22 Feb 2019 11:04:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190222100425.GA8035@dhcp-200-176.str.redhat.com>
References: <20190221173758.24672-1-slp@redhat.com>
	<441b350a-6e01-6163-c2ff-29065a344ab0@redhat.com>
	<20190221193236.5vlbu2aqghtastwv@dritchie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221193236.5vlbu2aqghtastwv@dritchie>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: implement copy offload (-C) for
 dd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Am 21.02.2019 um 20:32 hat Sergio Lopez geschrieben:
> On Thu, Feb 21, 2019 at 12:08:12PM -0600, Eric Blake wrote:
> > On 2/21/19 11:37 AM, Sergio Lopez wrote:
> > > This parameter is analogous to convert's "-C", making use of
> > > bdrv_co_copy_range().
> > 
> > The last time I tried to patch 'qemu-img dd', it was pointed out that it
> > already has several bugs (where it is not on feature-parity with real
> > dd), and that we REALLY want to make it a syntactic sugar wrapper around
> > 'qemu-img convert', rather than duplicating code (which means that
> > qemu-img convert needs to make it easier to do arbitrary offsets and
> > subsets - although to some extent you can already do that with
> > --image-opts and appropriate raw driver wrappers).
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg02618.html
> 
> Interesting, I wasn't aware of that conversation. It might a little
> late to go again through it, but while I don't a strong opinion about
> it, I do have some reservations about the idea of making 'dd' a
> frontend for 'convert'.
> 
> While I do see the functional similarity of both commands, to me they
> are quite different at a semantical level. For 'convert', I do expect
> it to do "the right thing" and use the optimal settings (i.e. choosing
> the best transfer size) by default, while 'dd' is more of "do whatever
> the user told you to do no matter how wrong it is".

I think that's what defaults are for. It would make sense to allow the
user to specify the buffer size even for 'qemu-img convert'. In fact, we
already have a variable for this, we'd just have to add an option to set
it explicitly instead of just relying on what the output block node
tells us.

> Due to this differences, I think turning 'convert' code into something
> able to deal with 'dd' semantics would imply adding a considerable
> number of conditionals, possibly making it harder to maintain than
> keeping it separate.

'qemu-img dd' currently supports five options:

* if and of. These are obviously supported for convert, too.
* count and skip. We don't have these in convert yet. We could either
  add the functionality there or add a raw layer in the 'dd'
  implementation before we call into the common code.
* bs. The buffer size is already configurable in ImgConvertState.

So getting this functionality into 'convert' should be easy.

There are more differences between 'convert' and 'dd' in how exactly the
copy is done. I'm not sure whether there is actually a good use for the
dumb 'dd' copying or whether it was just implemented this way because it
was easier.

Currently we have features like copying only a given range only in 'dd',
and most other features like zero detection, dealing with backing files,
compression, copy offloading or parallel out-of-order copy only in
'convert'.

Actually, we have more than just these two places that copy images: We
also have the mirror block job and for other special cases also the
other block jobs that copy data, each with its own list of features and
missing options.

What I really want to see eventually is a way to have all features
available in all of these instead of only a random selection where
you're out of luck if you want to copy part of an image with compressed
output while the VM is running because these three are features
supported in three different copy implementations and you can't get more
than one of the features at the same time.

Kevin
