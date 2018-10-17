Received: from eggs.gnu.org ([2001:4830:134:3::10]:59149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCpiP-00045I-FZ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCpiK-0007sn-Eb
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:34:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCpiJ-0007r6-M1
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:34:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F6293002F2B
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 17:34:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
	<20181017082702.5581-38-armbru@redhat.com>
	<20181017134555.GC31479@localhost.localdomain>
Date: Wed, 17 Oct 2018 19:34:26 +0200
In-Reply-To: <20181017134555.GC31479@localhost.localdomain> (Kevin Wolf's
	message of "Wed, 17 Oct 2018 15:45:55 +0200")
Message-ID: <874ldko4t9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 37/38] raw: Convert a warning to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 17.10.2018 um 10:27 hat Markus Armbruster geschrieben:
>> Convert the warning about dangerous automatic probing of raw images to
>> warn_report().  Split its text to conform to conventions spelled out
>> in warn_report()'s contract.
>
> One of the things the warn_report() documentation says is:
>
>     It's wrong to call this in a QMP monitor.  Use error_setg() there.
>
> Probably a bug in the comment (copy and paste from error_report())? The
> same sentence is also there for info_report().

We could debate whether use of warn_report() in a QMP monitor is a good
idea, but the comment is definitely wrong: error_setg() can't do
warnings.  I'll fix this.

>> Update expected output of qemu-iotest 109 accordingly.  Update
>> qemu-iotest 099's output filtering to keep filtering out the warning.
>> 
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>> --- a/tests/qemu-iotests/109.out
>> +++ b/tests/qemu-iotests/109.out
>> @@ -5,8 +5,9 @@ QA output created by 109
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>>  Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
>>  {"return": {}}
>> -WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
>> -         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
>> +warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
>> +Automatically detecting the format is dangerous for raw images, write
>> +operations on block 0 will be restricted.
>>           Specify the 'raw' format explicitly to remove the restrictions.
>
> I honestly like the old formatting better, with indentation and without
> the arbitrary \n in the error_printf() line that is probably shorter
> than the warning line anyway.

We don't indent an informational message following an error or a warning
elsewhere.  I'm willing to keep the indentation anyway.  You tell me.

I dislike text wider than some 70 characters.  I'm willing to keep it
that way anyway.  You tell me.

> Also, I know that qemu-iotests ignores whitespace for diffing the
> result, but not adjusting the last line in the reference output still
> looks a bit odd.

That's an accident.

Thanks!
