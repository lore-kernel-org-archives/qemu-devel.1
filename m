Received: from eggs.gnu.org ([209.51.188.92]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1K0t-0008S6-8h
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 19:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1K0s-0002VE-8V
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 19:02:23 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c67e661d-061e-8c01-d9e7-81f6c5a5ae8a@redhat.com>
Date: Tue, 5 Mar 2019 19:02:17 -0500
MIME-Version: 1.0
In-Reply-To: <20190305234337.18353-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] block/qcow2-bitmap: Enable resize with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 3/5/19 6:43 PM, John Snow wrote:

++ This series relies on [Qemu-devel] [PATCH v3 0/7] bitmaps: add
inconsistent bit, you can apply it on top of those patches, or you can
use my github staging branch as a basis:

https://github.com/jnsnow/qemu/tree/bitmaps

> This series aims to enable block resizes when persistent bitmaps are
> in use. The basic approach here is to recognize that we now load all
> persistent bitmaps in memory, and so we can rely on in-memory resizes
> and then flush the changed metadata back to disk.
> 
> One part that is potentially now quite strange is that bitmap resizes
> may happen twice: once during the qcow2 resize event only if persistent
> bitmaps are found, and then again as part of the generic resize callback
> event whether or not we have any persistent bitmaps.
> 
> The second round is required if we are not using qcow2 or we have only
> transient bitmaps. The first round is required as we wish to flush the
> bitmaps back to disk atomically with the qcow2 resize to avoid violating
> our invariants for the bitmap metadata which is checked in many places.
> 
> This is harmless; hbitmap_truncate will recognize the second round as
> a no-op.
> 
> John Snow (5):
>   block/qcow2-bitmap: Skip length check in some cases
>   block/qcow2-bitmap: Allow bitmap flushing
>   block/qcow2-bitmap: don't remove bitmaps on reopen
>   block/qcow2-bitmap: Allow resizes with persistent bitmaps
>   tests/qemu-iotests: add bitmap resize test 246
> 
>  block/qcow2.h              |   2 +
>  block/qcow2-bitmap.c       | 123 +++++++++++----
>  block/qcow2.c              |  27 +++-
>  tests/qemu-iotests/246     | 114 ++++++++++++++
>  tests/qemu-iotests/246.out | 296 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  6 files changed, 528 insertions(+), 35 deletions(-)
>  create mode 100755 tests/qemu-iotests/246
>  create mode 100644 tests/qemu-iotests/246.out
> 
