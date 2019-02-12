Received: from eggs.gnu.org ([209.51.188.92]:37946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtciW-0008Qq-GO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtciR-0002Je-Jo
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:23:34 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-2-jsnow@redhat.com>
	<2ff3d746-ac29-561a-3076-8ee67ff4595a@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5cad4407-dfc1-5295-3e4e-49ec3fb23113@redhat.com>
Date: Tue, 12 Feb 2019 13:23:11 -0500
MIME-Version: 1.0
In-Reply-To: <2ff3d746-ac29-561a-3076-8ee67ff4595a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] block/dirty-bitmap: add recording and
 busy properties
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



On 2/12/19 1:17 PM, Eric Blake wrote:
> On 2/11/19 7:02 PM, John Snow wrote:
>> The current API allows us to report a single status, which we've defined as:
>>
>> Frozen: has a successor, treated as qmp_locked, may or may not be enabled.
>> Locked: no successor, qmp_locked. may or may not be enabled.
>> Disabled: Not frozen or locked, disabled.
>> Active: Not frozen, locked, or disabled.
>>
>> The problem is that both "Frozen" and "Locked" mean nearly the same thing,
>> and that both of them do not intuit whether they are recording guest writes
>> or not.
>>
>> This patch deprecates that status field and introduces two orthogonal
>> properties instead to replace it.
>> ---
> 
> No S-o-b?
> 

Ah, heck, what's wrong with my script that it keeps dropping this? sorry.

> 
>> +++ b/qapi/block-core.json
>> @@ -455,7 +455,13 @@
>>  #
>>  # @granularity: granularity of the dirty bitmap in bytes (since 1.4)
>>  #
>> -# @status: current status of the dirty bitmap (since 2.4)
>> +# @status: Deprecated in favor of @recording and @locked. (since 4.0)
> 
> I'd leave this one as (since 2.4). The deprecation clock is starting in
> 4.0, but the field has been present longer, and it is still obvious to
> readers...
> >> +#
>> +# @recording: true if the bitmap is recording new writes from the guest.
>> +#             Replaces `active` status. (since 4.0)
> 
> ...that the replacement fields are only usable in 4.0 and newer.
> 

OK. I'll just add a small note for what it was deprecated in favor of.

>> +#
>> +# @busy: true if the bitmap is in-use by some operation (NBD or jobs)
>> +#        and cannot be modified via QMP right now. (since 4.0)
>>  #
>>  # @persistent: true if the bitmap will eventually be flushed to persistent
>>  #              storage (since 4.0)
>> @@ -464,6 +470,7 @@
>>  ##
>>  { 'struct': 'BlockDirtyInfo',
>>    'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
>> +           'recording': 'bool', 'busy': 'bool',
>>             'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }
> 
> The UI changes look reasonable.
> 
> No iotests coverage of "busy":true?
> 

I'll add it to the list. I wrote test 124 when I was pretty new at
python and it's a dense monster to add things to, but I can probably
work it in without much problem.
