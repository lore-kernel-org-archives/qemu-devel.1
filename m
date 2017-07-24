Received: from eggs.gnu.org ([2001:4830:134:3::10]:53053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dZUaR-0000Hk-ES
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dZUaO-0000EC-9c
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:03:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dZUaO-0000DW-0m
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:03:12 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
	<e31eb033-a770-e5fd-97b0-0b50f268c22c@redhat.com>
	<b1194532-a97a-33d3-92d4-8531674d358d@cambridgegreys.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2c69da12-2b18-2272-6eff-c6223667aad0@redhat.com>
Date: Mon, 24 Jul 2017 12:03:06 +0800
MIME-Version: 1.0
In-Reply-To: <b1194532-a97a-33d3-92d4-8531674d358d@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B407=E6=9C=8822=E6=97=A5 02:50, Anton Ivanov wrote:
>
> [snip]
>
>>> +    "-netdev raw,id=3Dstr,ifname=3Difname\n"
>>> +    "                configure a network backend with ID 'str'=20
>>> connected to\n"
>>> +    "                an Ethernet interface named ifname via raw=20
>>> socket.\n"
>>> +    "                This backend does not change the interface=20
>>> settings.\n"
>>> +    "                Most interfaces will require being set into=20
>>> promisc mode,\n"
>>> +    "                as well having most offloads (TSO, etc) turned=20
>>> off.\n"
>>> +    "                Some virtual interfaces like tap support only=20
>>> RX.\n"
>>
>> Pay attention that qemu supports vnet header. So any reason to turn=20
>> off e.g TSO here?
>
> I am not aware of any means to get extra info like checksums, etc show=20
> up on raw socket read.
>
> If you know a way to make them show up, this is worth investigating.

See packet_rcv_vnet(). But a known 'issue' for raw socket is that it=20
forbids change vnet header length after creation, we may need some=20
workaround in qemu.

>
>>
>>>   #endif
>>>       "-netdev=20
>>> socket,id=3Dstr[,fd=3Dh][,listen=3D[host]:port][,connect=3Dhost:port]=
\n"
>>>       "                configure a network backend to connect to=20
>>> another network\n"
>>> @@ -2463,6 +2470,32 @@ qemu-system-i386 linux.img -net nic -net=20
>>> gre,src=3D4.2.3.1,dst=3D1.2.3.4
>>>     @end example
>>>   +@item -netdev raw,id=3D@var{id},ifname=3D@var{ifname}
>>> +@itemx -net raw[,vlan=3D@var{n}][,name=3D@var{name}],ifname=3D@var{i=
fname}
>>> +Connect VLAN @var{n} directly to an Ethernet interface using raw=20
>>> socket.
>>> +
>>> +This transport allows a VM to bypass most of the network stack=20
>>> which is
>>> +extremely useful for tapping.
>>> +
>>> +@item ifname=3D@var{ifname}
>>> +    interface name (mandatory)
>>> +
>>> +@example
>>> +# set up the interface - put it in promiscuous mode and turn off=20
>>> offloads
>>> +ifconfig eth0 up
>>> +ifconfig eth0 promisc
>>> +
>>> +/sbin/ethtool -K eth0 gro off
>>> +/sbin/ethtool -K eth0 tso off
>>> +/sbin/ethtool -K eth0 gso off
>>> +/sbin/ethtool -K eth0 tx off
>>
>> Any reason to turn off tx here?
>
> Yes - we already have it computed and we have written it as is as a=20
> whole packet. You do not want it
> re-computed as at least some adapters do silly things if you start=20
> writing raw and the checksum already exists.

This looks like a bug of the driver?

For GRO it's easier to understand since guest may not handle big packets=20
with partial checksum. But tso,gso,tx, this still looks questionable for=20
the nic which may want to offload them to card (e.g virtio-net).

>
> Once again, this one of the pros/cons of using tpacket vs recv/send=20
> (with or without mmsg) on a raw socket.
>
> recvm(m)sg/sendm(m)sg are brute force as far as offloads, but things=20
> like scatter/gather work correctly so there are little copies.
>
> Compared to that, tpacket will allow you some access to checksumming=20
> which you can map onto checksum offload in a vNIC. As a payback for=20
> this you end up copying in more cases than for send/recvmmsg and you=20
> pay penalty for timestamping if you do not have a hardware timestamp=20
> source in the NIC.
>
> The other issue I always had with tpacket is that you "see" your own=20
> packets so you have to manage a  RX side BPF filter which removes=20
> those so you do not see your own packets.

Don't get here, looks like I don't get this 'issue'. Anyway we can=20
discuss this when I post the tpacket backend.

Thanks.

> That can get quite interesting if you have a lot of MACs on a NIC=20
> (f.e. when there are multicast apps). Not sure if this is still the=20
> case - it definitely was in mid 3.x Linux kernels. If you use raw=20
> sendm(m)sg there is no issue - the packets are not looped when writing=20
> to physical interfaces.
>
>>
>>> +
>>> +# launch QEMU instance - if your network has reorder or is very=20
>>> lossy add ,pincounter
>>> +
>>> +qemu-system-i386 linux.img -net nic -net raw,ifname=3Deth0
>>
>> Can we switch to use -netdev here?
>
> This is done in the new revisions.
>
>>
>> Thanks
>>
>>> +
>>> +@end example
>>> +
>>>   @item -netdev=20
>>> vde,id=3D@var{id}[,sock=3D@var{socketpath}][,port=3D@var{n}][,group=3D=
@var{groupname}][,mode=3D@var{octalmode}]
>>>   @itemx -net=20
>>> vde[,vlan=3D@var{n}][,name=3D@var{name}][,sock=3D@var{socketpath}]=20
>>> [,port=3D@var{n}][,group=3D@var{groupname}][,mode=3D@var{octalmode}]
>>>   Connect VLAN @var{n} to PORT @var{n} of a vde switch running on=20
>>> host and
>>
>>
