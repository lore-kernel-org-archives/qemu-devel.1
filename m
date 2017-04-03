Received: from eggs.gnu.org ([2001:4830:134:3::10]:58140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1cv5qK-0006Y5-8S
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1cv5qG-0002zk-S5
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:32:40 -0400
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:37933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick.ohly@intel.com>)
	id 1cv5qG-0002xj-Iu
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:32:36 -0400
Received: by mail-it0-x230.google.com with SMTP id y18so46775527itc.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 10:32:35 -0700 (PDT)
Message-ID: <1491240750.10884.10.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
Date: Mon, 03 Apr 2017 19:32:30 +0200
In-Reply-To: <20170403170738.GC2768@redhat.com>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

On Mon, 2017-04-03 at 18:07 +0100, Daniel P. Berrange wrote:
> On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
> > Briefly, Theses set of patches introduces:
> >  - new TPM backend driver to support software TPM emulators(swtpm(1)).
> >  - and few supported fixes/enhancements/cleanup to existing tpm backend code.
> > 
> > The similar idea was initiated earliar(2) by Stefan Berger(CCed) with slightly
> > different approach, using CUSE. As swtpm has excellent support for unix domain
> > sockets, hence this implementation uses unix domain sockets to communicate with
> > swtpm.
> > 
> > When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm' and
> > communicates its via Unix domain sockets.
> 
> I'm not convinced that having QEMU spawning swtpm itself is a desirable
> approach, as it means QEMU needs to have all the privileges that swtpm
> will need, so that swtpm can inherit them.

The intended usage is for emulating a TPM in software, for example to do
automated testing of an OS which requires a TPM or to do software
development in an environment were it is easy to reset the TPM. That
doesn't require any privileges, because swtpm just reads and writes
files owned by the user who calls qemu.

>  At the very least I think we
> need to have a way to disable this spawning, so it can connect to a
> pre-existing swtpm process that's been spawned ahead of time. This will
> let us have stricter privilege separation.

Which privileges and use cases did you have in mind?

swtpm already can be started so that it listens on a Unix domain socket,
instead of inheriting something from the parent. It shouldn't be hard to
add that as an alternative to the existing spawning code.

I can think of one use case: spawning swtpm in advance under debugging
tools like gdb or valgrind. Is that enough justification for adding more
code?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
