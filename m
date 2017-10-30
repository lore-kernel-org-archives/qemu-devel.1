Received: from eggs.gnu.org ([2001:4830:134:3::10]:46460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4692eb449=ross.lagerwall@citrix.com>)
	id 1e97eG-0007cv-Un
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4692eb449=ross.lagerwall@citrix.com>)
	id 1e97eC-00080h-AG
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:50:29 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:36982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4692eb449=ross.lagerwall@citrix.com>)
	id 1e97eC-0007zE-4J
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:50:24 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <d7a58698-bba9-b873-b2ae-a63bdd06895f@citrix.com>
Date: Mon, 30 Oct 2017 10:50:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QMP event missed during startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>

Hi,

I have found an issue where QEMU emits the RESUME event during startup 
when it starts VM execution, but it is not possible to receive this event.

To repro this, run:
qemu-system-i386 -m 256 -trace 
enable=monitor_protocol_event_emit,file=/tmp/out -qmp 
unix:/tmp/qmp,server,wait

QEMU will not start execution of the VM until something connects to the 
QMP socket (e.g. qmp-shell). Once connected, no event is received on the 
QMP connection but the tracepoint is hit indicating that an event has 
been emitted. I suspect that the event is emitted while the QMP client 
is doing the initial negotiation.

The reason I want to receive this event is that QEMU currently uses 
xenstore to communicate this information to the Xen toolstack (see 
xen-common.c:xen_change_state_handler) but we want to move to using QMP 
rather than xenstore for this kind of thing.

Is this a known issue or just a bug that should be fixed?

Thanks,
-- 
Ross Lagerwall
