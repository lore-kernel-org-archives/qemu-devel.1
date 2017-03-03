Received: from eggs.gnu.org ([2001:4830:134:3::10]:35746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjffR-0006Uf-6u
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjffQ-00089I-DF
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:22:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-3-git-send-email-armbru@redhat.com>
	<ea96afbe-4379-3e17-c0b6-6b615c170a2e@redhat.com>
Date: Fri, 03 Mar 2017 06:22:04 +0100
In-Reply-To: <ea96afbe-4379-3e17-c0b6-6b615c170a2e@redhat.com> (Eric Blake's
	message of "Thu, 2 Mar 2017 17:13:52 -0600")
Message-ID: <87wpc76ikj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/15] sheepdog: Fix error handling in
 sd_snapshot_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/02/2017 03:43 PM, Markus Armbruster wrote:
>> As a bdrv_snapshot_delete() method, sd_snapshot_delete() must set an
>> error and return negative errno on failure.  It sometimes returns -1,
>> and sometimes neglects to set an error.  It also prints error messages
>> with error_report().  Fix all that.
>> 
>> Moreover, its handling of an attempt to delete an nonexistent snapshot
>> is wrong: it error_report()s and succeeds.  Fix it to set an error and
>> return -ENOENT instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/sheepdog.c | 37 +++++++++++++++++--------------------
>>  1 file changed, 17 insertions(+), 20 deletions(-)
>> 
>
>> @@ -2447,15 +2444,14 @@ static bool remove_objects(BDRVSheepdogState *s)
>>                                      data_vdi_id[start_idx]),
>>                             false, s->cache_flags);
>>          if (ret < 0) {
>> -            error_report("failed to discard snapshot inode.");
>> -            result = false;
>> +            error_setg(errp, "failed to discard snapshot inode.");
>
> Lose the trailing '.'

Good idea.

> With that fixed,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
