Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44578C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F93624655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/YosG+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F93624655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuBP4-0001cI-59
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuBOS-00019j-10
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuBOQ-0000yf-U2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:29:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54371
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuBOQ-0000yV-QJ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579681782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/jPgMujBDjJZIjuomc4jbLKEqxhoNrHO88MZibyp+vE=;
 b=M/YosG+6bwbv5fToAg+lwy+Y2RZvFKNOZRclpTZ/p15RNxr/hZvEoVo78lPNqZFvmVeQ+n
 G8eL5IjU6OKs4ucA+9MkMgOhA38aZMMTHO66R3YvmF1Nc5RK5StryU1gZxU3sqtCrFPhtL
 4V+QHQiepJZ4fQvZPZwPNK0RmgQf6bY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-45s4Njf4Ot-In6B4vkENdA-1; Wed, 22 Jan 2020 03:29:33 -0500
Received: by mail-wr1-f70.google.com with SMTP id i9so2716542wru.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Rsxv79MIsJpMkuOHmysIM4sn2CG/wHNfUOUxHKcwzjQ=;
 b=agEykKnfHe24041qsGnnA3FSoNQJePkkLuD1MGLsAvgnoNgb2MUDUbwyCLvL+3MbJs
 xaMnjqyAG8bGD6XmU5sVHnTXxCzrljJvWkNJdqliBLFrQBCW68/ANpaycE0tzeCEfo+V
 ZIJQJEPBQ2tNOebUWEhKNiWGPLuF7hb8KiPxkMxEhGmkc6/uneqqlzbtPjgiEPjyueAq
 nk/ffc0121YLUyLmT2CfG6QsDX0bb2eeeyZRCHjv5rntVK8yIFQCEXNaj7xvlnzn3wzX
 tVa4+RKgHsgQsjCt05g6WL1FZvJQboLXyS4PzBzGPApS53ANZVspuVyF/ucMg65bLACW
 lROw==
X-Gm-Message-State: APjAAAWkP94fYnAtj8vKzdUEt5r9kPPXHhiKdlGSzKd9hIfnDnMKbqsv
 774KGqZoyuH0k+8En5AZlx23nLWDv+cGwoYL1Ce52/1n4QYRAqzPk7lbOpIe/KwkTrJdBcE6o5T
 EvStol48tJulXH2c=
X-Received: by 2002:a5d:548e:: with SMTP id h14mr9131482wrv.380.1579681772194; 
 Wed, 22 Jan 2020 00:29:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrFUnPGgplkiiBhAQPOlTJ32CQ5imjYv5btpKqodQXvX+aqR6aocpL97Qcfli8Mbqxh9qwtw==
X-Received: by 2002:a5d:548e:: with SMTP id h14mr9131438wrv.380.1579681771795; 
 Wed, 22 Jan 2020 00:29:31 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 g7sm55791801wrq.21.2020.01.22.00.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:29:31 -0800 (PST)
Date: Wed, 22 Jan 2020 03:29:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
Message-ID: <20200122032433-mutt-send-email-mst@kernel.org>
References: <CAD=HUj7N8dpEvf0Be8fg-qpFFTQOqzZX_kVoFB=BWp8S4uEFvg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj7N8dpEvf0Be8fg-qpFFTQOqzZX_kVoFB=BWp8S4uEFvg@mail.gmail.com>
X-MC-Unique: 45s4Njf4Ot-In6B4vkENdA-1
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

On Wed, Jan 22, 2020 at 04:16:35PM +0900, David Stevens wrote:
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  virtio-gpu.tex | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/virtio-gpu.tex b/virtio-gpu.tex
> index af4ca61..a1f0210 100644
> --- a/virtio-gpu.tex
> +++ b/virtio-gpu.tex
> @@ -186,12 +186,16 @@ \subsubsection{Device Operation: Request
> header}\label{sec:Device Types / GPU De
>          VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
>          VIRTIO_GPU_CMD_MOVE_CURSOR,
>=20
> +        /* misc commands */
> +        VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID =3D 0x0400,
> +
>          /* success responses */
>          VIRTIO_GPU_RESP_OK_NODATA =3D 0x1100,
>          VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
>          VIRTIO_GPU_RESP_OK_CAPSET_INFO,
>          VIRTIO_GPU_RESP_OK_CAPSET,
>          VIRTIO_GPU_RESP_OK_EDID,
> +        VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID,
>=20
>          /* error responses */
>          VIRTIO_GPU_RESP_ERR_UNSPEC =3D 0x1200,
> @@ -454,6 +458,32 @@ \subsubsection{Device Operation:
> controlq}\label{sec:Device Types / GPU Device /
>  This detaches any backing pages from a resource, to be used in case of
>  guest swapping or object destruction.
>=20
> +\item[VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID] Creates an exported object fr=
om
> +  a resource. Request data is \field{struct
> +    virtio_gpu_resource_assign_uuid}.  Response type is
> +  VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID, response data is \field{struc=
t
> +    virtio_gpu_resp_resource_assign_uuid}.
> +
> +\begin{lstlisting}
> +struct virtio_gpu_resource_assign_uuid {
> +        struct virtio_gpu_ctrl_hdr hdr;
> +        le32 resource_id;
> +        le32 padding;
> +};
> +
> +struct virtio_gpu_resp_resource_assign_uuid {
> +        struct virtio_gpu_ctrl_hdr hdr;
> +        le64 uuid_low;
> +        le64 uuid_high;
> +};
> +\end{lstlisting}
> +

ok but how is this then used? will there be more commands to pass
this uuid to another device?

> +The response contains a uuid which identifies the exported object create=
d from
> +the host private resource.

Are the uuids as specified in rfc-4122? I guess we need to link to that spe=
c then
..

> Note that if the resource has an attached backing,
> +modifications made to the host private resource through the exported obj=
ect by
> +other devices are not visible in the attached backing until they are
> transferred
> +into the backing.
> +

s/host/device/?

>  \end{description}
>=20
>  \subsubsection{Device Operation: cursorq}\label{sec:Device Types /
> GPU Device / Device Operation / Device Operation: cursorq}
> --=20
> 2.25.0.341.g760bfbb309-goog
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


