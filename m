Received: from eggs.gnu.org ([2001:4830:134:3::10]:52020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dufZQ-0007fD-EY
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dufZK-00082u-J8
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:44 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:51915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dufZK-00082B-Ci
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:38 -0400
Received: by mail-wr0-f178.google.com with SMTP id z39so2247153wrb.8
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 07:01:38 -0700 (PDT)
References: <1495613046-6430-1-git-send-email-thuth@redhat.com>
	<5e647277-d688-071d-7def-bd8d57dd7e66@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <deb2e9b4-686d-1a5a-0aba-0c404183ae9a@redhat.com>
Date: Wed, 20 Sep 2017 13:07:00 +0200
MIME-Version: 1.0
In-Reply-To: <5e647277-d688-071d-7def-bd8d57dd7e66@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net: Mark the 'hubport' netdev as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>

On 20/09/2017 09:45, Thomas Huth wrote:
> On 24.05.2017 10:04, Thomas Huth wrote:
>> The 'hubport' netdev is closely tied to the 'vlan' concept which
>> has been marked as deprecated in commit a2dbe1356faff3cb6 already.
>> Thus we should also mark the hubport netdevs as deprecated to make
>> the remaining users aware that they should not use this anymore.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>

What is the replacement for VLANs?

The point of hub/hubport was to implement this without needing
special-casing of VLANs everywhere in the net/ directory.  VLANs remain
messy in terms of command-line expression for -net, but that's where the
problems end.

In fact, while there are some uses of VLANs that have been replaced by
filters, VLANs are still needed to place 2 NICs to be on the same guest
network without using a host bridge.  This should be a supported use
case for e.g. L2TP backends, and it can be important for users that
don't have the ability to configure a host bridge.

In addition, depending on how you read the warning in commit a2dbe1356,
this patch could be deprecating the exact replacement that you're
suggesting in the warning.

Rather than deprecating hubport, we need a mechanism to define a hubport
for the back-end side.  For example:

   -netdev l2tp,...,id=l2tp-backend
   -netdev hubport,hubid=0,netdev=l2tp-backend,id=l2tp-hub
   -netdev hubport,hubid=0,id=nic0 -device virtio-net-pci,netdev=nic0
   -netdev hubport,hubid=0,id=nic1 -device virtio-net-pci,netdev=nic1

This would normalize the topology

   NIC      NIC      L2TP
    |        |        |
   hubport  hubport   |
    |        |        |
    '--------'--------'-------- hub

to

   NIC      NIC      L2TP
    |        |        |
   hubport  hubport  hubport
    |        |        |
    '--------'--------'-------- hub

and would let us drop vlan from the command-line options.  Even
immediately in 2.11.

(Also, the reasoning in commit a2dbe1356 seems backwards, what's wrong
with connecting two NICs with a cross cable?  If you can do it with
physical hardware, you ought to be able to do it in QEMU).

And in any case, this is certainly not a trivial patch!

Paolo

>> ---
>>  net/hub.c       | 4 ++++
>>  qemu-options.hx | 6 ++++--
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/hub.c b/net/hub.c
>> index 32d8cf5..85bd5bc 100644
>> --- a/net/hub.c
>> +++ b/net/hub.c
>> @@ -13,6 +13,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>  #include "monitor/monitor.h"
>>  #include "net/net.h"
>>  #include "clients.h"
>> @@ -286,6 +287,9 @@ int net_init_hubport(const Netdev *netdev, const char *name,
>>  {
>>      const NetdevHubPortOptions *hubport;
>>  
>> +    error_report("hubports are deprecated and will be removed in a "
>> +                 "future release");
>> +
>>      assert(netdev->type == NET_CLIENT_DRIVER_HUBPORT);
>>      assert(!peer);
>>      hubport = &netdev->u.hubport;
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index dc1a48a..efb555c 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1810,7 +1810,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>      "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
>>      "                configure a vhost-user network, backed by a chardev 'dev'\n"
>>      "-netdev hubport,id=str,hubid=n\n"
>> -    "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH_ALL)
>> +    "                configure a hub port on QEMU VLAN 'n' (deprecated)\n", QEMU_ARCH_ALL)
>>  DEF("net", HAS_ARG, QEMU_OPTION_net,
>>      "-net nic[,vlan=n][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
>>      "                old way to create a new NIC and connect it to VLAN 'n'\n"
>> @@ -2239,7 +2239,9 @@ Create a hub port on QEMU "vlan" @var{hubid}.
>>  
>>  The hubport netdev lets you connect a NIC to a QEMU "vlan" instead of a single
>>  netdev.  @code{-net} and @code{-device} with parameter @option{vlan} create the
>> -required hub automatically.
>> +required hub automatically. Note that the "vlan" concept and thus the hubport
>> +option, too, are considered as deprecated and might be removed in a future
>> +release of QEMU.
>>  
>>  @item -netdev vhost-user,chardev=@var{id}[,vhostforce=on|off][,queues=n]
>>  
>>
> 
> ping?
> 
>  Thomas
> 
