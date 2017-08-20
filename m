Received: from eggs.gnu.org ([2001:4830:134:3::10]:50832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djYuQ-0000to-10
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djYuM-00005i-Tm
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:41:30 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1djYuM-00005D-NA
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:41:26 -0400
Received: by mail-pg0-x243.google.com with SMTP id 83so20979177pgb.4
	for <qemu-devel@nongnu.org>; Sun, 20 Aug 2017 15:41:26 -0700 (PDT)
Reply-To: minyard@acm.org
References: <1503265602-9349-1-git-send-email-minyard@acm.org>
	<1503265602-9349-4-git-send-email-minyard@acm.org>
	<9a03693b-a8a3-ada6-de38-15d28f26b2ec@amsat.org>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <73893c0a-8a18-ae60-34e3-5c75e71185c9@gmail.com>
Date: Sun, 20 Aug 2017 17:41:22 -0500
MIME-Version: 1.0
In-Reply-To: <9a03693b-a8a3-ada6-de38-15d28f26b2ec@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 3/3] ipmi: Add the platform event
 message command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, minyard@acm.org, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On 08/20/2017 05:24 PM, Philippe Mathieu-Daudé wrote:
> Hi Corey,
>
> On 08/20/2017 06:46 PM, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> This lets an event be added to the SEL as if a sensor had generated
>> it.  The OpenIPMI driver uses it for storing panic event information.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   hw/ipmi/ipmi_bmc_sim.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
>> index a0bbfd5..e84d710 100644
>> --- a/hw/ipmi/ipmi_bmc_sim.c
>> +++ b/hw/ipmi/ipmi_bmc_sim.c
>> @@ -38,6 +38,7 @@
>>     #define IPMI_NETFN_SENSOR_EVENT       0x04
>>   +#define IPMI_CMD_PLATFORM_EVENT_MSG       0x02
>>   #define IPMI_CMD_SET_SENSOR_EVT_ENABLE    0x28
>>   #define IPMI_CMD_GET_SENSOR_EVT_ENABLE    0x29
>>   #define IPMI_CMD_REARM_SENSOR_EVTS        0x2a
>> @@ -1581,6 +1582,28 @@ static void set_sel_time(IPMIBmcSim *ibs,
>>       ibs->sel.time_offset = now.tv_sec - ((long) val);
>>   }
>>   +static void platform_event_msg(IPMIBmcSim *ibs,
>> +                               uint8_t *cmd, unsigned int cmd_len,
>> +                               RspBuffer *rsp)
>> +{
>> +    uint8_t event[16];
>
> Watch out, here you are using uninitialized stack,
>
>> +
>> +    event[2] = 2; /* System event record */
>> +    event[7] = cmd[2]; /* Generator ID */
>> +    event[8] = 0;
>> +    event[9] = cmd[3]; /* EvMRev */
>> +    event[10] = cmd[4]; /* Sensor type */
>> +    event[11] = cmd[5]; /* Sensor number */
>> +    event[12] = cmd[6]; /* Event dir / Event type */
>> +    event[13] = cmd[7]; /* Event data 1 */
>> +    event[14] = cmd[8]; /* Event data 2 */
>> +    event[15] = cmd[9]; /* Event data 3 */
>> +
>> +    if (sel_add_event(ibs, event)) {
>
> So here you have event[0,1,3-6] as crap/random.
>

Actually, if you look at sel_add_event(), it fills in these values.

> Also it'd be more efficient to use
>
>     memcpy(&event[9], &cmd[3], sizeof(event) - 9);
>

Maybe, I'm not sure if the compiler would catch this and do something
more efficient.  I like being able to document the individual values.

-corey

>> +        rsp_buffer_set_error(rsp, IPMI_CC_OUT_OF_SPACE);
>> +    }
>> +}
>> +
>>   static void set_sensor_evt_enable(IPMIBmcSim *ibs,
>>                                     uint8_t *cmd, unsigned int cmd_len,
>>                                     RspBuffer *rsp)
>> @@ -1757,6 +1780,7 @@ static const IPMINetfn chassis_netfn = {
>>   };
>>     static const IPMICmdHandler sensor_event_cmds[] = {
>> +    [IPMI_CMD_PLATFORM_EVENT_MSG] = { platform_event_msg, 10 },
>>       [IPMI_CMD_SET_SENSOR_EVT_ENABLE] = { set_sensor_evt_enable, 4 },
>>       [IPMI_CMD_GET_SENSOR_EVT_ENABLE] = { get_sensor_evt_enable, 3 },
>>       [IPMI_CMD_REARM_SENSOR_EVTS] = { rearm_sensor_evts, 4 },
>>
>
