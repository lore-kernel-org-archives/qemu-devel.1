Received: from eggs.gnu.org ([2001:4830:134:3::10]:39255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKAhE-0004w7-EL
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKATr-0004Lt-LB
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:10:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gKATU-0002pq-6Z
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:09:37 -0500
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<f5712b07-05a1-650c-332a-a24462fed977@redhat.com>
	<CAFEAcA-Wkk9wLOfSYs2_R_2WwSe59egU4dwRBpdALDaA7642mQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce8c76ea-2e3a-b049-d515-c52f004bfec6@redhat.com>
Date: Wed, 7 Nov 2018 00:09:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Wkk9wLOfSYs2_R_2WwSe59egU4dwRBpdALDaA7642mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 07/11/2018 00:05, Peter Maydell wrote:
> On 6 November 2018 at 19:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 06/11/2018 19:43, Peter Maydell wrote:
>>> hw/core/ptimer.c
>>
>> Not a device.
> 
> Indeed not, but it could be a QOM object I guess (would
> that gain us anything?)

I don't know, it seems to me more like a generic high-level abstraction
around QEMUTimer.

>>> hw/i2c/bitbang_i2c.c
>>
>> TYPE_GPIO_I2C?
> 
> That part is, but bitbang_i2c_init() creates an object
> which isn't a QOM object and is used by some other i2c devices.

Ah, I see.  Then I think it is in the same family as AHCIState.

>>> hw/ide/ahci.c
>>
>> Even though AHCIState is not a QOM object, all of its users are
>> (TYPE_SYSBUS_AHCI is in this file, TYPE_ICH9_AHCI is in hw/ide/ich.c)
> 
> Mmm, this is one of those which I was unsure about so
> put on the list anyway.
> 
> Overall something that occurs to me is that I'm not sure
> what exactly (other than tidiness) we gain from converting
> remaining non-QOM devices. In some of the other cases I've
> looked at (like sysbus init methods or old_mmio users) we
> get to complete an API transition and remove the old code.
> For a non-QOM device, how much does it hurt us that they're
> lying around in the codebase? We might do better to
> specifically target APIs we'd like to deal with (like
> direct uses of vmstate_register, maybe?).

Yes, those are ugly and are definitely a sign of a legacy device
(non-qdev even before QOM).  serial_mm_init is the main example as you
point out below.

Paolo

> Some bits I would definitely like to see cleaned up are
> the things like the mmio version of the 16550 UART code
> in hw/char/serial.c -- that not being QOMified has
> knock-on effects in making other devices that would
> like to basically just be 16550-wrappers harder to
> write in a clean way.
