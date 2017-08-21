Received: from eggs.gnu.org ([2001:4830:134:3::10]:44323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djhH1-0006mH-Bm
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djhGw-000209-Fg
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:37:23 -0400
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:47931)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1djhGw-0001zr-94
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:37:18 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id B63B312C8EA
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 09:37:16 +0200 (CEST)
References: <1503265602-9349-1-git-send-email-minyard@acm.org>
	<1503265602-9349-4-git-send-email-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9894dd40-e983-790f-e228-bf86ecc2694d@kaod.org>
Date: Mon, 21 Aug 2017 09:37:11 +0200
MIME-Version: 1.0
In-Reply-To: <1503265602-9349-4-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <cminyard@mvista.com>

On 08/20/2017 11:46 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> This lets an event be added to the SEL as if a sensor had generated
> it.  The OpenIPMI driver uses it for storing panic event information.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

As Philippe pointed it out, we could initialize all the event
bytes to some initial value, but this is minor and this is done
later on in sel_add_event().

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ipmi/ipmi_bmc_sim.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index a0bbfd5..e84d710 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -38,6 +38,7 @@
> =20
>  #define IPMI_NETFN_SENSOR_EVENT       0x04
> =20
> +#define IPMI_CMD_PLATFORM_EVENT_MSG       0x02
>  #define IPMI_CMD_SET_SENSOR_EVT_ENABLE    0x28
>  #define IPMI_CMD_GET_SENSOR_EVT_ENABLE    0x29
>  #define IPMI_CMD_REARM_SENSOR_EVTS        0x2a
> @@ -1581,6 +1582,28 @@ static void set_sel_time(IPMIBmcSim *ibs,
>      ibs->sel.time_offset =3D now.tv_sec - ((long) val);
>  }
> =20
> +static void platform_event_msg(IPMIBmcSim *ibs,
> +                               uint8_t *cmd, unsigned int cmd_len,
> +                               RspBuffer *rsp)
> +{
> +    uint8_t event[16];
> +
> +    event[2] =3D 2; /* System event record */
> +    event[7] =3D cmd[2]; /* Generator ID */
> +    event[8] =3D 0;
> +    event[9] =3D cmd[3]; /* EvMRev */
> +    event[10] =3D cmd[4]; /* Sensor type */
> +    event[11] =3D cmd[5]; /* Sensor number */
> +    event[12] =3D cmd[6]; /* Event dir / Event type */
> +    event[13] =3D cmd[7]; /* Event data 1 */
> +    event[14] =3D cmd[8]; /* Event data 2 */
> +    event[15] =3D cmd[9]; /* Event data 3 */
> +
> +    if (sel_add_event(ibs, event)) {
> +        rsp_buffer_set_error(rsp, IPMI_CC_OUT_OF_SPACE);
> +    }
> +}
> +
>  static void set_sensor_evt_enable(IPMIBmcSim *ibs,
>                                    uint8_t *cmd, unsigned int cmd_len,
>                                    RspBuffer *rsp)
> @@ -1757,6 +1780,7 @@ static const IPMINetfn chassis_netfn =3D {
>  };
> =20
>  static const IPMICmdHandler sensor_event_cmds[] =3D {
> +    [IPMI_CMD_PLATFORM_EVENT_MSG] =3D { platform_event_msg, 10 },
>      [IPMI_CMD_SET_SENSOR_EVT_ENABLE] =3D { set_sensor_evt_enable, 4 },
>      [IPMI_CMD_GET_SENSOR_EVT_ENABLE] =3D { get_sensor_evt_enable, 3 },
>      [IPMI_CMD_REARM_SENSOR_EVTS] =3D { rearm_sensor_evts, 4 },
>=20
