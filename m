Received: from eggs.gnu.org ([2001:4830:134:3::10]:39067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhvvR-00029Y-6H
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhvvO-0008L5-4b
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:51:49 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhvvN-0008Ji-U7
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:51:46 -0400
Received: by mail-wr0-f169.google.com with SMTP id 49so3433273wrw.2
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 03:51:43 -0700 (PDT)
References: <20170816082650.21880-1-cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
Date: Wed, 16 Aug 2017 12:51:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170816082650.21880-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] boot-serial-test: prefer tcg
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, richard.henderson@linaro.org

On 16/08/2017 10:26, Cornelia Huck wrote:
> Prefer to use the tcg accelarator if it is available: This is our only
> real smoke test for tcg, and fast enough to use it for that.

I'm not sure this is required for 2.10.  Yes, it means the coverage from
"make check" is worse, but that's it.

Paolo

> Fixes: 480bc11e6 ("boot-serial-test: fallback to kvm accelerator")
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  tests/boot-serial-test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index a8ca877168..b95c5e74ea 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -78,7 +78,11 @@ static void test_machine(const void *data)
>      fd = mkstemp(tmpname);
>      g_assert(fd != -1);
>  
> -    args = g_strdup_printf("-M %s,accel=kvm:tcg "
> +    /*
> +     * Make sure that this test uses tcg if available: It is used as a
> +     * fast-enough smoketest for that.
> +     */
> +    args = g_strdup_printf("-M %s,accel=tcg:kvm "
>                             "-chardev file,id=serial0,path=%s "
>                             "-no-shutdown -serial chardev:serial0 %s",
>                             test->machine, tmpname, test->extra);
> 
