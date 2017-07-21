Received: from eggs.gnu.org ([2001:4830:134:3::10]:46499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYPVr-0003n2-KL
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYPVn-0002SF-Jz
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:26:03 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42667
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYPVn-0002RT-Dc
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:25:59 -0400
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
	<6d89f581-fc89-3455-60c8-439702d7bba6@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1fe9110c-ae57-41e3-b479-66daa6d6cb3c@cambridgegreys.com>
Date: Fri, 21 Jul 2017 05:25:37 +0100
MIME-Version: 1.0
In-Reply-To: <6d89f581-fc89-3455-60c8-439702d7bba6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Unified Datagram Socket Transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org



On 21/07/17 04:55, Jason Wang wrote:
>
>
> On 2017年07月21日 03:12, anton.ivanov@cambridgegreys.com wrote:
>> Hi all,
>>
>> This addresses comments so far except Eric's suggestion to use
>> InetSocketAddressBase. If I understand correctly its intended use,
>> it will not be of help for protocols which have no port (raw
>> sockets - GRE, L2TPv3, etc).
>>
>> It also includes a port of the original socket.c transport to
>> the new UDST backend. The relevant code is ifdef-ed so there
>> should be no effect on other systems.
>
> This looks sub-optimal. If you want to do this, I would rather suggest 
> you just extend the socket dgram backend like what udst did now.

Apologies, do you mean extend it further to handle the tcp form?

That does not work at present. Sure, you can receive tcp using recvmmsg, 
but you cannot use it to handle a tcp based variable length encaps where 
frame lengths are set in a header. That can be done only be sequential 
read() or recv() to read the frame length first, then the frame.

I can in theory add that to a unified socket backend, but this is 
completely different tx and rx logic - so it will become suboptimal (and 
quite ugly). It will need different tx and rx functions and appropriate 
initialization to select them. I'd rather keep it to datagram only - 
what says on the tin.

>
>>
>> I think that this is would be the appropriate place to stop in this
>> iteration. I would prefer to have this polished, before I start
>> looking at sendmmsg and bulk send or some of the more unpleasant
>> encapsulations like geneve.
>
> Pay attention we're softfreeze now. So the feature is for 2.11, if it 
> looks good, I can only queue it for 2.11.

OK. Understood.

>
> Btw, looks like not all comments of v1 were addressed.

I will go through the comments one more time. I realized I may have 
missed converting malloc to a g_memdup in a couple places.

>
> Thanks

Best Regards,

A.

>
>>
>> A.
>>
>>
>
>

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
