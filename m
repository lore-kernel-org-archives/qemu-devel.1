Received: from eggs.gnu.org ([2001:4830:134:3::10]:48242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fLsBt-0000Li-4R
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fLsBn-0003ag-Fg
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:30:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fLsBn-0003Zz-51
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:30:03 -0400
References: <20180519092956.15134-1-laurent@vivier.eu>
	<20180519092956.15134-7-laurent@vivier.eu>
	<CAFEAcA8Wc2boEtJQC2feZ_N07no-ErGGk-Hhwyyuo91kGaTc2w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a423df2b-02a1-07f9-075f-55e68607f357@vivier.eu>
Date: Thu, 24 May 2018 17:29:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Wc2boEtJQC2feZ_N07no-ErGGk-Hhwyyuo91kGaTc2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 6/8] linux-user: update
 ARCH_HAS_SOCKET_TYPES use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>, Richard Henderson <rth@twiddle.net>

Le 21/05/2018 à 11:19, Peter Maydell a écrit :
> On 19 May 2018 at 10:29, Laurent Vivier <laurent@vivier.eu> wrote:
>> to be like in the kernel and rename it TARGET_ARCH_HAS_SOCKET_TYPES
> 
> You could note in the commit message that this fixes our
> incorrect definition of TARGET_SOCK_CLOEXEC for SPARC.

I agree

>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  linux-user/alpha/sockbits.h | 36 +++-----------------------
>>  linux-user/hppa/sockbits.h  | 33 +++---------------------
>>  linux-user/mips/sockbits.h  |  9 ++++---
>>  linux-user/socket.h         | 62 +++++++++++++++++++++++----------------------
>>  linux-user/sparc/sockbits.h | 36 --------------------------
>>  5 files changed, 44 insertions(+), 132 deletions(-)
>>
>> diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
>> index 4db3e52b67..f5397dd875 100644
>> --- a/linux-user/alpha/sockbits.h
>> +++ b/linux-user/alpha/sockbits.h
>> @@ -75,39 +75,9 @@
>>  /* Instruct lower device to use last 4-bytes of skb data as FCS */
>>  #define TARGET_SO_NOFCS     43
>>
>> -/** sock_type - Socket types
>> - *
>> - * Please notice that for binary compat reasons ALPHA has to
>> - * override the enum sock_type in include/linux/net.h, so
>> - * we define ARCH_HAS_SOCKET_TYPES here.
>> - *
>> - * @SOCK_DGRAM - datagram (conn.less) socket
>> - * @SOCK_STREAM - stream (connection) socket
>> - * @SOCK_RAW - raw socket
>> - * @SOCK_RDM - reliably-delivered message
>> - * @SOCK_SEQPACKET - sequential packet socket
>> - * @SOCK_DCCP - Datagram Congestion Control Protocol socket
>> - * @SOCK_PACKET - linux specific way of getting packets at the dev level.
>> - *                For writing rarp and other similar things on the user
>> - *                level.
>> - * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
>> - * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
>> +/* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
>> + * have to define SOCK_NONBLOCK to a different value here.
>>   */
>> +#define TARGET_SOCK_NONBLOCK   0x40000000
> 
> This new value is different from the old value in the enum:
> 
>> -#define ARCH_HAS_SOCKET_TYPES          1
>> -
>> -enum sock_type {
>> -       TARGET_SOCK_STREAM      = 1,
>> -       TARGET_SOCK_DGRAM       = 2,
>> -       TARGET_SOCK_RAW         = 3,
>> -       TARGET_SOCK_RDM         = 4,
>> -       TARGET_SOCK_SEQPACKET   = 5,
>> -       TARGET_SOCK_DCCP        = 6,
>> -       TARGET_SOCK_PACKET      = 10,
>> -       TARGET_SOCK_CLOEXEC     = 010000000,
>> -       TARGET_SOCK_NONBLOCK    = 010000000000,
> 
> ...does it matter?

It's what we could think at first glance (I did), but

0x40000000   (hex) is
010000000000 (octal)

Does this answer to your comment?

Thanks,
Laurent
