Received: from eggs.gnu.org ([2001:4830:134:3::10]:36131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d1Q4R-0002w8-7P
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 00:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d1Q4N-0005Di-AC
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 00:21:23 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d1Q4N-0005Da-5E
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 00:21:19 -0400
Received: by mail-qt0-x241.google.com with SMTP id t52so10534771qtb.3
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 21:21:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170420193616.36780-1-lepton@google.com>
Message-ID: <b31b761d-71e1-c322-5b42-a29cd8882b75@amsat.org>
Date: Fri, 21 Apr 2017 01:21:14 -0300
MIME-Version: 1.0
In-Reply-To: <20170420193616.36780-1-lepton@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/1] Fix wrong mss bug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Wu <ytht.net@gmail.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Tao Wu <lepton@google.com>

Hi Tao,

On 04/20/2017 04:36 PM, Tao Wu wrote:
> This bug was introduced by https://github.com/qemu/qemu/commit/98c6305

Nice catch...

In 98c6305 Guillaume probably missed parentheses :S
- mss = min(IF_MTU, IF_MRU) - sizeof(struct tcpiphdr);
+ mss = min(IF_MTU, IF_MRU) - sizeof(struct tcphdr) + sizeof(struct ip);

This would have been ok:
mss = min(IF_MTU, IF_MRU) - (sizeof(struct tcphdr) + sizeof(struct ip));

"The MSS value to be sent in an MSS option should be equal to the 
effective MTU minus the fixed IP and TCP headers." (RFC6691)

> Signed-off-by: Tao Wu <lepton@google.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  slirp/tcp_input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
> index edb98f06f3..07bcbdb2dd 100644
> --- a/slirp/tcp_input.c
> +++ b/slirp/tcp_input.c
> @@ -1587,11 +1587,11 @@ tcp_mss(struct tcpcb *tp, u_int offer)
>  	switch (so->so_ffamily) {
>  	case AF_INET:
>              mss = MIN(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
> -	                              + sizeof(struct ip);
> +	                              - sizeof(struct ip);
>  	    break;
>  	case AF_INET6:
>              mss = MIN(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
> -	                              + sizeof(struct ip6);
> +	                              - sizeof(struct ip6);
>  	    break;
>  	default:
>  	    g_assert_not_reached();
>
