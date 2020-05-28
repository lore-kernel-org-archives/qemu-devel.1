Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 18:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203092074B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 18:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ag/MgwjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203092074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeNcQ-0002Gq-6U
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 14:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jeNbj-0001Ui-NV; Thu, 28 May 2020 14:50:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56933
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jeNbi-0000RK-9j; Thu, 28 May 2020 14:50:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04SI3GCG169537; Thu, 28 May 2020 14:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type; s=pp1; bh=Li95ceZ3v2ln5HhMyqtu2zKdVNbMuRJ+mBidky84Nz4=;
 b=Ag/MgwjNEE5OE5kZ7cHbKPZXx2Ef/rAMBCMCuDm8tjo7M4Lj0yICukAT28cRyRPaeT9U
 pRTmU5jF9Ch0Ix3OmkB3+DVyXNhH8dPkBZGvnWTrn+F/DBxIy4zsC18vG1t1GWpUHGah
 gf/4lF+k3V/h8VGcRqnhysV/scE5D4chDMWpmz9HgovZfioE0aiPNTpUrm7chsneua2v
 syMmqUWqBZpiVht92FkCwHuDMTw5bvW4OC4ifFPTx6ZakcpgG5Y2Nf9HvWdQ//LP0wUN
 gEur3yM/oEwgjY1mjMZEBfu8LLEXOVw1Re48+sANipgsXwkiKC859k3tU7ZNi85rMp0T 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31agujv9us-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2020 14:50:20 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04SI3S9K170566;
 Thu, 28 May 2020 14:50:19 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31agujv9th-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2020 14:50:19 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SIfgbV016373;
 Thu, 28 May 2020 18:50:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 316uf92f6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2020 18:50:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04SIoF6763045788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2020 18:50:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AB284C050;
 Thu, 28 May 2020 18:50:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 763384C040;
 Thu, 28 May 2020 18:50:13 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.21.214])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 May 2020 18:50:13 +0000 (GMT)
Date: Thu, 28 May 2020 20:49:56 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200528204956.657e4a05.pasic@linux.ibm.com>
In-Reply-To: <eb340fdb-9453-2227-53f1-c507b3698f32@linux.ibm.com>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200522230451.632a3787.pasic@linux.ibm.com>
 <20200528132112.2a1fdf45.cohuck@redhat.com>
 <eb340fdb-9453-2227-53f1-c507b3698f32@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/OOscOCvg=QWs+53BK9IOFDA"; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-28_04:2020-05-28,
 2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 14:50:20
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
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/OOscOCvg=QWs+53BK9IOFDA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2020 16:42:49 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 5/28/20 1:21 PM, Cornelia Huck wrote:
> >> I think we have "allow protected" already expressed via cpu models. I'm
> >> also not sure how libvirt would react to the idea of a new machine
> >> property for this. You did mean "allow protected" as machine property,
> >> or?
> >=20
> > "Unpack facility in cpu model" means "guest may transition into pv
> > mode", right? What does it look like when the guest actually has
> > transitioned?
>=20
> Well, we don't sync the features that the protected guest has back into
> QEMU. So basically the VM doesn't really change except for ms->pv now
> being true.
>=20

The features as observed by the guest do change, some quite drastically,
it is just that the CPU model maintained by QEMU does not change. That
is the changes can not be inspected.=20

Unfortunately I'm not very familiar with the details, but my guess is
that
a) the ultravisor does what needs to be done with regards to features
that are obligatory or not prohibited in PV mode.
b) either the initial CPU model determines the CPU model after the
conversion fully, or we will need to express something more via
the QEMU cpu model. But we will have to do a fair amount of work
before we get migration, and I would hate to wait with this until
then.

Important for me is the following.=20
1) The user asks for a VM with certain
characteristics including cpu features. E.g. AP and unpack facilities.
2) The specified VM is sane, and gets started.
3) The OS decides to go secure.
4) Certain characteristics of the VM get changed as observed by the OS
(e.g. gains the ability to do uv calls, but also loses stuff).
5) The changes are not reflected via QEMU interfaces.

Compared to this my patch introduces a very similar behavior, in a sense
that the characteristics as observed by the guest change during the
transition, and that in a sense, after the transition the user gets
something different than she has asked for. The differences are that
this change ain't enforced by the ultravisor, and can be inspected
through the QEMU property 'iommu_platform'.

We can IMHO clam that the user opted in for this weird override of
featues with 'unpack' and with DIAG 308 subcode 10. That is what I mean
by 'already expressed': the machine property would be redundant and
add extra complexity. Conny do you agree?

>=20
>=20
> >=20
> >>
> >> AFAIU "allow protected" would be required for the !PV to PV switch, and
> >> we would have to reject paravirtualized devices with iommu_platform=3D=
'off'
> >> on VM construction or hotplug (iommu_platform=3D'auto/on' would be fin=
e).
> >>
> >> Could you please confirm that I understood this correctly?
> >>
> >>
> >>> This will come handy for other things like migrating to hosts without
> >>> protected memory support.
> >>>  =20
> >>
> >> This is already covered by cpu model AFAIK.
> >=20
> > I don't think we'd want to migrate between pv and non-pv anyway?
>=20
> What exactly do you mean by that?
> I'd expect that the VM can either be migrated in PV or non-PV mode and
> not in a transition phase.

>=20
I agree. I don't think migrating an in transition VM is practicable.
Currently migration is inhibited. We would probably need to inhibit
migration during transition, and make ms->pv conceptually a part of
the migration state. Both the source and the target would need to do
some things differently if the migration is requested while in PV
mode.

Regards,
Halil

--Sig_/OOscOCvg=QWs+53BK9IOFDA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJe0AfjAAoJEA0vhuyXGx0A4/AP/1r0NJPUVdrlh7/mhvnu/m89
NWdANE6YhhbIatSVzrheU8Baq9N2LD6NLr1ZoWYgPLs2xo5phvkfzTQ1A+xrMQ0s
TZyENNhrtDE7KVLtNn5gKraOqTHe5Jhqz7EfpDtIVGEt54SCJzjMU6ZaSYonhY8p
MxB4Y1jwcqxVXcnxFwUmOhkEoF+H45QntAeooxDp9pF+pJsCvtlE+pnMJb6vuN7y
Bey1PwzaOe3TOwNBgCyR2CBbDA6iWXEruqwpFsdwF5y0L4y/C73C3Eqx/5bwOA1P
apmF6JlLccixtUYhRPq/aKtuhERY1usUxmvSfXFDKo+frCTwXdcZFQ9EEfdG5Ty1
a4gswDB8Mvw8TspfFmI/IFmOzEorzWDg0XyEjy2HERmGTgesdQhmUv+iw+dnDf1F
THZmV57VvyTLPWSntKF4VvK+ouWVtR/XtAnFI/w1ZSQ3cOSgcqtR9kXnUjNJaDh4
ABkpIn/xV1f7HZgCWR4oZnSMMQDiW70cQM5p2ktK+Fu14g1X0lffyyRAEvhNkCAY
WJ4vA+PFANaw/Fz9nWahpWXtVPM4vvl4RRpT3P2Xxm9k9fciFQfWLfhW7mirg2wJ
mse4cIzzmT6R/4OFr+VW8bAK99QbF5pwCS6OZaInPwi3fDfbh2QM04rSv/V3Dt/S
eBLJsczFQ4WnBL6V6dQ7
=ptCD
-----END PGP SIGNATURE-----

--Sig_/OOscOCvg=QWs+53BK9IOFDA--


