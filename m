Received: from eggs.gnu.org ([2001:4830:134:3::10]:48955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMwqh-0005hy-Ok
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMwqe-0007BR-Em
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:12:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMwqe-00079z-7U
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:12:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so15790638wmc.1
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 07:12:56 -0800 (PST)
References: <20180420104743.7396-1-kraxel@redhat.com>
	<3f72757a-4b4c-9241-dd8f-561886cf3295@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a17f8629-e628-3b3d-f964-98bcb9b218f3@redhat.com>
Date: Wed, 14 Nov 2018 16:12:52 +0100
MIME-Version: 1.0
In-Reply-To: <3f72757a-4b4c-9241-dd8f-561886cf3295@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi Gerd,

On 20/4/18 17:38, Laszlo Ersek wrote:
> On 04/20/18 12:47, Gerd Hoffmann wrote:
>> applies on top of the firmware.json v2 series.
>> ---
>>   configure       |  2 +-
>>   Makefile        |  2 ++
>>   qemu-firmware.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 84 insertions(+), 1 deletion(-)
>>   create mode 100644 qemu-firmware.c
>>
>> diff --git a/configure b/configure
>> index 0a19b033bc..753f80147b 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5495,7 +5495,7 @@ fi
>>   
>>   tools=""
>>   if test "$want_tools" = "yes" ; then
>> -  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
>> +  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-firmware\$(EXESUF) $tools"
>>     if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
>>       tools="qemu-nbd\$(EXESUF) $tools"
>>     fi
>> diff --git a/Makefile b/Makefile
>> index 32034abe15..4d6e627113 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -543,6 +543,8 @@ qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
>>   
>>   qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
>>   
>> +qemu-firmware$(EXESUF): qemu-firmware.o $(COMMON_LDADDS)
>> +
>>   fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
>>   fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
>>   
>> diff --git a/qemu-firmware.c b/qemu-firmware.c
>> new file mode 100644
>> index 0000000000..792f0fec8f
>> --- /dev/null
>> +++ b/qemu-firmware.c
>> @@ -0,0 +1,81 @@
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +#include "qemu/error-report.h"
>> +
>> +#include "qapi/error.h"
>> +#include "qapi/qapi-types-firmware.h"
>> +#include "qapi/qapi-visit-firmware.h"
>> +#include "qapi/qobject-input-visitor.h"
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +    Error *err = NULL;
>> +    FirmwareMappingFlash *flash;
>> +    Firmware *fw;
>> +    Visitor *v;
>> +    int fd, size, rc;
>> +    char *buf;
>> +
>> +    if (argc != 2) {
>> +        fprintf(stderr, "usage: qemu-firmware <firmware-desc.json>\n");
>> +        exit(1);
>> +    }
>> +
>> +    /* read file */
>> +    fd = open(argv[1], O_RDONLY);
>> +    if (fd < 0) {
>> +        fprintf(stderr, "open %s: %s\n", argv[1], strerror(errno));
>> +        exit(1);
>> +    }
>> +    size = lseek(fd, 0, SEEK_END);
>> +    if (size < 0) {
>> +        perror("lseek");
>> +        exit(1);
>> +    }
>> +    lseek(fd, 0, SEEK_SET);
>> +    buf = malloc(size+1);
>> +    rc = read(fd, buf, size);
>> +    if (rc != size) {
>> +        fprintf(stderr, "file read error\n");
>> +        exit(1);
>> +    }
>> +    buf[size] = 0;
>> +    close(fd);
>> +
>> +    /* parse file */
>> +    v = qobject_input_visitor_new_str(buf, "", &err);
>> +    if (!v) {
>> +        error_report_err(err);
>> +        exit(1);
>> +    }
>> +    visit_type_Firmware(v, NULL, &fw, &error_fatal);
>> +    visit_free(v);
>> +
>> +    /* print cmdline */
>> +    switch (fw->mapping->device) {
>> +    case FIRMWARE_DEVICE_FLASH:
>> +        /*
>> +         * FIXME: nvram should be a per-guest copy.
>> +         *        How to handle that best here?
>> +         */
> 
> Perhaps print a few shell commands first? Such as:
> 
>    (
>      VARSTORE=$(mktemp)
>      trap 'rm -f -- "$VARSTORE"' EXIT
>      cat -- '[VARSTORE_TEMPLATE]' >> "$VARSTORE"
>      qemu ...
>    )
> 
> It really does take separate actions, just like when you create a new
> disk image with "qemu-img".
> 
> Thanks,
> Laszlo
> 
>> +        flash = &fw->mapping->u.flash;
>> +        printf("-drive if=pflash,index=0,format=%s,file=%s\n",
>> +               BlockdevDriver_str(flash->executable->format),
>> +               flash->executable->pathname);
>> +        printf("-drive if=pflash,index=1,format=%s,file=%s\n",
>> +               BlockdevDriver_str(flash->nvram_template->format),
>> +               flash->nvram_template->pathname);
>> +        break;
>> +    case FIRMWARE_DEVICE_MEMORY:
>> +        printf("-bios %s\n", fw->mapping->u.memory.pathname);
>> +        break;
>> +    case FIRMWARE_DEVICE_KERNEL:
>> +        printf("-kernel %s\n", fw->mapping->u.kernel.pathname);
>> +        break;
>> +    default:
>> +        fprintf(stderr, "TODO\n");
>> +        break;
>> +    }
>> +
>> +    exit(0);
>> +}

Any plan to respin this patch?

Thanks,

Phil.
