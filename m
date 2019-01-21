Received: from eggs.gnu.org ([209.51.188.92]:47566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1glhBc-0004y6-8U
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1glhBY-0005J4-Ki
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:32:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1glhBW-00056L-Eu
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:32:48 -0500
References: <20190120071337.55595-1-liq3ea@163.com>
	<20190120071337.55595-2-liq3ea@163.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <66f7e560-2e3e-0efc-6a80-9a44dff71324@redhat.com>
Date: Mon, 21 Jan 2019 22:32:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190120071337.55595-2-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
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
To: Li Qiang <liq3ea@163.com>, philmd@redhat.com, kraxel@redhat.com, thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

On 01/20/19 08:13, Li Qiang wrote:
> This is useful to write qtest about fw_cfg file entry.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/libqos/fw_cfg.c | 33 +++++++++++++++++++++++++++++++++
>  tests/libqos/fw_cfg.h |  2 ++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
> index d0889d1e22..e2b0cae7cd 100644
> --- a/tests/libqos/fw_cfg.c
> +++ b/tests/libqos/fw_cfg.c
> @@ -16,6 +16,7 @@
>  #include "libqos/fw_cfg.h"
>  #include "libqtest.h"
>  #include "qemu/bswap.h"
> +#include "standard-headers/linux/qemu_fw_cfg.h"
>  
>  void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>  {
> @@ -54,6 +55,38 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)
>      return le64_to_cpu(value);
>  }
>  
> +size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> +                      void *data, size_t buflen)
> +{
> +    uint32_t count;
> +    uint32_t i;
> +    unsigned char *filesbuf = NULL;
> +    uint32_t dsize;

dsize should be size_t

> +    struct fw_cfg_file *p;

Please use a better variable name, such as "dir_entry" or similar.

> +    size_t filesize = 0;
> +
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> +    count = be32_to_cpu(count);
> +    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);

where does "struct fw_cfg_file" come from?

... more precisely: why use it over the "FWCfgFile" typedef? (applies to
the declaration of "p" as well).

> +    filesbuf = g_malloc0(dsize);
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> +    p = (struct fw_cfg_file *)(filesbuf + sizeof(uint32_t));
> +    for (i = 0; i < count; ++i, ++p) {
> +        if (!strcmp(p->name, filename)) {
> +            uint32_t len = be32_to_cpu(p->size);
> +            uint16_t sel = be16_to_cpu(p->select);
> +            filesize = len;
> +            if (len > buflen) {
> +                len = buflen;
> +            }
> +            qfw_cfg_get(fw_cfg, sel, data, len);
> +            break;
> +        }
> +    }
> +    g_free(filesbuf);
> +    return filesize;
> +}
> +
>  static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>  {
>      qtest_writew(fw_cfg->qts, fw_cfg->base, key);
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 0353416af0..de73722e67 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -31,6 +31,8 @@ void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len);
>  uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
>  uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
>  uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
> +size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> +                      void *data, size_t buflen);
>  
>  QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
>  QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> 

Looks OK to me otherwise.

Thanks,
Laszlo
