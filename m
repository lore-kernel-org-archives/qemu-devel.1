Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87071C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B3424655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDwoQjAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B3424655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuBIw-0006w3-Ge
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuBIG-0006WG-8J
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuBIE-00064l-I5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:23:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuBIE-00063Q-Dq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579681397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCGL+U3iO0Eeq/JXsaDIPeF99NUFH4j+aMWlB6FSEuE=;
 b=RDwoQjAGqUJOHcDucUzSVkdWJZqbXSL0/UgdEuYuwPJbnFoAk1yw+lOACP+9WF5C8fSx0u
 Sx0GMjFS7SBqcfG5PWUjq+fAoyrygk2V4JOyJPoCPLSY5JyKUKYg1Lk1d40WRyVrex5CG2
 BKZASf8Kdbr+jcRsTg5b2yD9sEEv2zk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-z2WyuaDNP7CsVvQvUql4zg-1; Wed, 22 Jan 2020 03:23:15 -0500
Received: by mail-wr1-f69.google.com with SMTP id c17so2692899wrp.10
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oxbFuRA6cYANIAIOn7mbS+CIioBKwjscNIESnmng42k=;
 b=FjJIumAcaCbZCKtF4bm56FPjj/7ik0uSze/MwOz8f+e7OOX42XmcRO2IsDq82qGR8c
 CtTAnipXM+r6MQ6OX6m4ZQ30d/A2/nd7iv2ZrbwinMOQfGLheDa1EiKf5HKA7ShqJGdl
 DtmjywhyJi3/iyYq2feo+mHbBlbWY8/LA49Qxe6YUtCpCl+R8ZPtR490hb/Q+inGDXus
 c/oEu3OxSINimHBIvXhs+W8UnCEaSoGAToco81B4UqL6iVFKQ1qch6VGbbE1Tb7HPsk8
 jsdN1z5rcE7J82YeUZFhKfBYYWIdxYf4X5Ft/wDvPr4WkijARvcmv7UOUJOEoNokJL82
 vxDg==
X-Gm-Message-State: APjAAAUbN+Ymr/78bNEL8C0Cj8Y/9GCqPRYZ5LEmy7CQB+UJ7v9cw59v
 fZ3CXrfZmdfA+MqJzMAZ557S5gXjjdMC1zAclqdZn7qrXu7GcaZWr7JrnnC/q92J66fvO9d7Eup
 u25svQVbW3c8utjs=
X-Received: by 2002:adf:97d6:: with SMTP id t22mr9572875wrb.407.1579681394479; 
 Wed, 22 Jan 2020 00:23:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4Nc8yNudGXZtdqyE7DdO2kl4yoezYKuFNaKXZ60TsSGEZrp6pQXUYLinQY1sIflkXMblYHA==
X-Received: by 2002:adf:97d6:: with SMTP id t22mr9572839wrb.407.1579681394150; 
 Wed, 22 Jan 2020 00:23:14 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 s19sm2754234wmj.33.2020.01.22.00.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:23:13 -0800 (PST)
Date: Wed, 22 Jan 2020 03:23:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what an exported
 object is
Message-ID: <20200122032103-mutt-send-email-mst@kernel.org>
References: <CAD=HUj640QfNwO4J_tdcSx36YOVAVT_dZUXYuKPaCKvZVWeHsg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj640QfNwO4J_tdcSx36YOVAVT_dZUXYuKPaCKvZVWeHsg@mail.gmail.com>
X-MC-Unique: z2WyuaDNP7CsVvQvUql4zg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 04:16:24PM +0900, David Stevens wrote:
> Define a mechanism for sharing objects between different virtio
> devices.
>=20
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  content.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index b1ea9b9..6c6dd59 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -373,6 +373,24 @@ \section{Driver Notifications}
> \label{sec:Virtqueues / Driver notifications}
>=20
>  \input{shared-mem.tex}
>=20
> +\section{Exporting Objects}\label{sec:Basic Facilities of a Virtio
> Device / Exporting Objects}
> +
> +When an object created by one virtio device needs to be
> +shared with a seperate virtio device, the first device can
> +export the object by generating a \field{uuid}

This is a field where?

> which the
> +guest can pass to the second device to identify the object.


s/guest/Driver/ ?

> +
> +What constitutes an object, how to export objects, and
> +how to import objects are defined by the individual device
> +types. The generation method of a \field{uuid} is dependent
> +upon the implementation of the exporting device.
> +
> +Whether a particular exported object can be imported into
> +a device is dependent upon the implementations of the exporting
> +and importing devices. Generally speaking, the guest should
> +have some knowledge of the host configuration before trying to
> +use exported objects.

this last paragraph seems to be too general to be really useful.

Also - what are guest and host here?


> +
>  \chapter{General Initialization And Device
> Operation}\label{sec:General Initialization And Device Operation}
>=20
>  We start with an overview of device initialization, then expand on the
> --=20
> 2.25.0.341.g760bfbb309-goog
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


