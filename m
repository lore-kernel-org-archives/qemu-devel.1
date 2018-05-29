Received: from eggs.gnu.org ([2001:4830:134:3::10]:55734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNiAb-0002G8-Kl
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNiAY-00075z-Ek
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:12:25 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:46416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNiAY-0006zs-8f
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:12:22 -0400
Received: from player693.ha.ovh.net (unknown [10.109.105.34])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 30CB316301
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 19:12:20 +0200 (CEST)
References: <20180529062838.20556-1-clg@kaod.org>
	<20180529062838.20556-6-clg@kaod.org>
	<48fac48c-168d-70b6-5020-1faac584804e@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9849ec14-a8c6-99a6-ac64-5561dd7334fb@kaod.org>
Date: Tue, 29 May 2018 19:12:12 +0200
MIME-Version: 1.0
In-Reply-To: <48fac48c-168d-70b6-5020-1faac584804e@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] slirp/ncsi: add a "Get Parameter"
 response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 05/29/2018 03:11 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> In title: "Get Parameters" (plural)
>=20
> On 05/29/2018 03:28 AM, C=C3=A9dric Le Goater wrote:
>> This is a minimum response to exercise the kernel.
>=20
> This type is mandatory in DMTF Standard v1.0.1 indeed (DSP0222).
>=20
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  slirp/ncsi.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/slirp/ncsi.c b/slirp/ncsi.c
>> index 02d0e9def3e8..f00253641ea4 100644
>> --- a/slirp/ncsi.c
>> +++ b/slirp/ncsi.c
>> @@ -35,6 +35,27 @@ static int ncsi_rsp_handler_gls(struct ncsi_rsp_pkt=
_hdr *rnh)
>>      return 0;
>>  }
>> =20
>> +/* Get Parameter */
>=20
> "Parameters"
>=20
>> +static int ncsi_rsp_handler_gp(struct ncsi_rsp_pkt_hdr *rnh)
>> +{
>> +    struct ncsi_rsp_gp_pkt *rsp =3D (struct ncsi_rsp_gp_pkt *) rnh;
>> +
>> +    rsp->mac_cnt =3D 0x0;
>=20
> "MAC Address Count: The number of MAC addresses supported by the channe=
l"
>=20
> 0 means "no [MAC Address] filter [in use]"
>=20
>> +    rsp->mac_enable =3D 0x0;
>=20
> "MAC Address Flags: all [MAC Address filters] disabled" ...
>=20
>> +
>> +    /* TODO: provide the guest configured MAC */
>> +    rsp->mac[0] =3D 0xaa;
>> +    rsp->mac[1] =3D 0xbb;
>> +    rsp->mac[2] =3D 0xcc;
>> +    rsp->mac[3] =3D 0xdd;
>> +    rsp->mac[4] =3D 0xee;
>> +    rsp->mac[5] =3D 0xff;
>=20
> So there is no need to set this filter,
> or you have to set:
>=20
>     rsp->mac_cnt =3D 1;
>     rsp->mac_enable =3D 1 << 0;
>=20
> Also, you forgot to set:
>=20
>     rsp->vlan_cnt =3D 0;
>     rsp->vlan_enable =3D 0;


yes. I will clean up the handler.

Thanks,

C.

>> +
>> +    /* more data follows */
>> +
>> +    return 0;
>> +}
>> +
>>  static const struct ncsi_rsp_handler {
>>          unsigned char   type;
>>          int             payload;
>> @@ -62,7 +83,7 @@ static const struct ncsi_rsp_handler {
>>          { NCSI_PKT_RSP_SNFC,    4, NULL },
>>          { NCSI_PKT_RSP_GVI,    40, NULL },
>>          { NCSI_PKT_RSP_GC,     32, ncsi_rsp_handler_gc },
>> -        { NCSI_PKT_RSP_GP,     -1, NULL },
>> +        { NCSI_PKT_RSP_GP,     40, ncsi_rsp_handler_gp },
>>          { NCSI_PKT_RSP_GCPS,  172, NULL },
>>          { NCSI_PKT_RSP_GNS,   172, NULL },
>>          { NCSI_PKT_RSP_GNPTS, 172, NULL },
>>
