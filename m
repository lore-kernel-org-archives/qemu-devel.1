Received: from eggs.gnu.org ([2001:4830:134:3::10]:59786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjnJR-00046J-Fc
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjnJQ-0007fN-BC
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:32:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-3-git-send-email-armbru@redhat.com>
	<20170303130733.GC6599@noname.redhat.com>
Date: Fri, 03 Mar 2017 14:31:51 +0100
In-Reply-To: <20170303130733.GC6599@noname.redhat.com> (Kevin Wolf's message
	of "Fri, 3 Mar 2017 14:07:33 +0100")
Message-ID: <8737euv648.fsf@dusky.pond.sub.org>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 02.03.2017 um 22:43 hat Markus Armbruster geschrieben:
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
>
>> -static bool remove_objects(BDRVSheepdogState *s)
>> +static int remove_objects(BDRVSheepdogState *s, Error **errp)
>>  {
>>      int fd, i = 0, nr_objs = 0;
>> -    Error *local_err = NULL;
>>      int ret = 0;
>
> Preexisting, but I'll mention it anyway: This style of initialising ret
> with 0 isn't wrong, but it would be more obviously correct if you set
> ret = 0 only immediately before the out: label. The way it is currently,
> I had to assure myself that write_object() really can't return a
> positive number.

I can squash in that change.

>> -    bool result = true;
>>      SheepdogInode *inode = &s->inode;
>>  
>> -    fd = connect_to_sdog(s, &local_err);
>> +    fd = connect_to_sdog(s, errp);
>>      if (fd < 0) {
>> -        error_report_err(local_err);
>> -        return false;
>> +        return fd;
>>      }
>>  
>>      nr_objs = count_data_objs(inode);
>> @@ -2447,15 +2444,14 @@ static bool remove_objects(BDRVSheepdogState *s)
>>                                      data_vdi_id[start_idx]),
>>                             false, s->cache_flags);
>>          if (ret < 0) {
>> -            error_report("failed to discard snapshot inode.");
>> -            result = false;
>> +            error_setg(errp, "failed to discard snapshot inode.");
>
> As Eric said, remove the trailing period. I would also let the message
> start with a capital letter for consistency with the other error
> messages in sd_snapshot_delete().

Okay.

Aside: we don't do this consistently either way.  For what it's worth,
lower case looks ugly when there is no prefix (e.g. in the human
monitor), and upper case can look ugly when there is one, particularly
with error_prepend().

>>              goto out;
>>          }
>>      }
>>  
>>  out:
>>      closesocket(fd);
>> -    return result;
>> +    return ret;
>>  }
>>  
>>  static int sd_snapshot_delete(BlockDriverState *bs,
>> @@ -2465,7 +2461,6 @@ static int sd_snapshot_delete(BlockDriverState *bs,
>>  {
>>      unsigned long snap_id = 0;
>>      char snap_tag[SD_MAX_VDI_TAG_LEN];
>> -    Error *local_err = NULL;
>>      int fd, ret;
>>      char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
>>      BDRVSheepdogState *s = bs->opaque;
>> @@ -2478,8 +2473,9 @@ static int sd_snapshot_delete(BlockDriverState *bs,
>>      };
>>      SheepdogVdiRsp *rsp = (SheepdogVdiRsp *)&hdr;
>>  
>> -    if (!remove_objects(s)) {
>> -        return -1;
>> +    ret = remove_objects(s, errp);
>> +    if (ret) {
>> +        return ret;
>>      }
>>  
>>      memset(buf, 0, sizeof(buf));
>> @@ -2500,35 +2496,36 @@ static int sd_snapshot_delete(BlockDriverState *bs,
>>      }
>>  
>>      ret = find_vdi_name(s, s->name, snap_id, snap_tag, &vid, true,
>> -                        &local_err);
>> +                        errp);
>
> This fits on a single line.

Yes.

> Nothing critical, but it seems you're going to send a new version
> anyway, so you could as well improve it.

Sure!
