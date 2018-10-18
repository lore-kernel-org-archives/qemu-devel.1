Received: from eggs.gnu.org ([2001:4830:134:3::10]:44530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDC3V-00019J-AX
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDC3S-0007Av-4a
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDC3R-0007AF-Rv
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:25:50 -0400
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<ecc524bb47e169394f9bed88c979fdc8d990111a.1539861171.git.artem.k.pisarenko@gmail.com>
	<ede122b1-f98b-b094-f106-119d25243382@redhat.com>
	<CANzW0mvXfmeFoSqQy42gNg+Pbg12zRrz7bZYKLB2s+oxD=8iiQ@mail.gmail.com>
	<ad8fc9e1-af6c-b753-83ca-0dedc2a4e60f@redhat.com>
	<CANzW0muBKDUHUa01SgQgNajBX5ZqS3sM71qmPPZd_ocNFRKsag@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3fb302a-cc58-30b6-e59a-4f1ba9445054@redhat.com>
Date: Thu, 18 Oct 2018 19:25:45 +0200
MIME-Version: 1.0
In-Reply-To: <CANzW0muBKDUHUa01SgQgNajBX5ZqS3sM71qmPPZd_ocNFRKsag@mail.gmail.com>
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org

On 18/10/2018 19:10, Artem Pisarenko wrote:
> 
>> No, you're right. The if should remain in the caller, or
>> need_replay_checkpoint must be initialized with replay_mode.
> 
> If initialize 'need_replay_checkpoint', then it should also account for
> clock != QEMU_CLOCK_REALTIME.

Or you just get a unlock/lock pair for QEMU_CLOCK_REALTIME (which should
really never happen if e.g. you have no UI).

> And here we come to what if+switch block
> actually (mostly) does in my version. Finally, you will get duplication
> of this whole condition usage between source function and extracted
> function, which isn't nice.
> Why do you want to split up such tightly coupled code?

Because it's *too* coupled and not very readable.

Paolo
