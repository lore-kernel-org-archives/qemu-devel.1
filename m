Received: from eggs.gnu.org ([2001:4830:134:3::10]:42181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZywG-000134-1s
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZywC-0002n2-5N
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:32:20 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:51142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZywB-0002mm-Vs
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:32:16 -0400
Received: by mail-wm0-f54.google.com with SMTP id v25-v6so8120945wmc.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:32:15 -0700 (PDT)
References: <CABgObfazhaOHnDT_Le6aPd0_SNDXOcfQrnj+zU5mf-akmyjNZA@mail.gmail.com>
	<20180630165057.21632-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56a0f77d-7f90-9616-4c3c-c8e5f98a2dd2@redhat.com>
Date: Mon, 2 Jul 2018 15:32:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180630165057.21632-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] !fixup
 052f529eb3d07170b18b8d0920bc8c450e389a2f
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 30/06/2018 18:50, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> This was in e9dd993d-875f-4173-f68e-e6b4e75e3aa1@amsat.org but I can't
> find it on the list...
> 
>  tests/test-cutils.c    | 2 +-
>  tests/test-qemu-opts.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index a6e5fe4984..d85c3e0f6d 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -26,7 +26,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -
> +#include "qemu/units.h"
>  #include "qemu/cutils.h"
>  #include "qemu/units.h"
>  
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index fd4d848f66..43869cb754 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -8,7 +8,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/cutils.h"
> +#include "qemu/units.h"
>  #include "qemu/option.h"
>  #include "qemu/option_int.h"
>  #include "qapi/error.h"
> 

Not enough, this is needed too in order to avoid integer overflows in constant expressions:

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index dce9f7a..09b0ae3 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -462,7 +462,7 @@ static void test_keyval_visit_size(void)
     visit_type_size(v, "sz4", &sz, &error_abort);
     g_assert_cmphex(sz, ==, GiB / 10);
     visit_type_size(v, "sz5", &sz, &error_abort);
-    g_assert_cmphex(sz, ==, 16777215 * TiB);
+    g_assert_cmphex(sz, ==, 16777215ULL * TiB);
     visit_check_struct(v, &error_abort);
     visit_end_struct(v, NULL);
     visit_free(v);
Stage this hunk [y,n,q,a,d,/,e,?]? y

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 43869cb..ef96e84 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -709,7 +709,7 @@ static void test_opts_parse_size(void)
                            false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 2);
     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), ==, GiB / 10);
-    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 16777215U * TiB);
+    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 16777215ULL * TiB);
 
     /* Beyond limit with suffix */
     opts = qemu_opts_parse(&opts_list_02, "size1=16777216T",

Paolo
