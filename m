Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDE9C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7189720409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7189720409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGITH-0001MU-JV
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jGISd-0000vN-GB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jGISc-0005dn-DY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:29:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48648
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jGISc-0005dL-7J
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:29:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02N8F5Ji120152
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:29:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yxsebs1cn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:29:24 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 23 Mar 2020 08:29:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 23 Mar 2020 08:29:19 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02N8TITb54526162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2020 08:29:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65C14A4040;
 Mon, 23 Mar 2020 08:29:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12FCCA4055;
 Mon, 23 Mar 2020 08:29:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.67.204])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2020 08:29:17 +0000 (GMT)
Subject: Re: [PATCH v11 03/16] s390x: protvirt: Support unpack facility
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Bruce Rogers <brogers@suse.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200319131921.2367-1-frankja@linux.ibm.com>
 <20200319131921.2367-4-frankja@linux.ibm.com>
 <85df56f2bc703e38a19150f51c9a6501dffefd16.camel@suse.com>
 <28dc03df-79ac-35f8-32af-4e793a3559b8@de.ibm.com>
 <ea710b6b-3a8a-422e-ce67-1611eb0c970b@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Mon, 23 Mar 2020 09:29:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ea710b6b-3a8a-422e-ce67-1611eb0c970b@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v46paGIS6wyixht2LD8J9NI1Hv6RJvg3p"
X-TM-AS-GCONF: 00
x-cbid: 20032308-0016-0000-0000-000002F61551
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032308-0017-0000-0000-00003359AC77
Message-Id: <ec5454c3-787d-16e2-a9fa-13a3eb8c7a48@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-23_02:2020-03-21,
 2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003230045
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>, "david@redhat.com" <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v46paGIS6wyixht2LD8J9NI1Hv6RJvg3p
Content-Type: multipart/mixed; boundary="shQnxywMmI6Wr92X4gmv4UIwNWgigpfFT"

--shQnxywMmI6Wr92X4gmv4UIwNWgigpfFT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/23/20 8:37 AM, Christian Borntraeger wrote:
>=20
>=20
> On 23.03.20 08:15, Christian Borntraeger wrote:
>> [...]
>>
>>>> +int s390_ipl_prepare_pv_header(void)
>>>> +{
>>>> +    IplParameterBlock *ipib =3D s390_ipl_get_iplb_pv();
>>>> +    IPLBlockPV *ipib_pv =3D &ipib->pv;
>>>> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
>>>> +    int rc;
>>>> +
>>>> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>>>> +                             ipib_pv->pv_header_len);
>>>> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
>>>> +                               ipib_pv->pv_header_len);
>>> This causes a compiler issue when building for 32 bit x86 as follows:=

>>>
>>> /home/abuild/rpmbuild/BUILD/qemu-4.2.0/hw/s390x/ipl.c: In function
>>> 's390_ipl_prepare_pv_header':
>>> /home/abuild/rpmbuild/BUILD/qemu-4.2.0/hw/s390x/ipl.c:659:32: error:
>>> cast from pointer to integer of different size [-Werror=3Dpointer-to-=
int-
>>> cast]
>>>   659 |     rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
>>>       |                                ^
>>
>> Interesting. It seems that there is no travis-ci coverage for this
>> case.
>>
>> I guess we need something like this.
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 1d04cd5..01bdf81 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -656,7 +656,7 @@ int s390_ipl_prepare_pv_header(void)
>> =20
>>      cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>>                               ipib_pv->pv_header_len);
>> -    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
>> +    rc =3D s390_pv_set_sec_parms((uint64_t)(unsigned long) hdr,
>>                                 ipib_pv->pv_header_len);
>=20
> uint_ptr instead of long is probably even better (for Windows).
>=20

Yeah, I was wondering why you did a double cast instead of uintptr_t. ;-)=


I'll send out a revised version soon.


--shQnxywMmI6Wr92X4gmv4UIwNWgigpfFT--

--v46paGIS6wyixht2LD8J9NI1Hv6RJvg3p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl54c10ACgkQ41TmuOI4
ufjwvQ/9EVlWEJ4Flyu4ceg5IPHejH7/nx346FMb/In9LQwQ06O8JD/FxlYtYc0P
iNgym2qh1FV6HoZ1KKDRHTXUs1yHe8QrXaI0gg6d0s5uFbvBDW2ZUV2+V52E1YfW
YkjtoKBJdFZp9z8ICNapsFukFIPnTbRlzj+vj+jy5bTUG0JuGPrttoHkJnM9rLkZ
KGVmyl497wQRkmTKY1yXoy9Nh4o11Qnar3jC0yzlAnLcq3eFB4DqLl1PuJyrGy0x
OIjbNxnDrYwC6gZYlxxryG2Jgt1XmXEV94I1s2m/wJ+5uV95U7jm++51tneIlWE5
ISw6xzbuoLx00o7HRQchpEv7CF2ibkfrb7xjrhtW9Dq1iNi26PlpkmvH8/xU6CAW
IzgwNQD3lkWGP8Z03OwQmCJxJEMctLJmMATsEfKjbc+ndAF+6HMSm32fCdFyHAtp
Pgt6bJpbT8bob4mU3qqNbPiLYB9hyyBbfTsE5i14d71vdvKOXEZvhxGmL60v2cpL
/Uoc+H2pKBZVeeuU+WKHwSZJ4uABuEMzS1OgDeorpwY0fPM4DN9CooW3B/V6X+Om
lsFIT1NtTM9lveBUHq3O3slfpJ3rhszdGrk1Fsd+QIoNOqkTTvZY9/urJlojvClx
H2fEURSYGSdzGyn1lE9GQex5Bqc4nD8jY9ewVUDM2XtQu/dDgdM=
=Xtir
-----END PGP SIGNATURE-----

--v46paGIS6wyixht2LD8J9NI1Hv6RJvg3p--


