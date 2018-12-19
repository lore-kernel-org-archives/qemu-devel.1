Received: from eggs.gnu.org ([2001:4830:134:3::10]:46236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZffQ-0005Bj-Mi
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZffP-0000MX-P0
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:29:56 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-4-jsnow@redhat.com>
	<0de4bd2b-c78f-f293-4d43-20c8bcd168c6@virtuozzo.com>
	<71a31ed2-b371-3b8f-d527-bf37b09e5443@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <17495805-6cef-224e-16b0-ae854c96617b@redhat.com>
Date: Wed, 19 Dec 2018 12:29:49 -0500
MIME-Version: 1.0
In-Reply-To: <71a31ed2-b371-3b8f-d527-bf37b09e5443@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/5] iotests: change qmp_log filters to
 expect QMP objects only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/19/18 6:27 AM, Vladimir Sementsov-Ogievskiy wrote:
> 19.12.2018 14:07, Vladimir Sementsov-Ogievskiy wrote:
>> 19.12.2018 4:52, John Snow wrote:
>>> log() treats filters as if they can always filter its primary argument.
>>> qmp_log treats filters as if they're always text.
>>>
>>> Change qmp_log to treat filters as if they're always qmp object filters,
>>> then change the logging call to rely on log()'s ability to serialize QMP
>>> objects, so we're not duplicating that effort.
>>
>> As I understand, there still no use for qmp-object based filters (even after the
>> series), do we really need them? I'm afraid it's premature complication.
> 
> aha, sorry, missed that you use it in 206.
> But still not sure that it worth it. Isn't it better to just remove fields from dict,
> which are unpredictable, instead of substituting them..
> 

I'd like to keep the QMP output a prettified version of the plaintext
output, and not have it omit things. You can make the case for changing
that behavior in a separate patch.

> The other idea here: if we want
> automatically logged qmp commands (qmp_log(), actually), it should filter unpredictable
> things from output automatically, just by command, which is the first argument. Caller
> should not care about it, as it may be derived from command, how to filter it's output.
> And then, we just need a kind of dict of functions, which do not do something like generic
> recursion, but specifically prepares common-test-output for the concrete command...
> 

Feel free to enhance the test suite later to understand all the types of
commands and replies and scrub them automatically. For now, specifying
the filters matches behavior in much of the rest of the test suite and I
am not motivated to fix it.
