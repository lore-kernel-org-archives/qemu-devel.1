Received: from eggs.gnu.org ([2001:4830:134:3::10]:48498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYZZ3-0002MD-41
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYZZ2-0006UD-6K
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:37:45 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-8-git-send-email-armbru@redhat.com>
	<894b7bb8-768b-de12-cb48-7c9d52333bbe@redhat.com>
Date: Tue, 31 Jan 2017 15:37:34 +0100
In-Reply-To: <894b7bb8-768b-de12-cb48-7c9d52333bbe@redhat.com> (John Snow's
	message of "Tue, 31 Jan 2017 07:37:42 -0500")
Message-ID: <87efzjcn2p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 7/8] blockdev: Make
 orphaned -drive fatal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

John Snow <jsnow@redhat.com> writes:

> On 01/26/2017 10:09 AM, Markus Armbruster wrote:
>> Block backends defined with "-drive if=T" with T other than "none" are
>> meant to be picked up by machine initialization code: a suitable
>> frontend gets created and wired up automatically.
>> 
>> If machine initialization code doesn't comply, the block backend
>> remains unused.  This triggers a warning since commit a66c9dc, v2.2.0.
>> Drives created by default are excempted; use -nodefaults to get rid of
>> them.
>> 
>> Turn this warning into an error.
>> 
>
> "Exempted," oddly enough.
> </eblake>

Thanks!

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  blockdev.c                | 14 +++++++-------
>>  include/sysemu/blockdev.h |  2 +-
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>> 
>> diff --git a/blockdev.c b/blockdev.c
>> index a597a66..ec9c114 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -227,28 +227,28 @@ DriveInfo *drive_get(BlockInterfaceType type, int bus, int unit)
>>      return NULL;
>>  }
>>  
>> -bool drive_check_orphaned(void)
>> +void drive_check_orphaned(void)
>>  {
>>      BlockBackend *blk;
>>      DriveInfo *dinfo;
>>      Location loc;
>> -    bool rs = false;
>> +    bool orphans = false;
>>  
>>      for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
>>          dinfo = blk_legacy_dinfo(blk);
>> -        /* If dinfo->bdrv->dev is NULL, it has no device attached. */
>> -        /* Unless this is a default drive, this may be an oversight. */
>>          if (!blk_get_attached_dev(blk) && !dinfo->is_default &&
>>              dinfo->type != IF_NONE) {
>>              loc_push_none(&loc);
>>              qemu_opts_loc_restore(dinfo->opts);
>> -            error_report("warning: machine type does not support this drive");
>> +            error_report("machine type does not support this drive");
>>              loc_pop(&loc);
>> -            rs = true;
>> +            orphans = true;
>>          }
>>      }
>>  
>> -    return rs;
>> +    if (orphans) {
>> +        exit(1);
>> +    }
>
> Hardcore. Why not just return a status code and allow vl.c to exit? It
> only has the one caller. (Unless you added more and I didn't read
> because I'm lazy.)
>
> You could even add an Error **arg if you wanted to; but vl.c has exits
> all over the dang place, so maybe that's not really interesting.

My excuse it that checking for orphans makes sense only during initial
startup, and there, exit(1) on error is what we do.  Doing it right away
is simplest.

I'm fine with leaving the exit() to the caller.  I would prefer to leave
the printing to the caller as well then.

Anyone else got a preference?
