Received: from eggs.gnu.org ([2001:4830:134:3::10]:40537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chVzN-0007VT-T8
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chVzK-0007sg-JZ
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:37:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1chVzK-0007sP-BG
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:37:50 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6957AC056791
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 06:37:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-7-git-send-email-armbru@redhat.com>
	<902f6fcc-2aa4-8aca-7c4b-0b5fd0e918b8@redhat.com>
Date: Sat, 25 Feb 2017 07:37:47 +0100
In-Reply-To: <902f6fcc-2aa4-8aca-7c4b-0b5fd0e918b8@redhat.com> (Eric Blake's
	message of "Fri, 24 Feb 2017 17:03:54 -0600")
Message-ID: <874lzivkqs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/21] qmp: Drop duplicated QMP command
 object checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/23/2017 03:45 PM, Markus Armbruster wrote:
>> qmp_check_input_obj() duplicates qmp_dispatch_check_obj(), except the
>> latter screws up an error message.  handle_qmp_command() runs first
>> the former, then the latter via qmp_dispatch(), masking the screwup.
>> 
>> qemu-ga also masks the screwup, because it also duplicates checks,
>> just differently.
>
> Cleaning up the duplication is a win in my book.
>
>> 
>> qmp_check_input_obj() exists because handle_qmp_command() needs to
>> examine the command before dispatching it.  The previous commit got
>> rid of this need, except for a tracepoint, and a bit of "id" code that
>> relies on qdict not being null.
>> 
>> Fix up the error message in qmp_dispatch_check_obj(), drop
>> qmp_check_input_obj() and the tracepoint.  Protect the "id" code with
>> a conditional.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  monitor.c           | 74 +++++------------------------------------------------
>>  qapi/qmp-dispatch.c |  3 +--
>>  trace-events        |  1 -
>>  3 files changed, 7 insertions(+), 71 deletions(-)
>> 
>> diff --git a/monitor.c b/monitor.c
>> index dcf2de7..d83888d 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -3697,67 +3697,10 @@ static int monitor_can_read(void *opaque)
>>      return (mon->suspend_cnt == 0) ? 1 : 0;
>>  }
>>  
>> -/*
>> - * Input object checking rules
>> - *
>> - * 1. Input object must be a dict
>> - * 2. The "execute" key must exist
>> - * 3. The "execute" key must be a string
>> - * 4. If the "arguments" key exists, it must be a dict
>> - * 5. If the "id" key exists, it can be anything (ie. json-value)
>> - * 6. Any argument not listed above is considered invalid
>
> You know, with just a little tweak, we could add something to the .json
> file, and let generated code do all the checks of even the top-level
> entities:
>
> { 'struct': 'WireCommand',
>   'data': { 'execute': 'str', '*arguments': 'dict', '*id': 'any' } }
>
> if we had a way to force 'dict' as a subset of 'any' but where it must
> be a QDict.  (If we had a 'dict' recognized by the QAPI code generators,
> we could probably also fix 'object-add' to use '*props':'dict' instead
> of its current use of 'any')
>
> But that sounds like a bit much to ask for in the 2.9 timeframe, so it
> doesn't hold up this patch.

The thought came to me, too, but I banished it due to time pressure
before it could take presentable form.

Valid point on object-add.  If we find more uses for "generic object",
we can explore a new built-in QAPI type.

> We lose a trace, but I don't think that's fatal.

If we need one, it should be added to qmp_dispatch(), where it's also
useful for qemu-ga.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
