Received: from eggs.gnu.org ([2001:4830:134:3::10]:50998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1flA1y-0001Hh-Tq
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1flA1v-0007eC-0M
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:36:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1flA1u-0007dw-Op
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:36:22 -0400
Date: Thu, 2 Aug 2018 11:36:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180802113619.308800a3@redhat.com>
In-Reply-To: <20180801152430.3f1c5cee@bahia.lan>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box>
	<20180727095452.45edee8b@bahia>
	<20180730055715.GD2708@umbus.fritz.box>
	<20180730104145.109ef196@bahia.lan>
	<20180731032559.GH2708@umbus.fritz.box>
	<20180801152430.3f1c5cee@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] tests/cpu-plug-test: check CPU
 hotplug on ppc64 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

On Wed, 1 Aug 2018 15:24:30 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Tue, 31 Jul 2018 13:25:59 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> [...]
> > > 
> > > The CPU hotplug test doesn't seem to do anything on the guest side: it
> > > just checks that 'device_add' returns a response that isn't an
> > > error.    
> > 
> > Right, which makes this ill suited to being a qtest test.  The whole
> > point of qtest is making it easier to test qemu peripherals without
> > having to have specific test code within the guest, by essentially
> > replacing the guest's cpu with a stub controlled by the test harness.
> > That's what the qtest accel is all about.
> >   
> 
> I agree with what a qtest test should be, but cpu-plug-test doesn't
> do anything like that obviously, ie, the guest CPU does nothing at
> all. Only the hotplug path of the QEMU device model that don't need
> the guest to run is tested here.
> 
> The more general issue is that paths guarded with kvm_enabled() cannot
> be tested with a genuine qtest test. That's really unfortunate since
> these paths are sometimes the one that are mostly used on the field,
> eg, in-kernel XICS versus emulated XICS.
> 
> > I think it's confusing to have a test which tries things with both
> > qtest and kvm accelerators.  Looking like a qtest test, people might
> > reasonably think they can extend/refine the test to check behaviour
> > when the guest does respond to the hotplug events.  But such an
> > extension won't work with the kvm accel, because the qtest code used
> > to simulate that guest response won't have any effect with kvm.
> >   
> 
> If the motivation is to let the test be a true qtest in case someone
> wants to emulate some guest behavior, I agree the kvm change is wrong.
> 
> > > I'm not aware that the guest is expected to have a specific behavior
> > > during 'device_add', apart from not crashing or hanging. That was the
> > > initial idea behind passing '-S' to ensure the guest doesn't run.    
> > 
> > Note that with qtest (or -S) we don't even test that minimal
> > condition.  We only test that *qemu* doesn't crash - it could fatally
> > compromise the guest and the test would never know.
> >   
> 
> True.
> 
> > > Your remark seems to be more general though... are you meaning that
> > > doing something like qtest_start("-machine accel=kvm:tcg") is just
> > > wrong ?    
> > 
> > Pretty much, yes.  A non-qtest test which does that is reasonable, but
> > not a qtest test.
> >   
> 
> So, instead of hijacking the current qtest, we may add a non-qtest test
> that would start QEMU with "-machine accel=kvm:tcg -S". This would allow
> at least to test that QEMU doesn't crash right away. And, as suggested
> by Thomas, the coverage could include SLOF as well if we don't pass -S.
> But I would need to understand why SLOF sometimes hits a 0x700 when
> running cpu-plug-test with this patch applied...
Is cpu-plug-test a qtest one?
I was under impression it was using tcg accelerator.

we can switch it to accel=kvm:tcg like bios-tables-test did and
probably reuse boot_sector_init() to make sure that firmware part
at boot is exercised. Trying to do functional hotplug test on top
of that (guest side) probably is out of scope of this unit test (too complex)
and should be left to avocado or likes.
