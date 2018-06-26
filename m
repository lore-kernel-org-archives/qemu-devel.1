Received: from eggs.gnu.org ([2001:4830:134:3::10]:58245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXrf9-0003ae-Tf
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXrf6-0000r3-Po
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:21:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fXrf6-0000qx-KV
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:21:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C1A8407606B
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 17:21:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
Date: Tue, 26 Jun 2018 19:21:49 +0200
In-Reply-To: <20180620073223.31964-1-peterx@redhat.com> (Peter Xu's message of
	"Wed, 20 Jun 2018 15:32:16 +0800")
Message-ID: <871sctea4y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] (no subject)
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

I fooled around a bit, and I think there are a few lose ends.

Lets update the examples in docs/interop/qmp-spec.txt to show the
current greeting (section 3.1) and how to accept a capability (section
3.2).  The capability negotiation documentation could use some polish.
I'll post a patch.

Talking to a QMP monitor that supports OOB:

    $ socat UNIX:test-qmp READLINE,history=$HOME/.qmp_history,prompt='QMP> '
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": ["oob"]}}
    QMP> { "execute": "qmp_capabilities", "arguments": { "oob": true } }
    {"error": {"class": "GenericError", "desc": "Parameter 'oob' is unexpected"}}
    QMP> { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
    {"return": {}}
    QMP> { "execute": "query-qmp-schema" }
    {"error": {"class": "GenericError", "desc": "Out-Of-Band capability requires that every command contains an 'id' field"}}

Why does every command require 'id'?

Talking to a QMP monitor that doesn't support OOB:

    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": []}}
    QMP> { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
    {"error": {"class": "GenericError", "desc": "This monitor does not support Out-Of-Band (OOB)"}}
    QMP> { "execute": "qmp_capabilities" }
    {"return": {}}
    QMP> { "execute": "query-kvm" }
    {"return": {"enabled": true, "present": true}}
    QMP> { "execute": "query-kvm", "control": { "run-oob": true } }
    {"error": {"class": "GenericError", "desc": "Please enable Out-Of-Band first for the session during capabilities negotiation"}}

Telling people to enable OOB when that cannot be done is suboptimal.
More so when it cannot be used here anyway.  I'll post a patch.
