Received: from eggs.gnu.org ([209.51.188.92]:52021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1uN1-0006tg-L1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1uMt-000310-Tb
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:51:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1uMq-0002vn-4Q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:51:30 -0500
Date: Thu, 7 Mar 2019 14:51:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307145120.GF32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307142609.GF2843@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com

On Thu, Mar 07, 2019 at 02:26:09PM +0000, Stefan Hajnoczi wrote:
> On Wed, Mar 06, 2019 at 11:22:53PM -0800, elena.ufimtseva@oracle.com wrote:
> > diff --git a/docs/devel/qemu-multiprocess.txt b/docs/devel/qemu-multiprocess.txt
> > new file mode 100644
> > index 0000000..e29c6c8
> > --- /dev/null
> > +++ b/docs/devel/qemu-multiprocess.txt
> 
> Thanks for this document and the interesting work that you are doing.
> I'd like to discuss the security advantages gained by disaggregating
> QEMU in more detail.
> 
> The security model for VMs managed by libvirt (most production x86, ppc,
> s390 guests) is that the QEMU process is untrusted and only has access
> to resources belonging to the guest.  SELinux is used to restrict the
> process from accessing other files, processes, etc on the host.

NB it doesn't have to be SELinux. Libvirt also supports AppArmor and
can even do isolation with traditional DAC by putting each QEMU under
a distinct UID/GID and having libvirtd set ownership on resources each
VM is permitted to use.

> QEMU does not hold privileged resources that must be kept away from the
> guest.  An escaped guest can access its image file, tap file descriptor,
> etc but they are the same resources it could already access via device
> emulation.
> 
> Can you give specific examples of how disaggregation improves security?

I guess one obvious answer is that the existing security mechanisms like
SELinux/ApArmor/DAC can be made to work in a more fine grained manner if
there are distinct processes. This would allow for a more useful seccomp
filter to better protect against secondary kernel exploits should QEMU
itself be exploited, if we can protect individual components.

Not everything is protected by MAC/DAC. For example network based disks
typically have a username + password for accessing the remote storage
server. Best practice would be a distinct username for every QEMU process
such that each can only access its own storage, but I don't know of any
app which does that. So ability to split off backends into separate
processes could limit exposure of information that is not otherwise
protected by current protection models.

Whether any of this is useful in practice depends on the degree to
which the individual disaggregated pieces of QEMU trust each other.
Effectively they would have to consider each other as untrusted,
so one compromised piece can't simply trigger its desired exploit
via the communication channel with another disaggregated piece.

The broadening of vhost-user support is useful with that in much the
same way I imagine.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
