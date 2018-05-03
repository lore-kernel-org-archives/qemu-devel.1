Received: from eggs.gnu.org ([2001:4830:134:3::10]:51471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKke-0005E2-Jz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKkd-0005ho-Kj
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:22:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEKkd-0005gu-EQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:22:51 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-68-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f66f1d0-b6ef-82e6-0451-533159d6cd24@redhat.com>
Date: Thu, 3 May 2018 15:22:39 -0500
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-68-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 67/67] make: simplify source include path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=83=c2=a9?= <f4bug@amsat.org>, Yang Zhong <yang.zhong@intel.com>, Richard Henderson <richard.henderson@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>

On 05/03/2018 02:51 PM, Michael S. Tsirkin wrote:
> Include all files in the source directory through include/ directory.
> This helps ensure consistent naming and makes it easier to locate any
> specific header.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   configure       | 3 +--
>   Makefile.target | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 0a19b03..3d5d2b9 100755
> --- a/configure
> +++ b/configure
> @@ -534,7 +534,7 @@ QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
>   QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
>   QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
>   QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
> -QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH) -iquote \$(SRC_PATH)/accel/tcg -iquote \$(SRC_PATH)/include"
> +QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH)/include"

I think this is a nice cleanup.

>   if test "$debug_info" = "yes"; then
>       CFLAGS="-g $CFLAGS"
>       LDFLAGS="-g $LDFLAGS"
> @@ -6631,7 +6631,6 @@ elif test "$ARCH" = "ppc64" ; then
>   else
>     QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"

Should you also be cleaning up this line?

>   fi
> -QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg $QEMU_INCLUDES"
>   
>   echo "TOOLS=$tools" >> $config_host_mak
>   echo "ROMS=$roms" >> $config_host_mak
> diff --git a/Makefile.target b/Makefile.target
> index d0ec77a..b6605ed 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -11,7 +11,7 @@ $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
>   ifdef CONFIG_LINUX
>   QEMU_CFLAGS += -I../linux-headers
>   endif
> -QEMU_CFLAGS += -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
> +QEMU_CFLAGS += -iquote .. -iquote $(SRC_PATH)/include/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
>   
>   QEMU_CFLAGS+=-iquote $(SRC_PATH)/include
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
