Received: from eggs.gnu.org ([2001:4830:134:3::10]:55367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ddF24-00027F-5w
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ddF21-00073h-Av
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ddF21-00071P-5X
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:15:13 -0400
Date: Thu, 3 Aug 2017 17:45:06 +0530 (IST)
From: P J P <ppandit@redhat.com>
Message-ID: <alpine.LFD.2.20.1708031718030.16909@wniryva>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] A use-after-free in slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: wjjzhang <wjjzhang@tencent.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>

   Hello Jan, Samuel

Wjjzhang(CC'd) has reported a use-after-free issue which seems to occur while 
responding to a packet, after the socket has been closed by another thread.

===
==31922==ERROR: AddressSanitizer: heap-use-after-free on address 0x61400001ff8c at pc 0x56485de28ea0 bp 0x7f00f44fc950 sp 0x7f00f44fc940
READ of size 4 at 0x61400001ff8c thread T2
     #0 0x56485de28e9f in if_start slirp/if.c:230
     #1 0x56485de28a58 in if_output slirp/if.c:141
     #2 0x56485de35173 in ip_output slirp/ip_output.c:85
     #3 0x56485de57c48 in tcp_respond slirp/tcp_subr.c:218
     #4 0x56485de52440 in tcp_input slirp/tcp_input.c:1392
     #5 0x56485de329ef in ip_input slirp/ip_input.c:206
     #6 0x56485de3cf93 in slirp_input slirp/slirp.c:872
     #7 0x56485de0726d in net_slirp_receive net/slirp.c:119
     #8 0x56485ddee24d in nc_sendv_compat net/net.c:707
     #9 0x56485ddee3dd in qemu_deliver_packet_iov net/net.c:734
     #10 0x56485ddf422c in qemu_net_queue_deliver_iov net/queue.c:179
     ...
===

A full trace output can be seen

   here  -> https://paste.fedoraproject.org/paste/gh~hDctqUQ8uVt6UdG~zbg

I tried to debug how the 'so' and 'slirp' objects are connected and why it's 
leading to a UAF issue, but couldn't quite fix it.

Could you please help with an appropriate patch for this one?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
