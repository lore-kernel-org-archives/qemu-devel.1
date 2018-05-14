Received: from eggs.gnu.org ([2001:4830:134:3::10]:46050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fI7T1-0001q7-BP
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fI7Sw-0008Is-DA
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:00:19 -0400
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:46685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fI7Sw-0008I4-6t
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:00:14 -0400
Received: by mail-io0-x229.google.com with SMTP id f21-v6so13944821iob.13
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 00:00:14 -0700 (PDT)
References: <20180313044944.21058-1-aik@ozlabs.ru>
	<20180313074442.xw5deum6xfw5tvjw@var.youpi.perso.aquilenet.fr>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <87d13bdd-4a33-fb05-0c7c-36aabbd3d038@ozlabs.ru>
Date: Mon, 14 May 2018 17:00:08 +1000
MIME-Version: 1.0
In-Reply-To: <20180313074442.xw5deum6xfw5tvjw@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] slirp/debug: Print IP addresses in
 human readable form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org

On 13/3/18 6:44 pm, Samuel Thibault wrote:
> Alexey Kardashevskiy, on mar. 13 mars 2018 15:49:44 +1100, wrote:
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Applied to my tree, thanks!


And what is your tree, is this something to be merged sometime later
somewhere? :)



> 
>> ---
>>
>> checkpatch.pl complains on every single changed line as it keeps
>> using tabs - do I need to post 's/\t/    /g'?
>>
>> ---
>> Changes:
>> v2:
>> * replaced static cast to (in_addr*) with temporary structs
>> ---
>>  slirp/arp_table.c | 4 ++--
>>  slirp/socket.c    | 8 ++++----
>>  slirp/udp.c       | 4 ++--
>>  3 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/slirp/arp_table.c b/slirp/arp_table.c
>> index 3547043..f81963b 100644
>> --- a/slirp/arp_table.c
>> +++ b/slirp/arp_table.c
>> @@ -33,7 +33,7 @@ void arp_table_add(Slirp *slirp, uint32_t ip_addr, uint8_t ethaddr[ETH_ALEN])
>>      int i;
>>  
>>      DEBUG_CALL("arp_table_add");
>> -    DEBUG_ARG("ip = 0x%x", ip_addr);
>> +    DEBUG_ARG("ip = %s", inet_ntoa((struct in_addr){.s_addr = ip_addr}));
>>      DEBUG_ARGS((dfd, " hw addr = %02x:%02x:%02x:%02x:%02x:%02x\n",
>>                  ethaddr[0], ethaddr[1], ethaddr[2],
>>                  ethaddr[3], ethaddr[4], ethaddr[5]));
>> @@ -67,7 +67,7 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_addr,
>>      int i;
>>  
>>      DEBUG_CALL("arp_table_search");
>> -    DEBUG_ARG("ip = 0x%x", ip_addr);
>> +    DEBUG_ARG("ip = %s", inet_ntoa((struct in_addr){.s_addr = ip_addr}));
>>  
>>      /* If broadcast address */
>>      if (ip_addr == 0xffffffff || ip_addr == broadcast_addr) {
>> diff --git a/slirp/socket.c b/slirp/socket.c
>> index cb7b5b6..318301f 100644
>> --- a/slirp/socket.c
>> +++ b/slirp/socket.c
>> @@ -701,10 +701,10 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
>>  	memset(&addr, 0, addrlen);
>>  
>>  	DEBUG_CALL("tcp_listen");
>> -	DEBUG_ARG("haddr = %x", haddr);
>> -	DEBUG_ARG("hport = %d", hport);
>> -	DEBUG_ARG("laddr = %x", laddr);
>> -	DEBUG_ARG("lport = %d", lport);
>> +	DEBUG_ARG("haddr = %s", inet_ntoa((struct in_addr){.s_addr = haddr}));
>> +	DEBUG_ARG("hport = %d", ntohs(hport));
>> +	DEBUG_ARG("laddr = %s", inet_ntoa((struct in_addr){.s_addr = laddr}));
>> +	DEBUG_ARG("lport = %d", ntohs(lport));
>>  	DEBUG_ARG("flags = %x", flags);
>>  
>>  	so = socreate(slirp);
>> diff --git a/slirp/udp.c b/slirp/udp.c
>> index 227d779..e5bf065 100644
>> --- a/slirp/udp.c
>> +++ b/slirp/udp.c
>> @@ -241,8 +241,8 @@ int udp_output(struct socket *so, struct mbuf *m,
>>  	DEBUG_CALL("udp_output");
>>  	DEBUG_ARG("so = %p", so);
>>  	DEBUG_ARG("m = %p", m);
>> -	DEBUG_ARG("saddr = %lx", (long)saddr->sin_addr.s_addr);
>> -	DEBUG_ARG("daddr = %lx", (long)daddr->sin_addr.s_addr);
>> +	DEBUG_ARG("saddr = %s", inet_ntoa(saddr->sin_addr));
>> +	DEBUG_ARG("daddr = %s", inet_ntoa(daddr->sin_addr));
>>  
>>  	/*
>>  	 * Adjust for header
>> -- 
>> 2.11.0
>>
> 


-- 
Alexey
