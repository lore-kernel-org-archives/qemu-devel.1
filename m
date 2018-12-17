Received: from eggs.gnu.org ([2001:4830:134:3::10]:45769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gYyPf-0005WG-LT
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gYyPb-0005j2-H7
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:18:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gYyPb-0005iJ-A4
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:18:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
	<20181213184340.24037-33-armbru@redhat.com>
	<fde45953-c713-daf7-f3ce-47d63b050f7a@redhat.com>
Date: Mon, 17 Dec 2018 20:18:37 +0100
In-Reply-To: <fde45953-c713-daf7-f3ce-47d63b050f7a@redhat.com> (Thomas Huth's
	message of "Mon, 17 Dec 2018 17:00:59 +0100")
Message-ID: <87k1k8j71u.fsf@dusky.pond.sub.org>
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Thomas Huth <thuth@redhat.com> writes:

> On 2018-12-13 19:43, Markus Armbruster wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>=20
>> Add #if defined(CONFIG_REPLICATION) in generated code, and adjust the
>> code accordingly.
>>=20
>> Made conditional:
>>=20
>> * xen-set-replication, query-xen-replication-status,
>>   xen-colo-do-checkpoint
>>=20
>>   Before the patch, we first register the commands unconditionally in
>>   generated code (requires a stub), then conditionally unregister in
>>   qmp_unregister_commands_hack().
>>=20
>>   Afterwards, we register only when CONFIG_REPLICATION.  The command
>>   fails exactly the same, with CommandNotFound.
>>=20
>>   Improvement, because now query-qmp-schema is accurate, and we're one
>>   step closer to killing qmp_unregister_commands_hack().
>>=20
>> * enum BlockdevDriver value "replication" in command blockdev-add
>>=20
>> * BlockdevOptions variant @replication
>>=20
>> and related structures.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Message-Id: <20181213123724.4866-23-marcandre.lureau@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  migration/colo.c     | 16 ++++------------
>>  monitor.c            |  5 -----
>>  qapi/block-core.json | 13 +++++++++----
>>  qapi/migration.json  | 12 ++++++++----
>>  4 files changed, 21 insertions(+), 25 deletions(-)
>
> I think this might have broken compilation with --disable-replication:
>
>  https://gitlab.com/huth/qemu/-/jobs/135648240

Reproduced.

> Any ideas how to fix it?

The problem is fairly obvious, repair less so.  Sorry this escaped
review.

Union BlockdevCreateOptions doesn't specify a variant for tag
'replication'.  The default variant needs to inherits its condition from
the enumeration value.  I hope we can develop a fix quickly.
