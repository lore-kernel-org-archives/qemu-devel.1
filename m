Received: from eggs.gnu.org ([2001:4830:134:3::10]:38734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVLd0-0005qC-HC
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 14:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVLcu-0008Fc-Iw
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 14:17:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVLcs-00089k-Li
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 14:17:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so4775890wrt.11
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 11:17:24 -0800 (PST)
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-7-philmd@redhat.com>
	<20181207125539-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5a02718e-8fb8-4546-4918-5f2348c19853@redhat.com>
Date: Fri, 7 Dec 2018 20:17:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181207125539-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/nvram/fw_cfg: Add
 fw_cfg_add_file_from_host()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 12/7/18 6:56 PM, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 06:04:00PM +0100, Philippe Mathieu-Daudé wrote:
>> Add a function to read the full content of file on the host, and add
>> a new 'file' name item to the fw_cfg device.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Need to be careful with options that let users play with firmware.
> Way too easy to create conflicts.
> Anyway, I'd rather have this included with whatever is using it.

Yes, sure.

> 
>> ---
>>  hw/nvram/fw_cfg.c         | 22 ++++++++++++++++++++++
>>  include/hw/nvram/fw_cfg.h | 22 ++++++++++++++++++++++
>>  2 files changed, 44 insertions(+)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 50525ec1dd..f3232fcb16 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -842,6 +842,28 @@ void fw_cfg_add_file(FWCfgState *s,  const char *filename,
>>      fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, true);
>>  }
>>  
>> +void *fw_cfg_add_file_from_host(FWCfgState *s, const char *filename,
>> +                                const char *host_path, size_t *len)
>> +{
>> +    GError *gerr = NULL;
>> +    gchar *ptr = NULL;
>> +    gsize contents_len = 0;
>> +
>> +
>> +    if (g_file_get_contents(host_path, &ptr, &contents_len, &gerr)) {
>> +        fw_cfg_add_file(s, filename, ptr, contents_len);
>> +    } else {
>> +        error_report("failed to read file %s, %s", host_path, gerr->message);
>> +        g_error_free(gerr);
>> +        return NULL;
>> +    }
>> +    if (len) {
>> +        *len = contents_len;
>> +    }
>> +
>> +    return ptr;
>> +}
>> +
>>  void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>>                          void *data, size_t len)
>>  {
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index 28630b2f26..8de8d63433 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -166,6 +166,28 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value);
>>  void fw_cfg_add_file(FWCfgState *s, const char *filename, void *data,
>>                       size_t len);
>>  
>> +/**
>> + * fw_cfg_add_file_from_host:
>> + * @s: fw_cfg device being modified
>> + * @filename: name of new fw_cfg file item
>> + * @host_path: path of the host file to read the data from
>> + * @len: pointer to hold the length of the host file (optional)
>> + *
>> + * Read the content of a host file as a raw "blob" then add a new NAMED
>> + * fw_cfg item of the file size. If @len is provided, it will contains the
>> + * total length read from the host file. The data referenced by the starting
>> + * pointer is only linked, NOT copied, into the data structure of the fw_cfg
>> + * device.
>> + * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
>> + * will be used; also, a new entry will be added to the file directory
>> + * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
>> + * data size, and assigned selector key value.
>> + *
>> + * Returns: pointer to the file content, or NULL if an error occured.
>> + */
>> +void *fw_cfg_add_file_from_host(FWCfgState *s, const char *filename,
>> +                                const char *host_path, size_t *len);
>> +
>>  /**
>>   * fw_cfg_add_file_callback:
>>   * @s: fw_cfg device being modified
>> -- 
>> 2.17.2
