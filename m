Received: from eggs.gnu.org ([2001:4830:134:3::10]:51304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ff50X-0000bb-HN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ff50T-0001fz-9l
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:01:49 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
Message-ID: <4eca96cf-5520-fb82-2e23-afff3ba35077@virtuozzo.com>
Date: Mon, 16 Jul 2018 18:01:27 +0300
MIME-Version: 1.0
In-Reply-To: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v0 0/2] Postponed actions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, reitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Ping!

On 29.06.2018 15:40, Denis Plotnikov wrote:
> There are cases when a request to a block driver state shouldn't have
> appeared producing dangerous race conditions.
> This misbehaviour is usually happens with storage devices emulated
> without eventfd for guest to host notifications like IDE.
> 
> The issue arises when the context is in the "drained" section
> and doesn't expect the request to come, but request comes from the
> device not using iothread and which context is processed by the main loop.
> 
> The main loop apart of the iothread event loop isn't blocked by the
> "drained" section.
> The request coming and processing while in "drained" section can spoil the
> block driver state consistency.
> 
> This behavior can be observed in the following KVM-based case:
> 
> 1. Setup a VM with an IDE disk.
> 2. Inside a VM start a disk writing load for the IDE device
>    e.g: dd if=<file> of=<file> bs=X count=Y oflag=direct
> 3. On the host create a mirroring block job for the IDE device
>    e.g: drive_mirror <your_IDE> <your_path>
> 4. On the host finish the block job
>    e.g: block_job_complete <your_IDE>
>   
> Having done the 4th action, you could get an assert:
> assert(QLIST_EMPTY(&bs->tracked_requests)) from mirror_run.
> On my setup, the assert is 1/3 reproducible.
> 
> The patch series introduces the mechanism to postpone the requests
> until the BDS leaves "drained" section for the devices not using iothreads.
> Also, it modifies the asynchronous block backend infrastructure to use
> that mechanism to release the assert bug for IDE devices.
> 
> Denis Plotnikov (2):
>    async: add infrastructure for postponed actions
>    block: postpone the coroutine executing if the BDS's is drained
> 
>   block/block-backend.c | 58 ++++++++++++++++++++++++++++++---------
>   include/block/aio.h   | 63 +++++++++++++++++++++++++++++++++++++++++++
>   util/async.c          | 33 +++++++++++++++++++++++
>   3 files changed, 142 insertions(+), 12 deletions(-)
> 

-- 
Best,
Denis
