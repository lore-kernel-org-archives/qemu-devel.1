Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8084CC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B847205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXz3PbAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B847205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8qo-0000mC-Dj
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ip8pn-0008Tw-F1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ip8pm-0008Gw-EA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:45:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ip8pm-0008Fb-9E
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578480305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJFG+LWZhDtbC1m8KwxjvCdvwcMEMO+uAQF+tCPQvgo=;
 b=UXz3PbArNxwfapS4FinLE1/k8vp5aCh/pUAFr7gTXo9n0bS7SwB76k2GUliYqiFROEynHg
 VcgfWgnYi4ZuTRxox+AO5L6dKsB99BBliXPXzBm8jrf7V9Q22cMBp+DrpYSapTFYEj/a0v
 bFRSkmjcmHCTDha+x63Fx16EkgDx46Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-luh_hD2SNDaDuuVeDS-KMw-1; Wed, 08 Jan 2020 05:45:02 -0500
X-MC-Unique: luh_hD2SNDaDuuVeDS-KMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62DBDDB60;
 Wed,  8 Jan 2020 10:45:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DD9A5C1B0;
 Wed,  8 Jan 2020 10:45:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 474F39DA5; Wed,  8 Jan 2020 11:44:59 +0100 (CET)
Date: Wed, 8 Jan 2020 11:44:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
Message-ID: <20200108104459.qikjl4n2j5wkwslu@sirius.home.kraxel.org>
References: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: virtio-dev@lists.oasis-open.org, Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> +\begin{lstlisting}
> +struct virtio_gpu_export_resource {
> +        struct virtio_gpu_ctrl_hdr hdr;
> +        le32 resource_id;
> +        le32 padding;
> +};
> +
> +struct virtio_gpu_resp_export_resource {
> +        struct virtio_gpu_ctrl_hdr hdr;
> +        le64 uuid_low;
> +        le64 uuid_high;
> +};
> +\end{lstlisting}

Is there a specific reason why you want the host pick the uuid?  I would
let the guest define the uuid, i.e. move the uuid fields to
virtio_gpu_export_resource and scratch virtio_gpu_resp_export_resource.

Also I'd siggest to name the command (and struct) RESOURCE_ASSIGN_UUID.

cheers,
  Gerd


