Received: from eggs.gnu.org ([2001:4830:134:3::10]:44072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrrg-0000qh-2Q
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrrc-0001XM-SG
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:47:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYrrc-0001WU-Ls
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:46:56 -0400
Date: Fri, 29 Jun 2018 12:46:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629114651.GN27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625111935.26108-1-alex.bennee@linaro.org>
	<20180625111935.26108-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625111935.26108-8-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 07/10] build-system: add clean-coverage
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, famz@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Mon, Jun 25, 2018 at 12:19:32PM +0100, Alex Benn=C3=A9e wrote:
> This can be used to remove any stale coverage data before any
> particular test run. This is useful for analysing individual tests.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  Makefile               | 11 +++++++++++
>  docs/devel/testing.rst | 11 ++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 7ed9cc4a21..2b3413a5ba 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -723,6 +723,14 @@ module_block.h: $(SRC_PATH)/scripts/modules/module=
_block.py config-host.mak
>  	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
>  	"GEN","$@")
> =20
> +ifdef CONFIG_GCOV
> +.PHONY: clean-coverage
> +clean-coverage:
> +	$(call quiet-command, \
> +		find . \( -name '*.gcda' -o -name '*.gcov' \) -type f -exec rm {} +,=
 \
> +		"CLEAN", "coverage files")
> +endif
> +
>  clean:
>  # avoid old build problems by removing potentially incorrect old files
>  	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.=
h gen-op-arm.h
> @@ -1073,6 +1081,9 @@ endif
>  		echo '')
>  	@echo  'Cleaning targets:'
>  	@echo  '  clean           - Remove most generated files but keep the =
config'
> +ifdef CONFIG_GCOV
> +	@echo  '  clean-coverage  - Remove coverage files'
> +endif
>  	@echo  '  distclean       - Remove all generated files'
>  	@echo  '  dist            - Build a distributable tarball'
>  	@echo  ''
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 66ef219f69..a3652aea14 100644
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
> +clean-coverage`` target can be used to any existing coverage

s/to any/to delete any/

> +information before running a single test.
> +
> +Reports can be obtained by running ``gcov`` command
> +on the output files under ``$build_dir/tests/``, please read the
> +``gcov`` documentation for more information.

With the typo fixed

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
