Received: from eggs.gnu.org ([2001:4830:134:3::10]:56601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvRNQ-0000S1-H7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvRNN-0005cO-8f
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:04:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dvRNM-0005be-TT
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:04:29 -0400
References: <20170922140237.10869-1-carenas@gmail.com>
	<20170922140237.10869-7-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4bb66a11-110a-562a-8e3d-8d1c7088c2bc@vivier.eu>
Date: Fri, 22 Sep 2017 19:04:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170922140237.10869-7-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 6/6] linux-user: update default socket.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, riku.voipio@iki.fi

Le 22/09/2017 à 16:02, Carlo Marcelo Arenas Belón a écrit :
> * enable SO_REUSEPORT as a sideeffect and add SO_GET_FILTER alias
> * make sure 64bit version for ppc is also supported

As previously TARGET_PPC64 is not needed.

And you should move powerpc bits to linux-user/ppc/sockbits.h

Thanks,
Laurent

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/socket.h | 61 ++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/linux-user/socket.h b/linux-user/socket.h
> index 6fd486c6b1..c37c10822a 100644
> --- a/linux-user/socket.h
> +++ b/linux-user/socket.h
> @@ -27,8 +27,8 @@
>      #define TARGET_SO_PRIORITY     12
>      #define TARGET_SO_LINGER       13
>      #define TARGET_SO_BSDCOMPAT    14
> -    /* To add :#define TARGET_SO_REUSEPORT 15 */
> -#if defined(TARGET_PPC)
> +    #define TARGET_SO_REUSEPORT    15
> +#if defined(TARGET_PPC) || defined(TARGET_PPC64)
>      #define TARGET_SO_RCVLOWAT     16
>      #define TARGET_SO_SNDLOWAT     17
>      #define TARGET_SO_RCVTIMEO     18
> @@ -49,21 +49,58 @@
>      #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
>      #define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
>  
> -    #define TARGET_SO_BINDTODEVICE 25
> +    #define TARGET_SO_BINDTODEVICE            25
>  
>      /* Socket filtering */
> -    #define TARGET_SO_ATTACH_FILTER        26
> -    #define TARGET_SO_DETACH_FILTER        27
> +    #define TARGET_SO_ATTACH_FILTER           26
> +    #define TARGET_SO_DETACH_FILTER           27
> +    #define TARGET_SO_GET_FILTER              TARGET_SO_ATTACH_FILTER
>  
> -    #define TARGET_SO_PEERNAME             28
> -    #define TARGET_SO_TIMESTAMP            29
> -    #define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
> +    #define TARGET_SO_PEERNAME                28
> +    #define TARGET_SO_TIMESTAMP               29
> +    #define TARGET_SCM_TIMESTAMP              TARGET_SO_TIMESTAMP
>  
> -    #define TARGET_SO_ACCEPTCONN           30
> +    #define TARGET_SO_ACCEPTCONN              30
>  
> -    #define TARGET_SO_PEERSEC              31
> +    #define TARGET_SO_PEERSEC                 31
> +    #define TARGET_SO_PASSSEC                 34
> +    #define TARGET_SO_TIMESTAMPNS             35
> +    #define TARGET_SCM_TIMESTAMPNS            TARGET_SO_TIMESTAMPNS
> +
> +    #define TARGET_SO_MARK                    36
> +
> +    #define TARGET_SO_TIMESTAMPING            37
> +    #define TARGET_SCM_TIMESTAMPING           TARGET_SO_TIMESTAMPING
> +
> +    #define TARGET_SO_PROTOCOL                38
> +    #define TARGET_SO_DOMAIN                  39
> +
> +    #define TARGET_SO_RXQ_OVFL                40
> +
> +    #define TARGET_SO_WIFI_STATUS             41
> +    #define TARGET_SCM_WIFI_STATUS            TARGET_SO_WIFI_STATUS
> +    #define TARGET_SO_PEEK_OFF                42
> +
> +    #define TARGET_SO_NOFCS                   43
> +    #define TARGET_SO_LOCK_FILTER             44
> +    #define TARGET_SO_SELECT_ERR_QUEUE        45
> +    #define TARGET_SO_BUSY_POLL               46
> +    #define TARGET_SO_MAX_PACING_RATE         47
> +    #define TARGET_SO_BPF_EXTENSIONS          48
> +    #define TARGET_SO_INCOMING_CPU            49
> +    #define TARGET_SO_ATTACH_BPF              50
> +    #define TARGET_SO_DETACH_BPF              TARGET_SO_DETACH_FILTER
> +    #define TARGET_SO_ATTACH_REUSEPORT_CBPF   51
> +    #define TARGET_SO_ATTACH_REUSEPORT_EBPF   52
> +    #define TARGET_SO_CNX_ADVICE              53
> +    #define TARGET_SCM_TIMESTAMPING_OPT_STATS 54
> +    #define TARGET_SO_MEMINFO                 55
> +    #define TARGET_SO_INCOMING_NAPI_ID        56
> +    #define TARGET_SO_COOKIE                  57
> +    #define TARGET_SCM_TIMESTAMPING_PKTINFO   58
> +    #define TARGET_SO_PEERGROUPS              59
> +    #define TARGET_SO_ZEROCOPY                60
>  
> -    #define TARGET_SO_PASSSEC              34
>  #endif
>  
>  #ifndef ARCH_HAS_SOCKET_TYPES
> @@ -94,6 +131,6 @@
>      };
>  
>      #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
> -    #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
> +    #define TARGET_SOCK_TYPE_MASK  0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
>  
>  #endif
> 
