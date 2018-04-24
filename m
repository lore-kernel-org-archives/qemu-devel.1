Received: from eggs.gnu.org ([2001:4830:134:3::10]:44659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAy86-0002CB-5y
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAy82-0007BZ-Ul
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:37:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fAy82-00079d-P4
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:37:06 -0400
Date: Tue, 24 Apr 2018 14:36:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180424133658.GD2521@work-vm>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
	<20180411122923.GE2667@work-vm>
	<CAOGPPbc1b+0raMDrz5jms+8jeLf6T76nXybsmhLN-Eepe-xXfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGPPbc1b+0raMDrz5jms+8jeLf6T76nXybsmhLN-Eepe-xXfA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Enable postcopy RDMA live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>

* 858585 jemmy (jemmy858585@gmail.com) wrote:
> On Wed, Apr 11, 2018 at 8:29 PM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > * Lidong Chen (jemmy858585@gmail.com) wrote:
> >> Current Qemu RDMA communication does not support send and receive
> >> data at the same time, so when RDMA live migration with postcopy
> >> enabled, the source qemu return path thread get qemu file error.
> >>
> >> Those patch add the postcopy support for RDMA live migration.
> >
> > This description is a little misleading; it doesn't really
> > do RDMA during the postcopy phase - what it really does is disable
> > the RDMA page sending during the postcopy phase, relying on the
> > RDMA codes stream emulation to send the page.
> 
> Hi Dave:
>     I will modify the description in next version patch.
> 
> >
> > That's not necessarily a bad fix; you get the nice performance of RDMA
> > during the precopy phase, but how bad are you finding the performance
> > during the postcopy phase - the RDMA code we have was only really
> > designed for sending small commands over the stream?
> 
> I have not finished the performance test. There are three choices for RDMA
> migration during the postcopy phase.
> 
> 1. RDMA SEND operation from the source qemu
> 2. RDMA Write with Immediate from the source qemu
> 3. RDMA READ from the destination qemu
> 
> In theory, RDMA READ from the destination qemu is the best way.
> But I think it's better to make choice base on the performance result.
> I will send the performance result later.

An RDMA read certainly sounds like an interesting way for postcopy,
since it means the destination would be in control; so it can RDMA into
temporaries that it could then atomically place.  An interesting
thought.

> If use another way during the postcopy phase, it will a big change for the code.
> This patch just make postcopy works, and i will send another patch to
> improve the performance.

Sure; I just wanted to check that, because the existing code wasn't
designed for sending pages, that it wasn't really terribly slow.

Dave

> Thanks.
> 
> >
> > Dave
> >
> >> Lidong Chen (5):
> >>   migration: create a dedicated connection for rdma return path
> >>   migration: add the interface to set get_return_path
> >>   migration: implement the get_return_path for RDMA iochannel
> >>   migration: fix qemu carsh when RDMA live migration
> >>   migration: disable RDMA WRITR after postcopy started.
> >>
> >>  migration/qemu-file-channel.c |  12 ++--
> >>  migration/qemu-file.c         |  13 +++-
> >>  migration/qemu-file.h         |   2 +-
> >>  migration/rdma.c              | 148 ++++++++++++++++++++++++++++++++++++++++--
> >>  4 files changed, 163 insertions(+), 12 deletions(-)
> >>
> >> --
> >> 1.8.3.1
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
