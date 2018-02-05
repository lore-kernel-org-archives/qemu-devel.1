Received: from eggs.gnu.org ([2001:4830:134:3::10]:37745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eihqJ-0001Jf-87
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eihqE-00051E-IE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:33:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eihqE-000510-CC
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:33:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-15-armbru@redhat.com>
	<CAMxuvayFe8fU5PMyX00k2tM=2-=ZQqsxd1PwMUxAFAx26chFRA@mail.gmail.com>
Date: Mon, 05 Feb 2018 15:33:37 +0100
In-Reply-To: <CAMxuvayFe8fU5PMyX00k2tM=2-=ZQqsxd1PwMUxAFAx26chFRA@mail.gmail.com>
	(Marc-Andre Lureau's message of "Mon, 5 Feb 2018 14:45:35 +0100")
Message-ID: <87mv0nv73y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 14/21] qapi: Generate in source order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: marcandre <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

Marc-Andre Lureau <mlureau@redhat.com> writes:

> On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote:
>> The generators' conversion to visitors (merge commit 9e72681d16)
>> changed the processing order of entities from source order to
>> alphabetical order.  The next commit needs source order, so change it
>> back.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py                   |   4 +-
>>  tests/qapi-schema/comments.out           |   2 +-
>>  tests/qapi-schema/doc-bad-section.out    |   4 +-
>>  tests/qapi-schema/doc-good.out           |  32 ++--
>>  tests/qapi-schema/empty.out              |   2 +-
>>  tests/qapi-schema/event-case.out         |   2 +-
>>  tests/qapi-schema/ident-with-escape.out  |   6 +-
>>  tests/qapi-schema/include-relpath.out    |   2 +-
>>  tests/qapi-schema/include-repetition.out |   2 +-
>>  tests/qapi-schema/include-simple.out     |   2 +-
>>  tests/qapi-schema/indented-expr.out      |   2 +-
>>  tests/qapi-schema/qapi-schema-test.out   | 320 +++++++++++++++----------------
>>  12 files changed, 191 insertions(+), 189 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index d5b93e7381..3b97bf8702 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -1471,6 +1471,7 @@ class QAPISchema(object):
>>          parser = QAPISchemaParser(open(fname, 'r'))
>>          exprs = check_exprs(parser.exprs)
>>          self.docs = parser.docs
>> +        self._entity_list = []
>>          self._entity_dict = {}
>>          self._predefining = True
>>          self._def_predefineds()
>> @@ -1482,6 +1483,7 @@ class QAPISchema(object):
>>          # Only the predefined types are allowed to not have info
>>          assert ent.info or self._predefining
>>          assert ent.name not in self._entity_dict
>> +        self._entity_list.append(ent)
>>          self._entity_dict[ent.name] = ent
>
> Why not use the OrderedDict instead?

Fair question!  However, the next patch will create anonymous entities,
which get added only to ._entity_list, not _entity_dict.

[...]
