Received: from eggs.gnu.org ([209.51.188.92]:40680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3Ot6-000833-5o
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3Olu-00044Q-2t
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:31:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3Olt-000441-Ok
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:31:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190131202637.4062-1-jusual@mail.ru>
	<87lg2zj2f2.fsf@dusky.pond.sub.org>
	<d10b10d5-0600-515b-66d7-e6f448f42ced@mail.ru>
	<8736otqy2o.fsf@dusky.pond.sub.org>
	<3a755bba-a539-d1f5-933b-54d2def67596@mail.ru>
Date: Mon, 11 Mar 2019 18:31:22 +0100
In-Reply-To: <3a755bba-a539-d1f5-933b-54d2def67596@mail.ru> (Julia Suvorova
	via Qemu-devel's message of "Thu, 21 Feb 2019 20:27:56 +0300")
Message-ID: <87tvg9uxlh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Cc: Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?Q?G=C3=B6rtz?= <contrib@steffen-goertz.de>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>

I apologize for the long delay.

Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> writes:

> On 12.02.2019 10:13, Markus Armbruster wrote:
>> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> writes:
>>
>>> On 01.02.2019 12:14, Markus Armbruster wrote:
>>>> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> writes:
>>>>
>>>>> The whitelist option allows to run a reduced monitor with a subset of
>>>>> QMP commands. This allows the monitor to run in secure mode, which is
>>>>
>>>> For a value of "secure".  I'm not saying this can't be useful, just
>>>> tempering expecations.  I guess you intend to use this to restrict the
>>>> monitor to sufficiently harmless commands, such as commands that merely
>>>> return information without changing anything.  However, even such
>>>> commands can be abused for denial of service.  Whether that's an issue
>>>> depends on your use case.
>>>>
>>>>> convenient for sending commands via the WebSocket monitor using the
>>>>> web UI. This is planned to be done on micro:bit board.
>>>>>
>>>>> The list of allowed commands should be written to a file, one per line.
>>>>> The command line will look like this:
>>>>>       -mon chardev_name,mode=control,whitelist=path_to_file
>>>>>
>>>>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>>>>
>>>> Please describe your intended use case in more detail, and provide at
>>>> least a rough security analysis that includes the denial of service
>>>> aspect.
>>>
>>> It is planned to use the web interface for micro:bit board, e.g. send a
>>> button press as a QMP command and send a LED display changing as a QMP
>>> event, and send them via WebSocket protocol from QEMU to a web page.
>>> The monitor will also send commands from some other sensors, for
>>> example, an accelerometer/magnetometer. Therefore, it is convenient to
>>> limit the monitor so that it can send only these commands of
>>> buttons/sensors.
>>
>> Covers "describe your intended use case" nicely, thanks.  Still missing:
>> "a rough security analysis that includes the denial of service aspect".
>> Here are two questions to help you get started.  Is "the web interface"
>> trusted?  If not, what if it floods QEMU with button presses?
>
> In the case of a trusted connection, we don't even need a whitelist.
> The oob execution must be disabled in order to prohibit the direct
> execution of speculative series of commands. The regular command
> suspends the monitor and causes it to stop reading the commands until
> the execution is completed, which prevents the client from capturing too
> many resources.

It could still peg one core, at least in theory.

>                 And since the suspension of the monitor doesn't stop the
> sending of events, the display will work fine.

This is not an objection; I asked for a rough security analysis not to
challenge its premises, but to make sure you have one.  Now put it on
record by working it into your commit message.

I still have to review the actual patch.  You may want to wait for that
before you respin.
