Received: from eggs.gnu.org ([2001:4830:134:3::10]:36319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9L9-00064h-Tv
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9L7-0007SI-Ec
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD9L7-0007Rb-3V
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:53 -0400
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<ecc524bb47e169394f9bed88c979fdc8d990111a.1539861171.git.artem.k.pisarenko@gmail.com>
	<ede122b1-f98b-b094-f106-119d25243382@redhat.com>
	<CANzW0mvXfmeFoSqQy42gNg+Pbg12zRrz7bZYKLB2s+oxD=8iiQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad8fc9e1-af6c-b753-83ca-0dedc2a4e60f@redhat.com>
Date: Thu, 18 Oct 2018 16:31:47 +0200
MIME-Version: 1.0
In-Reply-To: <CANzW0mvXfmeFoSqQy42gNg+Pbg12zRrz7bZYKLB2s+oxD=8iiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] Optimize record/replay checkpointing
 for all clocks it applies to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 18/10/2018 15:23, Artem Pisarenko wrote:
>> We can also move the switch statement to a separate function, it
>> simplifies the code:
>> ...
> 
> When I prepared this patch my intuition said me to add note in advance:
> "Paolo, please, don't try to move this to a separate function. I've
> tried it already. It cannot be done correct, look nice and not decrease
> performancy at the same time". But I've ignored it... :)
> Change you did is correct and nice, but (compared to my version) it adds
> extra unlock/lock pair for running each timer list when it isn't empty
> and in non-rr mode (where we would ignore checkpoints and execution flow
> would bypass whole "if (need_replay_checkpoint) {...}" block).
> Maybe you're aware of it, but I don't think that such change worth it.

No, you're right.  The if should remain in the caller, or
need_replay_checkpoint must be initialized with replay_mode.

Paolo
