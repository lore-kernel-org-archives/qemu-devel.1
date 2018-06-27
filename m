Received: from eggs.gnu.org ([2001:4830:134:3::10]:53297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fY529-0002tP-Gl
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fY526-00089f-BH
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:38:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fY526-00089K-7I
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:38:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CEA8401EF06
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 07:38:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
Date: Wed, 27 Jun 2018 09:38:27 +0200
In-Reply-To: <871sctea4y.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 26 Jun 2018 19:21:49 +0200")
Message-ID: <87tvpoadcc.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> I fooled around a bit, and I think there are a few lose ends.
[...]
> Talking to a QMP monitor that supports OOB:
>
>     $ socat UNIX:test-qmp READLINE,history=$HOME/.qmp_history,prompt='QMP> '
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": ["oob"]}}
>     QMP> { "execute": "qmp_capabilities", "arguments": { "oob": true } }
>     {"error": {"class": "GenericError", "desc": "Parameter 'oob' is unexpected"}}
>     QMP> { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
>     {"return": {}}
>     QMP> { "execute": "query-qmp-schema" }
>     {"error": {"class": "GenericError", "desc": "Out-Of-Band capability requires that every command contains an 'id' field"}}
>
> Why does every command require 'id'?

I found one reason: event COMMAND_DROPPED wants it.  Any other reason?

[...]
