Received: from eggs.gnu.org ([209.51.188.92]:46166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIHVe-0003tJ-AX
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 14:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIHVa-0001W8-IJ
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 14:48:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIHVY-0001Sn-T5
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 14:48:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so12231682wmc.3
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 11:48:06 -0700 (PDT)
References: <20190319023030.947-1-liq3ea@163.com>
	<20190319023030.947-2-liq3ea@163.com>
	<27424fa0-0fed-c292-2321-069d725fd57d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <687c9a5b-b4bf-8364-36ff-f6b61439083e@redhat.com>
Date: Sun, 21 Apr 2019 20:48:03 +0200
MIME-Version: 1.0
In-Reply-To: <27424fa0-0fed-c292-2321-069d725fd57d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: fw_cfg: add a function to get
 the fw_cfg file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>, lvivier@redhat.com, pbonzini@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

Hi Thomas,

On 4/19/19 9:03 AM, Thomas Huth wrote:
> On 19/03/2019 03.30, Li Qiang wrote:
>> This is useful to write qtest about fw_cfg file entry.
>>
>> Signed-off-by: Li Qiang <liq3ea@163.com>
>> ---
>>  tests/libqos/fw_cfg.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/libqos/fw_cfg.h |  2 ++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
>> index d0889d1e22..2df33df859 100644
>> --- a/tests/libqos/fw_cfg.c
>> +++ b/tests/libqos/fw_cfg.c
>> @@ -16,12 +16,57 @@
>>  #include "libqos/fw_cfg.h"
>>  #include "libqtest.h"
>>  #include "qemu/bswap.h"
>> +#include "hw/nvram/fw_cfg.h"
>>  
>>  void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>>  {
>>      fw_cfg->select(fw_cfg, key);
>>  }
>>  
>> +/*
>> + * The caller need check the return value. When the return value is
>> + * nonzero, it means that some bytes have been transferred.
>> + *
>> + * If the fw_cfg file in question is smaller than the allocated & passed-in
>> + * buffer, then the buffer has been populated only in part.
>> + *
>> + * If the fw_cfg file in question is larger than the passed-in
>> + * buffer, then the return value explains how much room would have been
>> + * necessary in total. And, while the caller's buffer has been fully
>> + * populated, it has received only a starting slice of the fw_cfg file.
>> + */
>> +size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>> +                      void *data, size_t buflen)
>> +{
>> +    uint32_t count;
>> +    uint32_t i;
>> +    unsigned char *filesbuf = NULL;
>> +    size_t dsize;
>> +    FWCfgFile *pdir_entry;
>> +    size_t filesize = 0;
>> +
>> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
>> +    count = be32_to_cpu(count);
>> +    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
>> +    filesbuf = g_malloc0(dsize);
>> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> 
> If I get the code right,  qfw_cfg_get() fills the whole buffer here...
> in that case, g_malloc() should be sufficient, so you don't need
> g_malloc0() here.

Correct.

Apparently Li did address your suggestion in his next iteration of this
patch (same subject, Message-Id: <20190420100056.116305-3-liq3ea@163.com>).

Thanks,

Phil.
