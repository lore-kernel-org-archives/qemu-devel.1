Received: from eggs.gnu.org ([2001:4830:134:3::10]:58594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYc4b-0005L4-7c
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYc4X-000083-4G
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:50:45 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42744
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYc4W-00007i-QT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:50:40 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-2-anton.ivanov@cambridgegreys.com>
	<1236f136-c211-32a1-11b1-1e86fad422c4@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <c6bd0b81-0b9c-89fd-31e0-00662115cad8@cambridgegreys.com>
Date: Fri, 21 Jul 2017 18:50:08 +0100
MIME-Version: 1.0
In-Reply-To: <1236f136-c211-32a1-11b1-1e86fad422c4@redhat.com>
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

>> +    NetUnifiedState *s = (NetUnifiedState *) us;
>> +    L2TPV3TunnelParams *p = (L2TPV3TunnelParams *) s->params;
>
> How about embedding NetUnifiedState into this structure and keep using 
> NetL2TPV3State? Then:
>
> -  's' could be kept and lots of lines of changes could be saved here 
> and l2tpv3_verify_header()
> -  each transport could have their own type instead of using 
> NET_CLIENT_DRIVER_L2TPV3

That means each of them having their own read/write functions in each 
transport, destroy functions, etc.

I am trying to achieve exactly the opposite which across all transports 
should save more code. There should be nothing in a transport which 
leverages the common datagram processing backend except:

1. Init and parse arguments
2. Form Header
3. Verify Header

All the rest can be common for a large family of datagram based 
transports - L2TPv3, GRE, RAW (both full interface and just pulling a 
specific vlan out of it), etc.

It is trivial to do that for fixed size headers (as in the current 
patchset family). It is a bit more difficult to that for variable 
headers, but still datagram (GUE, Geneve, etc).

These may also add 4 - I/O to control plane, but it remains to be seen 
if that is needed.

This also makes any improvements to the backend - f.e. switching from 
send() to sendmmsg() automatically available for all transports.

What cannot be done is to shoehorn into this stream based. I believe we 
have only one of those - the original socket.c in tcp mode and we can 
leave it to stay that way and switch only the datagram mode to a better 
backend.

I am going through the other comments in the meantime to see if I missed 
something else and fixing the omissions.

A.

[snip]

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
