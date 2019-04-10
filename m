Received: from eggs.gnu.org ([209.51.188.92]:49568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAQp-00034I-EC
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAQo-0000Pk-Eb
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:26:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEAQo-0000OB-4u
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:26:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so2012946wma.2
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 03:26:14 -0700 (PDT)
References: <20190409230022.6462-1-lersek@redhat.com>
	<20190409230022.6462-11-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <061dcac9-82a2-8a48-3c7f-8c8375d81abe@redhat.com>
Date: Wed, 10 Apr 2019 12:26:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190409230022.6462-11-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 10/12] tests: add missing
 dependency to build QTEST_QEMU_BINARY, round 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

On 4/10/19 1:00 AM, Laszlo Ersek wrote:
> In commit b94b330e2333 ("tests: add missing dependency to build
> QTEST_QEMU_BINARY", 2017-07-31), Phil fixed the dependency list of make
> target "check-qtest-%". Namely, the recipe would set QTEST_QEMU_BINARY to
> the softmmu emulator for the emulation target, but the prerequisites
> didn't include the emulator.
> 
> The same issue affects the "check-report-qtest-%.tap" make target, which
> is the other make target whose recipe sets QTEST_QEMU_BINARY:
> 
>> $ make -j4 check-report-qtest-aarch64.tap
>>   TAP     check-report-qtest-aarch64.tap
>> sh: /.../aarch64-softmmu/qemu-system-aarch64: No such file or directory
> 
> Apply Phil's fix to this make target too.
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Tested-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Notes:
>     v4:
>     
>     - no change
>     
>     v3:
>     
>     - pick up Michal's R-b
>     
>     - pick up Igor's T-b
>     
>     - pick up Michael's R-b
>     
>     v2:
>     
>     - new patch, relied upon by the next patch
> 
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 36fc73fef55a..e2432d5e7712 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -912,7 +912,7 @@ check-speed: $(check-speed-y)
>  
>  # gtester tests with TAP output
>  
> -$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qtest-%.tap: $(check-qtest-y)
> +$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qtest-%.tap: subdir-%-softmmu $(check-qtest-y)
>  	$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
>  	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
>  	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
> 
