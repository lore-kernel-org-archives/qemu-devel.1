Received: from eggs.gnu.org ([2001:4830:134:3::10]:48748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePEUh-0002RX-Jx
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePEUg-00066j-Nw
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:23:11 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171207201320.19284-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a376c41f-e8cb-2ea0-b464-d9ff3d52c395@redhat.com>
Date: Wed, 13 Dec 2017 22:23:02 +0100
MIME-Version: 1.0
In-Reply-To: <20171207201320.19284-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] block: avoid recursive AioContext
 acquire in bdrv_inactivate_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On 07/12/2017 21:13, Stefan Hajnoczi wrote:
> v2:
>  * Added docs/devel/multiple-iothreads.txt doc update [Kevin]
>  * Added qemu-iotests 203 test case [Kevin]
>  * Added iothread_stop() race fix to make 203 reliable
> 
> Patch 1 is Paolo's recursive locking removal in bdrv_inactivate_all().  This
> solve migration hangs and is the main point of the patch series.
> 
> Patches 2-6 add a qemu-iotests test case and update the multiple-iothreads.txt
> documentation to discourage recursive AioContext locking.
> 
> Based-on: <20171206144550.22295-1-stefanha@redhat.com>
> 
> Paolo Bonzini (1):
>   block: avoid recursive AioContext acquire in bdrv_inactivate_all()
> 
> Stefan Hajnoczi (5):
>   docs: mark nested AioContext locking as a legacy API
>   blockdev: add x-blockdev-set-iothread force boolean
>   iotests: add VM.add_object()
>   iothread: fix iothread_stop() race condition
>   qemu-iotests: add 203 savevm with IOThreads test
> 
>  docs/devel/multiple-iothreads.txt |  7 +++--
>  qapi/block-core.json              |  6 +++-
>  include/sysemu/iothread.h         |  3 +-
>  block.c                           | 14 ++++++++--
>  blockdev.c                        | 11 ++++----
>  iothread.c                        | 20 +++++++++----
>  tests/qemu-iotests/203            | 59 +++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/203.out        |  6 ++++
>  tests/qemu-iotests/group          |  1 +
>  tests/qemu-iotests/iotests.py     |  5 ++++
>  10 files changed, 114 insertions(+), 18 deletions(-)
>  create mode 100755 tests/qemu-iotests/203
>  create mode 100644 tests/qemu-iotests/203.out
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

aio_notify should also be put on the blacklist of things that have
slowly become bad ideas. :|

Paolo
