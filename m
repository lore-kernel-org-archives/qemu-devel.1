Received: from eggs.gnu.org ([2001:4830:134:3::10]:37990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fgK80-00074Y-3E
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 21:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fgK7w-0007l3-Vu
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 21:22:40 -0400
References: <1531969910-32843-1-git-send-email-jia.he@hxt-semitech.com>
	<CAFEAcA_2t5z1JBWM9o7ygcOwxnQRba0qA8vVjcoZpcGfP9XUtA@mail.gmail.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <055381ef-7f32-1bb3-cae5-df6bfbe2888e@gmail.com>
Date: Fri, 20 Jul 2018 09:22:33 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2t5z1JBWM9o7ygcOwxnQRba0qA8vVjcoZpcGfP9XUtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_its: downgrade
 error_report to warn_report in kvm_arm_its_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Jia He <jia.he@hxt-semitech.com>

Hi Peter。 Thanks for the comments

On 7/19/2018 8:41 PM, Peter Maydell Wrote:
> On 19 July 2018 at 04:11, Jia He <hejianet@gmail.com> wrote:
>> In scripts/arch-run.bash of kvm-unit-tests, it will check the qemu
>> output log with:
>> if [ -z "$(echo "$errors" | grep -vi warning)" ]; then
>>
>> Thus without the warning prefix, all of the test fail.
>>
>> Since it is not unrecoverable error in kvm_arm_its_reset for
>> current implementation, downgrading the report from error to
>> warn makes sense.
> 
> I think the counterargument would be that this should report
> an error, because you just asked the device to do something
> that it doesn't support (ie to do a clean reset). Since the
> device isn't going to behave correctly, the tests should fail,
> and the way to make them pass is to upgrade to a kernel that
> implements the device correctly (by implementing the necessary
> feature).
> 
> But we could maybe move to warn_report() here -- I'm not
> sure what our rules are for what counts as an error and
> what counts as a warning.
I reviewed the other error_report in qemu. Some of them are followed
by exit(), but the rest are not. So it seems there is no definite
rules for error_report.

IMO, the best resolution is to change the output grep search criteria.
But it is difficult for kvm-unit-tests to identify whether it is an
error without exit() or a warning. The fastest resolution is moving
error_report to warn_report.

-- 
Cheers,
Jia
