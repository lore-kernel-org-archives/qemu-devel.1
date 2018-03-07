Received: from eggs.gnu.org ([2001:4830:134:3::10]:56571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1etSdB-0003eq-EH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 01:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1etSd8-00038q-BG
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 01:32:53 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:35801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1etSd8-00038h-51
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 01:32:50 -0500
Received: by mail-it0-x242.google.com with SMTP id v194so2045943itb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 22:32:50 -0800 (PST)
References: <20180201093545.33741-1-aik@ozlabs.ru>
	<38e2df74-c7d7-a062-8385-494adae0ef89@ozlabs.ru>
	<727e34b6-0f7f-bd0c-9a34-51d5bc844c73@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <e878fb8c-e33b-54bc-545d-bd4a80d92a88@ozlabs.ru>
Date: Wed, 7 Mar 2018 17:32:44 +1100
MIME-Version: 1.0
In-Reply-To: <727e34b6-0f7f-bd0c-9a34-51d5bc844c73@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] slirp/debug: Print IP addresses in
 human readable form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 7/3/18 5:24 pm, Thomas Huth wrote:
> On 07.03.2018 04:38, Alexey Kardashevskiy wrote:
>> On 01/02/18 20:35, Alexey Kardashevskiy wrote:
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> Ping?
>>
>>
>>> ---
>>>  slirp/arp_table.c | 4 ++--
>>>  slirp/socket.c    | 8 ++++----
>>>  slirp/udp.c       | 4 ++--
>>>  3 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/slirp/arp_table.c b/slirp/arp_table.c
>>> index 3547043..bac608f 100644
>>> --- a/slirp/arp_table.c
>>> +++ b/slirp/arp_table.c
>>> @@ -33,7 +33,7 @@ void arp_table_add(Slirp *slirp, uint32_t ip_addr, uint8_t ethaddr[ETH_ALEN])
>>>      int i;
>>>  
>>>      DEBUG_CALL("arp_table_add");
>>> -    DEBUG_ARG("ip = 0x%x", ip_addr);
>>> +    DEBUG_ARG("ip = %s", inet_ntoa(*(struct in_addr *)&ip_addr));
> 
> Is this endianness safe? The man-page of inet_ntoa says that the
> function is expecting network byte order, so I wonder whether this works
> right on both, big and little endian hosts?



arp_table_add() is called for either sin_addr (network order) or
slirp_arphdr::ar_sip which is initialized from sin_addr (network order)
with no order conversion. Bugs are still possible, of course :)


-- 
Alexey
