Received: from eggs.gnu.org ([2001:4830:134:3::10]:53317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXO5v-0004lf-UD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXO5s-0007Pr-OG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:19:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gXO5s-0007P6-IH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:19:48 -0500
Date: Thu, 13 Dec 2018 10:19:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181213101940.GC5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Dec 12, 2018 at 06:09:37PM -0800, Li Qiang wrote:
> Assert that the return value is not an error. This is like commit
> 7e6478e7d4f for qemu_set_cloexec.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  util/oslib-posix.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index c1bee2a581..4ce1ba9ca4 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -233,14 +233,18 @@ void qemu_set_block(int fd)
>  {
>      int f;
>      f = fcntl(fd, F_GETFL);
> -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> +    assert(f != -1);

This leads to *awful* diagnostics. We need to print something
useful when it fails so we stand a chance of understanding what
is wrong.

   if (fcntl(fd, F_SETFL, f & ~O_NONBLOCK) < 0) {
       error_report("Unable to set blocking flag on fd %d: %s (errno=%d)",
                    fd, strerror(errno), errno));
       abort();
   }


> +    f = fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> +    assert(f != -1);
>  }
>  
>  void qemu_set_nonblock(int fd)
>  {
>      int f;
>      f = fcntl(fd, F_GETFL);
> -    fcntl(fd, F_SETFL, f | O_NONBLOCK);
> +    assert(f != -1);
> +    f = fcntl(fd, F_SETFL, f | O_NONBLOCK);
> +    assert(f != -1);
>  }
>  
>  int socket_set_fast_reuse(int fd)
> -- 
> 2.11.0
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
