Received: from eggs.gnu.org ([2001:4830:134:3::10]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYd0u-00068T-19
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYd0q-0006vv-T4
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:51:00 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42747
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYd0q-0006vX-N6
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:50:56 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
	<e31eb033-a770-e5fd-97b0-0b50f268c22c@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <b1194532-a97a-33d3-92d4-8531674d358d@cambridgegreys.com>
Date: Fri, 21 Jul 2017 19:50:33 +0100
MIME-Version: 1.0
In-Reply-To: <e31eb033-a770-e5fd-97b0-0b50f268c22c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] Unified Datagram Socket Transport -
 raw support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org


[snip]

>> +    "-netdev raw,id=str,ifname=ifname\n"
>> +    "                configure a network backend with ID 'str' 
>> connected to\n"
>> +    "                an Ethernet interface named ifname via raw 
>> socket.\n"
>> +    "                This backend does not change the interface 
>> settings.\n"
>> +    "                Most interfaces will require being set into 
>> promisc mode,\n"
>> +    "                as well having most offloads (TSO, etc) turned 
>> off.\n"
>> +    "                Some virtual interfaces like tap support only 
>> RX.\n"
>
> Pay attention that qemu supports vnet header. So any reason to turn 
> off e.g TSO here?

I am not aware of any means to get extra info like checksums, etc show 
up on raw socket read.

If you know a way to make them show up, this is worth investigating.

>
>>   #endif
>>       "-netdev 
>> socket,id=str[,fd=h][,listen=[host]:port][,connect=host:port]\n"
>>       "                configure a network backend to connect to 
>> another network\n"
>> @@ -2463,6 +2470,32 @@ qemu-system-i386 linux.img -net nic -net 
>> gre,src=4.2.3.1,dst=1.2.3.4
>>     @end example
>>   +@item -netdev raw,id=@var{id},ifname=@var{ifname}
>> +@itemx -net raw[,vlan=@var{n}][,name=@var{name}],ifname=@var{ifname}
>> +Connect VLAN @var{n} directly to an Ethernet interface using raw 
>> socket.
>> +
>> +This transport allows a VM to bypass most of the network stack which is
>> +extremely useful for tapping.
>> +
>> +@item ifname=@var{ifname}
>> +    interface name (mandatory)
>> +
>> +@example
>> +# set up the interface - put it in promiscuous mode and turn off 
>> offloads
>> +ifconfig eth0 up
>> +ifconfig eth0 promisc
>> +
>> +/sbin/ethtool -K eth0 gro off
>> +/sbin/ethtool -K eth0 tso off
>> +/sbin/ethtool -K eth0 gso off
>> +/sbin/ethtool -K eth0 tx off
>
> Any reason to turn off tx here?

Yes - we already have it computed and we have written it as is as a 
whole packet. You do not want it
re-computed as at least some adapters do silly things if you start 
writing raw and the checksum already exists.

Once again, this one of the pros/cons of using tpacket vs recv/send 
(with or without mmsg) on a raw socket.

recvm(m)sg/sendm(m)sg are brute force as far as offloads, but things 
like scatter/gather work correctly so there are little copies.

Compared to that, tpacket will allow you some access to checksumming 
which you can map onto checksum offload in a vNIC. As a payback for this 
you end up copying in more cases than for send/recvmmsg and you pay 
penalty for timestamping if you do not have a hardware timestamp source 
in the NIC.

The other issue I always had with tpacket is that you "see" your own 
packets so you have to manage a  RX side BPF filter which removes those 
so you do not see your own packets. That can get quite interesting if 
you have a lot of MACs on a NIC (f.e. when there are multicast apps). 
Not sure if this is still the case - it definitely was in mid 3.x Linux 
kernels. If you use raw sendm(m)sg there is no issue - the packets are 
not looped when writing to physical interfaces.

>
>> +
>> +# launch QEMU instance - if your network has reorder or is very 
>> lossy add ,pincounter
>> +
>> +qemu-system-i386 linux.img -net nic -net raw,ifname=eth0
>
> Can we switch to use -netdev here?

This is done in the new revisions.

>
> Thanks
>
>> +
>> +@end example
>> +
>>   @item -netdev 
>> vde,id=@var{id}[,sock=@var{socketpath}][,port=@var{n}][,group=@var{groupname}][,mode=@var{octalmode}]
>>   @itemx -net 
>> vde[,vlan=@var{n}][,name=@var{name}][,sock=@var{socketpath}] 
>> [,port=@var{n}][,group=@var{groupname}][,mode=@var{octalmode}]
>>   Connect VLAN @var{n} to PORT @var{n} of a vde switch running on 
>> host and
>
>
-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
