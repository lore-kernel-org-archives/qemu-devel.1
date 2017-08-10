Received: from eggs.gnu.org ([2001:4830:134:3::10]:54492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfi5G-0002Wi-HU
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfi5F-0002kY-Fe
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:40:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-15-eblake@redhat.com>
	<87d184ojqp.fsf@dusky.pond.sub.org>
	<ecd3699b-1a73-a8e2-5dac-b4f227f106b9@redhat.com>
Date: Thu, 10 Aug 2017 09:40:32 +0200
In-Reply-To: <ecd3699b-1a73-a8e2-5dac-b4f227f106b9@redhat.com> (Eric Blake's
	message of "Wed, 9 Aug 2017 10:32:50 -0500")
Message-ID: <87poc3j2fj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 14/22] libqtest: Separate
 qmp_discard_response() from command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 08/09/2017 10:15 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> Upcoming patches will be adding new convenience methods for
>>> constructing QMP commands.  But making every variation of sending
>>> support every variation of response handling becomes unwieldy;
>>> it's easier to specify that discarding a JSON response is
>>> unassociated with sending the command, where qmp_async() already
>>> fits the bill for sending a command without tying up a reference
>>> to the response.
>>>
>>> Doing this renders qtest_qmp[v]_discard_response() unused.
>>>
>>> Bonus: gets rid of a non-literal format string, which is a step
>>> towards compile-time format string checking without triggering
>>> -Wformat-nonliteral.
>> 
>> Where?  (I'm feeling lazy today)
>> 
>
> Sure:
>
>> 
>> +++ b/tests/ide-test.c
>> @@ -624,7 +624,6 @@ static void test_retry_flush(const char *machine)
>>      QPCIDevice *dev;
>>      QPCIBar bmdma_bar, ide_bar;
>>      uint8_t data;
>> -    const char *s;
>> 
>>      prepare_blkdebug_script(debug_path, "flush_to_disk");
>> 
>> @@ -652,8 +651,8 @@ static void test_retry_flush(const char *machine)
>>      qmp_eventwait("STOP");
>> 
>>      /* Complete the command */
>> -    s = "{'execute':'cont' }";
>> -    qmp_discard_response(s);
>> +    qmp_async("{'execute':'cont' }");
>> +    qmp_discard_response();
>
> Yes, I can update the commit message to focus in on it more precisely.

Not enabled by this patch, just cleanup while there.  Recommend to make
that clearer in the commit message.

Aside: I wonder what goes through a developer's head when he writes such
code.  "Too terse, let me splice in a variable" seems unlikely.

[...]
