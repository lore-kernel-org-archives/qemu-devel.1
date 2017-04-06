Received: from eggs.gnu.org ([2001:4830:134:3::10]:45906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw1rC-00036Y-TK
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw1r9-0003R8-NZ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:29:26 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:53014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cw1r8-0003OI-Fr
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:29:23 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id BC60A6451C
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 09:29:13 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-11-git-send-email-clg@kaod.org>
	<c07a3f32-0967-0d9a-dd39-5f8e5e1d95d8@mvista.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f6840bfd-f8a7-7b76-b7f6-6fa16366b884@kaod.org>
Date: Thu, 6 Apr 2017 09:29:01 +0200
MIME-Version: 1.0
In-Reply-To: <c07a3f32-0967-0d9a-dd39-5f8e5e1d95d8@mvista.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/21] ipmi: add SET_SENSOR_READING command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <cminyard@mvista.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 04/05/2017 04:41 PM, Corey Minyard wrote:
> On 04/05/2017 07:41 AM, C=E9dric Le Goater wrote:
>> SET_SENSOR_READING is a complex IPMI command (IPMI spec : "35.17 Set
>> Sensor Reading And Event Status Command"). Here is a very minimum
>> framework fitting the Open PowerNV platform needs. This command is
>> used on this platform to set the "System Firmware Progress" sensor and
>> the "Boot Count" sensor.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>   hw/ipmi/ipmi_bmc_sim.c | 133 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   1 file changed, 133 insertions(+)
>>
>> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
>> index 155561d06614..26036b20d4df 100644
>> --- a/hw/ipmi/ipmi_bmc_sim.c
>> +++ b/hw/ipmi/ipmi_bmc_sim.c
>> @@ -45,6 +45,7 @@
>>   #define IPMI_CMD_GET_SENSOR_READING       0x2d
>>   #define IPMI_CMD_SET_SENSOR_TYPE          0x2e
>>   #define IPMI_CMD_GET_SENSOR_TYPE          0x2f
>> +#define IPMI_CMD_SET_SENSOR_READING       0x30
>>     /* #define IPMI_NETFN_APP             0x06 In ipmi.h */
>>   @@ -1739,6 +1740,137 @@ static void get_sensor_type(IPMIBmcSim *ibs,
>>       rsp_buffer_push(rsp, sens->evt_reading_type_code);
>>   }
>>   +static void set_sensor_reading(IPMIBmcSim *ibs,
>> +                               uint8_t *cmd, unsigned int cmd_len,
>> +                               RspBuffer *rsp)
>> +{
>> +    IPMISensor *sens;
>> +    uint8_t evd1;
>> +    uint8_t evd2;
>> +    uint8_t evd3;
>> +
>> +    if ((cmd[2] > MAX_SENSORS) ||
>=20
> Should be ">=3D" here, I believe.
>=20

yes.


>> +            !IPMI_SENSOR_GET_PRESENT(ibs->sensors + cmd[2])) {
>> +        rsp_buffer_set_error(rsp, IPMI_CC_REQ_ENTRY_NOT_PRESENT);
>> +        return;
>> +    }
>> +
>> +    sens =3D ibs->sensors + cmd[2];
>> +
>> +    /* Sensor Reading operation */
>> +    switch ((cmd[3]) & 0x3) {
>> +    case 0: /* Do not change */
>> +        break;
>> +    case 1: /* write given value to sensor reading byte */
>> +        sens->reading =3D cmd[4];
>> +        break;
>> +    case 2:
>> +    case 3:
>> +        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
>> +        return;
>> +    }
>> +
>> +    /* Deassertion bits operation */
>> +    switch ((cmd[3] >> 2) & 0x3) {
>> +    case 0: /* Do not change */
>> +        break;
>> +    case 1: /* write given value */
>> +        if (cmd_len > 7) {
>> +            sens->deassert_states =3D cmd[7];
>> +        }
>> +        if (cmd_len > 8) {
>> +            sens->deassert_states =3D cmd[8] << 8;
>> +        }
>> +
>> +    case 2: /* mask on */
>> +        if (cmd_len > 7) {
>> +            sens->deassert_states |=3D cmd[7];
>> +        }
>> +        if (cmd_len > 8) {
>> +            sens->deassert_states |=3D cmd[8] << 8;
>> +        }
>> +        break;
>> +    case 3: /* mask off */
>> +        if (cmd_len > 7) {
>> +            sens->deassert_states &=3D cmd[7];
>> +        }
>> +        if (cmd_len > 8) {
>> +            sens->deassert_states &=3D (cmd[8] << 8);
>> +        }
>> +        break;
>> +    }
>> +
>> +    /* Assertion bits operation */
>> +    switch ((cmd[3] >> 4) & 0x3) {
>> +    case 0: /* Do not change */
>> +        break;
>> +    case 1: /* write given value */
>> +        if (cmd_len > 5) {
>> +            sens->assert_states =3D cmd[5];
>> +        }
>> +        if (cmd_len > 6) {
>> +            sens->assert_states =3D cmd[6] << 8;
>> +        }
>> +
>> +    case 2: /* mask on */
>> +        if (cmd_len > 5) {
>> +            sens->assert_states |=3D cmd[5];
>> +        }
>> +        if (cmd_len > 6) {
>> +            sens->assert_states |=3D cmd[6] << 8;
>> +        }
>> +        break;
>> +    case 3: /* mask off */
>> +        if (cmd_len > 5) {
>> +            sens->assert_states &=3D cmd[5];
>> +        }
>> +        if (cmd_len > 6) {
>> +            sens->assert_states &=3D (cmd[6] << 8);
>> +        }
>> +        break;
>> +    }
>> +
>> +    evd1 =3D evd2 =3D evd3 =3D 0x0;
>> +    if (cmd_len > 9) {
>> +        evd1 =3D cmd[9];
>> +    }
>> +    if (cmd_len > 10) {
>> +        evd2 =3D cmd[10];
>> +    }
>> +    if (cmd_len > 11) {
>> +        evd3 =3D cmd[11];
>> +    }
>> +
>> +    /* Event Data Bytes operation */
>> +    switch ((cmd[3] >> 6) & 0x3) {
>> +    case 0: /* Do not use the event data in message */
>> +        evd1 =3D evd2 =3D evd3 =3D 0x0;
>> +        break;
>> +    case 1: /* Write given values to event data bytes excluding bits
>> +             * [3:0] Event Data 1. */
>> +        evd1 &=3D 0xf0;
>> +        break;
>> +    case 2: /* Write given values to event data bytes including bits
>> +             * [3:0] Event Data 1. */
>> +        break;
>> +    case 3:
>> +        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
>> +        return;
>> +    }
>=20
> I think the above section (from the initialization of evd<n>) should be=
 moved to
> right before the sensor reading handling.  Otherwise, on an error you w=
ill set the sensor
> reading and assertion bits but will return an error from the command an=
d not
> send an event.  Actually, it may be better to create local copies of th=
e reading
> and the assertion bits and commit everything together at the end, for r=
easons
> I will talk about later, and because it's more clear.

Yes it seems better.

> There is some vagueness in the spec about how to handle the event data =
bytes if
> they are not present in the command but the command says to use them.  =
I'm
> ok with this implementation, but I'm wondering if returning an error wo=
uldn't be
> better in this particular case.

I can add that.
=20
> The spec is also silent about how to handle setting threshold bits if t=
hey are not
> present but the value exceeds the thresholds.  I'm not sure what to do =
here.
> My gut says that the event should be generated, but that add a lot of c=
omplexity.
> We should probably at least add a comment about this if we don't do it,=
 since
> there is no handling of threshold sensors for event generation below.

I will leave that as a TODO for the moment. The command is becoming quite=
 complex.

>> +
>> +    if (IPMI_SENSOR_IS_DISCRETE(sens)) {
>> +        unsigned int bit =3D evd1 & 0xf;
>> +        uint16_t mask =3D (1 << bit);
>> +
>> +        if (sens->assert_states & mask & sens->assert_enable) {
>> +            gen_event(ibs, cmd[2], 0, evd1, evd2, evd3);
>> +        }
>> +
>> +        if (sens->deassert_states & mask & sens->deassert_enable) {
>> +            gen_event(ibs, cmd[2], 1, evd1, evd2, evd3);
>> +        }
>=20
> You should only generate the events if the values change. =20

hmm, if we do that test, we would not genereate an event if only evd2=20
changes. This is case with the command sent by the OpenPOWER firmware.

Should we really test for a change of the {de}assert_states fields ?=20

> So you need to save
> the original values so you can compare.  Also, if the command requests =
that the
> BMC generate it's own event, you would need to scan the new values comp=
ared
> with the old values and send events for each bit that needs it.=20

I will see what I can do. I am not sure which event data I should be=20
using in that case ...

> Again, more
> complexity, but we should at least comment that we are not doing someth=
ing
> that may be needed later.

OK. Thanks,

C.

> -corey
>=20
>> +    }
>> +}
>>     static const IPMICmdHandler chassis_cmds[] =3D {
>>       [IPMI_CMD_GET_CHASSIS_CAPABILITIES] =3D { chassis_capabilities }=
,
>> @@ -1759,6 +1891,7 @@ static const IPMICmdHandler sensor_event_cmds[] =
=3D {
>>       [IPMI_CMD_GET_SENSOR_READING] =3D { get_sensor_reading, 3 },
>>       [IPMI_CMD_SET_SENSOR_TYPE] =3D { set_sensor_type, 5 },
>>       [IPMI_CMD_GET_SENSOR_TYPE] =3D { get_sensor_type, 3 },
>> +    [IPMI_CMD_SET_SENSOR_READING] =3D { set_sensor_reading, 5 },
>>   };
>>   static const IPMINetfn sensor_event_netfn =3D {
>>       .cmd_nums =3D ARRAY_SIZE(sensor_event_cmds),
>=20
>=20
