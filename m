Received: from eggs.gnu.org ([209.51.188.92]:56248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmjkx-0004dh-HN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmjkv-00073M-DT
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:29:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
	<87munqieiv.fsf@dusky.pond.sub.org>
	<f16734e0-1ec3-15e7-5a06-7b2c804c80a9@redhat.com>
Date: Thu, 24 Jan 2019 19:29:26 +0100
In-Reply-To: <f16734e0-1ec3-15e7-5a06-7b2c804c80a9@redhat.com> (Eric Blake's
	message of "Thu, 24 Jan 2019 12:13:31 -0600")
Message-ID: <87tvhxaozd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, "Richard W. M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 1/24/19 3:35 AM, Markus Armbruster wrote:
>
>>     To gauge the bug's impact, let's review non-interpolating users of this
>>     parser, i.e. code passing NULL context to json_message_parser_init():
>> 
>>     * tests/check-qjson.c, tests/test-qobject-input-visitor.c,
>>       tests/test-visitor-serialization.c
>> 
>>       Plenty of tests, but we still failed to cover the buggy case.
>> 
>>     * monitor.c: QMP input
>> 
>>     * qga/main.c: QGA input
>> 
>>     * qobject_from_json():
>> 
>>       - qobject-input-visitor.c: JSON command line option arguments of
>>         -display and -blockdev
>> 
>>         Reproducer: -blockdev '{"%"}'
>> 
>>       - block.c: JSON pseudo-filenames starting with "json:"
>> 
>>         Reproducer: https://bugzilla.redhat.com/show_bug.cgi?id=1668244#c3
>> 
>>       - block/rbd.c: JSON key pairs
>> 
>>         Pseudo-filenames starting with "rbd:".
>> 
>
> Missed curl as being impacted. You'd have to do a v2 pull request to
> mention it now...
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1668244

Isn't that an instance of 'JSON pseudo-filenames starting with "json:"'?
