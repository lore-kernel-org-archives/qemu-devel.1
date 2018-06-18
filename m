Received: from eggs.gnu.org ([2001:4830:134:3::10]:47893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUyML-0005rA-72
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUyMI-0002LX-6H
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:54:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUyMH-0002L8-W6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:54:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180615220205.6929-1-tamiko@43-1.org>
	<20180615220205.6929-2-tamiko@43-1.org>
	<87muvssm2t.fsf@dusky.pond.sub.org>
	<20180618160430.GG7451@localhost.localdomain>
Date: Mon, 18 Jun 2018 19:54:26 +0200
In-Reply-To: <20180618160430.GG7451@localhost.localdomain> (Eduardo Habkost's
	message of "Mon, 18 Jun 2018 13:04:30 -0300")
Message-ID: <87y3fc6kvh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qapi: open files in binary mode and
 use explicit decoding/encoding in common.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Matthias Maier <tamiko@43-1.org>, qemu-devel@nongnu.org, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Jun 18, 2018 at 07:25:14AM +0200, Markus Armbruster wrote:
>> Matthias Maier <tamiko@43-1.org> writes:
>> 
>> > This is a different approach to fix the locale dependent encode/decode
>> > problem in common.py utilizing the binary read/write mode [1,2], and (if
>> > a python 3 interpreter is used) with explicit decode/encode arguments
>> > [3].
>> 
>> Why can't we simply pass encoding='utf-8' to open()?
>
> This wouldn't work in Python 2.7 (where the `open()` builtin
> doesn't support the `encoding` parameter).
>
> io.open(..., encoding='utf-8') should work, though.

This falls apart because then f.read() returns objects of type 'unicode'
in Python 2, breaking isinstance(..., str) predicates in several places.

What I asked for is something else: wrap the version conditional around
open() instead of around the conversion from bytes to str.  Coding up
the (trivial) patch is easier than explaining it in more detail than
"pass encoding='utf-8' to open()", so I did just that.
