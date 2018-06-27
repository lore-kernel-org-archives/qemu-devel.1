Received: from eggs.gnu.org ([2001:4830:134:3::10]:53351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYAGm-0007Rz-D0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYAGl-0003Ld-I9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:14:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fYAGl-0003LM-EN
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AD7CB5C4
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:13:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
Date: Wed, 27 Jun 2018 15:13:57 +0200
In-Reply-To: <87wouk8vul.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 27 Jun 2018 10:41:38 +0200")
Message-ID: <87h8lo74oa.fsf@dusky.pond.sub.org>
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

Monitor behavior changes even when the client rejects capability "oob".

Traditionally, the monitor reads, executes and responds to one command
after the other.  If the client sends in-band commands faster than the
server can execute them, the kernel will eventually refuse to buffer
more, and sending blocks or fails with EAGAIN.

To make OOB possible, we need to read and queue commands as we receive
them.  If the client sends in-band commands faster than the server can
execute them, the server will eventually drop commands to limit the
queue length.  The sever sends event COMMAND_DROPPED then.

However, we get the new behavior even when the client rejects capability
"oob".  We get the traditional behavior only when the server doesn't
offer "oob".

Is this what we want?
