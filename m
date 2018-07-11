Received: from eggs.gnu.org ([2001:4830:134:3::10]:37453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdM83-0007l8-5W
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdM7z-0003Ud-GO
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:54:27 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:45510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdM7z-0003UN-AP
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:54:23 -0400
Received: by mail-qk0-x244.google.com with SMTP id c192-v6so14397623qkg.12
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 13:54:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180710233229.9311-1-jonasschievink@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5271d71e-794c-2db0-9046-183fd79dd902@amsat.org>
Date: Wed, 11 Jul 2018 17:54:17 -0300
MIME-Version: 1.0
In-Reply-To: <20180710233229.9311-1-jonasschievink@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Zero out the host's `msg_control` buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonas Schievink <jonasschievink@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Hi Jonas,

You forgot to notify the maintainers, see
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer :

./scripts/get_maintainer.pl -f linux-user/syscall.c
Riku Voipio <riku.voipio@iki.fi> (maintainer:Linux user)
Laurent Vivier <laurent@vivier.eu> (reviewer:Linux user)
qemu-devel@nongnu.org (open list:All patches CC here)

On 07/10/2018 08:32 PM, Jonas Schievink wrote:
> (Apparently I messed up my git config for the last email so it didn't
> send the correct name - please bear with me, this is my first time
> submitting a patch to a mailing list. I've also added a link to the
> upstream bug in the commit description.)
> 
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

This misses your Signed-off-by:

https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line

> ---
>  linux-user/syscall.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e4b1b7d7da..77ce173b27 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3845,6 +3845,8 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
>      msg.msg_control = alloca(msg.msg_controllen);
>      msg.msg_flags = tswap32(msgp->msg_flags);
>  
> +    memset(msg.msg_control, 0, msg.msg_controllen);
> +
>      count = tswapal(msgp->msg_iovlen);
>      target_vec = tswapal(msgp->msg_iov);

Do you mind swapping:

>      msg.msg_control = alloca(msg.msg_controllen);
> +    memset(msg.msg_control, 0, msg.msg_controllen);
> +
>      msg.msg_flags = tswap32(msgp->msg_flags);

With your Signed-off-by:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
