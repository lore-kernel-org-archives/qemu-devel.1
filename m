Received: from eggs.gnu.org ([2001:4830:134:3::10]:41014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz2iX-0005iB-52
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz2iT-0003lZ-2p
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:33:13 -0400
Date: Mon, 2 Oct 2017 17:32:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171002153252.GF4362@localhost.localdomain>
References: <20170926175942.GE14717@localhost.localdomain>
	<20171002150127.gbodv4jwdlin7s53@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002150127.gbodv4jwdlin7s53@eukaryote>
Subject: Re: [Qemu-devel] [Qemu-block] blockdev-commit design
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com
List-ID: <qemu-devel.nongnu.org>

Am 02.10.2017 um 17:01 hat Kashyap Chamarthy geschrieben:
> On Tue, Sep 26, 2017 at 07:59:42PM +0200, Kevin Wolf wrote:
> 
> [...]
> 
> > In comparison with the old command, the important changes are:
> > 
> >   * top/base are node names instead of file names.
> > 
> >   * You don't need to specify the active layer any more (not the least
> >     because there could very well be more than one of them), but top
> >     becomes mandatory instead.
> 
> As a user of 'block-commit', I'm a bit confused on your above point.
> Two questions:
> 
> (1) During active block commit, isn't "active layer" == "top"? 
> 
>     With the existing QMP `block-commit`, given: 
>     
>         A <- B <- C <- D (active)
>     
>     To merge B, C, and D (the active layer) into A, I _have_ to specify
>     the active layer, which is "D", as a 'top' parameter:
> 
>         {
>             "execute": "block-commit",
>             "arguments": {
>                 "device": "node-D",
>                 "job-id": "job0",
>                 "top": "d.qcow2",
>                 "base": "a.qcow2"
>             }
>         }
> 
>     So when merging the top-most layer (D), there's at least one
>     scenario where we _are_ specifying the "active layer".  And 'top'
>     _is_ mandatory as seen above.  
>     
>     So I wonder if I'm misinterpreting your wording.

The point is that you specify both "device" and "top". There is no real
use in specifying "device", because "top" already identifies the node.
(Of course, file names aren't a good way to identify nodes, so the
assumption is that they are replaced by node names.)

In the active commit case, it is just duplicated information, but in the
case of an intermediate commit, it is additional information that needs
to be provided without good reason.

> (2) Also, just for my own education, can you mind expanding a bit more
>     about the "there can be more than one active layer" scenario?

Something like this, C is the backing file of both D and E:


                    +--- D
                    |
    A <- B <- C <---+
                    |
                    +--- E

I want to commit C into B. But do I specify D or E as the active layer?
They are both active layers above C.

Kevin
