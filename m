Received: from eggs.gnu.org ([2001:4830:134:3::10]:49047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fj0sN-0001p4-FX
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fj0sK-00007n-AC
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:25:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57522 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fj0sK-00005j-3S
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:25:36 -0400
Reply-To: thuth@redhat.com
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box> <20180727095452.45edee8b@bahia>
	<f43c94da-43d1-7621-1997-00407708d496@redhat.com>
	<20180727110000.16f55218@bahia>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <45f3757c-9c29-a894-d709-ba69ea9e9087@redhat.com>
Date: Fri, 27 Jul 2018 13:25:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180727110000.16f55218@bahia>
Content-Type: text/plain; charset=utf-8
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
To: Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 07/27/2018 11:00 AM, Greg Kurz wrote:
> On Fri, 27 Jul 2018 10:18:14 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 07/27/2018 09:54 AM, Greg Kurz wrote:
>>> On Fri, 27 Jul 2018 15:27:24 +1000
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>   
>>>> On Wed, Jul 25, 2018 at 04:45:26PM +0200, Greg Kurz wrote:  
>>>>> Commit b585395b655 fixed a regression introduced by some recent changes
>>>>> in the XICS code, that was causing QEMU to crash instantly during CPU
>>>>> hotplug with KVM. This is typically the kind of bug we'd like our
>>>>> test suite to detect before it gets merged. Unfortunately, the current
>>>>> tests run with '-machine accel=qtest' and don't exercise KVM specific
>>>>> paths in QEMU.
>>>>>
>>>>> This patch hence changes add_pseries_test_case() to launch QEMU with
>>>>> '-machine accel=kvm' if KVM is available.
>>>>>
>>>>> A notable consequence is that the guest will execute SLOF, but for some
>>>>> reasons SLOF sometimes hits a program exception. This causes the guest
>>>>> to loop forever and the test to be stuck.  Since we don't need the guest
>>>>> to be truely running, let's pass -S to QEMU to avoid that.
>>>>>
>>>>> Also disable machine capabilities that could be unavailable in KVM, eg,
>>>>> when using PR KVM.
>>>>>
>>>>> Signed-off-by: Greg Kurz <groug@kaod.org>    
>>>>
>>>> I'm pretty sure trying to change the accelerator on a qtest test just
>>>> doesn't make sense.  We'd need a different approach for testing cpu
>>>> hotplug against kvm & tcg backends.
>>>>  
>>>
>>> The test starts QEMU, triggers the CPU hotplug code with a QMP command
>>> and checks the command didn't fail (or QEMU didn't crash, as it would
>>> have before commit b585395b655a)... I really don't understand what
>>> is wrong with that... Please elaborate.  
>>
>> For a "real" test, I think you'd need a guest OS that is reacting to the
>> hot plug events. So maybe this should rather be done in the avocado
>> framework instead?
>>
> 
> The intent isn't a "real" test actually, but just to exercise the XICS-KVM
> paths in QEMU that get called during CPU hotplug. This cannot be achieved
> with the qtest accelerator.
> 
> This patch would have revealed the regression in b585395b655a right away,
> with the simple 'make check' developers are expected to run before posting.

OK, that's fair. I think what rather bugs me here is that you start QEMU
with -S to work around something that sounds like real bug in SLOF ...
any chance that you could fix that bug in SLOF instead of using -S here?

 Thomas
