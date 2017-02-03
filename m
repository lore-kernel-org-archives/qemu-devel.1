Received: from eggs.gnu.org ([2001:4830:134:3::10]:56039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZj27-0004Uu-ME
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZj23-000655-0e
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:56:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cZj22-00064H-R8
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:56:26 -0500
Date: Fri, 3 Feb 2017 18:56:24 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170203185624.GB13825@redhat.com>
References: <20170203170925.12554-1-rjones@redhat.com>
	<20170203170925.12554-2-rjones@redhat.com>
	<2f5ef524-02d7-e0e8-c693-db932f8270b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f5ef524-02d7-e0e8-c693-db932f8270b9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, dplotnikov@virtuozzo.com, rkagan@virtuozzo.com, den@openvz.org

On Fri, Feb 03, 2017 at 09:31:43AM -0800, Paolo Bonzini wrote:
> 
> 
> On 03/02/2017 09:09, Richard W.M. Jones wrote:
> > +                                                   const char *port,
> > +                                                   bool fork_process)
> > +{
> > +    if (device != NULL) {
> > +        return "NBD device can't be set when using socket activation";
> > +    }
> > +
> > +    if (sockpath != NULL) {
> > +        return "Unix socket can't be set when using socket activation";
> > +    }
> > +
> > +    if (address != NULL) {
> > +        return "The interface can't be set when using socket activation";
> > +    }
> > +
> > +    if (port != NULL) {
> > +        return "TCP port number can't be set when using socket activation";
> > +    }
> > +
> > +    if (fork_process) {
> > +        return "Fork (--fork) can't be used with socket activation";
> > +    }
> 
> Why not?  You could have a Type=forking foo.service, which makes little
> sense but would work.

The answer, I think, is because systemd will lose track of the PID of
the qemu-nbd process.  This would be important because systemd can
kill a socket-activated service which is idle.

Normally you would work around that by using PIDFile=... in the unit
file, but it looks like qemu-nbd doesn't support pid files.

Rich.

> Apart from this, the patch seems fine.
> 
> > +    return NULL;
> > +}
> 
> 

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
