Received: from eggs.gnu.org ([2001:4830:134:3::10]:55404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXU5W-0005ls-Ss
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXU5T-0002gY-Fr
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:11:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180621114015.9207-1-f4bug@amsat.org>
	<20180621114015.9207-3-f4bug@amsat.org>
	<988a6d50-a911-6ac0-2955-0f99292d8a15@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c1e03b95-e883-ca93-19b8-86cf37e71bcc@amsat.org>
Date: Mon, 25 Jun 2018 13:11:25 -0300
MIME-Version: 1.0
In-Reply-To: <988a6d50-a911-6ac0-2955-0f99292d8a15@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 2/3] hw/arm/sysbus-fdt:
 Replace error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Eric,

On 06/21/2018 10:02 AM, Auger Eric wrote:
> Hi Philippe,
> On 06/21/2018 01:40 PM, Philippe Mathieu-Daudé wrote:
>> Use error_report() + exit() instead of error_setg(&error_fatal),
>> as suggested by the "qapi/error.h" documentation:
>>
>>    Please don't error_setg(&error_fatal, ...), use error_report() and
>>    exit(), because that's more obvious.
>>
>> This fixes CID 1352173:
>>     "Passing null pointer dt_name to qemu_fdt_node_path, which dereferences it."
>>
>> And this also fixes:
>>
>>     hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable 'node_path') results in a null pointer dereference
>>         if (node_path[1]) {
>>             ^~~~~~~~~~~~
>>
>> Fixes: Coverity CID 1352173 (Dereference after null check)
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/arm/sysbus-fdt.c | 45 ++++++++++++++++++++++++++-------------------
>>  1 file changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
>> index 277ed872e7..63b74a353e 100644
>> --- a/hw/arm/sysbus-fdt.c
>> +++ b/hw/arm/sysbus-fdt.c
>> @@ -92,7 +92,7 @@ static void copy_properties_from_host(HostProperty *props, int nb_props,
>>          r = qemu_fdt_getprop(host_fdt, node_path,
>>                               props[i].name,
>>                               &prop_len,
>> -                             props[i].optional ? &err : &error_fatal);
>> +                             &err);
>>          if (r) {
>>              qemu_fdt_setprop(guest_fdt, nodename,
>>                               props[i].name, r, prop_len);
>> @@ -103,6 +103,10 @@ static void copy_properties_from_host(HostProperty *props, int nb_props,
>>              } else {
>>                  error_free(err);
>>              }
>> +            if (!props[i].optional) {
>> +                /* mandatory property not found: bail out */
>> +                exit(1);
> reading that code again, I am not sure this does the same thing as
> before. In case case the property is tagged not optional and is not
> found in the host dt, qemu_fdt_getprop will fill err with error_setg.
> However prop_len == -FDT_ERR_NOTFOUND so we are going to call error_free
> and no trace will be output to the user. Before the
> error_setg(&error_fatal) printed the cause of error error and exited. Do
> I miss something?

You are correct something is wrong here, I'll respin.

Thanks for your review!

> 
> Thanks
> 
> Eric
>> +            }
>>          }
>>      }
>>  }
>> @@ -138,9 +142,9 @@ static void fdt_build_clock_node(void *host_fdt, void *guest_fdt,
>>  
>>      node_offset = fdt_node_offset_by_phandle(host_fdt, host_phandle);
>>      if (node_offset <= 0) {
>> -        error_setg(&error_fatal,
>> -                   "not able to locate clock handle %d in host device tree",
>> -                   host_phandle);
>> +        error_report("not able to locate clock handle %d in host device tree",
>> +                     host_phandle);
>> +        exit(1);
>>      }
>>      node_path = g_malloc(path_len);
>>      while ((ret = fdt_get_path(host_fdt, node_offset, node_path, path_len))
>> @@ -149,16 +153,16 @@ static void fdt_build_clock_node(void *host_fdt, void *guest_fdt,
>>          node_path = g_realloc(node_path, path_len);
>>      }
>>      if (ret < 0) {
>> -        error_setg(&error_fatal,
>> -                   "not able to retrieve node path for clock handle %d",
>> -                   host_phandle);
>> +        error_report("not able to retrieve node path for clock handle %d",
>> +                     host_phandle);
>> +        exit(1);
>>      }
>>  
>>      r = qemu_fdt_getprop(host_fdt, node_path, "compatible", &prop_len,
>>                           &error_fatal);
>>      if (strcmp(r, "fixed-clock")) {
>> -        error_setg(&error_fatal,
>> -                   "clock handle %d is not a fixed clock", host_phandle);
>> +        error_report("clock handle %d is not a fixed clock", host_phandle);
>> +        exit(1);
>>      }
>>  
>>      nodename = strrchr(node_path, '/');
>> @@ -301,34 +305,37 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
>>  
>>      dt_name = sysfs_to_dt_name(vbasedev->name);
>>      if (!dt_name) {
>> -        error_setg(&error_fatal, "%s incorrect sysfs device name %s",
>> -                    __func__, vbasedev->name);
>> +        error_report("%s incorrect sysfs device name %s",
>> +                     __func__, vbasedev->name);
>> +        exit(1);
>>      }
>>      node_path = qemu_fdt_node_path(host_fdt, dt_name, vdev->compat,
>>                                     &error_fatal);
>>      if (!node_path || !node_path[0]) {
>> -        error_setg(&error_fatal, "%s unable to retrieve node path for %s/%s",
>> -                   __func__, dt_name, vdev->compat);
>> +        error_report("%s unable to retrieve node path for %s/%s",
>> +                     __func__, dt_name, vdev->compat);
>> +        exit(1);
>>      }
>>  
>>      if (node_path[1]) {
>> -        error_setg(&error_fatal, "%s more than one node matching %s/%s!",
>> -                   __func__, dt_name, vdev->compat);
>> +        error_report("%s more than one node matching %s/%s!",
>> +                     __func__, dt_name, vdev->compat);
>> +        exit(1);
>>      }
>>  
>>      g_free(dt_name);
>>  
>>      if (vbasedev->num_regions != 5) {
>> -        error_setg(&error_fatal, "%s Does the host dt node combine XGBE/PHY?",
>> -                   __func__);
>> +        error_report("%s Does the host dt node combine XGBE/PHY?", __func__);
>> +        exit(1);
>>      }
>>  
>>      /* generate nodes for DMA_CLK and PTP_CLK */
>>      r = qemu_fdt_getprop(host_fdt, node_path[0], "clocks",
>>                           &prop_len, &error_fatal);
>>      if (prop_len != 8) {
>> -        error_setg(&error_fatal, "%s clocks property should contain 2 handles",
>> -                   __func__);
>> +        error_report("%s clocks property should contain 2 handles", __func__);
>> +        exit(1);
>>      }
>>      host_clock_phandles = (uint32_t *)r;
>>      guest_clock_phandles[0] = qemu_fdt_alloc_phandle(guest_fdt);
>>
> 
