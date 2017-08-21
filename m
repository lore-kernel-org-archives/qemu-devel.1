Received: from eggs.gnu.org ([2001:4830:134:3::10]:41129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1djiun-0006af-0c
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1djiui-0001LU-37
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1djiuh-0001Kv-Pd
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:22:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBCFE267D5
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 09:22:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-5-ehabkost@redhat.com>
	<87fuctp2pi.fsf@dusky.pond.sub.org>
	<20170815203909.GY3108@localhost.localdomain>
	<87378sf2qi.fsf@dusky.pond.sub.org>
	<20170818170545.GC3108@localhost.localdomain>
Date: Mon, 21 Aug 2017 11:22:20 +0200
In-Reply-To: <20170818170545.GC3108@localhost.localdomain> (Eduardo Habkost's
	message of "Fri, 18 Aug 2017 14:05:45 -0300")
Message-ID: <878tid6zsj.fsf@dusky.pond.sub.org>
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

> On Wed, Aug 16, 2017 at 08:25:41AM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > On Tue, Aug 15, 2017 at 12:03:53PM +0200, Markus Armbruster wrote:
>> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> >> 
>> >> Suggest to insert here:
>> >> 
>> >>   If additional arguments QMP-COMMAND ARG=VAL... are given, run just
>> >>   that QMP command instead of the REPL.
>> >> 
>> >> Question: is this limited to simple arguments?  If no, how would I write
>> >> an object argument?  For instance, how would I do
>> >> 
>> >>     { "execute": "blockdev-add", "arguments": { "node-name": "foo", "driver": "nbd", "server": { "type": "inet", "host": "localhost", "port": "12345" } } }
>> >> 
>> >> ?
>> >
>> > Exactly the same way you would write it when running qmp-shell in
>> > interactive mode.  e.g.:
>> >
>> >   $ ./scripts/qmp/qmp-shell /tmp/qmp blockdev-add driver=qcow2 node-name=node-E 'file={"driver":"file","filename":"/path/to/file.qcow2"}'
>> 
>> I see.
>> 
>> The QEMU command line uses dotted key syntax instead.
>
> You mean -blockdev, or is there another way to send QMP commands
> to QEMU that I'm not aware of?

Dotted keys were invented for the block layer's -drive.  I adopted them
for -blockdev after considerable discussion.  The -blockdev code is all
new, and it even has documentation and tests.

>> To be honest, the less qmp-shell is used, the happier I am.
>
> What people would use instead of it?

The syntactic sugar qmp-shell provides over plain QMP doesn't simplify
its use all that much, and it can get in the way.

For my interactive QMP needs, I use

    $ socat UNIX:/wherever/qmp-socket READLINE,history=$HOME/.qmp_history,prompt='QMP> '

In programs, I send or receive either plain text or JSON objects,
depending on the program's needs.  Libqtest supports the latter.

>>                                                              Would you
>> like to serve as its sub-maintainer?
>
> I'd be glad to.

Great!  Please post a suitable MAINTAINERS stanza.
