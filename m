Received: from eggs.gnu.org ([2001:4830:134:3::10]:50508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6eIH-0003Jq-Ox
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6eIB-0005yj-On
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:05:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6eIB-0005yL-GJ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:05:27 -0400
Date: Mon, 23 Oct 2017 16:05:20 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171023150520.GO16472@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171019160419.11611-1-ross.lagerwall@citrix.com>
	<20171019162420.GA8408@redhat.com>
	<2c1c1652-7a70-7330-98b2-9225b35670a8@citrix.com>
	<20171023145050.GM16472@redhat.com>
	<a2f1d43d-c594-004f-9721-06d4769da4cd@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2f1d43d-c594-004f-9721-06d4769da4cd@citrix.com>
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Mon, Oct 23, 2017 at 04:01:12PM +0100, Ross Lagerwall wrote:
> On 10/23/2017 03:50 PM, Daniel P. Berrange wrote:
> > On Mon, Oct 23, 2017 at 03:30:05PM +0100, Ross Lagerwall wrote:
> > > On 10/19/2017 05:24 PM, Daniel P. Berrange wrote:
> > > > On Thu, Oct 19, 2017 at 05:04:19PM +0100, Ross Lagerwall wrote:
> > > > > Add an option to allow calling unshare() just before starting guest
> > > > > execution. The option allows unsharing one or more of the mount
> > > > > namespace, the network namespace, and the IPC namespace. This is useful
> > > > > to restrict the ability of QEMU to cause damage to the system should it
> > > > > be compromised.
> > > > > 
> > > > > An example of using this would be to have QEMU open a QMP socket at
> > > > > startup and unshare the network namespace. The instance of QEMU could
> > > > > still be controlled by the QMP socket since that belongs in the original
> > > > > namespace, but if QEMU were compromised it wouldn't be able to open any
> > > > > new connections, even to other processes on the same machine.
> > > > 
> > > > Unless I'm misunderstanding you, what's described here is already possible
> > > > by just using the 'unshare' command to spawn QEMU:
> > > > 
> > > >     # unshare --ipc --mount --net qemu-system-x86_64 -qmp unix:/tmp/foo,server -vnc :1
> > > >     qemu-system-x86_64: -qmp unix:/tmp/foo,server: QEMU waiting for connection on: disconnected:unix:/tmp/foo,server
> > > > 
> > > > And in another shell I can still access the QMP socket from the original host
> > > > namespace
> > > 
> > > So that works because UNIX domains sockets are not restricted by network
> > > namespaces. But if you try to connect to the VNC server listening on TCP
> > > port 5901, it won't work.
> > > 
> > > > 
> > > >     # ./scripts/qmp/qmp-shell /tmp/foo
> > > >     Welcome to the QMP low-level shell!
> > > >     Connected to QEMU 2.9.1
> > > > 
> > > >     (QEMU) query-kvm
> > > >     {"return": {"enabled": false, "present": true}}
> > > > 
> > > > 
> > > > FWIW, even if that were not possible, you could still do it by wrapping the
> > > > qmp-shell in an 'nsenter' call. eg
> > > > 
> > > >     nsenter --target $QEMUPID --net ./scripts/qmp/qmp-shell /tmp/foo
> > > 
> > > I have a single process which connects to all the QEMUs' listening VNC
> > > sockets so I'm not sure that this would work.
> > 
> > Yes, it can still work - you simply need to use set() to temporarily
> > switch into QEMU's namespace, and then switch back again afterwards
> > 
> >    oldns = open("/proc/self/ns/net")
> >    newns = open("/proc/$PID-OF-QEMU/ns/net")
> >    setns(newns, CLONE_NEWNET)
> > 
> >    ...open connection to VNC...
> >    setns(oldns, CLONE_NEWNET)
> > 
> >    ...use connection to VNC...
> > 
> > The setns() call is thread-local, so you can safely use different
> > namespaces in each thread if you need to have concurrent comms with
> > many QEMUs.
> > 
> 
> Ah, I didn't realize that the namespace could be set locally for a thread.
> That's helpful, thanks!

Oh I should have mentioned that there's some caveats with joining some of
the other namespaces (mount + pid) - so be sure to check the setns() manpage
which describes the edge cases. eg changing pid namespace won't take effect
until you fork() a new child.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
