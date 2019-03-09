Received: from eggs.gnu.org ([209.51.188.92]:53971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2dOm-0002W4-UJ
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2dOm-0007Ro-1A
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:56:28 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-7-philmd@redhat.com>
	<37ef3c6b-e99e-859e-2324-9c59ff6bc1f8@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <596ed94c-5121-06d5-e3e4-b4270bdf660b@vivier.eu>
Date: Sat, 9 Mar 2019 15:53:49 +0100
MIME-Version: 1.0
In-Reply-To: <37ef3c6b-e99e-859e-2324-9c59ff6bc1f8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 06/18] hw/nvram/fw_cfg:
 Remove the unnecessary boot_splash_filedata_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 08/03/2019 07:49, Thomas Huth wrote:
> On 08/03/2019 02.32, Philippe Mathieu-Daudé wrote:
>> The 'boot_splash_filedata_size' was introduced as a global variable
>> in 3d3b8303c6f. This variable is used as a 'size' argument to the
>> fw_cfg_add_file(). This function has an interface contract with his
>> 'data' argument, but there is no such contract for 'size' (this is
>> not a referenced pointer).  We can simply remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/nvram/fw_cfg.c       | 5 ++---
>>  include/sysemu/sysemu.h | 1 -
>>  vl.c                    | 1 -
>>  3 files changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 8eb76a382c..b2dc0a80cb 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -217,15 +217,14 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>>          }
>>          g_free(boot_splash_filedata);
>>          boot_splash_filedata = (uint8_t *)file_data;
>> -        boot_splash_filedata_size = file_size;
>>  
>>          /* insert data */
>>          if (file_type == JPG_FILE) {
>>              fw_cfg_add_file(s, "bootsplash.jpg",
>> -                    boot_splash_filedata, boot_splash_filedata_size);
>> +                            boot_splash_filedata, file_size);
>>          } else {
>>              fw_cfg_add_file(s, "bootsplash.bmp",
>> -                    boot_splash_filedata, boot_splash_filedata_size);
>> +                            boot_splash_filedata, file_size);
>>          }
>>          g_free(filename);
>>      }
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 89604a8328..6065d9e420 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -110,7 +110,6 @@ extern int old_param;
>>  extern int boot_menu;
>>  extern bool boot_strict;
>>  extern uint8_t *boot_splash_filedata;
>> -extern size_t boot_splash_filedata_size;
>>  extern bool enable_mlock;
>>  extern bool enable_cpu_pm;
>>  extern QEMUClockType rtc_clock;
>> diff --git a/vl.c b/vl.c
>> index 4c5cc0d8ad..fad6fec38c 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -188,7 +188,6 @@ const char *prom_envs[MAX_PROM_ENVS];
>>  int boot_menu;
>>  bool boot_strict;
>>  uint8_t *boot_splash_filedata;
>> -size_t boot_splash_filedata_size;
>>  bool wakeup_suspend_enabled;
>>  
>>  int icount_align_option;
>>
> 
> Nice, one global variable less!
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
