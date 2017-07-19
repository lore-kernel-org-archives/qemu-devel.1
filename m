Received: from eggs.gnu.org ([2001:4830:134:3::10]:32957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXimd-0002mz-Ms
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXimY-0002aV-Qk
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:48:31 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42432
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dXimY-0002Z8-K2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:48:26 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-2-anton.ivanov@cambridgegreys.com>
	<1236f136-c211-32a1-11b1-1e86fad422c4@redhat.com>
	<89e2f26c-4e1d-05ef-9a99-85dc5c9c111a@cambridgegreys.com>
	<050e2865-0453-64d8-f29a-7b6d2bb418d9@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <801b76cc-66fb-e7d9-3878-3afaf6fd60dc@cambridgegreys.com>
Date: Wed, 19 Jul 2017 07:48:17 +0100
MIME-Version: 1.0
In-Reply-To: <050e2865-0453-64d8-f29a-7b6d2bb418d9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] Unified Datagram Socket Transport
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

>>> Could we keep l2tpv3 option?
>>
>> The l2tpv3 test is actually a test for recvmmsg. If you can do one 
>> recvmmsg transport you can do all of them.
>
> Yes, but I wonder whether or not the check for recvmmsg is too simple. 
> We probably want something like what AV_VSOCK did, test the support of 
> each transport through socket().

We may need this in the future.

I do not think we need it for the first 3 transports lined up for this - 
l2tpv3, gre and raw.  The only reqs are recvmmsg (and sendmmsg in the 
future) and raw sockets. They are very simple :)

So unless we try to fold all of raw initialization (on/off for offloads, 
etc) into the driver we should not need more tests for now. We will need 
them once we add more transports.

By the way - on raw, in addition to cost of timestamps, recvmmsg and 
especially sendmmsg in most cases will have lower number of copies 
compared to tpacket. IMHO there is still a very important use case for 
tpacket, but it will require hw/ work - vm used as a forensic tap. We 
will need to emulate one of the drivers which convey the timestamp so 
that a pcap/tpacket implementation in the VM can get a precise timestamp 
"at real capture".

>
>>
>>>
>>>>   if test "$cap_ng" = "yes" ; then
>>>>     echo "CONFIG_LIBCAP=y" >> $config_host_mak
>>>> diff --git a/net/Makefile.objs b/net/Makefile.objs
>>>> index 67ba5e26fb..8026ad778a 100644
>>>> --- a/net/Makefile.objs
>>>> +++ b/net/Makefile.objs
>>>> @@ -2,7 +2,7 @@ common-obj-y = net.o queue.o checksum.o util.o hub.o
>>>>   common-obj-y += socket.o
>>>>   common-obj-y += dump.o
>>>>   common-obj-y += eth.o
>>>> -common-obj-$(CONFIG_L2TPV3) += l2tpv3.o
>>>> +common-obj-$(CONFIG_UNIFIED) += l2tpv3.o unified.o
>>>>   common-obj-$(CONFIG_POSIX) += vhost-user.o
>>>>   common-obj-$(CONFIG_SLIRP) += slirp.o
>>>>   common-obj-$(CONFIG_VDE) += vde.o
>
> [...]
>
>>>>>   -    s = DO_UPCAST(NetL2TPV3State, nc, nc);
>>>>> +    s->params = p;
>>>>>   +    s->form_header = &l2tpv3_form_header;
>>>>> +    s->verify_header = &l2tpv3_verify_header;
>>>>>       s->queue_head = 0;
>>>>>       s->queue_tail = 0;
>>>>>       s->header_mismatch = false;
>>>>
>>>> Why not move all above into qemu_new_unified_net()?
>>
>> Only queue head/tail assignment can move.
>>
>> raw which uses same backend does not use header_mismatch. Form/verify 
>> header are different for each sub-transport. F.e. for gre you need 
>> the gre one, for raw you need the raw one, etc.
>
> Right, I mean pass function pointer to qemu_new_unified_net().

Ack - will do in the next revision.


[snip]

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
