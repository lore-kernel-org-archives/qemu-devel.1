Received: from eggs.gnu.org ([2001:4830:134:3::10]:57242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eHz-00074b-Je
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eHw-0005H6-Cx
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:09:23 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eHw-0005H0-8W
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:09:20 -0400
Received: by mail-qt0-x244.google.com with SMTP id l39so11001955qtb.1
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 14:09:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170513004616.25749-1-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <056c1582-e264-ca47-520d-c14c4cface05@amsat.org>
Date: Sat, 13 May 2017 18:09:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170513004616.25749-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 05/12/2017 09:46 PM, Kamil Rytarowski wrote:
> ivshmem-server makes use of the POSIX shared memory object interfaces.
> This library is provided on NetBSD in -lrt (POSIX Real-time Library).
> Add ./configure check if there is needed -lrt linking for shm_open()
> and if so use it. Introduce new configure generated variable LIBS_SHMLIB.
>
> This fixes build issue on NetBSD.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
