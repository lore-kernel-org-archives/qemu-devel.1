Received: from eggs.gnu.org ([2001:4830:134:3::10]:41911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAtOI-00062g-TD
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAtOE-0005tJ-Cu
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:29:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAtOE-0005t4-4J
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:28:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170513004616.25749-1-n54@gmx.com>
Date: Wed, 17 May 2017 09:28:47 +0200
In-Reply-To: <20170513004616.25749-1-n54@gmx.com> (Kamil Rytarowski's message
	of "Sat, 13 May 2017 02:46:16 +0200")
Message-ID: <87a86crlg0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: Detect and use if there is
 required -lrt linking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

Kamil Rytarowski <n54@gmx.com> writes:

> ivshmem-server makes use of the POSIX shared memory object interfaces.
> This library is provided on NetBSD in -lrt (POSIX Real-time Library).
> Add ./configure check if there is needed -lrt linking for shm_open()
> and if so use it. Introduce new configure generated variable LIBS_SHMLIB.
>
> This fixes build issue on NetBSD.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  Makefile  |  1 +
>  configure | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 31d41a7eae..3248cb53d7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -473,6 +473,7 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
> +ivshmem-server$(EXESUF): LIBS += $(LIBS_SHMLIB)
>  
>  module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
>  	$(call quiet-command,$(PYTHON) $< $@ \
> diff --git a/configure b/configure
> index 7c020c076b..50c3aee746 100755
> --- a/configure
> +++ b/configure
> @@ -179,6 +179,7 @@ audio_pt_int=""
>  audio_win_int=""
>  cc_i386=i386-pc-linux-gnu-gcc
>  libs_qga=""
> +libs_shmlib=""
>  debug_info="yes"
>  stack_protector=""
>  
> @@ -4133,6 +4134,24 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
>    libs_qga="$libs_qga -lrt"
>  fi
>  
> +##########################################
> +# Do we need librt for shm_open()
> +cat > $TMPC <<EOF
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <stddef.h>
> +int main(void) {
> +  return shm_open(NULL, O_RDWR, 0644);
> +}
> +EOF
> +
> +if compile_prog "" "" ; then
> +  :
> +elif compile_prog "" "-lrt" ; then
> +  libs_shmlib="$libs_shmlib -lrt"
> +fi
> +
>  if test "$darwin" != "yes" -a "$mingw32" != "yes" -a "$solaris" != yes -a \
>          "$aix" != "yes" -a "$haiku" != "yes" ; then
>      libs_softmmu="-lutil $libs_softmmu"
> @@ -5949,6 +5968,7 @@ echo "EXESUF=$EXESUF" >> $config_host_mak
>  echo "DSOSUF=$DSOSUF" >> $config_host_mak
>  echo "LDFLAGS_SHARED=$LDFLAGS_SHARED" >> $config_host_mak
>  echo "LIBS_QGA+=$libs_qga" >> $config_host_mak
> +echo "LIBS_SHMLIB+=$libs_shmlib" >> $config_host_mak
>  echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
>  echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
>  echo "POD2MAN=$POD2MAN" >> $config_host_mak

We already have a test for -lrt.  It looks for timer_create() and
clock_gettime().  If we need -lrt, we add it to LIBS and to LIBS_QGA.
The latter because we don't use LIBS for qemu-ga:

    qemu-ga$(EXESUF): LIBS = $(LIBS_QGA)

This patch adds a second test for -lrt, to look for shm_open().  It adds
-lrt to new variable LIBS_SHMLIB, which gets used only for
ivshmem-server:

    ivshmem-server$(EXESUF): LIBS += $(LIBS_SHMLIB)

Note that ivshmem-server already uses LIBS.

Shouldn't we instead widen the existing test for -lrt to cover
shm_open()?

Can you confirm that the existing test does not add -lrt to LIBS on
NetBSD?

tests/ivshmem-test.c also calls shm_open().  Does it work on NetBSD?
