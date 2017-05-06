Received: from eggs.gnu.org ([2001:4830:134:3::10]:43697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d6zcu-0005I6-Ak
	for qemu-devel@nongnu.org; Sat, 06 May 2017 09:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d6zcr-0007cj-69
	for qemu-devel@nongnu.org; Sat, 06 May 2017 09:20:00 -0400
References: <20170505224833.17769-1-laurent@vivier.eu>
	<20170505224833.17769-2-laurent@vivier.eu>
	<20170505232738.targ5w5jm2vb73fe@var.youpi.perso.aquilenet.fr>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7f643a77-0dd7-cf43-b51a-337da34f8f87@vivier.eu>
Date: Sat, 6 May 2017 15:19:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170505232738.targ5w5jm2vb73fe@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 06/05/2017 à 01:27, Samuel Thibault a écrit :
> Hello,
> 

Hi,

> Laurent Vivier, on sam. 06 mai 2017 00:48:33 +0200, wrote:
>> @@ -617,6 +622,10 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
>>                   * Check sockets for reading
>>                   */
>>                  else if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
>> +                    if (so->so_state & SS_ISFCONNECTING) {
>> +                        socks5_recv(so->s, &so->so_proxy_state);
>> +                        continue;
>> +                    }
> 
> Again, I don't see how this can work with both socks5 case and
> non-socks5 case.  Don't we need to somehow check for the type of socket
> before calling socks5_recv?

The check is done previously by:

@@ -442,6 +443,10 @@ void slirp_pollfds_fill(GArray *pollfds, uint32_t
*timeout)
                     .fd = so->s,
                     .events = G_IO_OUT | G_IO_ERR,
                 };
+                if (so->so_proxy_state &&
+                    so->so_proxy_state != SOCKS5_STATE_ERROR) {
+                    pfd.events |= G_IO_IN;
+                }

We can enter in socks5_recv() only if so->so_proxy_state is in a valid
state because G_IO_IN triggers that.

> 
>> @@ -645,11 +654,19 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
>>                      /*
>>                       * Check for non-blocking, still-connecting sockets
>>                       */
>> -                    if (so->so_state & SS_ISFCONNECTING) {
>> -                        /* Connected */
>> -                        so->so_state &= ~SS_ISFCONNECTING;
>>  
>> -                        ret = send(so->s, (const void *) &ret, 0, 0);
>> +                    if (so->so_state & SS_ISFCONNECTING) {
>> +                        ret = socks5_send(so->s, slirp->proxy_user,
> 
> Ditto.

if so_proxy_state is 0 the function does nothing and all remains as
without the function call (it's the case "ret > 0)"

> 
>> diff --git a/slirp/socks5.c b/slirp/socks5.c
>> new file mode 100644
>> index 0000000..2bba045
>> --- /dev/null
>> +++ b/slirp/socks5.c
>> @@ -0,0 +1,371 @@
> 
> In v2 of the patch, this was said to have "some parts from nmap/ncat
> GPLv2".  Is that really not true any more?  If any part of the file is
> not original, it *has* to wear proper copyright notices, otherwise it's
> copyright infrigement.

No, I've re-written entirely this part from RFC.

for ncat.h license is 281 lines long (with clarifications and
extensions) for 60 lines copied...

> Also, see the bot build error report: <sys/socket.h> doesn't exist on
> windows,
> 
> #include <windows.h>
> #include <winsock2.h>
> #include <ws2tcpip.h>
> 
> should be used instead.

In fact, the include is not needed at all.

Thanks,
Laurent
