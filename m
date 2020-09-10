Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC090C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2309720795
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RF9A2X/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2309720795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRuC-0003lD-0X
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kGRKg-0002jm-1R; Thu, 10 Sep 2020 14:30:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kGRKd-00044R-KN; Thu, 10 Sep 2020 14:30:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08AILh3M034300; Thu, 10 Sep 2020 14:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=QV1z4Nk2PI7PCJjSItzHQAaLambHBG9VCF6xsUHbB0I=;
 b=RF9A2X/VIY2NZxj+GiQX+tVPUcudJiBh+0nV2sDblm25CZsvZIraZF5atKysT0PGdjuv
 uuKw7sJ4b6gXI5CNHtIPrtvhuJklWDBnXTICkKCZJhr/iCK9aOAWMcC0KWP/PXdQWzC9
 BQha1vrNsDvs2MibjuIZonGuTb3jUJuG8mmdXfwRHA+eN8ojLnVq+URVQBq9aW6X2B9Z
 O4DADF5Jwa0X1TRzNCjvnAqQfLj1ZAkbVqNPrMPLWs9ocsm7ZX0bGO03zunyrnQhoJba
 zQdUWUtRYhWdE9Q47UTpEdKTQLiqFkehY84oN2Bwo7N5qzR7SYmN8tHcQ2U9uuyCh89D EA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fsbv8598-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 14:29:54 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08AIQinw049632;
 Thu, 10 Sep 2020 14:29:54 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fsbv858e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 14:29:53 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AIIpsQ014531;
 Thu, 10 Sep 2020 18:29:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04fra.de.ibm.com with ESMTP id 33f91w8gw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 18:29:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08AITmAS63045954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 18:29:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A6E1A4054;
 Thu, 10 Sep 2020 18:29:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7600EA405B;
 Thu, 10 Sep 2020 18:29:47 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.38.251])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 18:29:47 +0000 (GMT)
Date: Thu, 10 Sep 2020 20:29:24 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [for-5.2 v4 10/10] s390: Recognize host-trust-limitation option
Message-ID: <20200910202924.3616935a.pasic@linux.ibm.com>
In-Reply-To: <20200910133609.4ac88c25.cohuck@redhat.com>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-11-david@gibson.dropbear.id.au>
 <20200907172253.0a51f5f7.pasic@linux.ibm.com>
 <20200910133609.4ac88c25.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_05:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100167
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:30:00
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
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 ehabkost@redhat.com, dgilbert@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 13:36:09 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 7 Sep 2020 17:22:53 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Fri, 24 Jul 2020 12:57:44 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > 
> > > At least some s390 cpu models support "Protected Virtualization" (PV),
> > > a mechanism to protect guests from eavesdropping by a compromised
> > > hypervisor.
> > > 
> > > This is similar in function to other mechanisms like AMD's SEV and
> > > POWER's PEF, which are controlled bythe "host-trust-limitation"
> > > machine option.  s390 is a slightly special case, because we already
> > > supported PV, simply by using a CPU model with the required feature
> > > (S390_FEAT_UNPACK).
> > > 
> > > To integrate this with the option used by other platforms, we
> > > implement the following compromise:
> > > 
> > >  - When the host-trust-limitation option is set, s390 will recognize
> > >    it, verify that the CPU can support PV (failing if not) and set
> > >    virtio default options necessary for encrypted or protected guests,
> > >    as on other platforms.  i.e. if host-trust-limitation is set, we
> > >    will either create a guest capable of entering PV mode, or fail
> > >    outright  
> > 
> > Shouldn't we also fail outright if the virtio features are not PV
> > compatible (invalid configuration)?
> > 
> > I would like to see something like follows as a part of this series.
> > ----------------------------8<--------------------------
> > From: Halil Pasic <pasic@linux.ibm.com>
> > Date: Mon, 7 Sep 2020 15:00:17 +0200
> > Subject: [PATCH] virtio: handle host trust limitation
> > 
> > If host_trust_limitation_enabled() returns true, then emulated virtio
> > devices must offer VIRTIO_F_ACCESS_PLATFORM, because the device is not
> > capable of accessing all of the guest memory. Otherwise we are in
> > violation of the virtio specification.
> > 
> > Let's fail realize if we detect that VIRTIO_F_ACCESS_PLATFORM feature is
> > obligatory but missing.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  hw/virtio/virtio.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 5bd2a2f621..19b4b0a37a 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -27,6 +27,7 @@
> >  #include "hw/virtio/virtio-access.h"
> >  #include "sysemu/dma.h"
> >  #include "sysemu/runstate.h"
> > +#include "exec/host-trust-limitation.h"
> >  
> >  /*
> >   * The alignment to use between consumer and producer parts of vring.
> > @@ -3618,6 +3619,12 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
> >      /* Devices should either use vmsd or the load/save methods */
> >      assert(!vdc->vmsd || !vdc->load);
> >  
> > +    if (host_trust_limitation_enabled(MACHINE(qdev_get_machine()))
> > +        && !virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
> > +        error_setg(&err, "devices without VIRTIO_F_ACCESS_PLATFORM are not compatible with host trust imitation");
> > +        error_propagate(errp, err);
> > +        return;
> 
> How can we get here? I assume only if the user explicitly turned the
> feature off while turning HTL on, as otherwise patch 9 should have
> taken care of it?
> 

Yes, we can get here only if iommu_platform is explicitly turned off.

Regards,
Halil

