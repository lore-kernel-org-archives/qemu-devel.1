Received: from eggs.gnu.org ([2001:4830:134:3::10]:56595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVF1L-0006fS-5u
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVF1J-0002Dp-6d
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:14:15 -0500
Date: Fri, 7 Dec 2018 13:14:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181207121402.GD5119@linux.fritz.box>
References: <75f7e3cc-bd46-c743-84ab-cd68bcb1dcfb@de.ibm.com>
	<d0966d94-87d4-0f25-f2e0-846a1d338be7@de.ibm.com>
	<20181205084614.GA4018@dhcp-200-186.str.redhat.com>
	<30858ce0-5b4b-c3c4-b846-6a214670f8d2@de.ibm.com>
	<f91cf64b-db93-f2e5-bceb-93013592ad03@virtuozzo.com>
	<34e1b572-41b0-ae72-6d12-283516c9218c@de.ibm.com>
	<7d5d502b-9bba-47ed-648e-65495765c4ca@virtuozzo.com>
	<f791fd99-4055-c308-6e62-fc3b818c7ebf@de.ibm.com>
	<61995d89-db9d-ac34-0b32-aacffd49b184@virtuozzo.com>
	<b11370e6-23f2-9586-aae4-915b8743a440@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11370e6-23f2-9586-aae4-915b8743a440@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 2/2] iotests: simple mirror
 test with kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 06.12.2018 um 12:05 hat Christian Borntraeger geschrieben:
> 
> 
> On 05.12.2018 17:09, Vladimir Sementsov-Ogievskiy wrote:
> > 05.12.2018 18:52, Christian Borntraeger wrote:
> >>
> >>
> >> On 05.12.2018 14:39, Vladimir Sementsov-Ogievskiy wrote:
> >>> 05.12.2018 15:35, Christian Borntraeger wrote:
> >>>>
> >>>>
> >>>> On 05.12.2018 13:00, Vladimir Sementsov-Ogievskiy wrote:
> >>>>> 05.12.2018 12:01, Christian Borntraeger wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 05.12.2018 09:46, Kevin Wolf wrote:
> >>>>>>> Am 05.12.2018 um 09:23 hat Christian Borntraeger geschrieben:
> >>>>>>>>>>> +# prepare source image
> >>>>>>>>>>> +qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
> >>>>>>>>>>> +                str(size))
> >>>>>>>>>>> +
> >>>>>>>>>>> +vm = QEMUMachine(iotests.qemu_prog)
> >>>>>>>>>>> +vm.add_args('-machine', 'pc,accel=kvm')
> >>>>>>>>
> >>>>>>>> This (pc) clearly does not work on other architectures.
> >>>>>>>> In addition to that, I also need to add -no-shutdown on s390 (see 068 for a similar case)
> >>>>>>>
> >>>>>>> Leaving out pc definitely makes sense, and the bug still reproduces for
> >>>>>>> me without it.
> >>>>>>>
> >>>>>>> I don't understand the -no-shutdown, though. Already for 068, neither
> >>>>>>> the code nor the commit message when it was added explain why this is
> >>>>>>> needed.
> >>>>>>>
> >>>>>>> Can you turn this into a proper patch and add a comment why -no-shutdown
> >>>>>>> is needed?
> >>>>>>
> >>>>>> I already sent this patch. The reason is that there is no BIOS in a classical sense
> >>>>>> on s390x. If no bootable image (external kernel or from disk) is found, the small boot
> >>>>>> bios loads a disabled wait PSW. The default action for that is then shutdown.
> >>>>>>
> >>>>>
> >>>>> Is it an option for you just drop the whole line "vm.add_args('-machine', 'pc,accel=kvm')"?
> >>>>> The problem without it for me was that gdb failed to produce full and nice backtrace, but
> >>>>> test worked anyway
> >>>>
> >>>> In the commid message Vladimir said that kvm is necessary to trigger the problem.
> >>>>
> >>>
> >>> No, I didn't)
> >>>
> >>> and it's in the comment:
> >>> # 3. drop kvm and use iotests.VM() (maybe, because of qtest) (however, it still
> >>> #    reproduces, if just drop kvm, but gdb failed to produce full backtraces
> >>> #    for me)
> >>
> >> Ok, so I would be fine with completely dropping that line.
> >>
> >> the patch would then be
> >>
> >>
> >>
> >> "-machine pc" will not work all architectures. Lets fall back to the
> >> default machine by not specifying anything for the machine.
> >>
> >> In addition we also need to specify -no-shutdown on s390 as qemu will
> >> exit on guest shutdown. This happens when there is no kernel or bootable
> >> disk on s390.
> >>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>   tests/qemu-iotests/235 | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
> >> index da044ed34e..329da8f0c2 100755
> >> --- a/tests/qemu-iotests/235
> >> +++ b/tests/qemu-iotests/235
> >> @@ -49,7 +49,8 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
> >>                   str(size))
> >>   
> >>   vm = QEMUMachine(iotests.qemu_prog)
> >> -vm.add_args('-machine', 'pc,accel=kvm')
> >> +if iotests.qemu_default_machine == 's390-ccw-virtio':
> >> +        vm.add_args('-no-shutdown')
> >>   vm.add_args('-drive', 'id=src,file=' + disk)
> >>   vm.launch()
> >>   
> >>
> >>
> >> Shall I resend a v2?
> >>
> > 
> > so, we need -no-shutdown even if we drop kvm? I hoped that not..
> > Hmm. grep points only to one iotest doing the same about no-shutdown
> > - 068..
> 
> Kevin, shall I send the above patch as v2?

Don't bother, I think v1 is fine. By specifying kvm explicitly, it's at
least clear that we're not using qtest like in other tests.

Kevin
