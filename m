Received: from eggs.gnu.org ([2001:4830:134:3::10]:33552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1etPvd-0000Mc-J2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1etPvb-0008J7-LF
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:39:45 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:39541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1etPvb-0008Ic-C5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:39:43 -0500
Received: by mail-pf0-x241.google.com with SMTP id u5so436096pfh.6
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 19:39:43 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
	by smtp.googlemail.com with ESMTPSA id
	i1sm36778543pfi.116.2018.03.06.19.39.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 19:39:41 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20180201093651.33801-1-aik@ozlabs.ru>
	<daf0cada-23d2-6dcb-3d6a-022ac646b492@ozlabs.ru>
Message-ID: <3c55c2a3-a40a-86f0-8c5f-ea14826220ae@ozlabs.ru>
Date: Wed, 7 Mar 2018 14:39:38 +1100
MIME-Version: 1.0
In-Reply-To: <daf0cada-23d2-6dcb-3d6a-022ac646b492@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] slirp: Update forwarding IP
 address if guest receiver non-default IP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 08/02/18 15:29, Alexey Kardashevskiy wrote:
> On 01/02/18 20:36, Alexey Kardashevskiy wrote:
>> If we run QEMU with -netdev user,id=USER0,hostfwd=tcp::2222-:22, it starts
>> a DHCP server and starts allocating client IPs from 10.0.2.15 so
>> this is what the guest normally receives. Since QEMU automatically adds
>> the DHCP starting address into the forwarding table, everything works.
>> This is the table before guest started:
>>
>> (qemu) info usernet
>> VLAN -1 (USER0):
>>   Protocol[State]    FD  Source Address  Port   Dest. Address  Port RecvQ SendQ
>>   TCP[HOST_FORWARD]  11               *  2222       10.0.2.15    22     0     0
>>
>> However if the guest happens to have DHCP lease (for example, 10.0.2.16),
>> the forwarding stops working. The guest can still reach the outer world
>> (which is expected).
>>
>> This updates the forwarding table when QEMU confirms the requested IP
>> to the guest.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> Does this look any useful?

Ping, anyone?

> 
> 
> It does not seem like it does very much but .... :)
> 
> 
>>
>> Sure I can remove /var/lib/dhcp/dhclient.enp0s1.leases in the guest or
>> start QEMU with the DHCP start address equal to what the guest wants to
>> reserve but it is quite confusing why such a simple config just does not
>> work.
>>
>> Found this with the brand new Ubuntu 17.10 which runs dhcp and something
>> called "netplan" and the guest ends up with 2 IPs from 10.0.2.x network.
>> After disabling netplan, the lease remains and it is not 10.0.2.15 but
>> rather .16 or .17.
>>
>> Comments? Thanks.
>>
>> ---
>>  slirp/libslirp.h |  2 ++
>>  slirp/bootp.c    |  2 ++
>>  slirp/slirp.c    | 27 +++++++++++++++++++++++++++
>>  3 files changed, 31 insertions(+)
>>
>> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
>> index 540b3e5..6779081 100644
>> --- a/slirp/libslirp.h
>> +++ b/slirp/libslirp.h
>> @@ -33,6 +33,8 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp,
>>                        struct in_addr guest_addr, int guest_port);
>>  int slirp_remove_hostfwd(Slirp *slirp, int is_udp,
>>                           struct in_addr host_addr, int host_port);
>> +void slirp_update_hostfwd(Slirp *slirp, struct in_addr old_guest_addr,
>> +                          struct in_addr new_guest_addr);
>>  int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
>>                     struct in_addr *guest_addr, int guest_port);
>>  
>> diff --git a/slirp/bootp.c b/slirp/bootp.c
>> index 5dd1a41..5876004 100644
>> --- a/slirp/bootp.c
>> +++ b/slirp/bootp.c
>> @@ -225,6 +225,8 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
>>      /* Update ARP table for this IP address */
>>      arp_table_add(slirp, daddr.sin_addr.s_addr, client_ethaddr);
>>  
>> +    slirp_update_hostfwd(slirp, slirp->vdhcp_startaddr, daddr.sin_addr);
>> +
>>      saddr.sin_addr = slirp->vhost_addr;
>>      saddr.sin_port = htons(BOOTP_SERVER);
>>  
>> diff --git a/slirp/slirp.c b/slirp/slirp.c
>> index 1cb6b07..a9d8a16 100644
>> --- a/slirp/slirp.c
>> +++ b/slirp/slirp.c
>> @@ -1061,6 +1061,33 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp, struct in_addr host_addr,
>>      return 0;
>>  }
>>  
>> +static void slirp_do_update_hostfwd(Slirp *slirp, struct socket *head,
>> +                                    struct in_addr old_guest_addr,
>> +                                    struct in_addr new_guest_addr)
>> +{
>> +    struct socket *so;
>> +    char oldaddr[17], newaddr[17];
>> +
>> +    for (so = head->so_next; so != head; so = so->so_next) {
>> +        if ((so->so_state & SS_HOSTFWD) &&
>> +            so->lhost.sin.sin_addr.s_addr == old_guest_addr.s_addr) {
>> +            strncpy(oldaddr, inet_ntoa(old_guest_addr), sizeof(oldaddr) - 1);
>> +            strncpy(newaddr, inet_ntoa(new_guest_addr), sizeof(newaddr) - 1);
>> +            DEBUG_ARGS((dfd, "Updating forwarding from %s:%d to %s:%d\n",
>> +                       oldaddr, ntohs(so->lhost.sin.sin_port),
>> +                       newaddr, ntohs(so->lhost.sin.sin_port)));
>> +            so->lhost.sin.sin_addr = new_guest_addr;
>> +        }
>> +    }
>> +}
>> +
>> +void slirp_update_hostfwd(Slirp *slirp, struct in_addr old_guest_addr,
>> +                          struct in_addr new_guest_addr)
>> +{
>> +    slirp_do_update_hostfwd(slirp, &slirp->udb, old_guest_addr, new_guest_addr);
>> +    slirp_do_update_hostfwd(slirp, &slirp->tcb, old_guest_addr, new_guest_addr);
>> +}
>> +
>>  int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
>>                     struct in_addr *guest_addr, int guest_port)
>>  {
>>
> 
> 


-- 
Alexey
