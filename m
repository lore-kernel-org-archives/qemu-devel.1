Received: from eggs.gnu.org ([2001:4830:134:3::10]:54971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eeIJd-0000hT-V7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 05:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eeIJa-0007DG-Pp
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 05:30:01 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eeIJa-0007CN-Km
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 05:29:58 -0500
Received: by mail-qt0-f195.google.com with SMTP id a27so9041253qtd.1
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 02:29:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180124032505.GD8001@xz-mi>
References: <20180123164041.30339-1-marcandre.lureau@redhat.com>
	<20180123164041.30339-3-marcandre.lureau@redhat.com>
	<20180124032505.GD8001@xz-mi>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Wed, 24 Jan 2018 11:29:57 +0100
Message-ID: <CAMxuvawJ4prohPxsncHwjbw13SB7XBqJ6t+vs4q7t4UsSu1xpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 2/4] fw_cfg: do DMA read operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, slp@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>, "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com, qemu-devel <qemu-devel@nongnu.org>

Hi

On Wed, Jan 24, 2018 at 4:25 AM, Peter Xu <peterx@redhat.com> wrote:
> On Tue, Jan 23, 2018 at 05:40:39PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> Modify fw_cfg_read_blob() to use DMA if the device supports it.
>> Return errors, because the operation may fail.
>>
>> The DMA operation is expected to run synchronously with today qemu,
>> but the specification states that it may become async, so we run
>> "control" field check in a loop for eventual changes.
>>
>> We may want to switch all the *buf addresses to use only kmalloc'ed
>> buffers (instead of using stack/image addresses with dma=3Dfalse).
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  drivers/firmware/qemu_fw_cfg.c | 131 ++++++++++++++++++++++++++++++++++=
-------
>>  1 file changed, 111 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_c=
fg.c
>> index 740df0df2260..686f0e839858 100644
>> --- a/drivers/firmware/qemu_fw_cfg.c
>> +++ b/drivers/firmware/qemu_fw_cfg.c
>> @@ -33,6 +33,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/io.h>
>>  #include <linux/ioport.h>
>> +#include <linux/delay.h>
>>
>>  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
>>  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
>> @@ -43,12 +44,22 @@ MODULE_LICENSE("GPL");
>>  #define FW_CFG_ID         0x01
>>  #define FW_CFG_FILE_DIR   0x19
>>
>> +#define FW_CFG_VERSION_DMA     0x02
>> +#define FW_CFG_DMA_CTL_ERROR   0x01
>> +#define FW_CFG_DMA_CTL_READ    0x02
>> +#define FW_CFG_DMA_CTL_SKIP    0x04
>> +#define FW_CFG_DMA_CTL_SELECT  0x08
>> +#define FW_CFG_DMA_CTL_WRITE   0x10
>> +
>>  /* size in bytes of fw_cfg signature */
>>  #define FW_CFG_SIG_SIZE 4
>>
>>  /* fw_cfg "file name" is up to 56 characters (including terminating nul=
) */
>>  #define FW_CFG_MAX_FILE_PATH 56
>>
>> +/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level di=
r. */
>> +static u32 fw_cfg_rev;
>> +
>>  /* fw_cfg file directory entry type */
>>  struct fw_cfg_file {
>>       u32 size;
>> @@ -57,6 +68,12 @@ struct fw_cfg_file {
>>       char name[FW_CFG_MAX_FILE_PATH];
>>  };
>>
>> +struct fw_cfg_dma {
>> +     u32 control;
>> +     u32 length;
>> +     u64 address;
>> +} __packed;
>> +
>>  /* fw_cfg device i/o register addresses */
>>  static bool fw_cfg_is_mmio;
>>  static phys_addr_t fw_cfg_p_base;
>> @@ -75,12 +92,68 @@ static inline u16 fw_cfg_sel_endianness(u16 key)
>>       return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
>>  }
>>
>> +static inline bool fw_cfg_dma_enabled(void)
>> +{
>> +     return fw_cfg_rev & FW_CFG_VERSION_DMA && fw_cfg_reg_dma;
>> +}
>> +
>> +/* qemu fw_cfg device is sync today, but spec says it may become async =
*/
>> +static void fw_cfg_wait_for_control(struct fw_cfg_dma *d)
>> +{
>> +     do {
>> +             u32 ctrl =3D be32_to_cpu(READ_ONCE(d->control));
>> +
>> +             if ((ctrl & ~FW_CFG_DMA_CTL_ERROR) =3D=3D 0)
>> +                     return;
>> +
>> +             usleep_range(50, 100);
>> +     } while (true);
>> +}
>> +
>> +static ssize_t fw_cfg_dma_transfer(struct device *dev,
>> +                             void *address, u32 length, u32 control)
>> +{
>> +     phys_addr_t dma;
>> +     struct fw_cfg_dma *d =3D NULL;
>> +     ssize_t ret =3D length;
>> +
>> +     d =3D kmalloc(sizeof(*d), GFP_KERNEL);
>> +     if (!d) {
>> +             ret =3D -ENOMEM;
>> +             goto end;
>> +     }
>> +
>> +     *d =3D (struct fw_cfg_dma) {
>> +             .address =3D cpu_to_be64(virt_to_phys(address)),
>> +             .length =3D cpu_to_be32(length),
>> +             .control =3D cpu_to_be32(control)
>> +     };
>> +
>> +     dma =3D virt_to_phys(d);
>> +
>> +     iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
>> +     iowrite32be(dma, fw_cfg_reg_dma + 4);
>
> We can do it with iowrite64be(virt_to_phys(d)) too?  In all cases I
> think it's good enough and no worth for a repost.

That would not build on 32 bit, but we could have a #ifdef
CONFIG_64BIT (untested).

>
> For the DMA transfer part:
>
> Acked-by: Peter Xu <peterx@redhat.com>

thanks
