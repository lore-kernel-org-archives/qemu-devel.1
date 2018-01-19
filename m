Received: from eggs.gnu.org ([2001:4830:134:3::10]:44980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecZbG-0004RM-Fm
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecZbC-000607-Di
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:33:06 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:63963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ecZbC-0005ye-4S
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:33:02 -0500
References: <1513345976-22958-1-git-send-email-peter.maydell@linaro.org>
	<1513345976-22958-2-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f927cc83-fb77-1230-e4f6-ceeb08315b68@vivier.eu>
Date: Fri, 19 Jan 2018 17:32:50 +0100
MIME-Version: 1.0
In-Reply-To: <1513345976-22958-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: Fix length calculations in
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Bruno Haible <bruno@clisp.org>, patches@linaro.org

Le 15/12/2017 à 14:52, Peter Maydell a écrit :
> The handling of length calculations in host_to_target_cmsg()
> was rather confused:
>  * when checking for whether the target cmsg header fit in
>    the remaining buffer, we were using the host struct size,
>    not the target size
>  * we were setting tgt_len to "target payload + header length"
>    but then using it as if it were the target payload length alone
>  * in various message type cases we weren't handling the possibility
>    that host or target buffers were truncated
> 
> Fix these problems. The second one in particular is liable
> to result in us overrunning the guest provided buffer,
> since we will try to convert more data than is actually
> present.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1701808
> Reported-by: Bruno Haible  <bruno@clisp.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 11c9116..a1b9772 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1782,7 +1782,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>           * to the guest via the CTRUNC bit), unlike truncation
>           * in target_to_host_cmsg, which is a QEMU bug.
>           */
> -        if (msg_controllen < sizeof(struct cmsghdr)) {
> +        if (msg_controllen < sizeof(struct target_cmsghdr)) {
>              target_msgh->msg_flags |= tswap32(MSG_CTRUNC);
>              break;
>          }
> @@ -1794,8 +1794,6 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>          }
>          target_cmsg->cmsg_type = tswap32(cmsg->cmsg_type);
>  
> -        tgt_len = TARGET_CMSG_LEN(len);
> -
>          /* Payload types which need a different size of payload on
>           * the target must adjust tgt_len here.
>           */
> @@ -1809,12 +1807,13 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>                  break;
>              }
>          default:
> +            tgt_len = len;
>              break;
>          }
>  
> -        if (msg_controllen < tgt_len) {
> +        if (msg_controllen < TARGET_CMSG_LEN(tgt_len)) {
>              target_msgh->msg_flags |= tswap32(MSG_CTRUNC);
> -            tgt_len = msg_controllen;
> +            tgt_len = msg_controllen - sizeof(struct target_cmsghdr);
>          }
>  
>          /* We must now copy-and-convert len bytes of payload
> @@ -1875,6 +1874,10 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>                  uint32_t *v = (uint32_t *)data;
>                  uint32_t *t_int = (uint32_t *)target_data;
>  
> +                if (len != sizeof(uint32_t) ||
> +                    tgt_len != sizeof(uint32_t)) {
> +                    goto unimplemented;
> +                }
>                  __put_user(*v, t_int);
>                  break;
>              }
> @@ -1888,6 +1891,10 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>                  struct errhdr_t *target_errh =
>                      (struct errhdr_t *)target_data;
>  
> +                if (len != sizeof(struct errhdr_t) ||
> +                    tgt_len != sizeof(struct errhdr_t)) {
> +                    goto unimplemented;
> +                }
>                  __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
>                  __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
>                  __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
> @@ -1911,6 +1918,10 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>                  uint32_t *v = (uint32_t *)data;
>                  uint32_t *t_int = (uint32_t *)target_data;
>  
> +                if (len != sizeof(uint32_t) ||
> +                    tgt_len != sizeof(uint32_t)) {
> +                    goto unimplemented;
> +                }
>                  __put_user(*v, t_int);
>                  break;
>              }
> @@ -1924,6 +1935,10 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>                  struct errhdr6_t *target_errh =
>                      (struct errhdr6_t *)target_data;
>  
> +                if (len != sizeof(struct errhdr6_t) ||
> +                    tgt_len != sizeof(struct errhdr6_t)) {
> +                    goto unimplemented;
> +                }
>                  __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
>                  __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
>                  __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
> @@ -1950,8 +1965,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>              }
>          }
>  
> -        target_cmsg->cmsg_len = tswapal(tgt_len);
> -        tgt_space = TARGET_CMSG_SPACE(len);
> +        target_cmsg->cmsg_len = tswapal(TARGET_CMSG_LEN(tgt_len));
> +        tgt_space = TARGET_CMSG_SPACE(tgt_len);
>          if (msg_controllen < tgt_space) {
>              tgt_space = msg_controllen;
>          }
> 

Applied to my linux-user branch.

Thanks,
Laurent
