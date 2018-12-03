Received: from eggs.gnu.org ([2001:4830:134:3::10]:49039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTuCy-0001pm-At
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTuCv-0004jM-4O
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:48:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTuCu-0004is-Vh
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:48:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E1E6307D858
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 19:48:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <f60b8f1e-979b-4af9-7b48-a691c1937f6a@redhat.com>
	<4dd4e70a-7129-722c-971a-1b9f8b9aa349@redhat.com>
Date: Mon, 03 Dec 2018 20:48:38 +0100
In-Reply-To: <4dd4e70a-7129-722c-971a-1b9f8b9aa349@redhat.com> (Eric Blake's
	message of "Mon, 3 Dec 2018 10:36:17 -0600")
Message-ID: <87wooql7c9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] QMP accepts double dict keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 12/3/18 10:30 AM, Max Reitz wrote:
>> Hi,
>>
>> QMP accepts double keys in dicts without complaining.  The value it is
>> using is apparently the last one specified:
>
> JSON says it is undefined what happens when a client passes double
> keys. We are probably best off if we teach our parser to be strict and
> reject doubled keys in QMP as invalid.

Not bug-compatible.  Do we care?

> Hmm - can a client abuse QMP with duplicate keys to cause qemu to leak
> memory?

No.  parse_pair() inserts with qdict_put_obj(), which replaces the old
value without leaking it.

>>
>> $ qemu-system-x86_64 -qmp stdio
>> {"QMP": {"version": {"qemu": {"micro": 93, "minor": 0, "major": 3},
>> "package": "v3.1.0-rc3-7-g87a45d86ed"}, "capabilities": []}}
>> {'execute':'qmp_capabilities'}
>> {"return": {}}
>> {'execute':'blockdev-add','arguments':{'driver':'null-co',
>>   'node-name':'foo','node-name':'bar'}}
>> {"return": {}}
>> {'execute':'query-named-block-nodes'}
>> {"return": [{ [...] "node-name": "bar" [...] }]}
>>
>> Another test case is iotest 229 which specifies both mode=absolute-paths
>> and mode=existing (it wants the latter).
>>
>> Max
>>
