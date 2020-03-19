Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B167C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F79020722
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F79020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEuaX-0001Vo-J4
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 08:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEuZd-0000my-E4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEuZc-00006l-6F
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:46:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEuZb-0008W9-Sx
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:46:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02JCXsaF013855
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 08:46:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yua3w6s8g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 08:46:53 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 19 Mar 2020 12:46:51 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Mar 2020 12:46:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02JCklVZ63045632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 12:46:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 664D0A405B;
 Thu, 19 Mar 2020 12:46:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10A6EA4051;
 Thu, 19 Mar 2020 12:46:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.146.136])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 12:46:46 +0000 (GMT)
Subject: Re: [PATCH v10 09/16] s390x: protvirt: SCLP interpretation
To: Cornelia Huck <cohuck@redhat.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-10-frankja@linux.ibm.com>
 <20200319130945.4134ed82.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 19 Mar 2020 13:46:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200319130945.4134ed82.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FRmWJ6IrCdsmxoK9HZNtttvEa0qVpinVg"
X-TM-AS-GCONF: 00
x-cbid: 20031912-0012-0000-0000-00000393D6EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031912-0013-0000-0000-000021D0BC93
Message-Id: <091466c6-95e7-b635-2d89-cc311b4b146d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-19_04:2020-03-19,
 2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190057
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FRmWJ6IrCdsmxoK9HZNtttvEa0qVpinVg
Content-Type: multipart/mixed; boundary="iYPdueyBB8cGD20JLe8FfzxGPYBN5JNSL"

--iYPdueyBB8cGD20JLe8FfzxGPYBN5JNSL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/19/20 1:09 PM, Cornelia Huck wrote:
> On Wed, 18 Mar 2020 10:30:40 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> SCLP for a protected guest is done over the SIDAD, so we need to use
>> the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
>> memory when reading/writing SCBs.
>>
>> To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
>> since the function that injects the sclp external interrupt would
>> reject a zero sccb address.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c         | 65 ++++++++++++++++++++++++++++++++++------=
-
>>  include/hw/s390x/sclp.h |  2 ++
>>  target/s390x/kvm.c      | 25 ++++++++++++----
>>  3 files changed, 76 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index af0bfbc2eca74767..6486890fecea4b3c 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -33,6 +33,22 @@ static inline SCLPDevice *get_sclp_device(void)
>>      return sclp;
>>  }
>> =20
>> +static inline bool sclp_command_code_valid(uint32_t code)
>> +{
>> +    switch (code & SCLP_CMD_CODE_MASK) {
>> +    case SCLP_CMDW_READ_SCP_INFO:
>> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
>> +    case SCLP_CMDW_READ_CPU_INFO:
>> +    case SCLP_CMDW_CONFIGURE_IOA:
>> +    case SCLP_CMDW_DECONFIGURE_IOA:
>> +    case SCLP_CMD_READ_EVENT_DATA:
>> +    case SCLP_CMD_WRITE_EVENT_DATA:
>> +    case SCLP_CMD_WRITE_EVENT_MASK:
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>>  static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, in=
t *count)
>>  {
>>      MachineState *ms =3D MACHINE(qdev_get_machine());
>> @@ -193,6 +209,43 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *=
sccb, uint32_t code)
>>      }
>>  }
>> =20
>> +/*
>> + * We only need the address to have something valid for the
>> + * service_interrupt call.
>> + */
>> +#define SCLP_PV_DUMMY_ADDR 0x4000
>> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>> +                                uint32_t code)
>> +{
>> +    SCLPDevice *sclp =3D get_sclp_device();
>> +    SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
>> +    SCCB work_sccb;
>> +    hwaddr sccb_len =3D sizeof(SCCB);
>> +
>> +    /*
>> +     * Only a very limited number of calls is permitted by the
>> +     * Ultravisor and we support all of them, so we don't check for
>=20
> This is no longer true, no?

Right, I just removed the comment.

>=20
>> +     * them. All other specification exceptions are also interpreted
>> +     * by the Ultravisor and hence never cause an exit we need to
>> +     * handle.
>> +     *
>> +     * Setting the CC is also done by the Ultravisor.
>> +     */
>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
>> +
>> +    if (!sclp_command_code_valid(code)) {
>> +        work_sccb.h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_SCL=
P_COMMAND);
>> +        goto out_write;
>> +    }
>> +
>> +    sclp_c->execute(sclp, &work_sccb, code);
>> +out_write:
>> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
>> +                          be16_to_cpu(work_sccb.h.length));
>> +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>> +    return 0;
>> +}
>> +
>>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t cod=
e)
>>  {
>>      SCLPDevice *sclp =3D get_sclp_device();
>=20



--iYPdueyBB8cGD20JLe8FfzxGPYBN5JNSL--

--FRmWJ6IrCdsmxoK9HZNtttvEa0qVpinVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5zabYACgkQ41TmuOI4
ufhktA/9GydAKuppDkC2eYpT+75J3lTTs2xzaHe7iXuHTj+vMkhXYmrm/i3PqunH
IEK0s0Z+a0GGd+4p7ewsSm6nSChgDu7nczqd+mtyU8epo3KAGDm220Rwdc5IXMeg
nO1xlFTIe5mRRj2+/JsoXdr0zUAV9VdGwANlNloxt0QIREqIVZMCyjUxzY+N91Rm
msXiPqdFhFquXmKxP/5gLgl3bbkIELIyS3BZ5CKWjq0kVgY2S1j+vTbg0BgsPHn4
prQWIoUWj8rNmqnzQef8/h6HPU8cu7N1s/SaszUET3h2dK2rDQN/m2TQCksGgDy3
BteXpm7qrHSV5hESXMvVMJhi7zhJkUrMkvqIvsmmg3l3I63f4+NcLMS1KkQLfj4f
zemX+v/8JwUGndiX6/OCXfVH5PLWpiqtHkVsWNdmn0HMJ/ctzo3FU6WriujvJcu7
zHSvHeJ80GRDi3sKpHnsK7qIvP2GZlecaXCAMAKgOldqrPM86ICoXGmbB9jjJvbs
aaivdPVOW8ryO+lk3V/QUdP8XEYwtn9c9OUSu8MnBRrB95lY2LaUJjV/oUV3Gfnm
pLi+AwvFPfmfV63GRyilieBbBj3QnKU5Rwflmsa5o/7cnxhjJesv/YPDEaZLqiHo
hXM5OcaodF/JngIOPajBcVrlCB8ZLzO86zpI9WxkGIG8YB2Rds8=
=yaCz
-----END PGP SIGNATURE-----

--FRmWJ6IrCdsmxoK9HZNtttvEa0qVpinVg--


