Received: from eggs.gnu.org ([2001:4830:134:3::10]:54582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5TTN-0005EY-8q
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5TTH-0003L3-OG
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:20:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e5TTH-0003Ke-Hc
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:20:03 -0400
References: <20170929033844.26935-1-peterx@redhat.com>
	<20170929033844.26935-14-peterx@redhat.com>
	<20171012125045.GF5957@stefanha-x1.localdomain>
	<20171016075039.GD4166@pxdev.xzpeter.org>
	<20171018153115.GD31848@stefanha-x1.localdomain>
	<20171019063649.GX4166@pxdev.xzpeter.org>
	<20171019131311.GE6205@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <657cdf86-237d-c68e-75ed-6f9a0ea0ac34@redhat.com>
Date: Fri, 20 Oct 2017 11:19:44 +0200
MIME-Version: 1.0
In-Reply-To: <20171019131311.GE6205@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 13/22] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 19/10/2017 15:13, Stefan Hajnoczi wrote:
> Up to you.  I don't remember the details of out_lock usage well enough
> to know whether using the lock for the queues is good or bad.

out_lock is called like that because it's only writes that can be done
from multiple threads (at both the chardev and monitor level).
IOThreads in particular want to generate QMP events.

out_lock protects the monitor's own output buffer, while the character
device layer has its own locking (chr_write_lock).  chr_write_lock
protects calls to the chr_write method of the Chardev object and writes
to the character device's logfd.

Renaming out_lock and reusing it is just fine if the lock is only held
for short periods of time.  But maybe it's simpler to just introduce
another lock, since the out_lock rules are very simple.

Paolo
