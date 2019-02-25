Received: from eggs.gnu.org ([209.51.188.92]:34418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyHsU-0003ee-8b
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyHsR-0001TF-HL
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:09:10 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-2-jsnow@redhat.com>
	<4aea2945-9e5e-e293-8a4d-ceb2780b12cc@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bf6ff77d-32b5-4519-7767-9e0a19d5270c@redhat.com>
Date: Mon, 25 Feb 2019 09:08:48 -0600
MIME-Version: 1.0
In-Reply-To: <4aea2945-9e5e-e293-8a4d-ceb2780b12cc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] block/dirty-bitmap: add recording
 and busy properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

On 2/25/19 9:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> 23.02.2019 3:06, John Snow wrote:
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
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---

>> +++ b/qapi/block-core.json
>> @@ -458,7 +458,14 @@
>>   #
>>   # @granularity: granularity of the dirty bitmap in bytes (since 1.4)
>>   #
>> -# @status: current status of the dirty bitmap (since 2.4)
>> +# @status: Deprecated in favor of @recording and @locked. (since 2.4)
>> +#
>> +# @recording: true if the bitmap is recording new writes from the guest.
>> +#             Replaces `active` and `disabled` statuses. (since 4.0)
>> +#
>> +# @busy: true if the bitmap is in-use by some operation (NBD or jobs)
>> +#        and cannot be modified via QMP or used by another operation.
>> +#        Replaces `locked` and `frozen` statuses. (since 4.0)
> 
> 
> Don't we want instead an array of flags? Which will include also persistent and
> inconsistent?

No, I don't think an array of flags is worth the extra complications in
generation and parsing of the JSON.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
