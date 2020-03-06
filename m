Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FDBC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDF72070A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXD+0GSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDF72070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9tT-0004aG-EB
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jA9sf-0003k0-Oz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jA9se-0000zt-Bx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:06:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57190
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jA9se-0000w1-2d
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583489215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP8LGWYnVfj/fV0ZT5Pl/FciL2Holb5QrXqu5aUzObE=;
 b=QXD+0GSivK6ADVh9YT+IsUy3OyNEY61B31B/CP6AhFMhz4gz5n3iVLtqg+jF61OkpUzpSo
 srsY6G2fA72fFmJgCe2MsRSmD/CIU0UoVoqN5O6qZxY+OFbALbhaaNhytSAK8bavRXaCoh
 NjkZ4jBFGyU3YKTWKgtJWC/Jtj/OaBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-CbtUNaUDM-OM_oYJS5wu3w-1; Fri, 06 Mar 2020 05:06:53 -0500
X-MC-Unique: CbtUNaUDM-OM_oYJS5wu3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 574F118A5502;
 Fri,  6 Mar 2020 10:06:52 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 195F85C221;
 Fri,  6 Mar 2020 10:06:50 +0000 (UTC)
Date: Fri, 6 Mar 2020 11:06:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH] hw/arm/cubieboard: make sure SOC object isn't leaked
Message-ID: <20200306110649.713ee0af@redhat.com>
In-Reply-To: <CAPan3Wqr8HuXSmZL1DZTSjD_PfcoxNO5FkKAr36rzY8+vyOORg@mail.gmail.com>
References: <20200303091254.22373-1-imammedo@redhat.com>
 <CAPan3Wqr8HuXSmZL1DZTSjD_PfcoxNO5FkKAr36rzY8+vyOORg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, drjones@redhat.com,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 21:07:08 +0100
Niek Linnenbank <nieklinnenbank@gmail.com> wrote:

> Hi Igor,
> 
[...]

> > +    a10 = AW_A10(object_new(TYPE_AW_A10));
> > +    object_property_add_child(OBJECT(machine), "soc", OBJECT(a10),
> > +                              &error_abort);
> > +    object_unref(OBJECT(a10));
> >  
> 
> I see that there are a few machines which also do
> object_property_add_child() to add its
> SoC object to the machine, but they do not do the object_unref(). Can you
> explain why it is needed here?

object_new() returns object with ref == 1, and it's responsibility
of the caller to take care of it.
If caller won't track and call object_unref() eventually on returned pointer,
the object will leak.

(object_unref() destroys object when 'ref' reaches 0 )

> Or do the other machines still have a leak due to the missing
> object_unref()? Examples are:
>   hw/arm/sabrelite.c
>   hw/arm/mcimx7d-sabre.c
>   hw/arm/mcimx6ul-evk.c
> 
> Regards,
> Niek
> 
> 
> > +
> >      object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
> >      if (err != NULL) {
> >          error_reportf_err(err, "Couldn't set phy address: ");
> > --
> > 2.18.1
> >
> >
> >  
> 


