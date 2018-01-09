Received: from eggs.gnu.org ([2001:4830:134:3::10]:38118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYvsL-0005eK-3K
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYvsK-00080F-0d
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:31:41 -0500
References: <cover.1513790494.git.alistair.francis@xilinx.com>
	<6bad4084f4cbc290e2e9f1a72fcfcda7223383ec.1513790495.git.alistair.francis@xilinx.com>
	<87lghulqno.fsf@dusky.pond.sub.org>
	<1cfb1217-e32d-8e91-da46-07f1c72be77f@redhat.com>
	<CAKmqyKPyL8B5ZjEUePkqVbzP8kVmM48vWML41PRXVVO7LVmMpg@mail.gmail.com>
	<87a7yah5ea.fsf@dusky.pond.sub.org>
	<CAKmqyKO5sKdiZJ65teDxa16PCE71WCLay7cOAQJQdyS-EVNOJg@mail.gmail.com>
	<87608k4dsh.fsf@dusky.pond.sub.org>
	<CAKmqyKMz2tfJwu0Q5joHm99QLbJ-psU=sSgDQtLuFKjyKRmO-A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b3489d6-de5e-27ff-8981-a3dc50794696@redhat.com>
Date: Tue, 9 Jan 2018 16:31:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMz2tfJwu0Q5joHm99QLbJ-psU=sSgDQtLuFKjyKRmO-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/29] hw/arm: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 09.01.2018 01:32, Alistair Francis wrote:
> On Tue, Jan 2, 2018 at 4:59 AM, Markus Armbruster <armbru@redhat.com> w=
rote:
>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>
>>> On Fri, Dec 22, 2017 at 12:30 PM, Markus Armbruster <armbru@redhat.co=
m> wrote:
>>>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>>>
>>>>> On Fri, Dec 22, 2017 at 9:17 AM, Thomas Huth <thuth@redhat.com> wro=
te:
>>>>>> On 22.12.2017 16:37, Markus Armbruster wrote:
>>>>>>> Second thoughts...
>>>>>>>
>>>>>>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>>>>> [...]
>>>>>>>>  #include "qemu/osdep.h"
>>>>>>>> +#include "qemu/error-report.h"
>>>>>>>>  #include "qapi/error.h"
>>>>>>>>  #include "qemu-common.h"
>>>>>>>>  #include "cpu.h"
>>>>>>>> @@ -1311,8 +1312,8 @@ static void omap_prcm_apll_update(struct o=
map_prcm_s *s)
>>>>>>>>      /* TODO: update clocks */
>>>>>>>>
>>>>>>>>      if (mode[0] =3D=3D 1 || mode[0] =3D=3D 2 || mode[1] =3D=3D =
1 || mode[1] =3D=3D 2)
>>>>>>>> -        fprintf(stderr, "%s: bad EN_54M_PLL or bad EN_96M_PLL\n=
",
>>>>>>>> -                        __func__);
>>>>>>>> +        error_report("%s: bad EN_54M_PLL or bad EN_96M_PLL",
>>>>>>>> +                     __func__);
>>>>>>>>  }
>>>>>>>
>>>>>>> This one's different: we neither exit() nor return a "failed" sta=
tus to
>>>>>>> the caller.
>>>>>>>
>>>>>>> We get here when the guest writes something funny to a certain
>>>>>>> memory-mapped I/O register.  In other words, it's guest misbehavi=
or, not
>>>>>>> a user error.  I doubt it should be reported with error_report().
>>>>>>> Peter, do we have a canonical way to report or log  guest misbeha=
vior?
>>>>>>
>>>>>> qemu_log_mask(LOG_GUEST_ERROR, ...) ?
>>>>>
>>>>> That seems like the best option to me.
>>>>
>>>> Suggest:
>>>>
>>>> 1. Keep converting fatal errors (the ones that exit())
>>>>
>>>> 2. Keep converting recoverable errors (the ones that return failure)
>>>>
>>>> 3. You can leave the prints that are neither alone.  You can also
>>>>    convert to logging or tracing, as appropriate, but that requires
>>>>    understanding the code.
>>>>
>>>> Makes sense?
>>>
>>> Does this apply to new patches after this series or to this series as
>>> well? The series is mostly just mechanical find/replace. I really
>>> don't want to have to dig through every patch to figure out what to
>>> change/not change.
>>
>> I understand your reluctance to sort patch hunks into buckets 1., 2. a=
nd
>> 3. manually: there's an awful lot of hunks to sort.
>>
>> We know we have many fprintf() that should be error_report(),
>> error_setg(), logging or tracing.
>>
>> We know we have error_report() that should be error_setg().
>>
>> Converting fprintf() to error_report() where we should really use
>> something else makes the situation worse, I'm afraid.
>>
>> Since we need to sort, and sorting manually isn't practical, we need t=
o
>> automate.
>>
>> The patterns to recognize are 1. fprintf() followed by exit() and
>> 2. fprintf() followed by return failure.
>>
>> Recognizing the patterns when there's stuff between fprintf() and exit=
()
>> / return may exceed sed's power.  Feels like a Coccinelle job to me.
>> Let's focus on the common case where exit() / return follows fprintf()
>> immediately.
>>
>> Let's start with the easiest case: exit().  I figure that's still in
>> reach of your find + sed tooling.
>>
>> Recognizing "return failure" is slightly harder, because error values
>> aren't always obvious.  Common ones are return NULL, return -1, return
>> -EFOO.
>>
>> I hope that peeling off truly simple cases like this will reduce the
>> remaining hunks sufficiently to permit manual review.  If it doesn't, =
we
>> should still get a major part of your work without making the situatio=
n
>> worse.
>=20
> Ok. So it is becoming apparent that this series is not going to be
> accepted. I might just drop it and try and re-group with Coccinelle at
> some point in the future.
>=20
> If there is a subset of this series that is fine to go in I'm happy to
> rebase and keep going, but at the moment it looks like starting again
> is gong to be the least painful effort.

Sorry to hear that. But I somewhat agree with Markus - lots of the
patches were not trivial and need close review to see whether the
fprintf should be replaced with error_report, warn_report, qemu_log_mask
or a tracepoint, so primary blindly converting everything to
error_report is really just the wrong way.

If I may suggest something: Don't send the patches as a huge series, but
send single patches (that you've reviewed on your own first), with the
individual subsystem maintainers in CC. That should help to get better
review, and the single patches then have a higher chance to get picked
up through the maintainers' trees.

 Thomas
