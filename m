Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A85FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A159522403
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VszzkoV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A159522403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuJ2-0004nX-CD
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kZuHg-0003wM-Us
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kZuHe-0002Wo-Ax
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604402120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RsAkkfT4dFhftmqO+S5CrBbadCbY/jcNPcc2lu+GeLA=;
 b=VszzkoV/sXSCgpk+mclUnUl/OCDkbrGKK3CVeNFJLwfaFinD/1YvVoq+jo2U8Zr5eHLuJI
 ccG5PWKE4W7SgY9Vy2UptZIuHlZBCAtNRswlqw0FTlgtppGEOEf+TA+Ok8um+wn8CEh/ti
 6TrDzWz0orUiviTVD+kpTQR3+If80oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-t7_vXEbZOa-8nZusG6LTDg-1; Tue, 03 Nov 2020 06:15:18 -0500
X-MC-Unique: t7_vXEbZOa-8nZusG6LTDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A583C8030A5;
 Tue,  3 Nov 2020 11:15:17 +0000 (UTC)
Received: from gondolin (ovpn-114-68.ams2.redhat.com [10.36.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2395C19C4F;
 Tue,  3 Nov 2020 11:15:12 +0000 (UTC)
Date: Tue, 3 Nov 2020 12:15:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PULL v3 23/32] s390x/pci: Add routine to get the vfio dma
 available count
Message-ID: <20201103121510.35d26fec.cohuck@redhat.com>
In-Reply-To: <2d6befc5-0516-5ff0-7498-0f4deca92738@redhat.com>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
 <160426454077.24886.1574050205264167707.stgit@gimli.home>
 <85a0a8e1-1081-12c8-c37b-4a7e919b421a@redhat.com>
 <20201103114513.6909502c.cohuck@redhat.com>
 <2d6befc5-0516-5ff0-7498-0f4deca92738@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 12:08:20 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 11/3/20 11:45 AM, Cornelia Huck wrote:
> > On Tue, 3 Nov 2020 06:49:13 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> Hi Matthew,
> >>
> >> On 11/1/20 10:02 PM, Alex Williamson wrote: =20
> >>> From: Matthew Rosato <mjrosato@linux.ibm.com>
> >>>
> >>> Create new files for separating out vfio-specific work for s390
> >>> pci. Add the first such routine, which issues VFIO_IOMMU_GET_INFO
> >>> ioctl to collect the current dma available count.
> >>>
> >>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> >>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >>> [aw: Fix non-Linux build with CONFIG_LINUX]
> >>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >>> ---
> >>>  hw/s390x/meson.build             |    1 +
> >>>  hw/s390x/s390-pci-vfio.c         |   54 ++++++++++++++++++++++++++++=
++++++++++
> >>>  include/hw/s390x/s390-pci-vfio.h |   24 +++++++++++++++++
> >>>  3 files changed, 79 insertions(+)
> >>>  create mode 100644 hw/s390x/s390-pci-vfio.c
> >>>  create mode 100644 include/hw/s390x/s390-pci-vfio.h
> >>>
> >>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> >>> index 948ceae7a7b3..f4663a835514 100644
> >>> --- a/hw/s390x/meson.build
> >>> +++ b/hw/s390x/meson.build
> >>> @@ -27,6 +27,7 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
> >>>  ))
> >>>  s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-vi=
rtio-ccw.c'))
> >>>  s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c=
'))
> >>> +s390x_ss.add(when: 'CONFIG_LINUX', if_true: files('s390-pci-vfio.c')=
) =20
> >=20
> > I think we need s/CONFIG_LINUX/CONFIG_VFIO/ here. =20
>=20
> With your change:
>=20
> hw/s390x/s390-pci-bus.c:1079: undefined reference to
> `s390_pci_end_dma_count'
> hw/s390x/s390-pci-bus.c:1019: undefined reference to
> `s390_pci_start_dma_count'
> hw/s390x/s390-pci-bus.c:1021: undefined reference to `s390_pci_get_clp_in=
fo'
>=20
> Do we need stubs instead?
>=20

We do have stubs; we just need them to be ifdeffed with CONFIG_VFIO
instead of CONFIG_LINUX. Currently preparing a proper patch.


