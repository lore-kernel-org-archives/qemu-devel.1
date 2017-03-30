Received: from eggs.gnu.org ([2001:4830:134:3::10]:48342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctaqQ-0004pD-4n
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctaqM-0004E8-1J
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1ctaqL-0004D6-Re
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:14:29 -0400
References: <1490880938-90331-1-git-send-email-agraf@suse.de>
	<CAFEAcA-qOqEW5t_=yG3pssetX3kDowoWwp52_MQBdBc2K8b0RA@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <32667301-f750-ed89-239c-31b8de2892c3@suse.de>
Date: Thu, 30 Mar 2017 16:14:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qOqEW5t_=yG3pssetX3kDowoWwp52_MQBdBc2K8b0RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] input: Add trace events for polled
 keyboard input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 03/30/2017 04:10 PM, Peter Maydell wrote:
> On 30 March 2017 at 14:35, Alexander Graf <agraf@suse.de> wrote:
>> When driving QEMU from the outside, we have basically no chance to
>> determine how quickly the guest OS picks up key events, so we usually
>> have to limit ourselves to very slow keyboard presses to make sure
>> the guest always has enough chance to pick them up.
>>
>> This patch adds trace events for when the guest polls for HID keyboard
>> events. That way we can be reasonably safely assume that the guest
>> handled that one key event and can type the next.
> This feels like the wrong way to solve the problem to me.
> Maybe we should have something like the network and
> UART device models do where they can say "my queue is
> full, I cannot accept any more data from the outside
> world" ?

That's really hard to realize unfortunately. If events come in from VNC, 
how do you stall new events from arriving? Would you stop reading the 
VNC stream? Would you allocate random buffers until you manage to 
finally push data onto the HID queue again?

Keep in mind that HID events might deliberately not be interpreted. OVMF 
doesn't have to have a tablet driver usually for example, so your tablet 
queue will fill up as soon as you push any mouse movement information in.


Alex
