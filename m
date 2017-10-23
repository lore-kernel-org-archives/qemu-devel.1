Received: from eggs.gnu.org ([2001:4830:134:3::10]:49425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=462d8fd40=ross.lagerwall@citrix.com>)
	id 1e6eEH-0001qZ-Oq
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=462d8fd40=ross.lagerwall@citrix.com>)
	id 1e6eEE-0003MC-No
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:01:25 -0400
Received: from smtp.citrix.com ([66.165.176.89]:6022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=462d8fd40=ross.lagerwall@citrix.com>)
	id 1e6eEE-0003Ld-Eo
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:01:22 -0400
References: <20171019160419.11611-1-ross.lagerwall@citrix.com>
	<20171019162420.GA8408@redhat.com>
	<2c1c1652-7a70-7330-98b2-9225b35670a8@citrix.com>
	<20171023145050.GM16472@redhat.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <a2f1d43d-c594-004f-9721-06d4769da4cd@citrix.com>
Date: Mon, 23 Oct 2017 16:01:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171023145050.GM16472@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] os-posix: Add -unshare option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 10/23/2017 03:50 PM, Daniel P. Berrange wrote:
> On Mon, Oct 23, 2017 at 03:30:05PM +0100, Ross Lagerwall wrote:
>> On 10/19/2017 05:24 PM, Daniel P. Berrange wrote:
>>> On Thu, Oct 19, 2017 at 05:04:19PM +0100, Ross Lagerwall wrote:
>>>> Add an option to allow calling unshare() just before starting guest
>>>> execution. The option allows unsharing one or more of the mount
>>>> namespace, the network namespace, and the IPC namespace. This is useful
>>>> to restrict the ability of QEMU to cause damage to the system should it
>>>> be compromised.
>>>>
>>>> An example of using this would be to have QEMU open a QMP socket at
>>>> startup and unshare the network namespace. The instance of QEMU could
>>>> still be controlled by the QMP socket since that belongs in the original
>>>> namespace, but if QEMU were compromised it wouldn't be able to open any
>>>> new connections, even to other processes on the same machine.
>>>
>>> Unless I'm misunderstanding you, what's described here is already possible
>>> by just using the 'unshare' command to spawn QEMU:
>>>
>>>     # unshare --ipc --mount --net qemu-system-x86_64 -qmp unix:/tmp/foo,server -vnc :1
>>>     qemu-system-x86_64: -qmp unix:/tmp/foo,server: QEMU waiting for connection on: disconnected:unix:/tmp/foo,server
>>>
>>> And in another shell I can still access the QMP socket from the original host
>>> namespace
>>
>> So that works because UNIX domains sockets are not restricted by network
>> namespaces. But if you try to connect to the VNC server listening on TCP
>> port 5901, it won't work.
>>
>>>
>>>     # ./scripts/qmp/qmp-shell /tmp/foo
>>>     Welcome to the QMP low-level shell!
>>>     Connected to QEMU 2.9.1
>>>
>>>     (QEMU) query-kvm
>>>     {"return": {"enabled": false, "present": true}}
>>>
>>>
>>> FWIW, even if that were not possible, you could still do it by wrapping the
>>> qmp-shell in an 'nsenter' call. eg
>>>
>>>     nsenter --target $QEMUPID --net ./scripts/qmp/qmp-shell /tmp/foo
>>
>> I have a single process which connects to all the QEMUs' listening VNC
>> sockets so I'm not sure that this would work.
> 
> Yes, it can still work - you simply need to use set() to temporarily
> switch into QEMU's namespace, and then switch back again afterwards
> 
>    oldns = open("/proc/self/ns/net")
>    newns = open("/proc/$PID-OF-QEMU/ns/net")
>    setns(newns, CLONE_NEWNET)
> 
>    ...open connection to VNC...
>    
>    setns(oldns, CLONE_NEWNET)
> 
>    ...use connection to VNC...
> 
> The setns() call is thread-local, so you can safely use different
> namespaces in each thread if you need to have concurrent comms with
> many QEMUs.
> 

Ah, I didn't realize that the namespace could be set locally for a 
thread. That's helpful, thanks!

-- 
Ross Lagerwall
