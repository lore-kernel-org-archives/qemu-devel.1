Received: from eggs.gnu.org ([2001:4830:134:3::10]:37580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fY5v7-00074c-7J
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fY5v4-0006ik-EY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:35:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fY5v4-0006Yu-8n
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:35:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49A86857AB
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 08:35:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87po0cad8n.fsf_-_@dusky.pond.sub.org>
Date: Wed, 27 Jun 2018 10:35:15 +0200
In-Reply-To: <87po0cad8n.fsf_-_@dusky.pond.sub.org> (Markus Armbruster's
	message of "Wed, 27 Jun 2018 09:40:40 +0200")
Message-ID: <871scsaapo.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Another lose end: event COMMAND_DROPPED seems to lack test coverage.

Hmm, dropping commands serves to limit the request queue.  What limits
the response queue?

Before OOB, the monitor read at most one command, and wrote its response
with monitor_puts().

For input, this leaves queueing to the kernel: if the client sends
commands faster than the server can execute them, eventually the kernel
refuses to buffer more, and the client's send either blocks or fails
with EAGAIN.

Output is a mess.  monitor_puts() uses an output buffer.  It tries to
flush at newline.  Issues:

* If flushing runs into a partial write, the unwritten remainder remains
  in the output buffer until the next newline.  That newline may take
  its own sweet time to arrive.  Could even lead to deadlocks, where a
  client awaits complete output before it sends more input.  Bug,
  predates OOB, doesn't block this series.

* If the client fails to read, the output buffer can grow without bound.
  Not a security issue; the client is trusted.  Just bad workmanship.

OOB doesn't change this for monitors running in the main thread.  Only
mux chardevs run there.

Aside: keeping special case code around just for mux is a really bad
idea.  We need to get rid of it.

For monitors running in an I/O thread, we add another buffer: the
response queue.  It's drained by monitor_qmp_bh_responder().  I guess
that means the response queue is effectively bounded by timely draining.
Correct?

Buffering twice seems silly, but that could be addressed in follow-up
patches.
