Received: from eggs.gnu.org ([2001:4830:134:3::10]:58468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUAn0-0008Se-Ke
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUAmu-0002LE-Qj
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:31:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gUAms-00026w-Qb
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so9632810wmh.1
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:30:53 -0800 (PST)
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
	<CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
	<20181204124739.GA17825@redhat.com>
	<CAFEAcA_ovMgKPPjtYVASFqhzM7MX79EJYMZuFY4-FGRh4oqN8A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ad451bd-7eb1-902f-6023-4b48bb84249c@redhat.com>
Date: Tue, 4 Dec 2018 14:30:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ovMgKPPjtYVASFqhzM7MX79EJYMZuFY4-FGRh4oqN8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V11 0/8] add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, Peng Hao <peng.hao2@zte.com.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 04/12/18 13:59, Peter Maydell wrote:
> On Tue, 4 Dec 2018 at 12:47, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> After it had merged there were some changes and the question of turning
>> it into a PCI device was raised. Paolo was concerned that the guest OS
>> is in an unknown state (arbitrary locks held, data structures corrupt,
>> etc) when panic is fired, so simplicity of the I/O port was desirable:
>>
>>   https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03309.html

(Actually that was Marcelo, I was just relaying the message).

>> Anthony countered that even a PCI device could simply do an outb() in
>> config space:
>>
>>   https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03325.html
>>
>> So it is not clear using a PCI device is in fact a problem in terms of
>> reliability at time of firing.
> 
> ...and if we'd done it that way in the first place for x86 then
> we wouldn't be having to do anything at all now for Arm.
> That suggests to me that we should do it that way now, and then we
> can avoid having to do a bunch of extra development work for the
> next architecture, or the next interesting Arm board model.

Is there any case where we have anything but ISA and MMIO?  (We have
8250 which is ISA, PCI and MMIO, but that's kind of special because PCI
is only there for hotpluggability.  pvpanic hotplug is not interesting).

Also, while reusing code in general is nice, sometimes there are
platform-specific ways to do it.  For ARM, for example, would it make
sense to use an HVC/SMC that "extends" the PSCI, and pass the number in
the PSCI device tree node?

Related to this, is there a more or less "standard" watchdog device on
ARM that could be added to virt?  There is the SBSA watchdog, but it's
ugly for implementation in KVM because it counts down with frequency
equal to CNTFRQ (which I'm not sure if QEMU has access too, and also it
doesn't play well with live migration).

> I notice also that there's a mention in that thread that the pvpanic
> ACPI table entry on x86 resulted in unhelpful Windows notifications
> about new devices it didn't understand. Is that going to be an issue
> for Arm with this mmio pvpanic ?

Yes, it is probably the same as for x86.

Paolo
