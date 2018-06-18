Received: from eggs.gnu.org ([2001:4830:134:3::10]:43581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUvEc-0008VE-4F
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUvEX-0005Uw-QA
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:34:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fUvEX-0005To-Jv
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:34:17 -0400
References: <CAAGnT3bjYPu9bordn_Dh8z+MW6p5DDLoSsZC9xg8QxQriVus9A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7c7ddb96-e865-53a2-3aa9-b79403c646a9@redhat.com>
Date: Mon, 18 Jun 2018 16:34:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAAGnT3bjYPu9bordn_Dh8z+MW6p5DDLoSsZC9xg8QxQriVus9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Design Decision for KVM based anti rootkit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ahmed Soliman <ahmedsoliman0x666@gmail.com>, kvm@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, riel@redhat.com, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Hossam Hassan <7ossam9063@gmail.com>, Ahmed Lotfy <A7med.lotfey@gmail.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org

On 16.06.2018 13:49, Ahmed Soliman wrote:
> Following up on these threads:
> - https://marc.info/?l=kvm&m=151929803301378&w=2
> - http://www.openwall.com/lists/kernel-hardening/2018/02/22/18
> 
> I lost the original emails so I couldn't reply to them, and also sorry
> for being late, it was the end of semester exams.
> 
> I was adviced on #qemu and #kernelnewbies IRCs to ask here as it will
> help having better insights.
> 
> To wrap things up, the basic design will be a method for communication
> between host and guest is guest can request certain pages to be read
> only, and then host will force them to be read-only by guest until
> next guest reboot, then it will impossible for guest OS to have them
> as RW again. The choice of which pages to be set as read only is the
> guest's. So this way mixed pages can still be mixed with R/W content
> even if holds kernel code.
> 
> I was planning to use KVM as my hypervisor, until I found out that KVM
> can't do that on its own so one will need a custom virtio driver to do
> this kind of guest-host communication/coordination, I am still
> sticking to KVM, and have no plans to do this for Xen at least for
> now, this means that in order to get it to work there must be a QEMU
> support our specific driver we are planning to write in order for
> things to work properly.
> 
> The question is is this the right approach? or is there a simpler way
> to achieve this goal?
> 

Especially if you want to support multiple architectures in the long
term, virtio is the way to go.

Design an architecture independent and extensible (+configurable)
interface and be happy :) This might of course require some thought.

(and don't worry, implementing a virtio driver is a lot simpler than you
might think)

But be aware that the virtio "hypervisor" side will be handled in QEMU,
so you'll need a proper QEMU->KVM interface to get things running.

-- 

Thanks,

David / dhildenb
