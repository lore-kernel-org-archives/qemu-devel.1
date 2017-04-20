Received: from eggs.gnu.org ([2001:4830:134:3::10]:35542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1Ehe-0001V6-Gr
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1EhY-0001KB-MF
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:13:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170419222258.13415-1-eblake@redhat.com>
	<87k26fffxa.fsf@dusky.pond.sub.org>
	<20170420120922.GJ20955@redhat.com>
	<1f4e72ed-fab1-7099-768e-2a111df3a633@redhat.com>
Date: Thu, 20 Apr 2017 18:12:42 +0200
In-Reply-To: <1f4e72ed-fab1-7099-768e-2a111df3a633@redhat.com> (Eric Blake's
	message of "Thu, 20 Apr 2017 08:20:11 -0500")
Message-ID: <87r30n83d1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Scott Wood <scottwood@freescale.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>, Cor nelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Eric Blake <eblake@redhat.com> writes:

> On 04/20/2017 07:09 AM, Daniel P. Berrange wrote:
>
>>>> +++ b/qapi/event.json
>>>> @@ -10,6 +10,10 @@
>>>>  # Emitted when the virtual machine has shut down, indicating that qemu is
>>>>  # about to exit.
>>>>  #
>>>> +# @guest: If true, the shutdown was triggered by a guest request (such as
>>>> +# executing a halt instruction) rather than a host request (such as sending
>>>> +# qemu a SIGINT). (since 2.10)
>>>> +#
>>>
>>> "executing a halt instruction" suggests "halt" is a machine instruction.
>
> Which is indeed what most of the places I patched to pass 'true' are
> emulating - the machine halt instruction.
>
>>> I think you mean /usr/sbin/halt.  Suggest something like "executing a
>>> halt command".
>> 
>> Well technically /usr/sbin/halt just terminates all processes / kernel and
>> halts CPUs, but the virtual machine is still active (and a 'reset' in the
>> monitor can start it again. /usr/sbin/poweroff is what actually does the
>> ACPI poweroff to trigger QEMU to exit[1]
>
> I'm thinking of this wording:
>
> triggered by a guest request (such as the guest running
> /usr/sbin/poweroff to trigger an ACPI shutdown or machine halt instruction)

A quick glance at the patch suggests the instructions in question are
typically writes to some device register.  I wouldn't call them "halt
instructions", in particular since there's the x86 "hlt" instruction
that does something else.
