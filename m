Received: from eggs.gnu.org ([2001:4830:134:3::10]:46285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnkw5-00023b-DD
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnkw1-0001ll-50
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:20:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnkw0-0001lb-SJ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE40C25C25
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:20:27 +0000 (UTC)
Date: Fri, 1 Sep 2017 13:20:21 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901122021.GN31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170901115500.12654-1-quintela@redhat.com>
	<20170901115500.12654-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901115500.12654-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] tests: Use real size for iov tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Fri, Sep 01, 2017 at 01:54:59PM +0200, Juan Quintela wrote:
> We were using -1 instead of the real size because the functions check
> what is bigger, size in bytes or the size of the iov.  Recent gcc's
> barf at this.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> --
> 
> Remove comments about this feature.
> Fix missing -1.
> ---
>  include/qemu/iov.h |  6 ------
>  tests/test-iov.c   | 10 +++++-----
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> index bd9fd55b0a..72d4c559b4 100644
> --- a/include/qemu/iov.h
> +++ b/include/qemu/iov.h
> @@ -31,11 +31,6 @@ size_t iov_size(const struct iovec *iov, const unsigned int iov_cnt);
>   * Number of bytes actually copied will be returned, which is
>   *  min(bytes, iov_size(iov)-offset)
>   * `Offset' must point to the inside of iovec.
> - * It is okay to use very large value for `bytes' since we're
> - * limited by the size of the iovec anyway, provided that the
> - * buffer pointed to by buf has enough space.  One possible
> - * such "large" value is -1 (sinice size_t is unsigned),
> - * so specifying `-1' as `bytes' means 'up to the end of iovec'.
>   */
>  size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
>                           size_t offset, const void *buf, size_t bytes);
> @@ -76,7 +71,6 @@ iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
>   * up to the end of it, will be filled with the specified value.
>   * Function return actual number of bytes processed, which is
>   * min(size, iov_size(iov) - offset).
> - * Again, it is okay to use large value for `bytes' to mean "up to the end".
>   */
>  size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
>                    size_t offset, int fillc, size_t bytes);

I'm not sure its right to be removing these comments, unless you've
audited the code to ensure no caller outside the test suite is
relying on this documented behaviour.

> diff --git a/tests/test-iov.c b/tests/test-iov.c
> index fa3d75aee1..458ca25099 100644
> --- a/tests/test-iov.c
> +++ b/tests/test-iov.c
> @@ -81,17 +81,17 @@ static void test_to_from_buf_1(void)
>            * skip whole vector and process exactly 0 bytes */
>  
>           /* first set bytes [i..sz) to some "random" value */
> -         n = iov_memset(iov, niov, 0, 0xff, -1);
> +         n = iov_memset(iov, niov, 0, 0xff, sz);
>           g_assert(n == sz);
>  
>           /* next copy bytes [i..sz) from ibuf to iovec */
> -         n = iov_from_buf(iov, niov, i, ibuf + i, -1);
> +         n = iov_from_buf(iov, niov, i, ibuf + i, sz - i);
>           g_assert(n == sz - i);
>  
>           /* clear part of obuf */
>           memset(obuf + i, 0, sz - i);
>           /* and set this part of obuf to values from iovec */
> -         n = iov_to_buf(iov, niov, i, obuf + i, -1);
> +         n = iov_to_buf(iov, niov, i, obuf + i, sz - i);
>           g_assert(n == sz - i);
>  
>           /* now compare resulting buffers */
> @@ -109,7 +109,7 @@ static void test_to_from_buf_1(void)
>                * with j in [i..sz]. */
>  
>               /* clear iovec */
> -             n = iov_memset(iov, niov, 0, 0xff, -1);
> +             n = iov_memset(iov, niov, 0, 0xff, sz);
>               g_assert(n == sz);
>  
>               /* copy bytes [i..j) from ibuf to iovec */
> @@ -225,7 +225,7 @@ static void test_io(void)
>         for (i = 0; i <= sz; ++i) {
>             for (j = i; j <= sz; ++j) {
>                 k = i;
> -               iov_memset(iov, niov, 0, 0xff, -1);
> +               iov_memset(iov, niov, 0, 0xff, sz);
>                 do {
>                     s = g_test_rand_int_range(0, j - k + 1);
>                     r = iov_recv(sv[0], iov, niov, k, s);

For the test-iov.c changes though you can have

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
