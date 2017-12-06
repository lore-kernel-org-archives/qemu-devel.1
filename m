Received: from eggs.gnu.org ([2001:4830:134:3::10]:38722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMWuC-0004yO-Qx
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMWu7-0005CA-SF
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:26:20 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eMWu7-0005Bf-J1
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:26:15 -0500
Received: by mail-wr0-x241.google.com with SMTP id v22so3338947wrb.0
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 02:26:15 -0800 (PST)
References: <1512397331-15238-1-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1512397331-15238-1-git-send-email-peter.maydell@linaro.org>
Date: Wed, 06 Dec 2017 10:26:12 +0000
Message-ID: <87zi6wqhiz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix locking order in
 fork_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, qemu-stable@nongnu.org, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Our locking order is that the tb lock should be taken
> inside the mmap_lock, but fork_start() grabs locks the
> other way around. This means that if a heavily multithreaded
> guest process (such as Java) calls fork() it can deadlock,
> with the thread that called fork() stuck in fork_start()
> with the tb lock and waiting for the mmap lock, but some
> other thread in tb_find() with the mmap lock and waiting
> for the tb lock. The cpu_list_lock() should also always be
> taken last, not first.
>
> Fix this by making fork_start() grab the locks in the
> right order. The order in which we drop locks doesn't
> matter, so we leave fork_end() the way it is.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>  linux-user/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 6286661..146ee3e 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -128,9 +128,9 @@ int cpu_get_pic_interrupt(CPUX86State *env)
>  /* Make sure everything is in a consistent state for calling fork().  */
>  void fork_start(void)
>  {
> -    cpu_list_lock();
> -    qemu_mutex_lock(&tb_ctx.tb_lock);
>      mmap_fork_start();
> +    qemu_mutex_lock(&tb_ctx.tb_lock);
> +    cpu_list_lock();
>  }
>
>  void fork_end(int child)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
