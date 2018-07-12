Received: from eggs.gnu.org ([2001:4830:134:3::10]:49955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fde6c-00022t-TG
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fde6X-0000Or-UO
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:06:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fde6X-0000KJ-Ke
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:06:05 -0400
References: <5271d71e-794c-2db0-9046-183fd79dd902@amsat.org>
	<20180711221244.31869-1-jonasschievink@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5701803b-7f38-2539-fd08-6706d624271d@vivier.eu>
Date: Thu, 12 Jul 2018 18:05:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180711221244.31869-1-jonasschievink@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] Zero out the host's `msg_control` buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonas Schievink <jonasschievink@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org

Le 12/07/2018 à 00:12, Jonas Schievink a écrit :
> If this is not done, qemu would drop any control message after the first
> one.
> 
> This is because glibc's `CMSG_NXTHDR` macro accesses the uninitialized
> cmsghdr's length field in order to find out if the message fits into the
> `msg_control` buffer, wrongly assuming that it doesn't because the
> length field contains garbage. Accessing the length field is fine for
> completed messages we receive from the kernel, but is - as far as I know
> - not needed since the kernel won't return such an invalid cmsghdr in
> the first place.
> 
> This is tracked as this glibc bug:
> https://sourceware.org/bugzilla/show_bug.cgi?id=13500
> 
> It's probably also a good idea to bail with an error if `CMSG_NXTHDR`
> returns NULL but `TARGET_CMSG_NXTHDR` doesn't (ie. we still expect
> cmsgs).
> 
> Signed-off-by: Jonas Schievink <jonasschievink@gmail.com>
> ---
> Changes in v2:
> - put the memset right after the msg_control alloca
> - added missing Signed-off-by line
> 
>  linux-user/syscall.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e4b1b7d7da..3c427500ef 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3843,6 +3843,8 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
>      }
>      msg.msg_controllen = 2 * tswapal(msgp->msg_controllen);
>      msg.msg_control = alloca(msg.msg_controllen);
> +    memset(msg.msg_control, 0, msg.msg_controllen);
> +

I'm not sure it is needed as the content of msg.control will be
overwritten by target_to_host_cmsg() from the content of msgp->control.

Do you have a test case revealing the bug?

Thanks,
Laurent
