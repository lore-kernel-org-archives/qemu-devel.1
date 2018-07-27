Received: from eggs.gnu.org ([2001:4830:134:3::10]:40038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fixx6-0006Rr-NV
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fixx3-0002wQ-JB
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:18:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fixx3-0002wI-BX
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:18:17 -0400
Reply-To: thuth@redhat.com
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box> <20180727095452.45edee8b@bahia>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f43c94da-43d1-7621-1997-00407708d496@redhat.com>
Date: Fri, 27 Jul 2018 10:18:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180727095452.45edee8b@bahia>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
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
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 07/27/2018 09:54 AM, Greg Kurz wrote:
> On Fri, 27 Jul 2018 15:27:24 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> On Wed, Jul 25, 2018 at 04:45:26PM +0200, Greg Kurz wrote:
>>> Commit b585395b655 fixed a regression introduced by some recent changes
>>> in the XICS code, that was causing QEMU to crash instantly during CPU
>>> hotplug with KVM. This is typically the kind of bug we'd like our
>>> test suite to detect before it gets merged. Unfortunately, the current
>>> tests run with '-machine accel=qtest' and don't exercise KVM specific
>>> paths in QEMU.
>>>
>>> This patch hence changes add_pseries_test_case() to launch QEMU with
>>> '-machine accel=kvm' if KVM is available.
>>>
>>> A notable consequence is that the guest will execute SLOF, but for some
>>> reasons SLOF sometimes hits a program exception. This causes the guest
>>> to loop forever and the test to be stuck.  Since we don't need the guest
>>> to be truely running, let's pass -S to QEMU to avoid that.
>>>
>>> Also disable machine capabilities that could be unavailable in KVM, eg,
>>> when using PR KVM.
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>  
>>
>> I'm pretty sure trying to change the accelerator on a qtest test just
>> doesn't make sense.  We'd need a different approach for testing cpu
>> hotplug against kvm & tcg backends.
>>
> 
> The test starts QEMU, triggers the CPU hotplug code with a QMP command
> and checks the command didn't fail (or QEMU didn't crash, as it would
> have before commit b585395b655a)... I really don't understand what
> is wrong with that... Please elaborate.

For a "real" test, I think you'd need a guest OS that is reacting to the
hot plug events. So maybe this should rather be done in the avocado
framework instead?

 Thomas
