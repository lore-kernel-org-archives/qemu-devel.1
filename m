Received: from eggs.gnu.org ([2001:4830:134:3::10]:59376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWOUu-0000YJ-FT
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWOUo-0001U2-SD
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:33:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWOUm-0001Sl-Tt
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:33:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so11896834wmd.2
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 08:33:23 -0800 (PST)
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-5-philmd@redhat.com>
	<8ec2e7fd-bf8e-e537-6a9c-905312bafc94@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8f1b11b-102a-d9e0-3d89-7653607ea12b@redhat.com>
Date: Mon, 10 Dec 2018 17:33:20 +0100
MIME-Version: 1.0
In-Reply-To: <8ec2e7fd-bf8e-e537-6a9c-905312bafc94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/6] hw/nvram/fw_cfg: Add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 12/10/18 5:10 PM, Laszlo Ersek wrote:
> On 12/07/18 18:03, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/nvram/fw_cfg.c     | 5 +++++
>>  hw/nvram/trace-events | 5 +++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 3cb726ff68..582653f07e 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -627,6 +627,7 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
>>  
>>  void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
>>  {
>> +    trace_fw_cfg_add_bytes(key, len);
>>      fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, true);
>>  }
>>  
>> @@ -634,6 +635,7 @@ void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
>>  {
>>      size_t sz = strlen(value) + 1;
>>  
>> +    trace_fw_cfg_add_string(key, value);
>>      fw_cfg_add_bytes(s, key, g_memdup(value, sz), sz);
>>  }
>>  
>> @@ -643,6 +645,7 @@ void fw_cfg_add_i16(FWCfgState *s, uint16_t key, uint16_t value)
>>  
>>      copy = g_malloc(sizeof(value));
>>      *copy = cpu_to_le16(value);
>> +    trace_fw_cfg_add_i16(key, value);
>>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>>  }
>>  
>> @@ -662,6 +665,7 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uint32_t value)
>>  
>>      copy = g_malloc(sizeof(value));
>>      *copy = cpu_to_le32(value);
>> +    trace_fw_cfg_add_i32(key, value);
>>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>>  }
>>  
>> @@ -671,6 +675,7 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value)
>>  
>>      copy = g_malloc(sizeof(value));
>>      *copy = cpu_to_le64(value);
>> +    trace_fw_cfg_add_i64(key, value);
>>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>>  }
>>  
>> diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
>> index 6b55ba7a09..0ee0f8d04a 100644
>> --- a/hw/nvram/trace-events
>> +++ b/hw/nvram/trace-events
>> @@ -7,4 +7,9 @@ nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: 0x%02x ->
>>  # hw/nvram/fw_cfg.c
>>  fw_cfg_select(void *s, uint16_t key, int ret) "%p key %d = %d"
>>  fw_cfg_read(void *s, uint64_t ret) "%p = 0x%"PRIx64
>> +fw_cfg_add_bytes(uint16_t key, size_t len) "key 0x%04" PRIx16 " (%zu bytes)"
>>  fw_cfg_add_file(void *s, int index, char *name, size_t len) "%p #%d: %s (%zd bytes)"
>> +fw_cfg_add_string(uint16_t key, const char *value) "key 0x%04" PRIx16 ", value '%s'"
>> +fw_cfg_add_i16(uint16_t key, uint32_t value) "key 0x%04" PRIx16 ", value 0x%" PRIx32
> 
> For the "value" parameter, you should use "uint16_t" here (and replace
> PRIx32 with PRIx16, as well).
> 
> (In practice this will make no difference, but for consistency's sake,
> we should do this.)

You are right :)

> 
> With the update:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thanks
> Laszlo
> 
>> +fw_cfg_add_i32(uint16_t key, uint32_t value) "key 0x%04" PRIx16 ", value 0x%" PRIx32
>> +fw_cfg_add_i64(uint16_t key, uint64_t value) "key 0x%04" PRIx16 ", value 0x%" PRIx64
>>
> 
