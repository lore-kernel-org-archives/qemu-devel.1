Received: from eggs.gnu.org ([2001:4830:134:3::10]:57405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYAVJ-0002hD-9L
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYAVG-0003CM-6W
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:29:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYAVG-0003BY-0S
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:28:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A167BB433
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:28:57 +0000 (UTC)
Date: Wed, 27 Jun 2018 14:28:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180627132853.GO30628@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
	<87h8lo74oa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h8lo74oa.fsf@dusky.pond.sub.org>
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

On Wed, Jun 27, 2018 at 03:13:57PM +0200, Markus Armbruster wrote:
> Monitor behavior changes even when the client rejects capability "oob".
> 
> Traditionally, the monitor reads, executes and responds to one command
> after the other.  If the client sends in-band commands faster than the
> server can execute them, the kernel will eventually refuse to buffer
> more, and sending blocks or fails with EAGAIN.
> 
> To make OOB possible, we need to read and queue commands as we receive
> them.  If the client sends in-band commands faster than the server can
> execute them, the server will eventually drop commands to limit the
> queue length.  The sever sends event COMMAND_DROPPED then.
> 
> However, we get the new behavior even when the client rejects capability
> "oob".  We get the traditional behavior only when the server doesn't
> offer "oob".
> 
> Is this what we want?

IMHO the key benefit of allowing the client to reject the capability
is to enable backwards compat support. So this behaviour feels wrong.
Rejecting OOB should have same semantics as previous QEMU's without
OOB available, otherwise we now have 3 distinct ways the monitor
operates  (no OOB, OOB rejected, OOB accepted). This can only ever
lead to more bugs due to lack of testing of no OOB vs OOB rejected
scenarios.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
