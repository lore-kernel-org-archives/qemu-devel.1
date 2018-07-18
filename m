Received: from eggs.gnu.org ([2001:4830:134:3::10]:46265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmkf-0000w5-Md
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmka-0004aL-OC
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:44:21 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:40046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmka-0004aD-HR
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:44:16 -0400
Received: by mail-vk0-x242.google.com with SMTP id s23-v6so2507524vks.7
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 06:44:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180718093815.8104-1-berrange@redhat.com>
	<20180718093815.8104-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <38b24622-d0e5-6ee9-24af-e23e2e5a6656@amsat.org>
Date: Wed, 18 Jul 2018 10:44:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180718093815.8104-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.0 2/4] tests: don't silence error
 reporting for all tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Hi Daniel,

On 07/18/2018 06:38 AM, Daniel P. Berrangé wrote:
> The test-vmstate test is a bit chatty because it triggers various
> expected failure scenarios and the code in question uses error_report
> instead of accepting 'Error **errp' parameters. To silence this test the
> stubs for error_vprintf() were changed to send errors via
> g_test_message() instead of stderr:
> 
>   commit 28017e010ddf6849cfa830e898da3e44e6610952
>   Author: Paolo Bonzini <pbonzini@redhat.com>
>   Date:   Mon Oct 24 18:31:03 2016 +0200
> 
>     tests: send error_report to test log
> 
>     Implement error_vprintf to send the output of error_report to
>     the test log.  This silences test-vmstate.
> 
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>     Message-Id: <1477326663-67817-3-git-send-email-pbonzini@redhat.com>
> 
> Unfortunately this change has global impact across the entire test suite
> and means that when tests fail for unexpected reasons, the message is
> not displayed on stderr. eg when using &error_abort in a call the test
> merely prints
> 
>   Unexpected error in qcrypto_tls_session_check_certificate() at crypto/tlssession.c:280:
> 
> and the actual error message is hidden, making it impossible to diagnose
> the failure. This is especially problematic in CI or build systems where
> it isn't possible to easily pass the --debug-log flag to tests and
> re-run with the test log visible.
> 
> This change makes the previous big hammer much more nuanced, providing a
> flag in the stub error_vprintf() that can used on a per-test basis to
> silence the errors. Only the test-vmstate silences errors initially.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  stubs/error-printf.c | 5 ++++-
>  tests/test-vmstate.c | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/stubs/error-printf.c b/stubs/error-printf.c
> index ac6b92aa69..2199d79d28 100644
> --- a/stubs/error-printf.c
> +++ b/stubs/error-printf.c
> @@ -2,9 +2,12 @@
>  #include "qemu-common.h"
>  #include "qemu/error-report.h"
>  
> +bool silence_test_errors;

This is not used.

> +
>  void error_vprintf(const char *fmt, va_list ap)
>  {
> -    if (g_test_initialized() && !g_test_subprocess()) {
> +    if (g_test_initialized() && !g_test_subprocess() &&
> +        getenv("QTEST_SILENT_ERRORS")) {
>          char *msg = g_strdup_vprintf(fmt, ap);
>          g_test_message("%s", msg);
>          g_free(msg);
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index 087844b6c8..42923bb1df 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -32,6 +32,7 @@
>  #include "../migration/qemu-file-channel.h"
>  #include "../migration/savevm.h"
>  #include "qemu/coroutine.h"
> +#include "qemu/error-report.h"

Why? This doesn't seem necessary, neither related to this patch.

>  #include "io/channel-file.h"
>  
>  static char temp_file[] = "/tmp/vmst.test.XXXXXX";
> @@ -859,6 +860,8 @@ int main(int argc, char **argv)
>  
>      module_call_init(MODULE_INIT_QOM);
>  
> +    setenv("QTEST_SILENT_ERRORS", "1", 1);
> +
>      g_test_init(&argc, &argv, NULL);
>      g_test_add_func("/vmstate/simple/primitive", test_simple_primitive);
>      g_test_add_func("/vmstate/versioned/load/v1", test_load_v1);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
