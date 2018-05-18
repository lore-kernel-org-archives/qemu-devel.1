Received: from eggs.gnu.org ([2001:4830:134:3::10]:55678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJkTA-0000N4-Kp
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJkT6-0001Oc-LR
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:51:12 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJkT6-0001NV-BN
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:51:08 -0400
References: <20180518184715.29833-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <99317bf1-5734-96cb-cbcd-2852b3b9b03a@vivier.eu>
Date: Fri, 18 May 2018 20:50:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180518184715.29833-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix payload size logic in
 host_to_target_cmsg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>

Le 18/05/2018 à 20:47, Peter Maydell a écrit :
> Coverity points out that there's a missing break in the switch in
> host_to_target_cmsg() where we update tgt_len for
> cmsg_level/cmsg_type combinations which require a different length
> for host and target (CID 1385425).  To avoid duplicating the default
> case (target length same as host) in both switches, set that before
> the switch so that only the cases which want to override it need any
> code.
> 
> This fixes a bug where we would have used the wrong length
> for SOL_SOCKET/SO_TIMESTAMP messages where the target and
> host have differently sized 'struct timeval' (ie one is 32
> bit and the other is 64 bit).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index af8603f1b7..88d166cdff 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1825,6 +1825,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>          /* Payload types which need a different size of payload on
>           * the target must adjust tgt_len here.
>           */
> +        tgt_len = len;
>          switch (cmsg->cmsg_level) {
>          case SOL_SOCKET:
>              switch (cmsg->cmsg_type) {
> @@ -1834,8 +1835,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>              default:
>                  break;
>              }
> +            break;
>          default:
> -            tgt_len = len;
>              break;
>          }
>  
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
