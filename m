Received: from eggs.gnu.org ([2001:4830:134:3::10]:55351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCn2k-00072O-Tw
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCn2f-0005D1-3c
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCn2d-0005AE-Q7
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:43:20 -0400
References: <20181017090750.4378-1-pbonzini@redhat.com>
	<001f01d465fd$01af8b80$050ea280$@ru>
	<CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
	<0817e2fe-5a97-a4ed-9ae2-2e8dee6c9a43@redhat.com>
	<004201d4660d$e86ef1e0$b94cd5a0$@ru>
	<a29da0a1-85d7-c57c-5c42-27594a7849ac@redhat.com>
	<005c01d4661c$3a9cd0a0$afd671e0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <168ee943-5b06-fbe5-a644-0312d80855ca@redhat.com>
Date: Wed, 17 Oct 2018 16:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <005c01d4661c$3a9cd0a0$afd671e0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Revert "icount: remove obsolete warp call"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>, 'Clement Deschamps' <clement.deschamps@greensocs.com>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>

On 17/10/2018 15:20, Pavel Dovgalyuk wrote:
> I found the source of the bug. As QEMU becomes more multi-threaded
> and non-synchronized, checkpoints move from thread to thread. And the
> event queue that processed at checkpoints should belong to the same
> thread in both record and replay executions.
> 
> Current problem was with the checkpoint for virtual timers. They are
> processed from different threads: from vCPU and from aio_dispatch
> function.
> 
> Therefore the following patch fixes the problem, but I think that
> this part has to be refactored. There should be nailed-to-thread
> events that process the event queue. Then checkpoints can become just
> synchronization events and therefore omitted for empty timer lists,
> for example.

Can you add a FIXME comment and submit this as a full patch?

Paolo
