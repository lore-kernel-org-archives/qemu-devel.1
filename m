Received: from eggs.gnu.org ([2001:4830:134:3::10]:59848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cv5w1-0008DP-2V
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cv5vx-0005P4-JA
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:38:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cv5vx-0005N8-61
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:38:29 -0400
Date: Mon, 3 Apr 2017 18:38:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170403173823.GD2112@work-vm>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
	<1491240750.10884.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491240750.10884.10.camel@intel.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

* Patrick Ohly (patrick.ohly@intel.com) wrote:
> On Mon, 2017-04-03 at 18:07 +0100, Daniel P. Berrange wrote:
> > On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
> > > Briefly, Theses set of patches introduces:
> > >  - new TPM backend driver to support software TPM emulators(swtpm(1)).
> > >  - and few supported fixes/enhancements/cleanup to existing tpm backend code.
> > > 
> > > The similar idea was initiated earliar(2) by Stefan Berger(CCed) with slightly
> > > different approach, using CUSE. As swtpm has excellent support for unix domain
> > > sockets, hence this implementation uses unix domain sockets to communicate with
> > > swtpm.
> > > 
> > > When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm' and
> > > communicates its via Unix domain sockets.
> > 
> > I'm not convinced that having QEMU spawning swtpm itself is a desirable
> > approach, as it means QEMU needs to have all the privileges that swtpm
> > will need, so that swtpm can inherit them.
> 
> The intended usage is for emulating a TPM in software, for example to do
> automated testing of an OS which requires a TPM or to do software
> development in an environment were it is easy to reset the TPM. That
> doesn't require any privileges, because swtpm just reads and writes
> files owned by the user who calls qemu.

Being able to do fancier permissions would let you use it in a real VM
situation so that the virtual guest sees it's own TPM; you would then
want to protect the TPM data files pretty carefully - for example stop
one compromised guest sniffing around the TPM data for another.

> >  At the very least I think we
> > need to have a way to disable this spawning, so it can connect to a
> > pre-existing swtpm process that's been spawned ahead of time. This will
> > let us have stricter privilege separation.
> 
> Which privileges and use cases did you have in mind?
> 
> swtpm already can be started so that it listens on a Unix domain socket,
> instead of inheriting something from the parent. It shouldn't be hard to
> add that as an alternative to the existing spawning code.
> 
> I can think of one use case: spawning swtpm in advance under debugging
> tools like gdb or valgrind. Is that enough justification for adding more
> code?

Or you could just remove the spawning code and use existing sockets; less code!

Dave

> -- 
> Best Regards, Patrick Ohly
> 
> The content of this message is my personal opinion only and although
> I am an employee of Intel, the statements I make here in no way
> represent Intel's position on the issue, nor am I authorized to speak
> on behalf of Intel on this matter.
> 
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
