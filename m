Received: from eggs.gnu.org ([208.118.235.92]:47620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gehBG-0007gn-Bn
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:07:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gehBF-0002FN-KK
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:07:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gehBF-0002EQ-Cy
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:07:33 -0500
References: <20181215120353.82786-1-liq3ea@163.com>
	<20181215120353.82786-4-liq3ea@163.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ed598a9a-ea9d-044e-1677-679a658676b0@redhat.com>
Date: Wed, 2 Jan 2019 15:07:24 +0100
MIME-Version: 1.0
In-Reply-To: <20181215120353.82786-4-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util: check the return value of
 fcntl in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, mst@redhat.com
Cc: lvivier@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org

On 2018-12-15 13:03, Li Qiang wrote:
> Assert that the return value is not an error. This is like commit
> 7e6478e7d4f for qemu_set_cloexec.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
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

Reviewed-by: Thomas Huth <thuth@redhat.com>

Michael, could you take this patch series through your vhost tree? Or
shall I pick them up for the qtests tree? In the latter case, please
provide an ACK for the second patch.
