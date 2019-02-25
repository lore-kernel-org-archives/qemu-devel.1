Received: from eggs.gnu.org ([209.51.188.92]:46413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyORB-0003lB-CC
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyOR4-00066I-Ui
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:09:23 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fec1904a-6b8a-54c2-f2f9-7012caf29e12@redhat.com>
Date: Mon, 25 Feb 2019 17:08:46 -0500
MIME-Version: 1.0
In-Reply-To: <20190223000614.13894-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/10] dirty-bitmaps: deprecate @status
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>



On 2/22/19 7:06 PM, John Snow wrote:
> The current internal meanings of "locked", "user_locked",
> "qmp_locked", "frozen", "enabled", and "disabled" are all
> a little muddled.
> 
> Deprecate the @status field in favor of two new booleans
> that carry very specific meanings. Then, rename and rework
> some of the internal semantics to help make the API a bit
> more clear and easier to read.
> 
> Well, in my opinion.
> 
> Based on my current bitmaps branch.
> 
> V3:
> 
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/10:[0002] [FC] 'block/dirty-bitmap: add recording and busy properties'
> 002/10:[0002] [FC] 'block/dirty-bitmaps: rename frozen predicate helper'
> 003/10:[down] 'block/dirty-bitmap: remove set/reset assertions against enabled bit'
> 004/10:[0006] [FC] 'block/dirty-bitmap: change semantics of enabled predicate'
> 005/10:[down] 'nbd: change error checking order for bitmaps'
> 006/10:[0002] [FC] 'block/dirty-bitmap: explicitly lock bitmaps with successors'
> 007/10:[0011] [FC] 'block/dirty-bitmaps: unify qmp_locked and user_locked calls'
> 008/10:[0002] [FC] 'block/dirty-bitmaps: move comment block'
> 009/10:[down] 'blockdev: remove unused paio parameter documentation'
> 010/10:[down] 'iotests: add busy/recording bit test to 124'
> 
> V3: (Following Vladimir's feedback)
> 
> 001: Changed texi phrasing, parameter --> field
> 002: Commit message adjustment
>      comment edit: "not locked" --> "not user_locked"
> 003: pulled forward out of patch 004
> 004: Commit message rewrite
>      create_successor and abdicate doc adjustments
> 005: New.
> 006: Change successor doc comment
>      Commit message adjustment
> 007: BdrvDirtyBitmap struct comment adjustments
>      Comment change to create_successor (lock --> busy)
>      Incidental changes from 004's changes
> 008: Grammar fix (Eric)
> 009: New, trivial, unrelated fix tagging along.
> 010: iotest 124 added.
> 
> John Snow (10):
>   block/dirty-bitmap: add recording and busy properties
>   block/dirty-bitmaps: rename frozen predicate helper
>   block/dirty-bitmap: remove set/reset assertions against enabled bit
>   block/dirty-bitmap: change semantics of enabled predicate
>   nbd: change error checking order for bitmaps
>   block/dirty-bitmap: explicitly lock bitmaps with successors
>   block/dirty-bitmaps: unify qmp_locked and user_locked calls
>   block/dirty-bitmaps: move comment block
>   blockdev: remove unused paio parameter documentation
>   iotests: add busy/recording bit test to 124
> 
>  block/dirty-bitmap.c           | 111 ++++++++++++++++++---------------
>  blockdev.c                     |  19 +++---
>  include/block/dirty-bitmap.h   |   7 +--
>  migration/block-dirty-bitmap.c |   8 +--
>  nbd/server.c                   |  14 ++---
>  qapi/block-core.json           |  10 ++-
>  qemu-deprecated.texi           |   6 ++
>  tests/qemu-iotests/124         | 110 ++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/124.out     |   4 +-
>  tests/qemu-iotests/236.out     |  28 +++++++++
>  10 files changed, 239 insertions(+), 78 deletions(-)
> 

Pushed to my bitmaps branch with the following minor changes:

001/10:[0002] [FC] 'block/dirty-bitmap: add recording and busy properties'
002/10:[0002] [FC] 'block/dirty-bitmaps: rename frozen predicate helper'
003/10:[----] [--] 'block/dirty-bitmap: remove set/reset assertions
against enabled bit'
004/10:[----] [--] 'block/dirty-bitmap: change semantics of enabled
predicate'
005/10:[----] [--] 'nbd: change error checking order for bitmaps'
006/10:[----] [--] 'block/dirty-bitmap: explicitly lock bitmaps with
successors'
007/10:[0002] [FC] 'block/dirty-bitmaps: unify qmp_locked and
user_locked calls'
008/10:[----] [--] 'block/dirty-bitmaps: move comment block'
009/10:[----] [--] 'blockdev: remove unused paio parameter documentation'
010/10:[0003] [FC] 'iotests: add busy/recording bit test to 124'


001: Texi doc spelling (Eric)
002: Commit message spelling (Eric)
     Additional asserts (Vladimir)
007: Comment phrasing (Vladimir)
010: Extra test comment
