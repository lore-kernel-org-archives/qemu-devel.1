Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8FAC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 12:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DAF20706
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 12:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvxRtN0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DAF20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig6SL-0006XZ-JP
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 07:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ig6R2-0005vB-Vx
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 07:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ig6Qz-00081c-HX
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 07:22:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23890
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ig6Qy-0007uz-RZ
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 07:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576326127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=MiYsMXgGsFHfWNGUd03kBxtaFzsYHIdfW2UUfaxifrI=;
 b=bvxRtN0ZpV3Vk46YhHObmpIfo3d4y8VD4TzNRM1J8zh0mowwm8YqAECobu29mM0QnZ42WT
 fKdmMyWpLXZTtwZMymgtIaTG+aFLcZ2hQdNElRFHpZD0rp/V/V0sz2RAoH3l6O0VMKBz9S
 U8YPS3YGiZg61WsxVICeGOtYgfNB/1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-cZztHh_DO_yeBQktVlvZug-1; Sat, 14 Dec 2019 07:22:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC62A477;
 Sat, 14 Dec 2019 12:22:03 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-80.ams2.redhat.com [10.36.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84B965D9CA;
 Sat, 14 Dec 2019 12:21:53 +0000 (UTC)
Subject: Re: [PATCH] virtio-blk: deprecate SCSI passthrough
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191213144626.1208237-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0d2e25dc-ff7a-e133-433a-faac5d6a45d2@redhat.com>
Date: Sat, 14 Dec 2019 13:21:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213144626.1208237-1-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cZztHh_DO_yeBQktVlvZug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/2019 15.46, Stefan Hajnoczi wrote:
> The Linux virtio_blk.ko guest driver is removing legacy SCSI passthrough
> support.  Deprecate this feature in QEMU too.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-deprecated.texi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 4b4b7425ac..ef94d497da 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -285,6 +285,17 @@ spec you can use the ``-cpu rv64gcsu,priv_spec=v1.9.1`` command line argument.
>  
>  @section Device options
>  
> +@subsection Emulated device options
> +
> +@subsubsection -device virtio-blk,scsi=on|off (since 5.0.0)
> +
> +The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
> +and later do not support it because the virtio-scsi device was introduced for
> +full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
> +
> +Note this also applies to ``-device virtio-blk-pci,scsi=on|off'', which is an
> +alias.

... and "-device virtio-blk-ccw,scsi=on|off". With that added:

Reviewed-by: Thomas Huth <thuth@redhat.com>


