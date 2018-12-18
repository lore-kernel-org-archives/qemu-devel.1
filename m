Received: from eggs.gnu.org ([2001:4830:134:3::10]:33385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZ9Q1-0005W3-UB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZ9Pv-00045J-CA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:03:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZ9Pn-0003xl-Eg
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:03:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
	<20181213184340.24037-33-armbru@redhat.com>
	<fde45953-c713-daf7-f3ce-47d63b050f7a@redhat.com>
	<CAJ+F1CLEDbur0x1H59U52F2kyKUhn55qJHPOBhcdeTvJdaSJLw@mail.gmail.com>
Date: Tue, 18 Dec 2018 08:03:30 +0100
In-Reply-To: <CAJ+F1CLEDbur0x1H59U52F2kyKUhn55qJHPOBhcdeTvJdaSJLw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 17 Dec 2018
	22:38:14 +0400")
Message-ID: <877eg7jozh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 32/32] qapi: add conditions to REPLICATION
 type/commands on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Dec 17, 2018 at 8:01 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 2018-12-13 19:43, Markus Armbruster wrote:
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > Add #if defined(CONFIG_REPLICATION) in generated code, and adjust the
>> > code accordingly.
>> >
>> > Made conditional:
>> >
>> > * xen-set-replication, query-xen-replication-status,
>> >   xen-colo-do-checkpoint
>> >
>> >   Before the patch, we first register the commands unconditionally in
>> >   generated code (requires a stub), then conditionally unregister in
>> >   qmp_unregister_commands_hack().
>> >
>> >   Afterwards, we register only when CONFIG_REPLICATION.  The command
>> >   fails exactly the same, with CommandNotFound.
>> >
>> >   Improvement, because now query-qmp-schema is accurate, and we're one
>> >   step closer to killing qmp_unregister_commands_hack().
>> >
>> > * enum BlockdevDriver value "replication" in command blockdev-add
>> >
>> > * BlockdevOptions variant @replication
>> >
>> > and related structures.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> > Message-Id: <20181213123724.4866-23-marcandre.lureau@redhat.com>
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> >  migration/colo.c     | 16 ++++------------
>> >  monitor.c            |  5 -----
>> >  qapi/block-core.json | 13 +++++++++----
>> >  qapi/migration.json  | 12 ++++++++----
>> >  4 files changed, 21 insertions(+), 25 deletions(-)
>>
>> I think this might have broken compilation with --disable-replication:
>>
>>  https://gitlab.com/huth/qemu/-/jobs/135648240
>>
>> Any ideas how to fix it?
>
> We introduced a regression by dropping osdep.h include from headers.
>
> To me, it's best to include osdep.h in headers, since the ifdef exist
> there. But I have been told we include it in .c instead. I'll upstream
> the qapi/scripts to include it.

This can't be the cause: qapi/qapi-visit-block-core.c includes osdep.h
first, like all our .c files.

> thanks for the report, sorry for the regression

You've since posted a fix to add the missing ifdeffery.  I'm testing it
while I write :)
