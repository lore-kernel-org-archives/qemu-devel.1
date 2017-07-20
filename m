Received: from eggs.gnu.org ([2001:4830:134:3::10]:45090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYE6I-0001QW-Ig
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYE6D-0002KD-Iz
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:14:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYE6D-0002IY-C7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52D31267C2
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 16:14:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170717180926.14924-1-ehabkost@redhat.com>
Date: Thu, 20 Jul 2017 18:14:44 +0200
In-Reply-To: <20170717180926.14924-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Mon, 17 Jul 2017 15:09:26 -0300")
Message-ID: <877ez3rsp7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] qapi: Fix error handling code on
 alternate conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> The conflict check added by commit c0644771 ("qapi: Reject
> alternates that can't work with keyval_parse()") doesn't work
> with the following declaration:
>
>   { 'alternate': 'Alt',
>     'data': { 'one': 'bool',
>               'two': 'str' } }
>
> It crashes with:
>
>   Traceback (most recent call last):
>     File "./scripts/qapi-types.py", line 295, in <module>
>       schema = QAPISchema(input_file)
>     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 1468, in __init__
>       self.exprs = check_exprs(parser.exprs)
>     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 958, in check_exprs
>       check_alternate(expr, info)
>     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 830, in check_alternate
>       % (name, key, types_seen[qtype]))
>   KeyError: 'QTYPE_QSTRING'
>
> This happens because the previously-seen conflicting member
> ('one') can't be found at types_seen[qtype], but at
> types_seen['QTYPE_BOOL'].
>
> Fix the bug by moving the error check to the same loop that adds
> new items to types_seen, raising an exception if types_seen[qt]
> is already set.
>
> Add two additional test cases that can detect the bug.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
[...]
> diff --git a/tests/qapi-schema/alternate-conflict-num-string.out b/tests/qapi-schema/alternate-conflict-num-string.out
> new file mode 100644
> index 0000000..e69de29
> diff --git a/tests/qapi-schema/alternate-multi-conflict.json b/tests/qapi-schema/alternate-multi-conflict.json
> new file mode 100644
> index 0000000..e69de29

Accident?  Can drop on commit.
