Received: from eggs.gnu.org ([2001:4830:134:3::10]:34507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djL8C-0001ib-8R
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djL89-0003MQ-7S
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:58:48 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:34893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1djL89-0003Ls-0Q
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:58:45 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 3DD93764BB
	for <qemu-devel@nongnu.org>; Sun, 20 Aug 2017 09:58:43 +0200 (CEST)
References: <1503178840-21512-1-git-send-email-minyard@acm.org>
	<1503178840-21512-4-git-send-email-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a6204dc4-18e4-edec-746b-956ebdb1c80f@kaod.org>
Date: Sun, 20 Aug 2017 09:58:39 +0200
MIME-Version: 1.0
In-Reply-To: <1503178840-21512-4-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] ipmi: Add the platform event message
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <cminyard@mvista.com>

On 08/19/2017 11:40 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> This lets an event be added to the SEL as if a sensor had generated
> it.  The OpenIPMI driver uses it for storing panic event information.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 0f191e8..09b15a8 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -38,6 +38,7 @@
>  
>  #define IPMI_NETFN_SENSOR_EVENT       0x04
>  
> +#define IPMI_CMD_PLATFORM_EVENT_MSG       0x02
>  #define IPMI_CMD_SET_SENSOR_EVT_ENABLE    0x28
>  #define IPMI_CMD_GET_SENSOR_EVT_ENABLE    0x29
>  #define IPMI_CMD_REARM_SENSOR_EVTS        0x2a
> @@ -1580,6 +1581,27 @@ static void set_sel_time(IPMIBmcSim *ibs,
>      ibs->sel.time_offset = now.tv_sec - ((long) val);
>  }
>  
> +static void platform_event_msg(IPMIBmcSim *ibs,
> +                               uint8_t *cmd, unsigned int cmd_len,
> +                               RspBuffer *rsp)
> +{
> +    uint8_t event[16];
> +
> +    event[2] = 2; /* System event record */
> +    event[7] = cmd[0]; /* Generator ID */

Like for patch 1, aren't cmd[0] and cmd[1] the 'netfun' and 'cmd' 
bytes ? Otherwise, I checked the specs.

C.


> +    event[8] = 0;
> +    event[9] = cmd[1]; /* EvMRev */
> +    event[10] = cmd[2]; /* Sensor type */
> +    event[11] = cmd[3]; /* Sensor number */
> +    event[12] = cmd[4]; /* Event dir / Event type */
> +    event[13] = cmd[5]; /* Event data 1 */
> +    event[14] = cmd[6]; /* Event data 2 */
> +    event[15] = cmd[7]; /* Event data 3 */
> +
> +    if (sel_add_event(ibs, event))
> +        rsp_buffer_set_error(rsp, IPMI_CC_OUT_OF_SPACE);
> +}
> +
>  static void set_sensor_evt_enable(IPMIBmcSim *ibs,
>                                    uint8_t *cmd, unsigned int cmd_len,
>                                    RspBuffer *rsp)
> @@ -1756,6 +1778,7 @@ static const IPMINetfn chassis_netfn = {
>  };
>  
>  static const IPMICmdHandler sensor_event_cmds[] = {
> +    [IPMI_CMD_PLATFORM_EVENT_MSG] = { platform_event_msg, 8 },
>      [IPMI_CMD_SET_SENSOR_EVT_ENABLE] = { set_sensor_evt_enable, 4 },
>      [IPMI_CMD_GET_SENSOR_EVT_ENABLE] = { get_sensor_evt_enable, 3 },
>      [IPMI_CMD_REARM_SENSOR_EVTS] = { rearm_sensor_evts, 4 },
> 
