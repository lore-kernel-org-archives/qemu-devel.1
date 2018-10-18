Received: from eggs.gnu.org ([2001:4830:134:3::10]:32883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@greensocs.com>) id 1gCxxM-0001FJ-JO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clement.deschamps@greensocs.com>) id 1gCxxG-0000T4-72
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:22:34 -0400
Received: from greensocs.com ([193.104.36.180]:53432)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@greensocs.com>) id 1gCxxF-0000QZ-Lb
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:22:30 -0400
References: <20181017090750.4378-1-pbonzini@redhat.com>
	<001f01d465fd$01af8b80$050ea280$@ru>
	<CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
	<0817e2fe-5a97-a4ed-9ae2-2e8dee6c9a43@redhat.com>
	<004201d4660d$e86ef1e0$b94cd5a0$@ru>
	<a29da0a1-85d7-c57c-5c42-27594a7849ac@redhat.com>
	<005c01d4661c$3a9cd0a0$afd671e0$@ru>
	<168ee943-5b06-fbe5-a644-0312d80855ca@redhat.com>
From: Clement Deschamps <clement.deschamps@greensocs.com>
Message-ID: <2e4aae0d-c13d-8ea4-aeb1-7facdb6386e2@greensocs.com>
Date: Wed, 17 Oct 2018 19:22:15 -0700
MIME-Version: 1.0
In-Reply-To: <168ee943-5b06-fbe5-a644-0312d80855ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "icount: remove obsolete warp call"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>

Hi all,

I'm traveling right now, but as soon as I get home, I'll send my patch
with the signed-off.


Best,

Cl=C3=A9ment

On 10/17/18 7:43 AM, Paolo Bonzini wrote:
> On 17/10/2018 15:20, Pavel Dovgalyuk wrote:
>> I found the source of the bug. As QEMU becomes more multi-threaded
>> and non-synchronized, checkpoints move from thread to thread. And the
>> event queue that processed at checkpoints should belong to the same
>> thread in both record and replay executions.
>>
>> Current problem was with the checkpoint for virtual timers. They are
>> processed from different threads: from vCPU and from aio_dispatch
>> function.
>>
>> Therefore the following patch fixes the problem, but I think that
>> this part has to be refactored. There should be nailed-to-thread
>> events that process the event queue. Then checkpoints can become just
>> synchronization events and therefore omitted for empty timer lists,
>> for example.
> Can you add a FIXME comment and submit this as a full patch?
>
> Paolo
