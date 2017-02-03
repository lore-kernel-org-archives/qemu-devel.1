Received: from eggs.gnu.org ([2001:4830:134:3::10]:33904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZjRb-0001gU-Ep
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZjRX-00018q-Gj
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:22:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cZjRX-00018U-9y
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:22:47 -0500
Date: Fri, 3 Feb 2017 19:22:44 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170203192244.GC13825@redhat.com>
References: <20170203170925.12554-1-rjones@redhat.com>
	<20170203170925.12554-2-rjones@redhat.com>
	<2f5ef524-02d7-e0e8-c693-db932f8270b9@redhat.com>
	<20170203185624.GB13825@redhat.com>
	<25dc57d6-ded3-9e4a-92cf-e678d0c92a27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25dc57d6-ded3-9e4a-92cf-e678d0c92a27@redhat.com>
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
Cc: den@openvz.org, stefanha@gmail.com, dplotnikov@virtuozzo.com, qemu-devel@nongnu.org, rkagan@virtuozzo.com

On Fri, Feb 03, 2017 at 10:58:15AM -0800, Paolo Bonzini wrote:
> On 03/02/2017 10:56, Richard W.M. Jones wrote:
> > On Fri, Feb 03, 2017 at 09:31:43AM -0800, Paolo Bonzini wrote:
> >> On 03/02/2017 09:09, Richard W.M. Jones wrote:
> >>> +    if (fork_process) {
> >>> +        return "Fork (--fork) can't be used with socket activation";
> >>> +    }
> >>
> >> Why not?  You could have a Type=forking foo.service, which makes little
> >> sense but would work.
> > 
> > The answer, I think, is because systemd will lose track of the PID of
> > the qemu-nbd process.  This would be important because systemd can
> > kill a socket-activated service which is idle.
> > 
> > Normally you would work around that by using PIDFile=... in the unit
> > file, but it looks like qemu-nbd doesn't support pid files.
> 
> PIDFile is recommended indeed but GuessMainPID=yes (the default for no
> PIDFile) should work, since qemu-nbd only has one parent process.

Another reason:

I think that the --fork option is mainly intended for command line use
of qemu-nbd.  If you're running qemu-nbd from a program there's no
real reason to use --fork, since you can control the fork process
better yourself.

LISTEN_PID isn't settable from the command line.  It's also not
settable from a shell script (as far as I can tell when I was trying
to write a shell script to test nbdkit).  It has to be set between the
fork and exec calls, because it is set to the qemu-nbd PID.

So I don't think --fork and socket activation are really features that
it makes any sense to mix.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
