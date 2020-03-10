Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5834C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8712051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8712051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBb8U-0002RQ-PS
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBb7G-0000mD-RY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBb7F-00038K-5c
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:23:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBb7E-00035h-Rn
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:23:57 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02A9KsrX055134
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:23:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym851q6w2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:23:55 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 10 Mar 2020 09:23:52 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 09:23:51 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02A9NoID40042744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 09:23:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4627A5204E;
 Tue, 10 Mar 2020 09:23:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.23.214])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E089452050;
 Tue, 10 Mar 2020 09:23:49 +0000 (GMT)
Subject: Re: [PATCH v8 2/2] s390x: protvirt: Support unpack facility
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <b608f7d8-81ac-1e5b-011d-bd576f77aade@redhat.com>
 <20200310083232.29805-1-frankja@linux.ibm.com>
 <20200310083232.29805-2-frankja@linux.ibm.com>
 <100bd846-61f1-973b-b97f-753463646e68@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 10 Mar 2020 10:23:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <100bd846-61f1-973b-b97f-753463646e68@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F1tzdirlg6MVp0UXlbJppExOoMGo6J68C"
X-TM-AS-GCONF: 00
x-cbid: 20031009-0008-0000-0000-0000035B14C1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031009-0009-0000-0000-00004A7C572B
Message-Id: <a7f478fa-3181-63fc-ce65-4006d64098b0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_04:2020-03-09,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=2 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100064
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F1tzdirlg6MVp0UXlbJppExOoMGo6J68C
Content-Type: multipart/mixed; boundary="wb3IHWfiehe0VXObegyzwuuVqO9zmwIXY"

--wb3IHWfiehe0VXObegyzwuuVqO9zmwIXY
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/10/20 10:00 AM, David Hildenbrand wrote:
> On 10.03.20 09:32, Janosch Frank wrote:
>> The unpack facility provides the means to setup a protected guest. A
>> protected guest can not be introspected by the hypervisor or any
>> user/administrator of the machine it is running on.
>>
>> Protected guests are encrypted at rest and need a special boot
>> mechanism via diag308 subcode 8 and 10.
>>
>> Code 8 sets the PV specific IPLB which is retained seperately from
>> those set via code 5.
>>
>> Code 10 is used to unpack the VM into protected memory, verify its
>> integrity and start it.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Chang=
es
>> to machine]
>=20
> [...]
>=20
>=20
>> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
>> new file mode 100644
>> index 0000000000..ba6409246e
>> --- /dev/null
>> +++ b/hw/s390x/pv.c
>> @@ -0,0 +1,104 @@
>> +/*
>> + * Secure execution functions
>=20
> Protected virtualization ;)

Ack

>=20
>> + *
>> + * Copyright IBM Corp. 2020
>> + * Author(s):
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 (at
>> + * your option) any later version. See the COPYING file in the top-le=
vel
>> + * directory.
>> + */
>=20
> [...]
>=20
>>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>  {
>> @@ -238,9 +240,11 @@ static void s390_create_sclpconsole(const char *t=
ype, Chardev *chardev)
>>  static void ccw_init(MachineState *machine)
>>  {
>>      int ret;
>> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);
>>      VirtualCssBus *css_bus;
>>      DeviceState *dev;
>> =20
>> +    ms->pv =3D false;
>=20
> As discussed, not needed.

Ack

>=20
>>      s390_sclp_init();
>>      /* init memory + setup max page size. Required for the CPU model =
*/
>>      s390_memory_init(machine->ram);
>> @@ -316,10 +320,88 @@ static inline void s390_do_cpu_ipl(CPUState *cs,=
 run_on_cpu_data arg)
>>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>  }
>> =20
>> +static void s390_machine_unprotect(S390CcwMachineState *ms)
>> +{
>> +    CPUState *t;
>> +
>> +    s390_pv_vm_disable();
>> +    CPU_FOREACH(t) {
>> +        S390_CPU(t)->env.pv =3D false;
>> +    }
>=20
> See below, would be great if we can get rid of env.pv IMHO.
>=20
> [...]

I'll have a look

>=20
>> +    case S390_RESET_PV: /* Subcode 10 */
>> +        subsystem_reset();
>> +        s390_crypto_reset();
>> +
>> +        CPU_FOREACH(t) {
>> +            if (t =3D=3D cs) {
>> +                continue;
>> +            }
>> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>> +        }
>> +        run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>> +
>> +        if (s390_machine_protect(ms)) {
>> +            s390_machine_inject_pv_error(cs);
>> +            /*
>> +             * Continue after the diag308 so the guest knows somethin=
g
>> +             * went wrong.
>> +             */
>> +            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>> +            return;
>=20
> Didn't you want to squash in that hunk from the other patch? (I remembe=
r
> seeing a goto)

I chose to leave it this way so we don't jump around with the goto

>=20
>> +        }
>> +
>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>          break;
>>      default:
>=20
> [...]
>=20
>> =20
>> +#if !defined(CONFIG_USER_ONLY)
>> +static bool machine_is_pv(MachineState *ms)
>> +{
>> +    static S390CcwMachineState *ccw;
>> +    Object *obj;
>> +
>> +    if (ccw)
>> +	    return ccw->pv;
>=20
> missing {}
>=20
>> +
>> +    /* we have to bail out for the "none" machine */
>> +    obj =3D object_dynamic_cast(OBJECT(ms), TYPE_S390_CCW_MACHINE);
>> +     if (!obj) {
>> +        return false;
>> +    }
>> +    ccw =3D S390_CCW_MACHINE(obj);
>> +    return ccw->pv;
>> +}
>> +#endif
>=20
> Now that we talked about cached values, what about
>=20
> #if !defined(CONFIG_USER_ONLY)
> static bool s390_is_pv(void)
> {
>     static S390CcwMachineState *ccw;
>     Object *obj;
>=20
>     if (ccw) {
>         return ccw->pv;
>     }
>=20
>     /* we have to bail out for the "none" machine */
>     obj =3D object_dynamic_cast(qdev_get_machine(),
>                               TYPE_S390_CCW_MACHINE);
>     if (!obj) {
>         return false;
>     }
>     ccw =3D S390_CCW_MACHINE(obj);
>     return ccw->pv;
> }
> #endif
>=20
> and drop all env->pv checks, replacing them by s390_is_pv(). (sorry,
> should have recommended that earlier)

Fine by me.
@Christian: Opinions?

>=20
>> +
>>  static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>>  {
>>      CPUState *cs =3D CPU(dev);
>> @@ -205,6 +226,7 @@ static void s390_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>>          goto out;
>>      }
>> =20
>> +    cpu->env.pv =3D machine_is_pv(ms);
>>      /* sync cs->cpu_index and env->core_id. The latter is needed for =
TCG. */
>>      cs->cpu_index =3D cpu->env.core_id;
>>  #endif
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 1d17709d6e..7e4d9d267c 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -114,6 +114,7 @@ struct CPUS390XState {
>> =20
>>      /* Fields up to this point are cleared by a CPU reset */
>>      struct {} end_reset_fields;
>> +    bool pv; /* protected virtualization */
>> =20
>>  #if !defined(CONFIG_USER_ONLY)
>>      uint32_t core_id; /* PoP "CPU address", same as cpu_index */
>> diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_fe=
atures_def.inc.h
>> index 31dff0d84e..60db28351d 100644
>> --- a/target/s390x/cpu_features_def.inc.h
>> +++ b/target/s390x/cpu_features_def.inc.h
>> @@ -107,6 +107,7 @@ DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, =
"Deflate-conversion facility (
>>  DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH, "vxpdeh", STFL, 152, "Vector-Pack=
ed-Decimal-Enhancement Facility")
>>  DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-=
extension-9 facility (excluding subfunctions)")
>>  DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
>> +DEF_FEAT(UNPACK, "unpack", STFL, 161, "Unpack facility")
>=20
> Random thought: The naming of that facility could have been improved to=

> something that gives users/readers an idea what it's actually doing.

That's the name from our specifications and with those feature bits we
normally use the facility names from those docs, no?
Something like "protected guest boot facility" would certainly have been
better to understand.

>=20
>=20
> [...]
>=20
>> @@ -128,17 +142,31 @@ out:
>>          g_free(iplb);
>>          return;
>>      case DIAG308_STORE:
>> +    case DIAG308_PV_STORE:
>>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>>              return;
>>          }
>> -        iplb =3D s390_ipl_get_iplb();
>> +        if (subcode =3D=3D DIAG308_PV_STORE) {
>> +            iplb =3D s390_ipl_get_iplb_pv();
>> +        } else {
>> +            iplb =3D s390_ipl_get_iplb();
>> +        }
>>          if (iplb) {
>>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->l=
en));
>>              env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>>          } else {
>>              env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
>>          }
>> -        return;
>> +        break;
>=20
> return->break is unrelated, but we do have a wild mixture already.

I removed it here and in the move diag structures over SIDA patch.
After this has been merged I can do a cleanup patch if wanted.

>=20
>> +    case DIAG308_PV_START:
>> +        iplb =3D s390_ipl_get_iplb_pv();
>> +        if (!iplb) {
>> +            env->regs[r1 + 1] =3D DIAG_308_RC_NO_PV_CONF;
>> +            return;
>> +        }
>> +
>> +        s390_ipl_reset_request(cs, S390_RESET_PV);
>> +        break;
>>      default:
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          break;
>>
>=20
>=20



--wb3IHWfiehe0VXObegyzwuuVqO9zmwIXY--

--F1tzdirlg6MVp0UXlbJppExOoMGo6J68C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5nXKUACgkQ41TmuOI4
ufgF2g/+PoOH07Mq3eO4pSyfp0iMIBYyqd3u5HyYHzzFQOGu0QrzYipVVzEHNxol
it5jrRk+SXx889jZ5HuMjtkPwj2pPkTNxj/hhCNQVjvwOth/3rZLrn6yXQNJTMGG
xIXlUv4q2d/WsbYMnmNeu6ZxXEG9pFzDHbyyf6ZBhmQE3Aia2wrVEpRgXRwPygJN
q/eQaKJKKXv2qYL9mrg4e1/KYGVVjvXoQDm35fIhGIVMZmAn28imu1KOzholY1Mk
0GcWnP2kl49hB7IB7vIbZbGmw8UIGama2qCHLl6avXHwZPg/rHW45SKxO+/QWZgb
tNnMPrQE9+nykdzVTdeOZGPePbWiH1+gVPNuR7vtLPvb9cBmtzlnpjjRhqqFnAyd
9ZoZK0mb30r5N8VSF885XsnQ+LooYdGO7Nhnk3CEvBKgnTEwtGiIHAQmJbSlpqwQ
ibK1S8lGWQwxkxVqvrB89rMlrtIUzJQN2gkTe2zINaR8rHCyAM8kA9gre+smQq3X
f1bODC1AKvCtE8AFf4DbxOssloP0OskejZkOkITHzs9Xmefbg/UgWqlMid9dvUKV
IjuvXj7MxI7Wz9+5D0z7RFnHQ00wI80KodO7fW2hVRNqdfvYJxnO4YmVQOoF0wRT
IyugjDaMTOFCeQy7I5X8BjbOdx9Up2yoRvrcm1SlvlyrzyLqb2Y=
=hWn5
-----END PGP SIGNATURE-----

--F1tzdirlg6MVp0UXlbJppExOoMGo6J68C--


