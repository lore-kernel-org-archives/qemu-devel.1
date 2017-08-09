Received: from eggs.gnu.org ([2001:4830:134:3::10]:59801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfK7j-0000nD-5A
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfK7h-0001Ms-Rb
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:05:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-11-git-send-email-armbru@redhat.com>
	<20170808151005.GL2081@work-vm>
Date: Wed, 09 Aug 2017 08:05:28 +0200
In-Reply-To: <20170808151005.GL2081@work-vm> (David Alan Gilbert's message of
	"Tue, 8 Aug 2017 16:10:06 +0100")
Message-ID: <87shh1z36f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 10/56] hmp: Make balloon's argument
 unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> The previous commit made it unsigned in QMP.  Switch HMP's args_type
>> from 'M' to 'o'.  Loses support for expressions (QEMU pocket
>> calculator), gains support for units other than mebibytes.  Negative
>> values are no longer accepted and interpreted modulo 2^64.  Instead,
>> values between 2^63 and 2^64-1 are now accepted.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hmp-commands.hx | 2 +-
>>  hmp.c           | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 1941e19..46ce79c 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -1433,7 +1433,7 @@ ETEXI
>>  
>>      {
>>          .name       = "balloon",
>> -        .args_type  = "value:M",
>> +        .args_type  = "value:o",
>>          .params     = "target",
>>          .help       = "request VM to change its memory allocation (in MB)",
>>          .cmd        = hmp_balloon,
>> diff --git a/hmp.c b/hmp.c
>> index 4556045..1932a11 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -781,7 +781,7 @@ void hmp_info_balloon(Monitor *mon, const QDict *qdict)
>>          return;
>>      }
>>  
>> -    monitor_printf(mon, "balloon: actual=%" PRIu64 "\n", info->actual >> 20);
>> +    monitor_printf(mon, "balloon: actual=%" PRId64 "\n", info->actual >> 20);
>
> That looks like a partial reversion of the last patch ?

Accident, will fix, thanks!

[...]
