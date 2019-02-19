Received: from eggs.gnu.org ([209.51.188.92]:46433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4XE-0004Oq-Ct
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4XC-0007tY-Kv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:30:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw4XC-0007Ua-Ch
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:30:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so2574936wmj.1
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:29:40 -0800 (PST)
References: <20190219060719.8211-1-richardw.yang@linux.intel.com>
	<20190219060719.8211-2-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <44d5032e-7271-3779-c7e2-d0edd3e1c7fb@redhat.com>
Date: Tue, 19 Feb 2019 13:29:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190219060719.8211-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] pc-dimm: remove check on pc-dimm
 hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com

On 2/19/19 7:07 AM, Wei Yang wrote:
> Function acpi_memory_plug_cb() is only invoked when dev is a PCDIMM,
> which is hotpluggable. This means it is not necessary to check this
> property again.
> 
> This patch removes this check.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  hw/acpi/memory_hotplug.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 8c7c1013f3..b19673d337 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -266,10 +266,6 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
>      MemStatus *mdev;
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);

You have to remove the 'dc' variable now:

  CC      hw/acpi/memory_hotplug.o
hw/acpi/memory_hotplug.c: In function ‘acpi_memory_plug_cb’:
hw/acpi/memory_hotplug.c:267:18: error: unused variable ‘dc’
[-Werror=unused-variable]
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
                  ^~

Once removed:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
> -    if (!dc->hotpluggable) {
> -        return;
> -    }
> -
>      mdev = acpi_memory_slot_status(mem_st, dev, errp);
>      if (!mdev) {
>          return;
> 
