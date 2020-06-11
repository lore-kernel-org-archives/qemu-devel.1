Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C3FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A6D20691
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnA/Igvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A6D20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjR8I-0004oY-Kj
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 13:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jjR7U-0003dP-58
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:36:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jjR7R-00069Z-Ce
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591896960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRo2nnUP3Ez03P41pr7SNcZgh/RRUdizyX3Xxk6IWyI=;
 b=CnA/IgvqEAL4ip8LisV6v9S8l3OnYfhTFzrlknpzIGhBW4/lRDOBPXarXrBIiJQ8KEk4mU
 qJMd5f+UZqaN+jafCGGEaXofkeWerckobyv0iWf7eXzlO0XO7LADqeRXvmKClkPSB8tIup
 pWShr5okgr8hw7V4XtmQhbd73NTxSyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-3nTh33OwNzSXvQR1r7_2ag-1; Thu, 11 Jun 2020 13:35:54 -0400
X-MC-Unique: 3nTh33OwNzSXvQR1r7_2ag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2C01107ACF3;
 Thu, 11 Jun 2020 17:35:53 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6ED017F4FB;
 Thu, 11 Jun 2020 17:35:53 +0000 (UTC)
Date: Thu, 11 Jun 2020 11:35:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/vfio/pci-quirks: Fix broken legacy IGD passthrough
Message-ID: <20200611113552.6f702421@x1.home>
In-Reply-To: <c3f40a57-e511-6b31-1a13-01acb38b0843@redhat.com>
References: <20200610035102.20192-1-thuth@redhat.com>
 <706060db-46c4-2dee-d746-eba24e6b137d@redhat.com>
 <a8195883-fb78-0cc1-5e15-e100dcb807de@redhat.com>
 <fd82556f-297d-6634-1bb2-37c4da415a50@redhat.com>
 <c3f40a57-e511-6b31-1a13-01acb38b0843@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jun 2020 09:59:35 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 10/06/2020 09.53, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 6/10/20 9:50 AM, Thomas Huth wrote: =20
> >> On 10/06/2020 09.31, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>> On 6/10/20 5:51 AM, Thomas Huth wrote: =20
> >>>> The #ifdef CONFIG_VFIO_IGD in pci-quirks.c is not working since the
> >>>> required header config-devices.h is not included, so that the legacy
> >>>> IGD passthrough is currently broken. Let's include the right header
> >>>> to fix this issue.
> >>>>
> >>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1882784
> >>>> Fixes: 29d62771c81d8fd244a67c14a1d968c268d3fb19
> >>>>        ("hw/vfio: Move the IGD quirk code to a separate file") =20
> >>>
> >>> What about shorter tag?
> >>>
> >>> Fixes: 29d62771c81 ("vfio: Move the IGD quirk code to a separate file=
") =20
> >>
> >> I always forget whether to use the short or the long version for
> >> "Fixes:" ... this can hopefully be fixed (if necessary) when the patch
> >> gets picked up.
> >> =20
> >>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>>> ---
> >>>>  hw/vfio/pci-quirks.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> >>>> index f2155ddb1d..3158390db1 100644
> >>>> --- a/hw/vfio/pci-quirks.c
> >>>> +++ b/hw/vfio/pci-quirks.c
> >>>> @@ -11,6 +11,7 @@
> >>>>   */
> >>>> =20
> >>>>  #include "qemu/osdep.h"
> >>>> +#include "config-devices.h" =20
> >>>
> >>> I've been wondering how we can avoid that mistake in the
> >>> future, but can find anything beside human review. =20
> >>
> >> I think in the long term, we should include config-devices.h in osdep.=
h,
> >> just like config-host.h and config-target.h is already included there.
> >> Everything else is just too confusing. But then we should also add a
> >> mechanism to poison the switches from config-devices.h in common code.=
.. =20
> >=20
> > We only need it for the files under hw/, right? =20
>=20
> qtest.c in the main directory includes it, too.
>=20
> >> thus this likely needs some work and discussion of the patch first, so=
 I
> >> think we should go with this change to pci-quirks.c here first to get
> >> the regression fixed ASAP. =20
> >=20
> > Sure, I'm not objecting that. =20
>=20
> Sure, I just wanted to make sure that whoever (Alex?) picks up this
> patch does not wait for that other solution instead.

Yep, I'll grab it, I've got one less-trivial patch to send a pull
request for anyway.  Thanks,

Alex


