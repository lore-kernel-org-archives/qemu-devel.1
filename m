Received: from eggs.gnu.org ([209.51.188.92]:35575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtcc7-0003I9-Jw
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtcc3-0001GY-DG
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:16:57 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<04ac803b-1faa-f184-2fd8-10a202bd6042@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <721b8aef-fbf6-0a30-7034-abcdc7036721@redhat.com>
Date: Tue, 12 Feb 2019 13:15:08 -0500
MIME-Version: 1.0
In-Reply-To: <04ac803b-1faa-f184-2fd8-10a202bd6042@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] dirty-bitmaps: deprecate @status field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/12/19 1:12 PM, Eric Blake wrote:
> On 2/11/19 7:02 PM, John Snow wrote:
>> The current internal meanings of "locked", "user_locked",
>> "qmp_locked", "frozen", "enabled", and "disabled" are all
>> a little muddled.
>>
>> Deprecate the @status field in favor of two new booleans
>> that carry very specific meanings. Then, rename and rework
>> some of the internal semantics to help make the API a bit
>> more clear and easier to read.
> 
> So far, my libvirt patches are not relying on the contents of the status
> field, so deprecating things should not hurt libvirt. Using the full
> 2-cycle process is still probably wise for other users, though, even if
> it means for some awkward back-compat computation of status for a while
> longer.
> 

I didn't fully remove it, either. I will leave it there for the normal
deprecation period -- it doesn't hurt to keep it around.

>>
>> Well, in my opinion.
>>
>> Based on my current bitmaps branch (includes Eric's patch
>> and my documentation update patch.)
>>
>> John Snow (5):
>>   block/dirty-bitmap: add recording and busy properties
>>   block/dirty-bitmaps: rename frozen predicate helper
>>   block/dirty-bitmap: change semantics of enabled predicate
>>   block/dirty-bitmap: explicitly lock bitmaps with successors
>>   block/dirty-bitmaps: unify qmp_locked and user_locked calls
>>
>>  block/dirty-bitmap.c           | 74 +++++++++++++++++++---------------
>>  blockdev.c                     | 18 ++++-----
>>  include/block/dirty-bitmap.h   |  7 ++--
>>  migration/block-dirty-bitmap.c |  8 ++--
>>  nbd/server.c                   |  6 +--
>>  qapi/block-core.json           |  9 ++++-
>>  tests/qemu-iotests/236.out     | 28 +++++++++++++
>>  7 files changed, 96 insertions(+), 54 deletions(-)
> 
> No change to qemu-deprecated.texi to start the clock ticking, so we can
> remove the old field?
> 

I was counting on having to send a v2, I just didn't add the RFC tag
because I wanted to trick people into reviewing it.

If this passes the sniff test for you, I will document it in the .texi.

--js
