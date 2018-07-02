Received: from eggs.gnu.org ([2001:4830:134:3::10]:60680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa11L-0007eT-TJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa11I-0000Bj-N1
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:43 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa11I-0000Bb-JN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:40 -0400
Received: by mail-qk0-x243.google.com with SMTP id y4-v6so8883809qka.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:45:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
	<20180702143021.18864-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <871e8f6d-2778-2ade-e1c9-5f0193a53fcd@amsat.org>
Date: Mon, 2 Jul 2018 12:45:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180702143021.18864-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/20] build-system: add clean-coverage
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

Hi Alex,

On 07/02/2018 11:30 AM, Alex Bennée wrote:
> This can be used to remove any stale coverage data before any
> particular test run. This is useful for analysing individual tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> v2
>   - s/to any/to delete any/
> ---
>  Makefile               | 11 +++++++++++
>  docs/devel/testing.rst | 11 ++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7ed9cc4a21..2b3413a5ba 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -723,6 +723,14 @@ module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
>  	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
>  	"GEN","$@")
>  
> +ifdef CONFIG_GCOV
> +.PHONY: clean-coverage
> +clean-coverage:
> +	$(call quiet-command, \
> +		find . \( -name '*.gcda' -o -name '*.gcov' \) -type f -exec rm {} +, \
> +		"CLEAN", "coverage files")

Would "find $(BUILD_DIR) ..." be safer?

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +endif
> +
>  clean:
>  # avoid old build problems by removing potentially incorrect old files
>  	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
> @@ -1073,6 +1081,9 @@ endif
>  		echo '')
>  	@echo  'Cleaning targets:'
>  	@echo  '  clean           - Remove most generated files but keep the config'
> +ifdef CONFIG_GCOV
> +	@echo  '  clean-coverage  - Remove coverage files'
> +endif
>  	@echo  '  distclean       - Remove all generated files'
>  	@echo  '  dist            - Build a distributable tarball'
>  	@echo  ''
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 66ef219f69..7f04ca104e 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -161,9 +161,14 @@ GCC gcov support
>  ``gcov`` is a GCC tool to analyze the testing coverage by
>  instrumenting the tested code. To use it, configure QEMU with
>  ``--enable-gcov`` option and build. Then run ``make check`` as usual.
> -Reports can be obtained by running ``gcov`` command on the output
> -files under ``$build_dir/tests/``, please read the ``gcov``
> -documentation for more information.
> +
> +If you want to gather coverage information on a single test the ``make
> +clean-coverage`` target can be used to delete any existing coverage
> +information before running a single test.
> +
> +Reports can be obtained by running ``gcov`` command
> +on the output files under ``$build_dir/tests/``, please read the
> +``gcov`` documentation for more information.
>  
>  QEMU iotests
>  ============
> 
