Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn1wB-0000e9-Gk
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn1wA-0006m1-Ek
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:22:11 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fn1wA-0006jy-8V
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:22:10 -0400
Received: by mail-oi0-x243.google.com with SMTP id 8-v6so28414719oip.0
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 06:22:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87muty2u57.fsf@trasno.org>
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Aug 2018 14:21:49 +0100
Message-ID: <CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 7 August 2018 at 14:17, Juan Quintela <quintela@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> Currently the vmstate subsection handling code treats a subsection
>> with no 'needed' function pointer as if it were the subsection
>> list terminator, so the subsection is never transferred and nor
>> is any subsection following it in the list.

>> @@ -486,8 +486,8 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>>      int ret = 0;
>>
>>      trace_vmstate_subsection_save_top(vmsd->name);
>> -    while (sub && *sub && (*sub)->needed) {
>> -        if ((*sub)->needed(opaque)) {
>> +    while (sub && *sub) {
>> +        if (vmstate_save_needed(*sub, opaque)) {
>>              const VMStateDescription *vmsdsub = *sub;
>>              uint8_t len;
>
>
> I am not so sure about this one.  Why are we having a subsection without
> a ->needed function?  I don't know why that it is useful for.  if we
> don't have a needed function, then it is just better to just add that
> "subsection" to the normal section, increase the version number and live
> with that, no?

No, because then you can't migrate from an older QEMU without
the subsection to one with it. AIUI version-number bumps are
deprecated if you care about migration compatibility, because
they don't work if you're potentially going to be backporting
changes to older versions.

Also, what prompted me to write this patch was that for 3.0
I had to fix several bugs where subsections had been written
with no needed function and the migration code was (a)
silently ignoring the subsection and (b) silently ignoring
any subsection following. If you want to make it a bug to
not have a needed function, you need to have code that checks
for this in device init and aborts, so that device authors
don't fall into this trap.

thanks
-- PMM
