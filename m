Received: from eggs.gnu.org ([2001:4830:134:3::10]:56732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMUZ2-0004Ie-1j
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMUYx-0001Ja-75
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:56:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMUYw-0001JD-VK
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:56:15 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so5571597wme.5
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 23:56:14 -0800 (PST)
References: <1512397331-15238-1-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5785c05c-1a81-bc60-0e33-b698b6f56b99@redhat.com>
Date: Wed, 6 Dec 2017 08:56:11 +0100
MIME-Version: 1.0
In-Reply-To: <1512397331-15238-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, qemu-stable@nongnu.org, patches@linaro.org

On 04/12/2017 15:22, Peter Maydell wrote:
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
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
