Received: from eggs.gnu.org ([2001:4830:134:3::10]:48577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ahmedsoliman0x666@gmail.com>) id 1fUx7U-0006yq-V5
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ahmedsoliman0x666@gmail.com>) id 1fUx7T-0007Ft-U8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:35:08 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:35439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ahmedsoliman0x666@gmail.com>)
	id 1fUx7T-0007FW-PG
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:35:07 -0400
Received: by mail-io0-x231.google.com with SMTP id u4-v6so17411889iof.2
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 09:35:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7c7ddb96-e865-53a2-3aa9-b79403c646a9@redhat.com>
References: <CAAGnT3bjYPu9bordn_Dh8z+MW6p5DDLoSsZC9xg8QxQriVus9A@mail.gmail.com>
	<7c7ddb96-e865-53a2-3aa9-b79403c646a9@redhat.com>
From: Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Date: Mon, 18 Jun 2018 18:35:06 +0200
Message-ID: <CAAGnT3avoMOJP9zEdG2WmmxUe7m4S+5mDWezjJerzO4fq11cjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Design Decision for KVM based anti rootkit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, riel@redhat.com, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Hossam Hassan <7ossam9063@gmail.com>, Ahmed Lotfy <A7med.lotfey@gmail.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org

Shortly after I sent the first email, we found that there is another
way to achieve this kind of communication, via KVM Hypercalls, I think
they are underutilised in kvm, but they exist.

We also found that they are architecture dependent, but the advantage
is that one doesn't need to create QEMU<-> kvm interface

So from our point of view it is either have things easily compatible
with many architectures out of the box (virtio) VS compatiability with
almost every front end including QEMU and any other one without
modification (Hypercalls)?

If it is the case, We might stick to hypercalls at the beginning,
because it can be easily tested with out modifying QEMU, but then
later we can move to virtio if there turned out to be clearer
advantage, especially performance wise.

Does that sounds like good idea?
I wanted to make sure because maybe maybe hypercalls aren't that much
used in kvm for a reason, so I wanted to verify that.

On 18 June 2018 at 16:34, David Hildenbrand <david@redhat.com> wrote:
> On 16.06.2018 13:49, Ahmed Soliman wrote:
>> Following up on these threads:
>> - https://marc.info/?l=kvm&m=151929803301378&w=2
>> - http://www.openwall.com/lists/kernel-hardening/2018/02/22/18
>>
>> I lost the original emails so I couldn't reply to them, and also sorry
>> for being late, it was the end of semester exams.
>>
>> I was adviced on #qemu and #kernelnewbies IRCs to ask here as it will
>> help having better insights.
>>
>> To wrap things up, the basic design will be a method for communication
>> between host and guest is guest can request certain pages to be read
>> only, and then host will force them to be read-only by guest until
>> next guest reboot, then it will impossible for guest OS to have them
>> as RW again. The choice of which pages to be set as read only is the
>> guest's. So this way mixed pages can still be mixed with R/W content
>> even if holds kernel code.
>>
>> I was planning to use KVM as my hypervisor, until I found out that KVM
>> can't do that on its own so one will need a custom virtio driver to do
>> this kind of guest-host communication/coordination, I am still
>> sticking to KVM, and have no plans to do this for Xen at least for
>> now, this means that in order to get it to work there must be a QEMU
>> support our specific driver we are planning to write in order for
>> things to work properly.
>>
>> The question is is this the right approach? or is there a simpler way
>> to achieve this goal?
>>
>
> Especially if you want to support multiple architectures in the long
> term, virtio is the way to go.
>
> Design an architecture independent and extensible (+configurable)
> interface and be happy :) This might of course require some thought.
>
> (and don't worry, implementing a virtio driver is a lot simpler than you
> might think)
>
> But be aware that the virtio "hypervisor" side will be handled in QEMU,
> so you'll need a proper QEMU->KVM interface to get things running.
>
> --
>
> Thanks,
>
> David / dhildenb
