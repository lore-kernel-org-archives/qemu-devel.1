Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A55C4724C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8846A2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RajCSVC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8846A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWglD-0006F1-KZ
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWgkZ-0005pC-NA
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:39:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWgkY-0006ZT-19
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588858780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dA6kPqYmHrEYZGYG5jcU+QfN1Ca3i6FjYuXSMbqo4h8=;
 b=RajCSVC7kZfPqqP8PAuvjxzRWLqAZ+9wRU0tv/PwWdMhfcQByY3gtmIv9jcDS8iaBK5JK2
 ZLYHYZH9ZPdOGsQKi8RJcNM3IThtRL/BTB17PQcB8rFpz6b6D62L9j/HWFwcfxPq7XwTOQ
 WPegrcpVc4NVMOI1pMIHNLst2ORlCGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-9wl7eFbfOt2W5GGei9dVtw-1; Thu, 07 May 2020 09:39:38 -0400
X-MC-Unique: 9wl7eFbfOt2W5GGei9dVtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C08501009440;
 Thu,  7 May 2020 13:39:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB63962952;
 Thu,  7 May 2020 13:39:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6E37C9D54; Thu,  7 May 2020 15:39:30 +0200 (CEST)
Date: Thu, 7 May 2020 15:39:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 09/13] microvm: add minimal acpi support
Message-ID: <20200507133930.dzioq37pbujf5c3a@sirius.home.kraxel.org>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-10-kraxel@redhat.com>
 <20200505172037.2bd55d6e@redhat.com>
 <20200506103549.yplkfmv3uqdbeumt@sirius.home.kraxel.org>
 <20200506161419.3d17e26a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200506161419.3d17e26a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 04:14:19PM +0200, Igor Mammedov wrote:
> On Wed, 6 May 2020 12:35:49 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> > > > +/* FIXME: copy & paste */
> > > > +static void acpi_dsdt_add_power_button(Aml *scope)
> > > > +{
> > > > +    Aml *dev =3D aml_device(ACPI_POWER_BUTTON_DEVICE);
> > > > +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> > > > +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > > > +    aml_append(scope, dev);
> > > > +} =20
> > >=20
> > > could be unified with ARM's version =20
> >=20
> > Yep.  Suggestions for a good place?  hw/acpi/aml-build.c ?
> sounds good to me

Hmm, tried that, but ACPI_POWER_BUTTON_DEVICE is defined in ged header
file, so ged.c looks like a better fit ;)

take care,
  Gerd


