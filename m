Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35640C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B158F24125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbeFzgmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B158F24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifrFY-0005R7-Uo
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 15:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ifrEm-0004zy-0m
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ifrEj-0004D6-AT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:08:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ifrEi-00049S-Tk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576267707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2G1nwFLPvlwha+ZXsujgy7xM1NydShSaqljYKRsiHgU=;
 b=cbeFzgmbIC8vb9d27Iw+7/vschUqMX+l46oQcd1St5yrdwoq8UA69tMISR/i2pvrnzZ+Q5
 TihlFIyfsdhmLURGB8+cTdKngygJOCmimStiNe4rD+bJST4yQvh9tSilhxbftAZDFEZnog
 THzWwTOMW4q4IOPq6JvgAF5muuNe8KE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-HBEVIkmRPsGCJsEFNA2HQQ-1; Fri, 13 Dec 2019 15:08:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDC0C107ACC4;
 Fri, 13 Dec 2019 20:08:24 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0ACBB63BDA;
 Fri, 13 Dec 2019 20:08:18 +0000 (UTC)
Date: Fri, 13 Dec 2019 17:08:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] hw/nmi: Fix the NMI() macro, based on INTERFACE_CHECK()
Message-ID: <20191213200817.GG498046@habkost.net>
References: <20191207094823.20707-1-philmd@redhat.com>
 <7c698f75-5be4-de98-2e8a-c271ae4c28d8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7c698f75-5be4-de98-2e8a-c271ae4c28d8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HBEVIkmRPsGCJsEFNA2HQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Dec 08, 2019 at 12:44:16AM +1100, Gavin Shan wrote:
> On 12/7/19 8:48 PM, Philippe Mathieu-Daud=E9 wrote:
> > There is no declaration of the 'NMI' type. INTERFACE_CHECK()
> > returns an abstract type (see commit aa1b35b975d8). The abstract
> > type corresponding to the TYPE_NMI interface is 'NMIState'.
> >=20
> > Fixes: 9cb805fd267
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
>=20
> Reviewed-by: Gavin Shan <gshan@redhat.com>

Queued, thanks!

--=20
Eduardo


