Received: from eggs.gnu.org ([2001:4830:134:3::10]:32882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhrm3-0003KS-Tl
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhrm0-00077S-Ov
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhrm0-00076p-8R
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:25:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B65C61482
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 06:25:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-5-ehabkost@redhat.com>
	<87fuctp2pi.fsf@dusky.pond.sub.org>
	<20170815203909.GY3108@localhost.localdomain>
Date: Wed, 16 Aug 2017 08:25:41 +0200
In-Reply-To: <20170815203909.GY3108@localhost.localdomain> (Eduardo Habkost's
	message of "Tue, 15 Aug 2017 17:39:09 -0300")
Message-ID: <87378sf2qi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 4/5] qmp-shell: Accept QMP
 command as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, Aug 15, 2017 at 12:03:53PM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> Suggest to insert here:
>> 
>>   If additional arguments QMP-COMMAND ARG=VAL... are given, run just
>>   that QMP command instead of the REPL.
>> 
>> Question: is this limited to simple arguments?  If no, how would I write
>> an object argument?  For instance, how would I do
>> 
>>     { "execute": "blockdev-add", "arguments": { "node-name": "foo", "driver": "nbd", "server": { "type": "inet", "host": "localhost", "port": "12345" } } }
>> 
>> ?
>
> Exactly the same way you would write it when running qmp-shell in
> interactive mode.  e.g.:
>
>   $ ./scripts/qmp/qmp-shell /tmp/qmp blockdev-add driver=qcow2 node-name=node-E 'file={"driver":"file","filename":"/path/to/file.qcow2"}'

I see.

The QEMU command line uses dotted key syntax instead.

To be honest, the less qmp-shell is used, the happier I am.  Would you
like to serve as its sub-maintainer?

>> > This is useful for testing QMP commands in scripts.
>> >
>> > Example usage, combined with 'jq' for filtering the results:
>> >
>> >   $ ./scripts/qmp/qmp-shell /tmp/qmp qom-list path=/ | jq -r .return[].name
>> >   machine
>> >   type
>> >   chardevs
>> >   backend
>> 
>> What's jq?
>
> https://stedolan.github.io/jq/
>
> "like sed for JSON data"

A fine addition to your commit message.

>> 
>> >   $
>> 
>> Let's drop this line.
>
> Will do it.
>
>> 
>> >
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
[...]
