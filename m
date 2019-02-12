Received: from eggs.gnu.org ([209.51.188.92]:36626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtSSK-0006M0-G7
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtSFm-0001vA-11
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:13:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtSFl-0001s5-IF
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:13:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190131202637.4062-1-jusual@mail.ru>
	<87lg2zj2f2.fsf@dusky.pond.sub.org>
	<d10b10d5-0600-515b-66d7-e6f448f42ced@mail.ru>
Date: Tue, 12 Feb 2019 08:13:03 +0100
In-Reply-To: <d10b10d5-0600-515b-66d7-e6f448f42ced@mail.ru> (Julia Suvorova
	via Qemu-devel's message of "Mon, 11 Feb 2019 18:42:24 +0300")
Message-ID: <8736otqy2o.fsf@dusky.pond.sub.org>
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

Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> writes:

> On 01.02.2019 12:14, Markus Armbruster wrote:
>> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> writes:
>>
>>> The whitelist option allows to run a reduced monitor with a subset of
>>> QMP commands. This allows the monitor to run in secure mode, which is
>>
>> For a value of "secure".  I'm not saying this can't be useful, just
>> tempering expecations.  I guess you intend to use this to restrict the
>> monitor to sufficiently harmless commands, such as commands that merely
>> return information without changing anything.  However, even such
>> commands can be abused for denial of service.  Whether that's an issue
>> depends on your use case.
>>
>>> convenient for sending commands via the WebSocket monitor using the
>>> web UI. This is planned to be done on micro:bit board.
>>>
>>> The list of allowed commands should be written to a file, one per line.
>>> The command line will look like this:
>>>      -mon chardev_name,mode=control,whitelist=path_to_file
>>>
>>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>>
>> Please describe your intended use case in more detail, and provide at
>> least a rough security analysis that includes the denial of service
>> aspect.
>
> It is planned to use the web interface for micro:bit board, e.g. send a
> button press as a QMP command and send a LED display changing as a QMP
> event, and send them via WebSocket protocol from QEMU to a web page.
> The monitor will also send commands from some other sensors, for
> example, an accelerometer/magnetometer. Therefore, it is convenient to
> limit the monitor so that it can send only these commands of
> buttons/sensors.

Covers "describe your intended use case" nicely, thanks.  Still missing:
"a rough security analysis that includes the denial of service aspect".
Here are two questions to help you get started.  Is "the web interface"
trusted?  If not, what if it floods QEMU with button presses?
