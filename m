Received: from eggs.gnu.org ([2001:4830:134:3::10]:37886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUtR2-0002dA-Oq
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUtQx-0006yu-PO
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:11:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUtQx-0006yH-IU
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:11:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8D7A307D85F
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 13:11:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181206121743.20762-1-armbru@redhat.com>
	<fa022957-1015-9173-6e17-c683f1a39392@redhat.com>
Date: Thu, 06 Dec 2018 14:11:10 +0100
In-Reply-To: <fa022957-1015-9173-6e17-c683f1a39392@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 6 Dec 2018 13:50:08
	+0100")
Message-ID: <878t12g5qp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] json: Fix to reject duplicate object
 member names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 12/6/18 1:17 PM, Markus Armbruster wrote:
>> The JSON parser happily accepts duplicate object member names.  The
>> last value wins.  Reproducer #1:
>>=20
>>     $ qemu-system-x86_64 -qmp stdio
>>     {"QMP": {"version": {"qemu": {"micro": 93, "minor": 0, "major": 3},
>>     "package": "v3.1.0-rc3-7-g87a45d86ed"}, "capabilities": []}}
>>     {'execute':'qmp_capabilities'}
>>     {"return": {}}
>>     {'execute':'blockdev-add','arguments':{'driver':'null-co',
>>      'node-name':'foo','node-name':'bar'}}
>>     {"return": {}}
>>     {'execute':'query-named-block-nodes'}
>>     {"return": [{ [...] "node-name": "bar" [...] }]}
>>=20
>> Reproducer #2 is iotest 229.
>>=20
>> Fix the parser to reject duplicates, and fix iotest 229 not to use
>> them.
>
> Looks like 2 different patches.

I admit it does.  But the iotest one is trivial, so I decided to squash
it in.

>> Reported-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qobject/json-parser.c  | 5 +++++
>>  tests/qemu-iotests/229 | 1 -
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
>> index 5a840dfd86..a86de3f462 100644
>> --- a/qobject/json-parser.c
>> +++ b/qobject/json-parser.c
>> @@ -288,6 +288,11 @@ static int parse_pair(JSONParserContext *ctxt, QDic=
t *dict)
>>          goto out;
>>      }
>>=20=20
>> +    if (qdict_haskey(dict, qstring_get_str(key))) {
>> +        parse_error(ctxt, token, "duplicate key");
>> +        goto out;
>> +    }
>> +=20=20=20=20=20=20=20=20
>>      qdict_put_obj(dict, qstring_get_str(key), value);
>>=20=20
>>      qobject_unref(key);
>> diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
>> index 86602437ff..893d098ad2 100755
>> --- a/tests/qemu-iotests/229
>> +++ b/tests/qemu-iotests/229
>> @@ -69,7 +69,6 @@ echo
>>  _send_qemu_cmd $QEMU_HANDLE \
>>      "{'execute': 'drive-mirror',
>>                   'arguments': {'device': 'testdisk',
>> -                               'mode':   'absolute-paths',
>>                                 'format': '$IMGFMT',
>>                                 'target': '$DEST_IMG',
>>                                 'sync':   'full',
>>=20
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!
