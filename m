Received: from eggs.gnu.org ([2001:4830:134:3::10]:50889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6ypE-0003Hp-7T
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 09:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6yp8-0000mF-KN
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 09:00:56 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:53389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e6yp8-0000lP-Ch
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 09:00:50 -0400
Received: by mail-wm0-x235.google.com with SMTP id r196so3219259wmf.2
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 06:00:50 -0700 (PDT)
Date: Tue, 24 Oct 2017 14:35:53 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171024123553.GG18756@stefanha-x1.localdomain>
References: <20171019160419.11611-1-ross.lagerwall@citrix.com>
	<20171019162420.GA8408@redhat.com>
	<2c1c1652-7a70-7330-98b2-9225b35670a8@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c1c1652-7a70-7330-98b2-9225b35670a8@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v1] os-posix: Add -unshare option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Mon, Oct 23, 2017 at 03:30:05PM +0100, Ross Lagerwall wrote:
> On 10/19/2017 05:24 PM, Daniel P. Berrange wrote:
> > On Thu, Oct 19, 2017 at 05:04:19PM +0100, Ross Lagerwall wrote:
> > > Add an option to allow calling unshare() just before starting guest
> > > execution. The option allows unsharing one or more of the mount
> > > namespace, the network namespace, and the IPC namespace. This is useful
> > > to restrict the ability of QEMU to cause damage to the system should it
> > > be compromised.
> > > 
> > > An example of using this would be to have QEMU open a QMP socket at
> > > startup and unshare the network namespace. The instance of QEMU could
> > > still be controlled by the QMP socket since that belongs in the original
> > > namespace, but if QEMU were compromised it wouldn't be able to open any
> > > new connections, even to other processes on the same machine.
> > 
> > Unless I'm misunderstanding you, what's described here is already possible
> > by just using the 'unshare' command to spawn QEMU:
> > 
> >    # unshare --ipc --mount --net qemu-system-x86_64 -qmp unix:/tmp/foo,server -vnc :1
> >    qemu-system-x86_64: -qmp unix:/tmp/foo,server: QEMU waiting for connection on: disconnected:unix:/tmp/foo,server
> > 
> > And in another shell I can still access the QMP socket from the original host
> > namespace
> 
> So that works because UNIX domains sockets are not restricted by network
> namespaces.

Slightly pedantic but hopefully interesting:

It's not correct to say that UNIX domain sockets are not restricted by
network namespaces, it's more complicated than that.  UNIX domain
sockets fall into several groups:

1. pathname (i.e. they have an inode on disk) sockets are namespaced by
   the mount namespace, not the network namespace.  These sockets can
   only be accessed if the thread's mount (filesystem) namespace can
   reach the inode.

2. unnamed (e.g. socketpair(2)) sockets can never be looked up in any
   namespace anyway, only fork() or file descriptor passing transfers
   them between processes.  Namespaces are irrelevant here.

3. abstract (sun_path[0] == '\0') sockets are affected by the network
   namespace.

Stefan
