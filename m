Received: from eggs.gnu.org ([2001:4830:134:3::10]:38445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gOK9Q-00035s-RZ
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 05:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gOK9M-0006wc-TV
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 05:18:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gOK9M-0006wF-Kc
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 05:17:56 -0500
Date: Sun, 18 Nov 2018 12:17:45 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181118101744.GG3638@lap1>
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-26-yuval.shaia@oracle.com>
	<20181117172741.GA10217@srabinov-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117172741.GA10217@srabinov-laptop>
Subject: Re: [Qemu-devel] [PATCH v3 01/23] contrib/rdmacm-mux: Add
 implementation of RDMA User MAD multiplexer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc: marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, cohuck@redhat.com, yuval.shaia@oracle.com

On Sat, Nov 17, 2018 at 07:27:43PM +0200, Shamir Rabinovitch wrote:
> On Tue, Nov 13, 2018 at 09:13:14AM +0200, Yuval Shaia wrote:
> > RDMA MAD kernel module (ibcm) disallow more than one MAD-agent for a
> > given MAD class.
> > This does not go hand-by-hand with qemu pvrdma device's requirements
> > where each VM is MAD agent.
> > Fix it by adding implementation of RDMA MAD multiplexer service which on
> > one hand register as a sole MAD agent with the kernel module and on the
> > other hand gives service to more than one VM.
> > 
> > Design Overview:
> > ----------------
> > A server process is registered to UMAD framework (for this to work the
> > rdma_cm kernel module needs to be unloaded) and creates a unix socket to
> > listen to incoming request from clients.
> > A client process (such as QEMU) connects to this unix socket and
> > registers with its own GID.
> > 
> > TX:
> > ---
> > When client needs to send rdma_cm MAD message it construct it the same
> > way as without this multiplexer, i.e. creates a umad packet but this
> > time it writes its content to the socket instead of calling umad_send().
> > The server, upon receiving such a message fetch local_comm_id from it so
> > a context for this session can be maintain and relay the message to UMAD
> > layer by calling umad_send().
> > 
> > RX:
> > ---
> > The server creates a worker thread to process incoming rdma_cm MAD
> > messages. When an incoming message arrived (umad_recv()) the server,
> > depending on the message type (attr_id) looks for target client by
> > either searching in gid->fd table or in local_comm_id->fd table. With
> > the extracted fd the server relays to incoming message to the client.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >  MAINTAINERS                      |   1 +
> >  Makefile                         |   3 +
> >  Makefile.objs                    |   1 +
> >  contrib/rdmacm-mux/Makefile.objs |   4 +
> >  contrib/rdmacm-mux/main.c        | 771 +++++++++++++++++++++++++++++++
> >  contrib/rdmacm-mux/rdmacm-mux.h  |  56 +++
> >  6 files changed, 836 insertions(+)
> >  create mode 100644 contrib/rdmacm-mux/Makefile.objs
> >  create mode 100644 contrib/rdmacm-mux/main.c
> >  create mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
> >
> 
> Reviewed-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

Thanks Shamir!

Thanks a lot also for all the MAD related tips and comments you gave
off-list, it make the code much more mature and correct.

> 
