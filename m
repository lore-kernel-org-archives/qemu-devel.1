Received: from eggs.gnu.org ([2001:4830:134:3::10]:34514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxxsa-0003Z2-HB
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxxsW-0006Tc-9x
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:15:40 -0400
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
	<5c204531-2e59-4166-0325-745e4aa98531@redhat.com>
	<CAFEAcA-Auwy1Mp=L89VYB4xoCG1BFdCWyUjhA4HHFiGmycBjzg@mail.gmail.com>
	<c2d69fb0-fc47-e145-3b24-c7eb6c9cea45@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <507bad9d-61fc-c513-e023-674836eb72a1@ilande.co.uk>
Date: Thu, 6 Sep 2018 18:15:09 +0100
MIME-Version: 1.0
In-Reply-To: <c2d69fb0-fc47-e145-3b24-c7eb6c9cea45@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/3] scsi: remove lsi53c895a_create() and
 lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/09/18 17:40, Thomas Huth wrote:

> On 2018-09-06 16:50, Peter Maydell wrote:
>> On 6 September 2018 at 13:02, Thomas Huth <thuth@redhat.com> wrote:
>>> I somehow fail to see that something outside of lsi53c895a.c should
>>> really need to access the internals of LSIState. If there is something
>>> that needs to be configured from the outside, it should be done via QOM
>>> properties instead, shouldn't it? So I think I'd rather prefer if you
>>> could do it the other way round and change the lsi*_create() functions
>>> to return a pointer to PCIDevice instead, if possible.
>>
>> Nothing typically does, but the "modern" style of having QOM objects which
>> use other QOM objects do so by embedding the child object's struct into
>> the struct of the parent requires that the struct definition is available.
> 
> But in this case we don't have anything that "inherits" from LSIState,
> so shouldn't we rather follow the "information hiding" principle and
> keep the state local to the lsi53c895a.c file? If you want to use a
> "LSIState *" from another .c file, you can still put an "anonymous"
> 
>  struct LSIState;
>  typedef struct LSIState LSIState;
> 
> in a header somewhere without revealing the implementation.
> 
> I'm fine with putting the whole LSIState into a header file if we really
> need it, but in this case, I don't see the point.

I completely agree with you that struct members used to configure the
device initialisation should only be done via qdev properties, however
having the struct information and the QOM defines available is very,
very handy.

In terms of information hiding we are a long way away from this, and in
my experience having both the compile time and runtime checks on QOM
macros means that just doing a FOO(pci_create_simple...) or strongly
typing object links when wiring up a board catches just about all errors
developers can make.

Amusingly the main reason I need to expose the LSIState at all is to be
able to call scsi_bus_legacy_handle_cmdline() on the SCSI bus object
itself. I guess you could say that this is an argument in favour of the
existing approach, but then you're effectively moving back to the
equivalent of _init() functions for this one particular case which these
days are considered to be bad.

My feeling is that since the pattern of a separate header with struct
and QOM macros (or "modern" style) is used throughout the rest of the
codebase, why should we make an exception for this one particular case?

I see Peter also mentions about marking members as public/private, but
again in my opinion and experience, with the addition of runtime as well
as compile time QOM casts a huge class of problems has now gone away -
and as a result of this, there are now more urgent problems which is
probably why no-one has really picked up Peter's patch in over 4 years.


ATB,

Mark.
