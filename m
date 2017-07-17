Received: from eggs.gnu.org ([2001:4830:134:3::10]:48991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXANe-0006AM-Ts
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXANa-0007ia-QL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:04:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXANa-0007iH-KY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 928F84E047
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 18:04:21 +0000 (UTC)
Date: Mon, 17 Jul 2017 15:04:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170717180418.GZ6020@localhost.localdomain>
References: <20170714203313.31041-1-ehabkost@redhat.com>
	<68543d33-8f49-5948-dc4c-fc678ac6aee7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68543d33-8f49-5948-dc4c-fc678ac6aee7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix error handling code on alternate
 conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Jul 17, 2017 at 09:45:01AM -0500, Eric Blake wrote:
> On 07/14/2017 03:33 PM, Eduardo Habkost wrote:
> > The conflict check added by commit c0644771 ("qapi: Reject
> > alternates that can't work with keyval_parse()") doesn't work
> > with the following declaration:
> > 
> >   { 'alternate': 'Alt',
> >     'data': { 'one': 'bool',
> >               'two': 'str' } }
> > 
> > It crashes with:
> > 
> >   Traceback (most recent call last):
> >     File "./scripts/qapi-types.py", line 295, in <module>
> >       schema = QAPISchema(input_file)
> >     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 1468, in __init__
> >       self.exprs = check_exprs(parser.exprs)
> >     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 958, in check_exprs
> >       check_alternate(expr, info)
> >     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 830, in check_alternate
> >       % (name, key, types_seen[qtype]))
> >   KeyError: 'QTYPE_QSTRING'
> > 
> > This happens because the previously-seen conflicting member
> > ('one') can't be found at types_seen[qtype], but at
> > types_seen['QTYPE_BOOL'].
> > 
> > Fix the bug by moving the error check to the same loop that adds
> > new items to types_seen, raising an exception if types_seen[qt]
> > is already set.
> > 
> > Add two additional test cases that can detect the bug.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> 
> > +++ b/tests/qapi-schema/alternate-conflict-bool-string.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/alternate-conflict-bool-string.json:3: Alternate 'Alt' member 'two' can't be distinguished from member 'one'
> 
> Claims the error is at line 3,
> 
> > +++ b/tests/qapi-schema/alternate-conflict-bool-string.json
> > @@ -0,0 +1,4 @@
> > +# alternate branches of 'str' type conflict with all scalar types
> > +{ 'alternate': 'Alt',
> 
> but the declaration starts at line 2.  That's probably why patchew
> complained that your patch doesn't build.  The idea looks sane, though;
> looking forward to v2.

Oops, sorry!  I had a two-line comment in the beginning of the
file and decided to update it just before submitting the series.

-- 
Eduardo
