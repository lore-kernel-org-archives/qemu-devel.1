Received: from eggs.gnu.org ([2001:4830:134:3::10]:43024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9Y6z-0006vE-Q7
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9Y6v-0000fO-LW
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:38:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f9Y6v-0000Yf-DH
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:38:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D555581A88BC
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 15:38:04 +0000 (UTC)
References: <20180420104743.7396-1-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3f72757a-4b4c-9241-dd8f-561886cf3295@redhat.com>
Date: Fri, 20 Apr 2018 17:38:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180420104743.7396-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] simple firmware.json test tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 04/20/18 12:47, Gerd Hoffmann wrote:
> applies on top of the firmware.json v2 series.
> ---
>  configure       |  2 +-
>  Makefile        |  2 ++
>  qemu-firmware.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 qemu-firmware.c
> 
> diff --git a/configure b/configure
> index 0a19b033bc..753f80147b 100755
> --- a/configure
> +++ b/configure
> @@ -5495,7 +5495,7 @@ fi
>  
>  tools=""
>  if test "$want_tools" = "yes" ; then
> -  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
> +  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-firmware\$(EXESUF) $tools"
>    if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
>      tools="qemu-nbd\$(EXESUF) $tools"
>    fi
> diff --git a/Makefile b/Makefile
> index 32034abe15..4d6e627113 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -543,6 +543,8 @@ qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
>  
>  qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
>  
> +qemu-firmware$(EXESUF): qemu-firmware.o $(COMMON_LDADDS)
> +
>  fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
>  fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
>  
> diff --git a/qemu-firmware.c b/qemu-firmware.c
> new file mode 100644
> index 0000000000..792f0fec8f
> --- /dev/null
> +++ b/qemu-firmware.c
> @@ -0,0 +1,81 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +
> +#include "qapi/error.h"
> +#include "qapi/qapi-types-firmware.h"
> +#include "qapi/qapi-visit-firmware.h"
> +#include "qapi/qobject-input-visitor.h"
> +
> +int main(int argc, char *argv[])
> +{
> +    Error *err = NULL;
> +    FirmwareMappingFlash *flash;
> +    Firmware *fw;
> +    Visitor *v;
> +    int fd, size, rc;
> +    char *buf;
> +
> +    if (argc != 2) {
> +        fprintf(stderr, "usage: qemu-firmware <firmware-desc.json>\n");
> +        exit(1);
> +    }
> +
> +    /* read file */
> +    fd = open(argv[1], O_RDONLY);
> +    if (fd < 0) {
> +        fprintf(stderr, "open %s: %s\n", argv[1], strerror(errno));
> +        exit(1);
> +    }
> +    size = lseek(fd, 0, SEEK_END);
> +    if (size < 0) {
> +        perror("lseek");
> +        exit(1);
> +    }
> +    lseek(fd, 0, SEEK_SET);
> +    buf = malloc(size+1);
> +    rc = read(fd, buf, size);
> +    if (rc != size) {
> +        fprintf(stderr, "file read error\n");
> +        exit(1);
> +    }
> +    buf[size] = 0;
> +    close(fd);
> +
> +    /* parse file */
> +    v = qobject_input_visitor_new_str(buf, "", &err);
> +    if (!v) {
> +        error_report_err(err);
> +        exit(1);
> +    }
> +    visit_type_Firmware(v, NULL, &fw, &error_fatal);
> +    visit_free(v);
> +
> +    /* print cmdline */
> +    switch (fw->mapping->device) {
> +    case FIRMWARE_DEVICE_FLASH:
> +        /*
> +         * FIXME: nvram should be a per-guest copy.
> +         *        How to handle that best here?
> +         */

Perhaps print a few shell commands first? Such as:

  (
    VARSTORE=$(mktemp)
    trap 'rm -f -- "$VARSTORE"' EXIT
    cat -- '[VARSTORE_TEMPLATE]' >> "$VARSTORE"
    qemu ...
  )

It really does take separate actions, just like when you create a new
disk image with "qemu-img".

Thanks,
Laszlo

> +        flash = &fw->mapping->u.flash;
> +        printf("-drive if=pflash,index=0,format=%s,file=%s\n",
> +               BlockdevDriver_str(flash->executable->format),
> +               flash->executable->pathname);
> +        printf("-drive if=pflash,index=1,format=%s,file=%s\n",
> +               BlockdevDriver_str(flash->nvram_template->format),
> +               flash->nvram_template->pathname);
> +        break;
> +    case FIRMWARE_DEVICE_MEMORY:
> +        printf("-bios %s\n", fw->mapping->u.memory.pathname);
> +        break;
> +    case FIRMWARE_DEVICE_KERNEL:
> +        printf("-kernel %s\n", fw->mapping->u.kernel.pathname);
> +        break;
> +    default:
> +        fprintf(stderr, "TODO\n");
> +        break;
> +    }
> +
> +    exit(0);
> +}
> 
