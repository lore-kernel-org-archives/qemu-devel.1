Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3703C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5962168B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gsKpgGEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5962168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWA6-0001AA-Ja
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kVW8e-0000VN-U3; Thu, 22 Oct 2020 04:40:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kVW8b-0002t9-AS; Thu, 22 Oct 2020 04:40:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09M8WOL8012180; Thu, 22 Oct 2020 04:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=APGCXCP0KIdr8pqx1c0VSvaYWlHXPRwn1zzEUcT8LpM=;
 b=gsKpgGExWv6Y+4D3vDO7mXBzQqB+VbLQ4ItokNtZ7DJuoS2MFRpKTKfpy8NvxiWM3ZUt
 UU4LeSnaM4xxUanEgZvuEx/QfgDpCANmdDoIStwAv2+NIhDkzDRfitI2Cd6gitsXS0MB
 TTeKEAJd+Uat9E7VhTVdCvlClvzCErjBt/9dHWfFS5b3EmbkFyrjOlNwq11gJh9vrg3y
 DGGo0xijy72iM34Dx/Lvc+5LBjv11eBw20RG/xHC2LCiFMwIi6sL7dOC9lHs4xpmBAXT
 ZrJwQ99AzpayzT4K0JKSxd5Rjiv2XGL5jRFsxzoQn2kuq2J2L51H2IPmciTrjmAsaVbR fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b0829yug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 04:39:54 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09M8XDrZ015205;
 Thu, 22 Oct 2020 04:39:54 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b0829yte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 04:39:54 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09M8ccKM004390;
 Thu, 22 Oct 2020 08:39:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06fra.de.ibm.com with ESMTP id 347qvhaqa0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 08:39:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09M8dmOa28770726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 08:39:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC10811C054;
 Thu, 22 Oct 2020 08:39:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52D2B11C04A;
 Thu, 22 Oct 2020 08:39:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.16.169])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 22 Oct 2020 08:39:48 +0000 (GMT)
Subject: Re: [PATCH] s390x: pv: Fix diag318 PV fencing
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <74c4631b-735c-e5ad-77a3-0bbd9c63c4db@redhat.com>
 <20201022082312.124708-1-frankja@linux.ibm.com>
 <3c2d61a4-1312-14a9-ac99-c562dfedcf31@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <74499bb4-b873-1191-e8ca-cf64303e3970@linux.ibm.com>
Date: Thu, 22 Oct 2020 10:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3c2d61a4-1312-14a9-ac99-c562dfedcf31@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JhuOjEE0AfatOM4ajrEYAPpyAJMO3eh8V"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-22_02:2020-10-20,
 2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220053
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:23:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, cohuck@redhat.com, walling@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mhartmay@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JhuOjEE0AfatOM4ajrEYAPpyAJMO3eh8V
Content-Type: multipart/mixed; boundary="36SIw6i6JvspcP7GRoU4yJk47mhSv1647"

--36SIw6i6JvspcP7GRoU4yJk47mhSv1647
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/22/20 10:32 AM, David Hildenbrand wrote:
> On 22.10.20 10:23, Janosch Frank wrote:
>> Diag318 fencing needs to be determined on the current VM PV state and
>> not on the state that the VM has when we create the CPU model.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Fixes: fabdada935 ("s390: guest support for diagnose 0x318")
>> ---
>>
>> If you're sure that this is what you want, then I'll send a v2 of the
>> patch set.
>=20
> So that's going to be the first CPU feature that gets suppressed in PC
> mode - which seems to be what we want.
>=20
> diag318_needed() will return false, resulting in vmstate_diag318() not
> being included in the migration stream (I know, we don't support
> migration yet for PV).

Well either you have it and need to migrate it or you don't.
As it doesn't persist over IPLs, that should not be a problem, no?

>=20
> I don't see where diag318 would get reset during a reipl - is it
> expected to be persistent when switching in/out of PV, or when reipling=

> etc..?

That's actually another bug we need to address. Diag318 will need to be
reset on a diag308 reset instead of when doing the cpu resets...

>=20
>>
>> ---
>>  target/s390x/cpu_features.c | 5 +++++
>>  target/s390x/cpu_features.h | 4 ++++
>>  target/s390x/cpu_models.c   | 4 ++++
>>  target/s390x/kvm.c          | 3 +--
>>  4 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c=

>> index 31ea8df246..42fe0bf4ca 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -14,6 +14,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu/module.h"
>>  #include "cpu_features.h"
>> +#include "hw/s390x/pv.h"
>> =20
>>  #define DEF_FEAT(_FEAT, _NAME, _TYPE, _BIT, _DESC) \
>>      [S390_FEAT_##_FEAT] =3D {                        \
>> @@ -105,6 +106,10 @@ void s390_fill_feat_block(const S390FeatBitmap fe=
atures, S390FeatType type,
>>          }
>>          feat =3D find_next_bit(features, S390_FEAT_MAX, feat + 1);
>>      }
>> +
>> +    if (type =3D=3D S390_FEAT_TYPE_SCLP_FAC134 && s390_is_pv()) {
>> +        clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
>> +    }
>>  }
>> =20
>>  void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType t=
ype,
>> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h=

>> index ef52ffce83..87463f064d 100644
>> --- a/target/s390x/cpu_features.h
>> +++ b/target/s390x/cpu_features.h
>> @@ -81,6 +81,10 @@ const S390FeatGroupDef *s390_feat_group_def(S390Fea=
tGroup group);
>> =20
>>  #define BE_BIT_NR(BIT) (BIT ^ (BITS_PER_LONG - 1))
>> =20
>> +static inline void clear_be_bit(unsigned int bit_nr, uint8_t *array)
>> +{
>> +    array[bit_nr / 8] &=3D ~(0x80 >> (bit_nr % 8));
>> +}
>>  static inline void set_be_bit(unsigned int bit_nr, uint8_t *array)
>>  {
>>      array[bit_nr / 8] |=3D 0x80 >> (bit_nr % 8);
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index ca484bfda7..461e0b8f4a 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -29,6 +29,7 @@
>>  #include "hw/pci/pci.h"
>>  #endif
>>  #include "qapi/qapi-commands-machine-target.h"
>> +#include "hw/s390x/pv.h"
>> =20
>>  #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _de=
sc) \
>>      {                                                                =
    \
>> @@ -238,6 +239,9 @@ bool s390_has_feat(S390Feat feat)
>>          }
>>          return 0;
>>      }
>> +    if (feat =3D=3D S390_FEAT_DIAG_318 && s390_is_pv()) {
>> +        return false;
>> +    }
>>      return test_bit(feat, cpu->model->features);
>>  }
>> =20
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index f13eff688c..baa070fdf7 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -2498,8 +2498,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *m=
odel, Error **errp)
>>       */
>>      set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
>> =20
>> -    /* DIAGNOSE 0x318 is not supported under protected virtualization=
 */
>> -    if (!s390_is_pv() && kvm_check_extension(kvm_state, KVM_CAP_S390_=
DIAG318)) {
>> +    if (kvm_check_extension(kvm_state, KVM_CAP_S390_DIAG318)) {
>>          set_bit(S390_FEAT_DIAG_318, model->features);
>>      }
>> =20
>>
>=20
>=20



--36SIw6i6JvspcP7GRoU4yJk47mhSv1647--

--JhuOjEE0AfatOM4ajrEYAPpyAJMO3eh8V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl+RRVMACgkQ41TmuOI4
ufivJg//RaDn6hOeijXjtnV3Zg0VXPBMFhWPhnzTSdNcU7VNXaDwMk8rHK3w0sQ0
Gsti9FEQ3QrTN+dwHh/QkFSizvuOsTJQKBxNzyOrWc0IyoJhbiBmyxefE+uJ2f6W
K9nlNiTBYFbXhKWeYkngPOzno4EF3PhQP6raCg8YsA5cJeMQSPbnuqAh5/T53kja
mLRCj95iU4RUkQpNJyj1EKlUrPQa5cFFvXjJG5fHLEn+SXIU1IdM9O3XiQnbX1j6
DZgN1tnr002cKHQYPIiHZSNpfYjQBMXhlS3CgUtvNMoJd7ZTHM1d5d/wBFDulcyP
32y9RFuas30bpP4u4IghdNap400yWLPFY0h8dXBB9UrDVJgWpWtI7C9lHvieETf0
fRYu3IA4pfP3pqBVjWmY+2wbQSYF3q+4VesEof4DQtRYv74hfBHtAJDWARmW1kfu
Ru39jvqazBjrx0HbwqNkPv2bPMHCmm3TtxdNe6vtVQR5oGMe+BmDB+aGtLLHoZfv
aecvUpXKEViIw/D8J4d2CAj8Xxt7DcbhadG29BgcqcWRlAD6zGMNUe+7BzOWf4xB
PfTRUa3w2NfoJ9NtGx00j6SQ6KwIOnLKc5HEj9WLY12Yj0BsAx4jAzEdF+nDdo1F
JhGeZFBQ/RbiOUeUVGeYHnqRv781H75waoiAwdiTbvn/VSt2ZFU=
=6OIr
-----END PGP SIGNATURE-----

--JhuOjEE0AfatOM4ajrEYAPpyAJMO3eh8V--


