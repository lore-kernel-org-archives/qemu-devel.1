Received: from eggs.gnu.org ([2001:4830:134:3::10]:41100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spanella@gmail.com>) id 1etZZS-000865-Jo
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spanella@gmail.com>) id 1etZZM-0000kP-Iw
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:57:30 -0500
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXzMf1UdehS3Cp3Yud6a7U4n-ixYTtCawyd8_wGLbWq0w@mail.gmail.com>
References: <20180306204819.11266-1-stefanha@redhat.com>
	<20180306204819.11266-3-stefanha@redhat.com>
	<CANz-nerKaY_NG4enTxut9RuerWGL47sNKkgtJ_QpHws75ckO7A@mail.gmail.com>
	<CAJSP0QXzMf1UdehS3Cp3Yud6a7U4n-ixYTtCawyd8_wGLbWq0w@mail.gmail.com>
From: Stefano Panella <spanella@gmail.com>
Date: Wed, 7 Mar 2018 13:57:23 +0000
Message-ID: <CANz-neoa1o-x+opbd6OLHdw0K1ROvwA462wXC-MOmXVPDDbu8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] iotests: add 208
 nbd-server + blockdev-snapshot-sync test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Wed, Mar 7, 2018 at 10:55 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Tue, Mar 6, 2018 at 11:25 PM, Stefano Panella <spanella@gmail.com>
wrote:
> > I have applied this patch and when I run the following qmp commands I I
do
> > not see the crash anymore but there is still something wrong because
only
> > /root/a is opened from qemu. It looks like nbd-server-stop is also
getting
> > rid of the nodes added with blockdev-snapshot-sync, therfore is than not
> > possible to do blockdev-del on /root/d because node-name is not found
>
> Nodes are reference counted.  If nothing holds a refcount then the
> node is freed.
Thanks, that explains the behaviour
>
> The blockdev-add command holds a reference to the node.  The node will
> stay alive until blockdev-del, which releases that reference.
>
> blockdev-snapshot-sync does not hold a reference.  Therefore snapshot
> nodes are freed once nothing is using them anymore.  When the snapshot
> node is created, the users of the parent node are updated to point to
> the snapshot node instead.  This is why the NBD server switches to the
> snapshot mode after blockdev-snapshot-sync.
>
> This is why the snapshot nodes disappear after the NBD server is
> stopped while /root/a stays alive.
>
> I'm not sure if the current blockdev-snapshot-sync behavior is useful.
> Perhaps the presence of the "snapshot-node-name" argument should cause
> the snapshot node to be treated as monitor-owned, just like
> blockdev-add.  This would introduce leaks for existing QMP clients
> though, so it may be necessary to add yet another argument for this
> behavior.
that would be nice, I mean to add an extra parameter so it is added to the
monitor
>
> Anyway, I hope this explains the current behavior.  I don't see a
> problem with it, but it's something the API users need to be aware of.
>
Yes, I was not aware of that behaviour, the problem is that many examples
refer
to having a device associated with the blockdev-add'd node therefore we do
not
see this problem.
> If it is a problem for your use case, please explain what you are trying
to do.
>
It is not strictly a problem for my usecase but it would be nice to have
the extra param to
blockdev-snapshot-sync. That would also fix the problem of running multiple
snap-sync
after blockdev-add but before there is any user.
> Stefan
