Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEE6C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1F4206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1F4206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXn9P-00041u-97
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXn18-0005CI-Nc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXn16-0005JK-9M
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:01:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15888
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXn16-0005IL-3P
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:01:04 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xALDvtPk115480
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:01:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdfxu708y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:01:00 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 21 Nov 2019 14:00:58 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 14:00:54 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xALE0rlf42336588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 14:00:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6735DAE051;
 Thu, 21 Nov 2019 14:00:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E968DAE05A;
 Thu, 21 Nov 2019 14:00:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.70.129])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2019 14:00:52 +0000 (GMT)
Subject: Re: [PATCH 07/15] s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
To: Cornelia Huck <cohuck@redhat.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-8-frankja@linux.ibm.com>
 <20191121145001.5e7a182d.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 21 Nov 2019 15:00:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121145001.5e7a182d.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p46EtOKbPysJxPt9isRDLQ8OSAMdRepQ4"
X-TM-AS-GCONF: 00
x-cbid: 19112114-0012-0000-0000-0000036A56D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112114-0013-0000-0000-000021A5EB3D
Message-Id: <3101996a-93f6-b7e3-a44b-4e663f6beff6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210127
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p46EtOKbPysJxPt9isRDLQ8OSAMdRepQ4
Content-Type: multipart/mixed; boundary="LxhFn1LTJfRpYZ9ElrU7I0Y6rMRpUsaxB"

--LxhFn1LTJfRpYZ9ElrU7I0Y6rMRpUsaxB
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/21/19 2:50 PM, Cornelia Huck wrote:
> On Wed, 20 Nov 2019 06:43:26 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Now that we know the protection state off the cpus, we can start
>> handling all diag 308 subcodes in the protected state.
>=20
> "As we now have access to the protection state of the cpus, we can
> implement special handling of diag 308 subcodes for cpus in the
> protected state."
>=20
> ?

Sure

>=20
>>
>> For subcodes 0 and 1 we need to unshare all pages before continuing,
>> so the guest doesn't accidently expose data when dumping.
>>
>> For subcode 3/4 we tear down the protected VM and reboot into
>> unprotected mode. We do not provide a secure reboot.
>>
>> Before we can do the unshare calls, we need to mark all cpus as
>> stopped.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 30 +++++++++++++++++++++++++++---
>>  target/s390x/diag.c        |  4 ++++
>>  2 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 7262453616..6fd50b4c42 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -319,11 +319,26 @@ static inline void s390_do_cpu_ipl(CPUState *cs,=
 run_on_cpu_data arg)
>>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>  }
>> =20
>> +static void s390_pv_prepare_reset(CPUS390XState *env)
>> +{
>> +    CPUState *cs;
>> +
>> +    if (!env->pv) {
>> +        return;
>> +    }
>> +    CPU_FOREACH(cs) {
>> +        s390_cpu_set_state(S390_CPU_STATE_STOPPED, S390_CPU(cs));
>> +    }
>> +    s390_pv_unshare();
>> +    s390_pv_perf_clear_reset();
>> +}
>> +
>>  static void s390_machine_reset(MachineState *machine)
>>  {
>>      enum s390_reset reset_type;
>>      CPUState *cs, *t;
>>      S390CPU *cpu;
>> +    CPUS390XState *env;
>> =20
>>      /* get the reset parameters, reset them once done */
>>      s390_ipl_get_reset_request(&cs, &reset_type);
>> @@ -332,29 +347,38 @@ static void s390_machine_reset(MachineState *mac=
hine)
>>      s390_cmma_reset();
>> =20
>>      cpu =3D S390_CPU(cs);
>> +    env =3D &cpu->env;
>> =20
>>      switch (reset_type) {
>>      case S390_RESET_MODIFIED_CLEAR:  /* Subcode 0 */
>> +        subsystem_reset();
>> +        s390_crypto_reset();
>> +        s390_pv_prepare_reset(env);
>>          CPU_FOREACH(t) {
>>              run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>>          }
>> -        subsystem_reset();
>> -        s390_crypto_reset();
>=20
> This also switches the order in which different parts are reset for
> normal guests. I presume that order doesn't matter here?

I don't think that the order is specified in the POP, it is however
specified for protected VMs...

>=20
>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>          break;
>>      case S390_RESET_LOAD_NORMAL: /* Subcode 1*/
>=20
> missing blank before */ (introduced in a previous patch)

Will fix

>=20
>=20
>> +        subsystem_reset();
>> +        s390_pv_prepare_reset(env);
>>          CPU_FOREACH(t) {
>>              if (t =3D=3D cs) {
>>                  continue;
>>              }
>>              run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>>          }
>> -        subsystem_reset();
>>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>          break;
>>      case S390_RESET_EXTERNAL:
>=20
> Annotate this with the subcode as well? (in the patch introducing it)

Sure

>=20
>>      case S390_RESET_REIPL: /* Subcode 4 */
>> +        if (env->pv) {
>> +            CPU_FOREACH(t) {
>> +                s390_pv_vcpu_destroy(t);
>> +            }
>> +            s390_pv_vm_destroy();
>> +        }
>>          qemu_devices_reset();
>>          s390_crypto_reset();
>>          /* configure and start the ipl CPU only */
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index 32049bb4ee..db6d79cef3 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -68,6 +68,10 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1=
, uint64_t r3)
>>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64=
_t addr,
>>                                uintptr_t ra, bool write)
>>  {
>> +    /* Handled by the Ultravisor */
>> +    if (env->pv) {
>> +        return 0;
>> +    }
>>      if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          return -EINVAL;
>=20



--LxhFn1LTJfRpYZ9ElrU7I0Y6rMRpUsaxB--

--p46EtOKbPysJxPt9isRDLQ8OSAMdRepQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3WmJQACgkQ41TmuOI4
ufhplw//dxyeksQpjouVpQLyqaS9RRLRTcur/9HGZjvMjNZ+ON4mlrznNbitqXBr
KvHscSg333oFAVl9p/32WnpAD4YuhAMVbme7kPvcXmkMa1SteMi1n6LwmdJ8uHn8
e7fj5P3nARixZTNugjrw5borqiz2mA8F4wZRv2aozNf9eIBNFnsOPB8j3bBkCH4W
Fu52jU3UQ8BN+O7SOUDQfI1at9HfYovdWfGfdpSIz/P8R1zNrxR5C0iOj2ADQJDo
+a9bpkfQZM7+f5CI0+AzWZ9rEf4vo/Tk8djCgH5OlutTwhByLalzG3vLYjNGMeaH
z32lyEjHqh45ATb5n346RSVVqVmHxsmmN4EsoqgUmbeTMEdoXtZ0g2ArsznzZl3P
mmwqzVG+tg1FwmPuF1qORnSWyQ+Ub1w3oBxfThDtX6fzFCNHSSZ61Ismsj/o9lKW
V+ftp4jhlex2jIPSgQeZZAX7aQEKr6z4C+o2jUa1yYZnScG11z4vP5ik4hyM1cO+
AfU8/yP/mbYPCz97QSm1YzPj8CuietupzEtXW+cyRLoiFRQ53iDw8IYZHl6qXPX7
MzYuUpqgbd0ohXHqNBT8Lg5Cc7ipKAmY9S9JI5mGXRqstKgXjtDwIbP2geWfGoAh
xKJ/fuBfk5GsQ2sx6fC2n/+oz1+blhzCYfdVouDgXB/GVwSdibk=
=7bn2
-----END PGP SIGNATURE-----

--p46EtOKbPysJxPt9isRDLQ8OSAMdRepQ4--


