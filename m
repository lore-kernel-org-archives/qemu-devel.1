Received: from eggs.gnu.org ([2001:4830:134:3::10]:43771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNJ3j-0005WE-JS
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNJ3e-000119-H2
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:55:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gNJ3e-0000y1-B1
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:55:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so19198816wma.4
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:55:44 -0800 (PST)
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-10-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cc305bf4-fe14-89c0-79f3-a2051086e5f0@redhat.com>
Date: Thu, 15 Nov 2018 15:55:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181115143124.19234-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/10] vhost-user-test: small changes to
 init_hugepagefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, jasowang@redhat.com, mst@redhat.com

Hi Paolo,

On 15/11/18 15:31, Paolo Bonzini wrote:
> After the conversion to qgraph, the equivalent of "main" will be in
> a constructor and will run even if the tests are not being requested.
> Therefore, it should not assert that init_hugepagefs succeeds and will
> be called when creating the TestServer.  This patch changes the prototype
> of init_hugepagefs, this way the next patch looks nicer.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/vhost-user-test.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 93d5157b13..a282fc57c8 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -461,13 +461,19 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>       g_mutex_unlock(&s->data_mutex);
>   }
>   
> -static const char *init_hugepagefs(const char *path)
> +static const char *init_hugepagefs(void)
>   {
> +    const char *path = getenv("QTEST_HUGETLBFS_PATH");
>       struct statfs fs;
>       int ret;
>   
> +    if (!path) {
> +        return NULL;
> +    }
> +
>       if (access(path, R_OK | W_OK | X_OK)) {
>           g_test_message("access on path (%s): %s\n", path, strerror(errno));
> +        abort();
>           return NULL;

Can we remove the 'return NULL's now?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>       }
>   
> @@ -477,11 +483,13 @@ static const char *init_hugepagefs(const char *path)
>   
>       if (ret != 0) {
>           g_test_message("statfs on path (%s): %s\n", path, strerror(errno));
> +        abort();
>           return NULL;
>       }
>   
>       if (fs.f_type != HUGETLBFS_MAGIC) {
>           g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
> +        abort();
>           return NULL;
>       }
>   
> @@ -974,7 +982,6 @@ static void test_multiqueue(void)
>   
>   int main(int argc, char **argv)
>   {
> -    const char *hugefs;
>       int ret;
>       char template[] = "/tmp/vhost-test-XXXXXX";
>   
> @@ -989,13 +996,7 @@ int main(int argc, char **argv)
>       }
>       g_assert(tmpfs);
>   
> -    hugefs = getenv("QTEST_HUGETLBFS_PATH");
> -    if (hugefs) {
> -        root = init_hugepagefs(hugefs);
> -        g_assert(root);
> -    } else {
> -        root = tmpfs;
> -    }
> +    root = init_hugepagefs() ? : tmpfs;
>   
>       if (qemu_memfd_check(0)) {
>           qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
> 
