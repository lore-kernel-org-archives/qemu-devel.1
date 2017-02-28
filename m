Received: from eggs.gnu.org ([2001:4830:134:3::10]:47401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cinCM-0006RV-O0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cinCI-0000uV-JW
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:12:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cinCI-0000sd-Dr
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:12:30 -0500
Date: Tue, 28 Feb 2017 16:12:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170228191226.GI2778@thinpad.lan.raisama.net>
References: <20170227162501.29280-1-ehabkost@redhat.com>
	<CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
	<20170227194134.GH2778@thinpad.lan.raisama.net>
	<20170227205753.60b8a225@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227205753.60b8a225@bahia.lan>
Subject: Re: [Qemu-devel] travis-ci 'make check' timeouts (was Re: [PULL
 00/11] x86 queue, 2017-02-27)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Mon, Feb 27, 2017 at 08:57:53PM +0100, Greg Kurz wrote:
> On Mon, 27 Feb 2017 16:41:34 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Mon, Feb 27, 2017 at 07:16:03PM +0000, Peter Maydell wrote:
> > [...]
> > > This seemed to hang in 'make check' on x86. I didn't have time to
> > > investigate, so I'll have another go with it later.  
> > 
> > I have been seeing lots of travis-ci failures recently because of
> > 'make check' taking too long. The jobs seem to timeout while
> > running tests/test-aio-multithread.
> > 
> > I see similar failures on recent qemu.git master jobs, too:
> > https://travis-ci.org/qemu/qemu/builds
> > 
> > Are they similar to the hang you have seen?
> > 
> 
> The problem with tests/test-aio-multithread got fixed today with the
> following commit:
> 
> http://git.qemu-project.org/?p=qemu.git;a=commit;h=3b1d8169844fafee184366b0e0d7080534758b4d

I see. The failures really stopped after I rebased to that
commit.

I saw a failure on x86-pull-request that seemed to be because of
vhost-user-test[1]. However, after restarting the job, it
passed[2]. (I can't confirm the actual cause of the first
failure, because the log files seem to be temporarily unavailable
on Travis.)

Now, the problem with vhost-user-test is that it is not
guaranteed to work without KVM[3], so we need to add a mechanism
to skip vhost-user-test (or at least make errors non-fatal) if
KVM is unavailable.

[1] https://travis-ci.org/ehabkost/qemu/builds/205849528
[2] https://travis-ci.org/ehabkost/qemu/builds/205850173
[3] See commit cdafe929615ec5eca71bcd5a3d12bab5678e5886

-- 
Eduardo
