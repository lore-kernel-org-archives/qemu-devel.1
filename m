Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86058C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6E2207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PploC0Ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6E2207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeJlj-0001Yl-F8
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jeJkk-0000uv-WC; Thu, 28 May 2020 10:43:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51272
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jeJkj-00076J-FP; Thu, 28 May 2020 10:43:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04SEZVff021812; Thu, 28 May 2020 10:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=eQ/MGiIh24IBa4XbkeBTwIUaVthzxi+agGHcwG0Y228=;
 b=PploC0JapI8IKdglfyM9O+YRR+sDDLI1Kdh6ty9JE2qtODkpUXQu6Is6DnjFQv759mF3
 ONo5lwRFEtFlWLGKTYuX6v5g+Qx8Szle8/+29cgmU8htq8/DFY6d6MGAZlp2uMbdfJrH
 hrtQgCEg9E19s0A20iM8IOivAS5oayXlsVkNckiwfqvLDIqkzCFKF089m/Gg6QGeuiK2
 xaExvppvbx1X50XlZSGiznE62CPq1EywIiwL/ZOI8u3Vd/jfm7f0qDLeoTDudHIuHeWU
 jTXv/HCY/bV4wXgUUTJC6gf0tRjbOi03SyB//1Ed0w6mJo3v7GeV8QhS667wsZ2g0cew mA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 319tyfbs11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2020 10:42:57 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04SEZTCZ021679;
 Thu, 28 May 2020 10:42:57 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 319tyfbs0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2020 10:42:57 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SEexpm017713;
 Thu, 28 May 2020 14:42:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03fra.de.ibm.com with ESMTP id 316uf843d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2020 14:42:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04SEgq4i47644870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2020 14:42:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53FFFAE055;
 Thu, 28 May 2020 14:42:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01401AE045;
 Thu, 28 May 2020 14:42:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.74.112])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 May 2020 14:42:50 +0000 (GMT)
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM if
 PV
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200522230451.632a3787.pasic@linux.ibm.com>
 <20200528132112.2a1fdf45.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eb340fdb-9453-2227-53f1-c507b3698f32@linux.ibm.com>
Date: Thu, 28 May 2020 16:42:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200528132112.2a1fdf45.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yzFN00To9H82ZFoiYdugMhih1XYJ4IdHQ"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-28_03:2020-05-28,
 2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 priorityscore=1501 cotscore=-2147483648
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280097
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 10:42:58
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yzFN00To9H82ZFoiYdugMhih1XYJ4IdHQ
Content-Type: multipart/mixed; boundary="cWSGx8k2xeUTRpi64GMfvO0LLj2hdg8lg"

--cWSGx8k2xeUTRpi64GMfvO0LLj2hdg8lg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/28/20 1:21 PM, Cornelia Huck wrote:
> On Fri, 22 May 2020 23:04:51 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
>> On Wed, 20 May 2020 12:23:24 -0400
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Fri, May 15, 2020 at 12:11:55AM +0200, Halil Pasic wrote: =20
>>>> The virtio specification tells that the device is to present
>>>> VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
>>>> device "can only access certain memory addresses with said access
>>>> specified and/or granted by the platform". This is the case for a
>>>> protected VMs, as the device can access only memory addresses that a=
re
>>>> in pages that are currently shared (only the guest can share/unsare =
its
>>>> pages).
>>>>
>>>> No VM, however, starts out as a protected VM, but some VMs may be
>>>> converted to protected VMs if the guest decides so.
>>>>
>>>> Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM v=
ia
>>>> the property iommu_on is a minor disaster. Since the correctness of =
the
>>>> paravirtualized virtio devices depends (and thus in a sense the
>>>> correctness of the hypervisor) it, then the hypervisor should have t=
he
>>>> last word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented =
or
>>>> not. =20
>>>
>>> So, how about this: switch iommu to on/off/auto. =20
>>
>> Many thanks for the reveiw, and sorry about the delay on my side. We
>> have holidays here in Germany and I was not motivated enough up until
>> now to check on my mails.
>>
>>
>> I've actually played  with the thought of switching iommu_platform to =

>> 'on/off/auto', but I didn't find an easy way to do it. I will look
>> again. This would be the first property of this kind in QEMU, or?
>=20
> virtio-pci uses it for 'disable-legacy'.
>=20
>>
>> The 'on/off/auto' would be certainly much cleaner form user-interface
>> perspective. The downsides are that it is more invasive, and more
>> complicated. I'm afraid that it would also leave more possibilities fo=
r
>> user error.
>=20
> To me, on/off/auto sounds like a reasonable thing to do.
>=20
> What possibilities of 'user error' do you see? Shouldn't we fence off
> misconfigurations, if the consequences would be disastrous?
>=20
>>
>>>  Add a property with a
>>> reasonable name "allow protected"?  If set allow switch to protected
>>> memory and also set iommu auto to on by default.  If not set then don=
't.
>>> =20
>>
>> I think we have "allow protected" already expressed via cpu models. I'=
m
>> also not sure how libvirt would react to the idea of a new machine
>> property for this. You did mean "allow protected" as machine property,=

>> or?
>=20
> "Unpack facility in cpu model" means "guest may transition into pv
> mode", right? What does it look like when the guest actually has
> transitioned?

Well, we don't sync the features that the protected guest has back into
QEMU. So basically the VM doesn't really change except for ms->pv now
being true.



>=20
>>
>> AFAIU "allow protected" would be required for the !PV to PV switch, an=
d
>> we would have to reject paravirtualized devices with iommu_platform=3D=
'off'
>> on VM construction or hotplug (iommu_platform=3D'auto/on' would be fin=
e).
>>
>> Could you please confirm that I understood this correctly?
>>
>>
>>> This will come handy for other things like migrating to hosts without=

>>> protected memory support.
>>>  =20
>>
>> This is already covered by cpu model AFAIK.
>=20
> I don't think we'd want to migrate between pv and non-pv anyway?

What exactly do you mean by that?
I'd expect that the VM can either be migrated in PV or non-PV mode and
not in a transition phase.

>=20
>>
>>>
>>> Also, virtio now calls this PLATFORM_ACCESS, maybe we should rename
>>> the property (keeping old one around for compat)? =20
>>
>> You mean the like rename 'iommu_platform' to 'platform_access'? I like=

>> the idea, but I'm not sure libvirt will like it as well. Boris any
>> opinions?
>>
>>> I feel this will address lots of complaints ...
>>>  =20
>>>> Currently presenting a PV guest with a (paravirtualized) virtio-ccw
>>>> device has catastrophic consequences for the VM (after the hyperviso=
rs
>>>> access to protected memory). This is especially grave in case of dev=
ice
>>>> hotplug (because in this case the guest is more likely to be in the
>>>> middle of something important).
>>>>
>>>> Let us manage the VIRTIO_F_ACCESS_PLATFORM virtio feature automatica=
lly
>>>> for virtio-ccw devices, i.e. force it before we start the protected =
VM.
>>>> If the VM should cease to be protected, the original value is restor=
ed.
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com> =20
>>>
>>>
>>> I don't really understand things fully but it looks like you are
>>> changing features of a device.  If so this bothers me, resets
>>> happen at random times while driver is active, and we never
>>> expect features to change.
>>> =20
>>
>> Changing the device features is IMHO all right because the features ca=
n
>> change only immediately after a system reset and before the first vCPU=

>> is run. That is ensured by two facts.
>>
>>
>> First, the feature can only change when ms->pv changes. That is on the=

>> first reset after the VM entered or left the "protected virtualization=
"
>> mode of operation. And that switch requires a system reset. Because th=
e
>> PV switch is initiated by the guest, and the guest is rebooted as a
>> consequence, the guest will never observe the change in features.
>=20
> This really needs more comments, as it is not obvious to the casual
> reader. (I also stumbled over the resets.)
>=20
> But I wonder whether we are actually missing those subsystems resets
> today?
>=20
>=20



--cWSGx8k2xeUTRpi64GMfvO0LLj2hdg8lg--

--yzFN00To9H82ZFoiYdugMhih1XYJ4IdHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7PzeoACgkQ41TmuOI4
ufiy8xAAjZTPBYb6PPIKbfUeoUKQObDZrb6VAFSBE2yCaCd0nymcMMYoaQw/ffHf
ve5m6qrc15hJFWwneG60h7XKAU6kEAjFkHe5Og5+AFPY8rQUqs729YE0nuxa0GJi
6Ib7Fjw3y84gYZndOGr8kKksFvUUTLHVrzZJaaYenHCL4pH4HWB5gYyqCIgqX8Uq
gXZNiuIO2C532c7F7l7yfzn5yKQocMIvCfnbFuj4WDsZDtKwOfCkTzOPld69/3VB
fArjL9p2ALNtxOkn0e6bpanWzHMI1ev1ITMTVvfH4KJcMyWP+tcuk4eXkTnCg0FA
Idy30OKWKe/8fCmu0V0VccoyzHA6L8ZGvO02/uu7aWUwXhrT/rv/PBbuy9gLEjhK
fw1T8XsUwel743HXCsH+F0E6flPV5L1jMEjKN4OR/ArKOfTOScXOPtT4GUkbcPTc
FWEF00AyHM5yb6e6/94BsvkENxNr1eZVsLTGXOlP2fx5VMnh4HLS17AfJlHVBI2J
5lcAD0oMUglYjOuim82IBwDS01+BMFHtsJMveKVbKIpv4R4fHUy+54ufQb7edCSD
g6B9hy8Q9tjRCtz3N7hDRl8LMkVkljFNZ3JxkXMOzIBsEUef1ERAYaga6eFCF198
IonN75z9QSPQKApkVV4WUb1wDhi1XqSRVA6SNnnTqdyKv0aZJI4=
=RhNU
-----END PGP SIGNATURE-----

--yzFN00To9H82ZFoiYdugMhih1XYJ4IdHQ--


