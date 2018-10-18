Received: from eggs.gnu.org ([2001:4830:134:3::10]:38334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gDBor-0003nl-Pr
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gDBoq-0000UI-0U
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:10:45 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gDBop-0000KC-EC
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:10:43 -0400
Received: by mail-oi1-x242.google.com with SMTP id 22-v6so24637602oiz.2
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 10:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<ecc524bb47e169394f9bed88c979fdc8d990111a.1539861171.git.artem.k.pisarenko@gmail.com>
	<ede122b1-f98b-b094-f106-119d25243382@redhat.com>
	<CANzW0mvXfmeFoSqQy42gNg+Pbg12zRrz7bZYKLB2s+oxD=8iiQ@mail.gmail.com>
	<ad8fc9e1-af6c-b753-83ca-0dedc2a4e60f@redhat.com>
In-Reply-To: <ad8fc9e1-af6c-b753-83ca-0dedc2a4e60f@redhat.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 18 Oct 2018 23:10:26 +0600
Message-ID: <CANzW0muBKDUHUa01SgQgNajBX5ZqS3sM71qmPPZd_ocNFRKsag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org

> =D1=87=D1=82, 18 =D0=BE=D0=BA=D1=82. 2018 =D0=B3., 20:31 Paolo Bonzini:
>On 18/10/2018 15:23, Artem Pisarenko wrote:
>>> We can also move the switch statement to a separate function, it
>>> simplifies the code:
>>> ...
>>
>> When I prepared this patch my intuition said me to add note in advance:
>> "Paolo, please, don't try to move this to a separate function. I've
>> tried it already. It cannot be done correct, look nice and not decrease
>> performancy at the same time". But I've ignored it... :)
>> Change you did is correct and nice, but (compared to my version) it adds
>> extra unlock/lock pair for running each timer list when it isn't empty
>> and in non-rr mode (where we would ignore checkpoints and execution flow
>> would bypass whole "if (need_replay_checkpoint) {...}" block).
>> Maybe you're aware of it, but I don't think that such change worth it.
>
> No, you're right. The if should remain in the caller, or
> need_replay_checkpoint must be initialized with replay_mode.

If initialize 'need_replay_checkpoint', then it should also account for
clock !=3D QEMU_CLOCK_REALTIME. And here we come to what if+switch block
actually (mostly) does in my version. Finally, you will get duplication of
this whole condition usage between source function and extracted function,
which isn't nice.
Why do you want to split up such tightly coupled code?
