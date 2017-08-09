Received: from eggs.gnu.org ([2001:4830:134:3::10]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfK8W-0001HK-S5
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfK8V-0001fI-MM
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:06:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-28-git-send-email-armbru@redhat.com>
	<dd036d00-e59d-6696-e872-6557d7fe75f2@redhat.com>
Date: Wed, 09 Aug 2017 08:06:16 +0200
In-Reply-To: <dd036d00-e59d-6696-e872-6557d7fe75f2@redhat.com> (Eric Blake's
	message of "Tue, 8 Aug 2017 09:53:13 -0500")
Message-ID: <87o9rpz353.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 27/56] block/dirty-bitmap: Clean up
 signed vs. unsigned dirty counts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 08/07/2017 09:45 AM, Markus Armbruster wrote:
>> hbitmap_count() returns uint64_t.
>> 
>> Clean up test-hbitmap.c to check its value with g_assert_cmpuint()
>> instead of g_assert_cmpint().
>> 
>> bdrv_get_dirty_count() and bdrv_get_meta_dirty_count() return its
>> value converted to int64_t.  Clean them up to return it unadulterated.
>> 
>> This moves the implicit conversion to some callers, so clean them up,
>> too.
>> 
>> mirror_run() assigns the value of bdrv_get_meta_dirty_count() to a
>> local int64_t variable.  Change it to uint64_t.  Signedness still gets
>> mixed up in the computation of s->common.len, but messing with that is
>> more than I can handle right now.
>> 
>> get_remaining_dirty() tallies bdrv_get_dirty_count() values in
>> int64_t.  Its caller block_save_pending() converts it back to
>> uint64_t.  Change get_remaining_dirty() to uint64_t.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/dirty-bitmap.c         |  4 ++--
>>  block/mirror.c               |  4 ++--
>>  block/trace-events           |  8 ++++----
>>  include/block/dirty-bitmap.h |  4 ++--
>>  migration/block.c            |  4 ++--
>>  tests/test-hbitmap.c         | 16 +++++++++-------
>>  6 files changed, 21 insertions(+), 19 deletions(-)
>
> I don't know how much this will conflict with my pending work for
> byte-based block status, but I suspect it may be easier for your RFC to
> go in after my cleanups (I think you'll still have things to fix).

I fully expect to rebase on your work.
