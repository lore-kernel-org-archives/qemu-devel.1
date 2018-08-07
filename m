Received: from eggs.gnu.org ([2001:4830:134:3::10]:47191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn32c-0002XS-Pa
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn32b-0000ag-Or
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:32:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fn32b-0000aT-Jh
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:32:53 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
	(Peter Maydell's message of "Tue, 7 Aug 2018 14:21:49 +0100")
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
	<CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 07 Aug 2018 16:32:49 +0200
Message-ID: <87in4m2qni.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: Correctly handle subsections
 with no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 7 August 2018 at 14:17, Juan Quintela <quintela@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>> Currently the vmstate subsection handling code treats a subsection
>>> with no 'needed' function pointer as if it were the subsection
>>> list terminator, so the subsection is never transferred and nor
>>> is any subsection following it in the list.
>
>>> @@ -486,8 +486,8 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>>>      int ret = 0;
>>>
>>>      trace_vmstate_subsection_save_top(vmsd->name);
>>> -    while (sub && *sub && (*sub)->needed) {
>>> -        if ((*sub)->needed(opaque)) {
>>> +    while (sub && *sub) {
>>> +        if (vmstate_save_needed(*sub, opaque)) {
>>>              const VMStateDescription *vmsdsub = *sub;
>>>              uint8_t len;
>>
>>
>> I am not so sure about this one.  Why are we having a subsection without
>> a ->needed function?  I don't know why that it is useful for.  if we
>> don't have a needed function, then it is just better to just add that
>> "subsection" to the normal section, increase the version number and live
>> with that, no?
>
> No, because then you can't migrate from an older QEMU without
> the subsection to one with it. AIUI version-number bumps are
> deprecated if you care about migration compatibility, because
> they don't work if you're potentially going to be backporting
> changes to older versions.
>
> Also, what prompted me to write this patch was that for 3.0
> I had to fix several bugs where subsections had been written
> with no needed function and the migration code was (a)
> silently ignoring the subsection and (b) silently ignoring
> any subsection following. If you want to make it a bug to

b) is clearly a bug.

a) ... I am not sure that this should be correct.

> not have a needed function, you need to have code that checks
> for this in device init and aborts, so that device authors
> don't fall into this trap.

Here you have a good point.

Later, Juan.
