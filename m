Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DCEC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A831920737
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI8fE/rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A831920737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC8EB-0000j2-Gw
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 16:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jC8Bq-00074d-9F
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jC8Bp-0008S6-91
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:42:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jC8Bp-0008Qa-5K
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583959372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+wQH7JI9cIqMDoaXgnUKjII6HWlKF0yYYs9GvPHuII=;
 b=hI8fE/rpvOAyNMrshwEZsD1yV5Zjq2y/Zh/1PB4TFns/EVcJ+88g0uEpmsCnmfg0rXaN6B
 P8z6ECv54SB4hWBmuJkrtvH63YUZeagcx0pJiEqfbG0jdEPPTnexslM2K6Ocs0xi8IIJ30
 jPPGEXQuAZkMb8ysdbF0FXdhz6ufWhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-0nnJjphEMAuGyeaTD_Lh_g-1; Wed, 11 Mar 2020 16:42:50 -0400
X-MC-Unique: 0nnJjphEMAuGyeaTD_Lh_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EA0D189D6C0;
 Wed, 11 Mar 2020 20:42:49 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7DBB9298D;
 Wed, 11 Mar 2020 20:42:46 +0000 (UTC)
Date: Wed, 11 Mar 2020 16:42:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] util: fix to get configuration macros in util/mmap-alloc.c
Message-ID: <20200311204246.GN1187748@habkost.net>
References: <20200305154142.63070-1-jingqi.liu@intel.com>
 <20200305161047.GB3627464@lpt>
 <CAFEAcA-OQncMrU_-DJJ9g5rEcrJvbhTOjOVs0YqO3NS_Y413OQ@mail.gmail.com>
 <f774652b-5145-1e47-62c4-99a69a037506@intel.com>
 <CAFEAcA8HMSg8nS27YGPEQsPeGW2UicWRxeJDQf3oKbyHH2TY6Q@mail.gmail.com>
 <a57d479a-c9d5-0acc-b808-fe4e5a20ae80@intel.com>
 <20200310051003-mutt-send-email-mst@kernel.org>
 <16328974-3c7f-0e69-9614-a085c5841a2e@intel.com>
 <CAFEAcA_B7FYboWR3L=X32ssyKxz2HXD3jxsQXeTinP-oXSBf6Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_B7FYboWR3L=X32ssyKxz2HXD3jxsQXeTinP-oXSBf6Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>,
 =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 12:37:17PM +0000, Peter Maydell wrote:
> On Wed, 11 Mar 2020 at 00:43, Liu, Jingqi <jingqi.liu@intel.com> wrote:
> > 1) If '#include <linux/mman.h>' first then '#include qemu/osdep.h', it
> > should be fine.
> >
> > 2) Peter mentioned osdep.h should go first.
> >
> > It will  cause redefinitions of other MAP_* macros after '#include
> > <linux/mman.h>'.
> >
> > This is where the conflict lies.
>=20
> osdep.h first, always. Other uses of linux-headers headers
> have presumably already dealt with this issue...

Including linux/mman.h before sys/mman.h is just a workaround to
the root cause: both headers really redefine each others' macros,
but gcc hide the warnings if the warnings are generated inside
system-provided headers.

I believe we should use -isystem for linux-headers insteaad of -I.

--=20
Eduardo


