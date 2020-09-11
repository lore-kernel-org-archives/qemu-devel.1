Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BA8C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2956020575
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ddirH8yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2956020575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGiTb-0007dG-3i
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kGiRj-00062v-Tb; Fri, 11 Sep 2020 08:46:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kGiRh-0002yn-Dw; Fri, 11 Sep 2020 08:46:31 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08BCWGQ3140266; Fri, 11 Sep 2020 08:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type; s=pp1; bh=LKqTyuRkTCY/yYwfiwaty6Dl5Cxr1wfYlzt2m1IMkeA=;
 b=ddirH8yz9TTvbDT8j19iQjfECPo+Mr2esAX2TiXP/0FbBXyIF2I68z7mxcK/tOitGx1w
 1QVovpeVo6DFZQbQoAVpkP67iJneNKaHWHv9gE36KjT5/+4pmQ/Bw1BhzNbvL1ZQB269
 p8IujgRAjXQLDHRaIdfzCkmVLwZCvXtvYXdbxZeAusGJd8bk/n58QjkcXGVgN1oMHlyL
 9RZ60lo+NIzU++UrPJACdvCnb0uu1M22etL9x6ZYidwfzRMIX2eHEnChk5sE3jdne9GW
 XfRLQ4/25ZEWjtgBpFetXW97ztYVqwPAD0kE8nnlixcnX/v/hxu5JzcwkcF6JyDfuxVl Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33g6nxdf1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 08:46:21 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BCYKVJ146292;
 Fri, 11 Sep 2020 08:46:21 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33g6nxdf0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 08:46:21 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BCgxAm018975;
 Fri, 11 Sep 2020 12:46:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 33dxdr4dj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 12:46:18 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08BCkFVs63832344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2020 12:46:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 908E652052;
 Fri, 11 Sep 2020 12:46:15 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.148.109])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A63CF5204E;
 Fri, 11 Sep 2020 12:46:14 +0000 (GMT)
Date: Fri, 11 Sep 2020 14:45:56 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.2 v4 10/10] s390: Recognize host-trust-limitation option
Message-ID: <20200911144556.144ef065.pasic@linux.ibm.com>
In-Reply-To: <20200911000718.GF66834@yekko.fritz.box>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-11-david@gibson.dropbear.id.au>
 <20200907172253.0a51f5f7.pasic@linux.ibm.com>
 <20200910133609.4ac88c25.cohuck@redhat.com>
 <20200910202924.3616935a.pasic@linux.ibm.com>
 <20200911000718.GF66834@yekko.fritz.box>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/mIwR4+yv1W82PBv50GU+7oV"; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-11_04:2020-09-10,
 2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 08:46:27
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/mIwR4+yv1W82PBv50GU+7oV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2020 10:07:18 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Sep 10, 2020 at 08:29:24PM +0200, Halil Pasic wrote:
> > On Thu, 10 Sep 2020 13:36:09 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >=20
> > > On Mon, 7 Sep 2020 17:22:53 +0200
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >=20
> > > > On Fri, 24 Jul 2020 12:57:44 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >=20
> > > > > At least some s390 cpu models support "Protected Virtualization" =
(PV),
> > > > > a mechanism to protect guests from eavesdropping by a compromised
> > > > > hypervisor.
> > > > >=20
> > > > > This is similar in function to other mechanisms like AMD's SEV and
> > > > > POWER's PEF, which are controlled bythe "host-trust-limitation"
> > > > > machine option.  s390 is a slightly special case, because we alre=
ady
> > > > > supported PV, simply by using a CPU model with the required featu=
re
> > > > > (S390_FEAT_UNPACK).
> > > > >=20
> > > > > To integrate this with the option used by other platforms, we
> > > > > implement the following compromise:
> > > > >=20
> > > > >  - When the host-trust-limitation option is set, s390 will recogn=
ize
> > > > >    it, verify that the CPU can support PV (failing if not) and set
> > > > >    virtio default options necessary for encrypted or protected gu=
ests,
> > > > >    as on other platforms.  i.e. if host-trust-limitation is set, =
we
> > > > >    will either create a guest capable of entering PV mode, or fail
> > > > >    outright =20
> > > >=20
> > > > Shouldn't we also fail outright if the virtio features are not PV
> > > > compatible (invalid configuration)?
> > > >=20
> > > > I would like to see something like follows as a part of this series.
> > > > ----------------------------8<--------------------------
> > > > From: Halil Pasic <pasic@linux.ibm.com>
> > > > Date: Mon, 7 Sep 2020 15:00:17 +0200
> > > > Subject: [PATCH] virtio: handle host trust limitation
> > > >=20
> > > > If host_trust_limitation_enabled() returns true, then emulated virt=
io
> > > > devices must offer VIRTIO_F_ACCESS_PLATFORM, because the device is =
not
> > > > capable of accessing all of the guest memory. Otherwise we are in
> > > > violation of the virtio specification.
> > > >=20
> > > > Let's fail realize if we detect that VIRTIO_F_ACCESS_PLATFORM featu=
re is
> > > > obligatory but missing.
> > > >=20
> > > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > > ---
> > > >  hw/virtio/virtio.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >=20
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index 5bd2a2f621..19b4b0a37a 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -27,6 +27,7 @@
> > > >  #include "hw/virtio/virtio-access.h"
> > > >  #include "sysemu/dma.h"
> > > >  #include "sysemu/runstate.h"
> > > > +#include "exec/host-trust-limitation.h"
> > > > =20
> > > >  /*
> > > >   * The alignment to use between consumer and producer parts of vri=
ng.
> > > > @@ -3618,6 +3619,12 @@ static void virtio_device_realize(DeviceStat=
e *dev, Error **errp)
> > > >      /* Devices should either use vmsd or the load/save methods */
> > > >      assert(!vdc->vmsd || !vdc->load);
> > > > =20
> > > > +    if (host_trust_limitation_enabled(MACHINE(qdev_get_machine()))
> > > > +        && !virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)=
) {
> > > > +        error_setg(&err, "devices without VIRTIO_F_ACCESS_PLATFORM=
 are not compatible with host trust imitation");
> > > > +        error_propagate(errp, err);
> > > > +        return;
> > >=20
> > > How can we get here? I assume only if the user explicitly turned the
> > > feature off while turning HTL on, as otherwise patch 9 should have
> > > taken care of it?
> > >=20
> >=20
> > Yes, we can get here only if iommu_platform is explicitly turned off.
>=20
> Right.. my assumption was that if you really want to specify
> contradictory options, you get to keep both pieces.  Or, more
> seriously, there might be some weird experimental cases where this
> combination could do something useful if you really know what you're
> doing, and explicitly telling qemu to do this implies you know what
> you're doing.
>=20

According to Michael, the correctness of a hypervisor is depending on
this (if device has restricted access to guest memory, but does not
present F_ACCESS_PLATFORM then the hypervisor is buggy).

Also a hotplug of such a misconfigured device is at the moment likely
bring down the guest on s390x.

The only scenario in which the guest has protected memory and the device
is able to access it, is a trusted HW device. But then we would need=20
F_ACCESS_PLATFORM because it is a HW device. So I consider this combination
doing something useful very unlikely. Does anybody have a scenario where
this combination is legit and useful?

If such a scenario emerges later, I think the check can be refined or
dropped.

Regards,
Halil



--Sig_/mIwR4+yv1W82PBv50GU+7oV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJfW3GUAAoJEA0vhuyXGx0AKjQQANiLwf90hINGj8sKmx3nvFsD
8Vlj95uX1RB+zvgmBVRkDFx+O0WC5QGJbxfdsbKkC47TesXywnzUy9sPBMuUsadY
nsHUbVGUL6gqmwABCKvPHBCpvwIp+5vUiaWpACgBJq7Bjl4seoiyv56HacSAyojA
f3gW9T83l1+dwNmKtFzaYwItWx+ET8FN2NRdzrXrwe3doav/Oxpo3Mx9jViHbTXv
rPthgG5xbh0O2BopHrbHQd2tJZBrONvqABYZumhgwmdUb8q3qE2BYFEZg6lc1P9J
4GKA2i5A85vRXf4EECuHmVQDBjqrdShdQ5H3fn9w5vCklH9C7GwryyJFURC0NHxo
qos5j28Kutz/Qg7XtEHJrKS7/4dCc3LfQyujcI6xXlPWQrnIrOQkb4vvhR9PO3xr
0a8Gfmu5MzeIjqMG9wyTDytFxlsXKeR/ukGpwrLQ9D8m+b6k5Y7bq58S6GyqStyI
jlwT+JMS1zELTbd4ryNqLC/E/zUybD/po+r8RUYTKL5gV61Kghq3gisSIkyzp0Rq
dvnqP9Bk8l8xw9nxuRMABkWXfPc8+39xRTkILfOgv3J/IfaUijUk1E/vChRf28Ln
Yc8LLVC5QWa9AtjPbItKvlXAEcidF2qKGgZELLAGyZqrb93zBNHFBKMdtZuFxu79
0STxaXJXYUEuzeUF3iju
=YAB+
-----END PGP SIGNATURE-----

--Sig_/mIwR4+yv1W82PBv50GU+7oV--


