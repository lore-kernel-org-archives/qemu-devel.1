Received: from eggs.gnu.org ([2001:4830:134:3::10]:51147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTuLH-0008F5-3X
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTuLD-0007ga-S4
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:57:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTuLD-0007fp-ML
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:57:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD48C37E87
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 19:57:14 +0000 (UTC)
References: <f60b8f1e-979b-4af9-7b48-a691c1937f6a@redhat.com>
	<4dd4e70a-7129-722c-971a-1b9f8b9aa349@redhat.com>
	<87wooql7c9.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de1686a3-1981-442d-a82a-704bca834922@redhat.com>
Date: Mon, 3 Dec 2018 13:57:13 -0600
MIME-Version: 1.0
In-Reply-To: <87wooql7c9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QMP accepts double dict keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 12/3/18 1:48 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 12/3/18 10:30 AM, Max Reitz wrote:
>>> Hi,
>>>
>>> QMP accepts double keys in dicts without complaining.  The value it is
>>> using is apparently the last one specified:
>>
>> JSON says it is undefined what happens when a client passes double
>> keys. We are probably best off if we teach our parser to be strict and
>> reject doubled keys in QMP as invalid.
> 
> Not bug-compatible.  Do we care?

I don't think so. Such a client was already invoking undefined behavior. 
Relying on first- or last-past-the-post to win is not portable, since 
JSON parsers are allowed to use hash tables with non-deterministic 
lookups. I think erroring out is nicer than silently accepting one 
thing, especially if that might have been different than what the client 
(incorrectly) expected.  I'm not even sure that we would want a 
deprecation period.

> 
>> Hmm - can a client abuse QMP with duplicate keys to cause qemu to leak
>> memory?
> 
> No.  parse_pair() inserts with qdict_put_obj(), which replaces the old
> value without leaking it.

Good to know.

>>>
>>> Another test case is iotest 229 which specifies both mode=absolute-paths
>>> and mode=existing (it wants the latter).

We'll have to fix such broken clients, of course. If it is just our 
iotests (and not libvirt), I'm less worried about the change in behavior.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
