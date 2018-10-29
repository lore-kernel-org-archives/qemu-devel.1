Received: from eggs.gnu.org ([2001:4830:134:3::10]:53015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHHF8-0005q8-TZ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHHF5-0004FA-Dg
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:46:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHHF5-0004Do-08
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:46:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id g9-v6so10568684wrq.4
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 16:46:42 -0700 (PDT)
References: <20181028124004.30494-1-liq3ea@163.com>
	<20181028124004.30494-2-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b181c7d-338f-3612-48bb-751bab8f020a@redhat.com>
Date: Tue, 30 Oct 2018 00:46:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181028124004.30494-2-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: fw_cfg: add a function to get
 the fw_cfg file entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com
Cc: qemu-devel@nongnu.org

Hi Li,

On 28/10/18 13:40, Li Qiang wrote:
> This is useful to write qtest abount fw_cfg file entry.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   tests/libqos/fw_cfg.c | 30 ++++++++++++++++++++++++++++++
>   tests/libqos/fw_cfg.h |  2 ++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
> index d0889d1e22..2dd7a498ab 100644
> --- a/tests/libqos/fw_cfg.c
> +++ b/tests/libqos/fw_cfg.c
> @@ -16,6 +16,7 @@
>   #include "libqos/fw_cfg.h"
>   #include "libqtest.h"
>   #include "qemu/bswap.h"
> +#include "standard-headers/linux/qemu_fw_cfg.h"
>   
>   void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>   {
> @@ -54,6 +55,35 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)
>       return le64_to_cpu(value);
>   }
>   

Can this return size_t the size of the file?
So qfw_cfg_get_file(..., buflen=0) returns the file size.

> +void qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> +                      void *data, size_t buflen)
> +{
> +    uint32_t count;
> +    uint32_t i;
> +    unsigned char *filesbuf = NULL;
> +    uint32_t dsize;
> +    struct fw_cfg_file *p;

        size_t filesize = 0;

> +
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> +    count = be32_to_cpu(count);
> +    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
> +    filesbuf = g_malloc0(dsize);
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> +    p = (struct fw_cfg_file *)(filesbuf + 4);
> +    for (i = 0; i < count; ++i, ++p) {
> +        if (!strcmp(p->name, filename)) {
> +            uint32_t len = be32_to_cpu(p->size);


> +            uint16_t sel = be16_to_cpu(p->select);
> +            void *buf = g_malloc0(len);

Why call malloc() here?

> +            qfw_cfg_get(fw_cfg, sel, buf, len);

And not copy directly to 'data':

                filesize = len;
                if (len > buflen) {
                    len = buflen;
                }
                qfw_cfg_get(fw_cfg, sel, data, len);

> +            memcpy(data, buf, buflen);
> +            g_free(buf);

Dropping 2 previous lines.

> +            break;
> +        }
> +    }
> +    g_free(filesbuf);

        return filesize;

> +}
> +
>   static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>   {
>       qtest_writew(fw_cfg->qts, fw_cfg->base, key);
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 0353416af0..50e4227638 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -31,6 +31,8 @@ void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len);
>   uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
>   uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
>   uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
> +void qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> +                      void *data, size_t buflen);
>   
>   QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
>   QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> 
