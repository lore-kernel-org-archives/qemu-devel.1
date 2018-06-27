Received: from eggs.gnu.org ([2001:4830:134:3::10]:40249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fY7ZD-0004yb-2n
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fY7Z9-0002Oh-U5
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:20:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fY7Z9-0002Nj-Or
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:20:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 324AB857AB
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:20:47 +0000 (UTC)
Date: Wed, 27 Jun 2018 11:20:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180627102043.GD30628@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wouk8vul.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

On Wed, Jun 27, 2018 at 10:41:38AM +0200, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Markus Armbruster <armbru@redhat.com> writes:
> >
> >> I fooled around a bit, and I think there are a few lose ends.
> > [...]
> >> Talking to a QMP monitor that supports OOB:
> >>
> >>     $ socat UNIX:test-qmp READLINE,history=$HOME/.qmp_history,prompt='QMP> '
> >>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": ["oob"]}}
> >>     QMP> { "execute": "qmp_capabilities", "arguments": { "oob": true } }
> >>     {"error": {"class": "GenericError", "desc": "Parameter 'oob' is unexpected"}}
> >>     QMP> { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
> >>     {"return": {}}
> >>     QMP> { "execute": "query-qmp-schema" }
> >>     {"error": {"class": "GenericError", "desc": "Out-Of-Band capability requires that every command contains an 'id' field"}}
> >>
> >> Why does every command require 'id'?
> >
> > I found one reason: event COMMAND_DROPPED wants it.  Any other reason?
> >
> > [...]
> 
> Apropos COMMAND_DROPPED: we send an event rather than an error response
> because we may send it out-of-order.  Makes sense.
> 
> However, broadcasting it to all monitors doesn't make sense.  We could
> use a way to send an event to just one monitor.

Worse than that - broadcasting to all monitors is categorically broken.
Different monitors make use the same "id" formatting scheme, so if you
broadcast COMMAND_DROPPED to a different monitor you might have clashing
"id" and thus incorrectly tell a client its command was dropped when in
fact it was processed. You'd have to be fairly unlucky in timing, but
it could happen.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
