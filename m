Received: from eggs.gnu.org ([2001:4830:134:3::10]:47792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eBeyF-0004py-ND
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eBeyC-0002Qk-L0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:49:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1eBeyC-0002Oh-Dk
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:49:32 -0500
Date: Mon, 6 Nov 2017 11:49:14 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20171106104914.w2tcqgog2e7jfi2e@localhost.localdomain>
References: <20170808203900.7661-1-jfreimann@redhat.com>
	<20170808203900.7661-3-jfreimann@redhat.com>
	<CAFEAcA96q_ebN06WE5mgOqiPprufR3aVOgkFBhgKKyjFr=aiCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFEAcA96q_ebN06WE5mgOqiPprufR3aVOgkFBhgKKyjFr=aiCA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] net: fix -netdev socket,
 fd= for UDP sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andr?? Lureau <marcandre.lureau@redhat.com>

On Fri, Nov 03, 2017 at 06:46:57PM +0000, Peter Maydell wrote:
>On 8 August 2017 at 21:38, Jens Freimann <jfreimann@redhat.com> wrote:
>> @@ -333,8 +333,13 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>>       * by ONLY ONE process: we must "clone" this dgram socket --jjo
>>       */
>>
>> -    if (is_connected) {
>> -        if (getsockname(fd, (struct sockaddr *) &saddr, &saddr_len) == 0) {
>> +    if (is_connected && mcast != NULL) {
>
>This changes the condition() under which we fill in the struct sockaddr_in saddr
>from "if (is_connected)" to "if (is_connected && mcast != NULL)"...
>
>> +            if (parse_host_port(&saddr, mcast) < 0) {
>> +                fprintf(stderr,
>> +                        "qemu: error: init_dgram: fd=%d failed parse_host_port()\n",
>> +                        fd);
>> +                goto err;
>> +            }
>>              /* must be bound */
>>              if (saddr.sin_addr.s_addr == 0) {
>>                  fprintf(stderr, "qemu: error: init_dgram: fd=%d unbound, "
>
>...but later in the function we do:
>
>    /* mcast: save bound address as dst */
>    if (is_connected) {

This should be changed to "if (is_connected && mcast != NULL)" because
it is only necessary to do this if there is a multicast address specified. 

>        s->dgram_dst = saddr;
>        snprintf(nc->info_str, sizeof(nc->info_str),
>                 "socket: fd=%d (cloned mcast=%s:%d)",
>                 fd, inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
>    } else {
>        snprintf(nc->info_str, sizeof(nc->info_str),
>                 "socket: fd=%d", fd);
>    }
>
>and coverity correctly points out that if is_connected is true
>but mcast is NULL then we use 'saddr' without having initialized
>it properly.
>
>Any suggestions for the correct fix for this?

I think we should initialize saddr to 0 and do the above change. I'll send a
patch.

Thanks!

regards,
Jens 
