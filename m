Received: from eggs.gnu.org ([209.51.188.92]:60300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gwu5K-0002kW-2t
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gwu5I-00050U-BO
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:32:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1gwu5H-0004zm-W0
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:32:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so10392311wmh.3
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:32:39 -0800 (PST)
Date: Thu, 21 Feb 2019 20:32:36 +0100
From: Sergio Lopez <slp@redhat.com>
Message-ID: <20190221193236.5vlbu2aqghtastwv@dritchie>
References: <20190221173758.24672-1-slp@redhat.com>
	<441b350a-6e01-6163-c2ff-29065a344ab0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441b350a-6e01-6163-c2ff-29065a344ab0@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Thu, Feb 21, 2019 at 12:08:12PM -0600, Eric Blake wrote:
> On 2/21/19 11:37 AM, Sergio Lopez wrote:
> > This parameter is analogous to convert's "-C", making use of
> > bdrv_co_copy_range().
> 
> The last time I tried to patch 'qemu-img dd', it was pointed out that it
> already has several bugs (where it is not on feature-parity with real
> dd), and that we REALLY want to make it a syntactic sugar wrapper around
> 'qemu-img convert', rather than duplicating code (which means that
> qemu-img convert needs to make it easier to do arbitrary offsets and
> subsets - although to some extent you can already do that with
> --image-opts and appropriate raw driver wrappers).
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg02618.html

Interesting, I wasn't aware of that conversation. It might a little late
to go again through it, but while I don't a strong opinion about it, I
do have some reservations about the idea of making 'dd' a frontend for
'convert'.

While I do see the functional similarity of both commands, to me they
are quite different at a semantical level. For 'convert', I do expect it
to do "the right thing" and use the optimal settings (i.e. choosing the
best transfer size) by default, while 'dd' is more of "do whatever the
user told you to do no matter how wrong it is".

Due to this differences, I think turning 'convert' code into something
able to deal with 'dd' semantics would imply adding a considerable
number of conditionals, possibly making it harder to maintain than
keeping it separate.

Sergio (slp).
