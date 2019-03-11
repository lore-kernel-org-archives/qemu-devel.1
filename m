Received: from eggs.gnu.org ([209.51.188.92]:46580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3NGP-0006QS-NW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3NDw-0006vw-HM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:52:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3NDw-0006vY-9h
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:52:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-2-f4bug@amsat.org>
	<ed8793ce-cc5f-a506-2bdc-a39e9fc79cc7@amsat.org>
	<07100472-e75f-88c7-6740-21a56e225f80@redhat.com>
	<20190311134306.GJ8899@habkost.net>
	<CAFEAcA-yBu1SyhmfYKjXtA2BSHJrPnz_n-SrNwcdpG-isLbzWA@mail.gmail.com>
Date: Mon, 11 Mar 2019 16:52:13 +0100
In-Reply-To: <CAFEAcA-yBu1SyhmfYKjXtA2BSHJrPnz_n-SrNwcdpG-isLbzWA@mail.gmail.com>
	(Peter Maydell's message of "Mon, 11 Mar 2019 13:48:00 +0000")
Message-ID: <87imwpl87m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdbus: add a QMP command to access
 a SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 11 Mar 2019 at 13:43, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>> On Mon, Mar 11, 2019 at 12:49:50PM +0100, Thomas Huth wrote:
>> > On 08/03/2019 17.11, Philippe Mathieu-Daud=C3=A9 wrote:
>> > > Hi Markus,
>> > >
>> > > [Asking again from the correct series thread]
>> > >
>> > > On 1/3/18 10:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> > >> Use Base64 to serialize the binary blobs in JSON.
>> > >> So far at most 512 bytes will be transfered, which result
>> > >> in a 684 bytes payload.
>> > >> Since this command is intented for qtesting, it is acceptable.
>> > >
>> > > Any comment regarding QMP for this patch?
>> >
>> > Is this useful for anybody else than qtest? If not, I think this should
>> > rather go into the qtest protocol instead, since QMP is our "public"
>> > protocol.
>>
>> Extending qtest requires writing parsers by hand.  Do we really
>> want to go that route and start extending the qtest protocol more
>> often?
>
> Perhaps we could have qtest-only QMP commands that only get
> recognized if qtest_enabled() ?

QMP commands are defined at compile time.  We just got rid of the hack
to "unrecognize" selected commands dynamically at run-time (commit
0b69f6f72ce), which we had because our compile-time facilities were
lacking.  I'd hate to bring this hack back.

What's easy is to have QMP commands that fail unless qtest_enabled() :)
