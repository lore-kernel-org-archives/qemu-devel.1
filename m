Received: from eggs.gnu.org ([2001:4830:134:3::10]:58672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dzI8N-00053T-U7
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dzI8I-00048k-1p
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:00:56 -0400
Date: Tue, 3 Oct 2017 10:00:26 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171003080026.6nmw6pdpcuo2sqoe@eukaryote>
References: <20170926175942.GE14717@localhost.localdomain>
	<20171002150127.gbodv4jwdlin7s53@eukaryote>
	<20171002153252.GF4362@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002153252.GF4362@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] blockdev-commit design
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

On Mon, Oct 02, 2017 at 05:32:52PM +0200, Kevin Wolf wrote:
> Am 02.10.2017 um 17:01 hat Kashyap Chamarthy geschrieben:
> > On Tue, Sep 26, 2017 at 07:59:42PM +0200, Kevin Wolf wrote:

[...]

> >         {
> >             "execute": "block-commit",
> >             "arguments": {
> >                 "device": "node-D",
> >                 "job-id": "job0",
> >                 "top": "d.qcow2",
> >                 "base": "a.qcow2"
> >             }
> >         }
> > 
> >     So when merging the top-most layer (D), there's at least one
> >     scenario where we _are_ specifying the "active layer".  And 'top'
> >     _is_ mandatory as seen above.  
> >     
> >     So I wonder if I'm misinterpreting your wording.
> 
> The point is that you specify both "device" and "top". There is no real
> use in specifying "device", because "top" already identifies the node.
> (Of course, file names aren't a good way to identify nodes, so the
> assumption is that they are replaced by node names.)

Ah, thanks.  Now I recall that the existing `block-commit` is the only
command (among mirror, backup, stream, and commit) that doesn't yet
support 'node-name' / 'snapshot-node-name'.  Hence your proposal, to
bring it more in-line w/ blockdev-{mirror,backup}, and `block-stream`[*]
(which accepts 'base-node', and its "device" parameter takes a named
node).

[*] https://lists.gnu.org/archive/html/qemu-block/2017-05/msg01230.html

> In the active commit case, it is just duplicated information, but in the
> case of an intermediate commit, it is additional information that needs
> to be provided without good reason.

It's clearer now, thank you.

> > (2) Also, just for my own education, can you mind expanding a bit more
> >     about the "there can be more than one active layer" scenario?
> 
> Something like this, C is the backing file of both D and E:
> 
> 
>                     +--- D
>                     |
>     A <- B <- C <---+
>                     |
>                     +--- E
> 
> I want to commit C into B. But do I specify D or E as the active layer?
> They are both active layers above C.

Ah-ha, yes, it's the "thin provisoning" case.

Thanks for the explanation.

-- 
/kashyap
