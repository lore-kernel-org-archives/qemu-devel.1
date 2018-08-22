Received: from eggs.gnu.org ([2001:4830:134:3::10]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHie-0004jr-7p
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHbi-0004Bx-A0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:06:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsHbi-00047p-0f
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:06:46 -0400
References: <20180818190118.12911-1-richard.henderson@linaro.org>
	<20180818190118.12911-9-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f0aea4d7-54e7-cc8f-898f-b5a3fd8165e1@vivier.eu>
Date: Wed, 22 Aug 2018 03:06:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180818190118.12911-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 08/16] configure: Use
 -Wunused-const-variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 18/08/2018 à 21:01, Richard Henderson a écrit :
> For the linux-user syscall split, we have static const structs
> that must be matched up with a switch statement that uses them.
> By default, gcc will not warn for such a variable, but silently
> remove them.
> 
> For C++, such objects are sometimes declared for their constructor
> side effects.  Do not propagate this flag into QEM_CXXFLAGS.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index db97930314..86e6e18428 100755
> --- a/configure
> +++ b/configure
> @@ -105,7 +105,8 @@ update_cxxflags() {
>      for arg in $QEMU_CFLAGS; do
>          case $arg in
>              -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
> -            -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls)
> +            -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls|\
> +            -Wunused-const-variable)
>                  ;;
>              *)
>                  QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
> @@ -1780,6 +1781,7 @@ gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>  gcc_flags="-Wno-string-plus-int $gcc_flags"
>  gcc_flags="-Wno-error=address-of-packed-member $gcc_flags"
> +gcc_flags="-Wunused-const-variable $gcc_flags"
>  # Note that we do not add -Werror to gcc_flags here, because that would
>  # enable it for all configure tests. If a configure test failed due
>  # to -Werror this would just silently disable some features,
> 

This breaks build of hw/misc/macio/gpio.o:

In file included from include/hw/misc/macio/macio.h:33,
                 from hw/misc/macio/gpio.c:29:
hw/misc/macio/pmu.h:129:21: error: 'pmu_data_len' defined but not used
[-Werror=unused-const-variable=]
 static const int8_t pmu_data_len[256][2] = {
                     ^~~~~~~~~~~~
In file included from include/hw/misc/macio/macio.h:33,
                 from hw/misc/macio/macio.c:33:
include/hw/misc/macio/pmu.h:129:21: error: 'pmu_data_len' defined but
not used [-Werror=unused-const-variable=]
 static const int8_t pmu_data_len[256][2] = {
                     ^~~~~~~~~~~~

This can be fixed by moving pmu_data_len array from pmu.h to pmu.c as it
is the only user.

Thanks,
Laurent
