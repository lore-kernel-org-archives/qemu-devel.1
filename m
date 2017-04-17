Received: from eggs.gnu.org ([2001:4830:134:3::10]:47308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1d0Caa-0001wc-EJ
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1d0CaZ-0007qN-0Y
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:45:32 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:32849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1d0CaY-0007qC-QD
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:45:30 -0400
Received: by mail-oi0-x244.google.com with SMTP id a189so5639914oib.0
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 12:45:30 -0700 (PDT)
Reply-To: minyard@acm.org
References: <1491980930-32184-1-git-send-email-clg@kaod.org>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <121e1e67-6edc-f647-f4f0-158f4831f941@gmail.com>
Date: Mon, 17 Apr 2017 14:45:27 -0500
MIME-Version: 1.0
In-Reply-To: <1491980930-32184-1-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] ipmi: add SET_SENSOR_READING command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Corey Minyard <cminyard@mvista.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 04/12/2017 02:08 AM, Cédric Le Goater wrote:
> SET_SENSOR_READING is a complex IPMI command (see IPMI spec 35.17)
> which enables the host software to set the reading value and the event
> status of sensors supporting it.
>
> Below is a proposal for all the operations (reading, assert, deassert,
> event data) with the following limitations :
>
>   - No event are generated for threshold-based sensors.
>   - The case in which the BMC needs to generate its own events is not
>     supported.
>     
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Looks good.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

Thanks.

> ---
>
>   Corey,
>
>   There is some progress but I didn't add a check on the value before
>   generating events because we would not generate an event when only
>   the event bytes change.
>
>   Changes since v1:
>   
>   - created copies of the reading and the assertion bits before
>     committing the values
>   - added some TODOs
>   - handled inconsistent Event Data Bytes operation
>   
>   hw/ipmi/ipmi_bmc_sim.c |  213 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 213 insertions(+)
>
> Index: qemu-powernv-2.9.git/hw/ipmi/ipmi_bmc_sim.c
> ===================================================================
> --- qemu-powernv-2.9.git.orig/hw/ipmi/ipmi_bmc_sim.c
> +++ qemu-powernv-2.9.git/hw/ipmi/ipmi_bmc_sim.c
> @@ -45,6 +45,7 @@
>   #define IPMI_CMD_GET_SENSOR_READING       0x2d
>   #define IPMI_CMD_SET_SENSOR_TYPE          0x2e
>   #define IPMI_CMD_GET_SENSOR_TYPE          0x2f
> +#define IPMI_CMD_SET_SENSOR_READING       0x30
>   
>   /* #define IPMI_NETFN_APP             0x06 In ipmi.h */
>   
> @@ -1739,6 +1740,217 @@ static void get_sensor_type(IPMIBmcSim *
>       rsp_buffer_push(rsp, sens->evt_reading_type_code);
>   }
>   
> +/*
> + * bytes   parameter
> + *    1    sensor number
> + *    2    operation (see below for bits meaning)
> + *    3    sensor reading
> + *  4:5    assertion states (optional)
> + *  6:7    deassertion states (optional)
> + *  8:10   event data 1,2,3 (optional)
> + */
> +static void set_sensor_reading(IPMIBmcSim *ibs,
> +                               uint8_t *cmd, unsigned int cmd_len,
> +                               RspBuffer *rsp)
> +{
> +    IPMISensor *sens;
> +    uint8_t evd1 = 0;
> +    uint8_t evd2 = 0;
> +    uint8_t evd3 = 0;
> +    uint8_t new_reading = 0;
> +    uint16_t new_assert_states = 0;
> +    uint16_t new_deassert_states = 0;
> +    bool change_reading = false;
> +    bool change_assert = false;
> +    bool change_deassert = false;
> +    enum {
> +        SENSOR_GEN_EVENT_NONE,
> +        SENSOR_GEN_EVENT_DATA,
> +        SENSOR_GEN_EVENT_BMC,
> +    } do_gen_event = SENSOR_GEN_EVENT_NONE;
> +
> +    if ((cmd[2] >= MAX_SENSORS) ||
> +            !IPMI_SENSOR_GET_PRESENT(ibs->sensors + cmd[2])) {
> +        rsp_buffer_set_error(rsp, IPMI_CC_REQ_ENTRY_NOT_PRESENT);
> +        return;
> +    }
> +
> +    sens = ibs->sensors + cmd[2];
> +
> +    /* [1:0] Sensor Reading operation */
> +    switch ((cmd[3]) & 0x3) {
> +    case 0: /* Do not change */
> +        break;
> +    case 1: /* write given value to sensor reading byte */
> +        new_reading = cmd[4];
> +        if (sens->reading != new_reading) {
> +            change_reading = true;
> +        }
> +        break;
> +    case 2:
> +    case 3:
> +        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
> +        return;
> +    }
> +
> +    /* [3:2] Deassertion bits operation */
> +    switch ((cmd[3] >> 2) & 0x3) {
> +    case 0: /* Do not change */
> +        break;
> +    case 1: /* write given value */
> +        if (cmd_len > 7) {
> +            new_deassert_states = cmd[7];
> +            change_deassert = true;
> +        }
> +        if (cmd_len > 8) {
> +            new_deassert_states |= (cmd[8] << 8);
> +        }
> +        break;
> +
> +    case 2: /* mask on */
> +        if (cmd_len > 7) {
> +            new_deassert_states = (sens->deassert_states | cmd[7]);
> +            change_deassert = true;
> +        }
> +        if (cmd_len > 8) {
> +            new_deassert_states |= (sens->deassert_states | (cmd[8] << 8));
> +        }
> +        break;
> +
> +    case 3: /* mask off */
> +        if (cmd_len > 7) {
> +            new_deassert_states = (sens->deassert_states & cmd[7]);
> +            change_deassert = true;
> +        }
> +        if (cmd_len > 8) {
> +            new_deassert_states |= (sens->deassert_states & (cmd[8] << 8));
> +        }
> +        break;
> +    }
> +
> +    if (change_deassert && (new_deassert_states == sens->deassert_states)) {
> +        change_deassert = false;
> +    }
> +
> +    /* [5:4] Assertion bits operation */
> +    switch ((cmd[3] >> 4) & 0x3) {
> +    case 0: /* Do not change */
> +        break;
> +    case 1: /* write given value */
> +        if (cmd_len > 5) {
> +            new_assert_states = cmd[5];
> +            change_assert = true;
> +        }
> +        if (cmd_len > 6) {
> +            new_assert_states |= (cmd[6] << 8);
> +        }
> +        break;
> +
> +    case 2: /* mask on */
> +        if (cmd_len > 5) {
> +            new_assert_states = (sens->assert_states | cmd[5]);
> +            change_assert = true;
> +        }
> +        if (cmd_len > 6) {
> +            new_assert_states |= (sens->assert_states | (cmd[6] << 8));
> +        }
> +        break;
> +
> +    case 3: /* mask off */
> +        if (cmd_len > 5) {
> +            new_assert_states = (sens->assert_states & cmd[5]);
> +            change_assert = true;
> +        }
> +        if (cmd_len > 6) {
> +            new_assert_states |= (sens->assert_states & (cmd[6] << 8));
> +        }
> +        break;
> +    }
> +
> +    if (change_assert && (new_assert_states == sens->assert_states)) {
> +        change_assert = false;
> +    }
> +
> +    if (cmd_len > 9) {
> +        evd1 = cmd[9];
> +    }
> +    if (cmd_len > 10) {
> +        evd2 = cmd[10];
> +    }
> +    if (cmd_len > 11) {
> +        evd3 = cmd[11];
> +    }
> +
> +    /* [7:6] Event Data Bytes operation */
> +    switch ((cmd[3] >> 6) & 0x3) {
> +    case 0: /* Don’t use Event Data bytes from this command. BMC will
> +             * generate it's own Event Data bytes based on its sensor
> +             * implementation.  */
> +        evd1 = evd2 = evd3 = 0x0;
> +        do_gen_event = SENSOR_GEN_EVENT_BMC;
> +        break;
> +    case 1: /* Write given values to event data bytes including bits
> +             * [3:0] Event Data 1. */
> +        do_gen_event = SENSOR_GEN_EVENT_DATA;
> +        break;
> +    case 2: /* Write given values to event data bytes excluding bits
> +             * [3:0] Event Data 1. */
> +        evd1 &= 0xf0;
> +        do_gen_event = SENSOR_GEN_EVENT_DATA;
> +        break;
> +    case 3:
> +        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
> +        return;
> +    }
> +
> +    /* Event Data Bytes operation and parameter are inconsistent. The
> +     * Specs are not clear on that topic but generating an error seems
> +     * correct. */
> +    if (do_gen_event == SENSOR_GEN_EVENT_DATA && cmd_len < 10) {
> +        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
> +        return;
> +    }
> +
> +    /* commit values */
> +    if (change_reading) {
> +        sens->reading = new_reading;
> +    }
> +
> +    if (change_assert) {
> +        sens->assert_states = new_assert_states;
> +    }
> +
> +    if (change_deassert) {
> +        sens->deassert_states = new_deassert_states;
> +    }
> +
> +    /* TODO: handle threshold sensor */
> +    if (!IPMI_SENSOR_IS_DISCRETE(sens)) {
> +        return;
> +    }
> +
> +    switch (do_gen_event) {
> +    case SENSOR_GEN_EVENT_DATA: {
> +        unsigned int bit = evd1 & 0xf;
> +        uint16_t mask = (1 << bit);
> +
> +        if (sens->assert_states & mask & sens->assert_enable) {
> +            gen_event(ibs, cmd[2], 0, evd1, evd2, evd3);
> +        }
> +
> +        if (sens->deassert_states & mask & sens->deassert_enable) {
> +            gen_event(ibs, cmd[2], 1, evd1, evd2, evd3);
> +        }
> +    }
> +        break;
> +    case SENSOR_GEN_EVENT_BMC:
> +        /* TODO: generate event and event data bytes depending on the
> +         * sensor */
> +        break;
> +    case SENSOR_GEN_EVENT_NONE:
> +        break;
> +    }
> +}
>   
>   static const IPMICmdHandler chassis_cmds[] = {
>       [IPMI_CMD_GET_CHASSIS_CAPABILITIES] = { chassis_capabilities },
> @@ -1759,6 +1971,7 @@ static const IPMICmdHandler sensor_event
>       [IPMI_CMD_GET_SENSOR_READING] = { get_sensor_reading, 3 },
>       [IPMI_CMD_SET_SENSOR_TYPE] = { set_sensor_type, 5 },
>       [IPMI_CMD_GET_SENSOR_TYPE] = { get_sensor_type, 3 },
> +    [IPMI_CMD_SET_SENSOR_READING] = { set_sensor_reading, 5 },
>   };
>   static const IPMINetfn sensor_event_netfn = {
>       .cmd_nums = ARRAY_SIZE(sensor_event_cmds),
>
