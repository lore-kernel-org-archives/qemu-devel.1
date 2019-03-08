Received: from eggs.gnu.org ([209.51.188.92]:35948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Da5-0008SI-Ix
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Da4-0006Zs-Kg
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:22:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2Da4-0006ZK-CU
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:22:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so12293033wme.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 03:22:23 -0800 (PST)
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-11-philmd@redhat.com>
	<40a49a86-3010-da90-41f3-0f4a1705bca0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad4255d0-455b-d850-9c10-4839c1bbbf34@redhat.com>
Date: Fri, 8 Mar 2019 12:22:20 +0100
MIME-Version: 1.0
In-Reply-To: <40a49a86-3010-da90-41f3-0f4a1705bca0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/18] hw/nvram/fw_cfg: Add
 reboot_timeout to FWCfgState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 3/8/19 12:04 PM, Laszlo Ersek wrote:
> Hi Phil,
> 
> On 03/08/19 02:32, Philippe Mathieu-Daudé wrote:
>> Due to the contract interface of fw_cfg_add_file(), the
>> 'reboot_timeout' data has to be valid for the lifetime of the
>> FwCfg object. For this reason it is copied on the heap with
>> memdup().
>>
>> The object state, 'FWCfgState', is also meant to be valid during the
>> lifetime of the object.
>> Move the 'reboot_timeout' in FWCfgState to achieve the same purpose.
>> Doing so we avoid a memory leak.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/nvram/fw_cfg.c         | 4 +++-
>>  include/hw/nvram/fw_cfg.h | 2 ++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Currently, there is no memory leak. Right now, the leak is theoretical,
> and it would depend on the fw_cfg object being actually destroyed.

Actually my first motivation came while using valgrind, there are a
bunch of warnings related to the fw_cfg device.
This device is not hotpluggable however, and we don't test it in the
device-introspect-test.

> I think armoring the fw_cfg implementation for such lifetime actions is
> valuable. But, that definitely belongs to its own series, in my opinion.
> 
> In the "hw/nvram/fw_cfg.c" file, I count:
> 
> (a) two "specific purpose" g_memdup() calls, namely in
> fw_cfg_bootsplash() and in fw_cfg_reboot();
> 
> (b) one "generic purpose" g_memdup() call, namely in fw_cfg_add_string();
> 
> (c) two "generic purpose" g_malloc() calls, namely in fw_cfg_add_i16(),
> fw_cfg_add_i32(), and fw_cfg_add_i64(). (The one in fw_cfg_modify_i16()
> does not matter here because the previous blob is freed in that function.)
> 
> Your series deals with (a), namely with fw_cfg_reboot() in this patch,
> and with fw_cfg_bootsplash() in the next one.
> 
> Your series deals with neither (b) nor (c). The

I did a PoC of (b) and (c) but it is a more invasive patchset indeed.

> fw_cfg_add_(string|i16|i32|i64) functions are called from a bunch of
> places however, so if we really intend *not* to leak those copies upon
> fw_cfg destruction, then we'll have to track all of them dynamically, in
> a list for example.

I haven't think of using a list.

> (And that necessitates a separate series for this topic even more.)

OK.

> In turn, once we add dynamic tracking, for those blobs that the
> fw_cfg_add_(string|i16|i32|i64) functions allocate internally -- as they
> are advertized to do --, then we might as well use the same tracking
> infrastructure for (a). In other words, it should not be necessary to
> add the specific fields "reboot_timeout" and "boot_splash" to FWCfgState.

OK, I'll drop these patches from this series.

> 
> Thanks,
> Laszlo
> 
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index b73a591eff..182d27f59a 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -250,7 +250,9 @@ static void fw_cfg_reboot(FWCfgState *s)
>>          }
>>      }
>>  
>> -    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_val, 4), 4);
>> +    s->reboot_timeout = rt_val;
>> +    fw_cfg_add_file(s, "etc/boot-fail-wait",
>> +                    &s->reboot_timeout, sizeof(s->reboot_timeout));
>>  }
>>  
>>  static void fw_cfg_write(FWCfgState *s, uint8_t value)
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index 828ad9dedc..99f6fafcaa 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -53,6 +53,8 @@ struct FWCfgState {
>>      dma_addr_t dma_addr;
>>      AddressSpace *dma_as;
>>      MemoryRegion dma_iomem;
>> +
>> +    uint32_t reboot_timeout;
>>  };
>>  
>>  struct FWCfgIoState {
>>
> 
