Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4267BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5F32230C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2AzrGLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5F32230C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWySx-0003sb-3Y
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 03:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iWyPz-0001Tn-Kb
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iWyPy-00046m-5R
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:59:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59433
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iWyPx-00046A-LI
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574150360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1LpUeV9HnDD2ZePdk4HidJkLtdjNP6Jbm0IbAFwLkU=;
 b=S2AzrGLpPfU1NEuK8RqtCWGn4C3X0EXGK4WS/tnik6pPw1jJvKCU2mj/SVlyhL+OFFmsk7
 8sw1by4GSXcKvvjOexNDPAWMIC8OyVFSHHyXMFm7PT59SNSEveoZDkI1AyNNfWxbzKoDE4
 k5GBdpc92h353vpVVaSjtqoi1LmtqWg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-L165I-7RMCeFm_0isW-bDQ-1; Tue, 19 Nov 2019 02:59:19 -0500
Received: by mail-ot1-f70.google.com with SMTP id z39so11575378ota.7
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 23:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J1LpUeV9HnDD2ZePdk4HidJkLtdjNP6Jbm0IbAFwLkU=;
 b=XVSB45Jur7+Mg8lIyrPC1XO6KDqNuvXWL7TdZ0wlQWLo4BZkEEFzuqCODpGzXCfAIm
 n0y1KoE7xSvCe0Q/ZyudKRpieuX0Dx6Js7RmfN2MnBrwa/4IgCmLIT8sjqI3apmevjd+
 QzhM93eZ2yTQtw+lTLRgcLjh6UNAWdck5ylQN2SjndGRXlXm+oF0vNSGomkFBxAvxWp3
 9fFJnQOSbDbZatn3/HqD9w6W9E4upWD7VQTjSnY2+K/1V4Z05teDWglnu/V+Lz5mL8qH
 +K8IDenHwVUATkBxIZMLOQP3wa4iGr/Msl4WJps55QJ47jxYGTFo6H0d7GDGNjUEbKC/
 HeLg==
X-Gm-Message-State: APjAAAWciL+o4Ar9nNjeNO/YJRpgy3HppDaC4WHdoHfB1VwmEaAqmoPR
 8RTjLCXcBR/Nq3ubWGpHAa06MboBv7NS+G911fIg4ENdJXwN56ugM6YEsnhPtRBxS7ci4n94q88
 CghUVxzfG4mIfaeQTwkm4tSy39wTaoAE=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr299743otg.368.1574150358709;
 Mon, 18 Nov 2019 23:59:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwACp8wePIlSsFQnwqvK2FAEF+dWipHJ/VAHrOGrV7SP3FN9CI/9QeaLFthccE5fk9d/6/wExmXuQkA/8Epwtg=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr299735otg.368.1574150358496;
 Mon, 18 Nov 2019 23:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20191119075759.4334-1-xieyongji@baidu.com>
In-Reply-To: <20191119075759.4334-1-xieyongji@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Nov 2019 11:59:07 +0400
Message-ID: <CAMxuvaykbk-B+feVuU1rVpHK9GeZqjjongOF0YCLXbsrSRsYcw@mail.gmail.com>
Subject: Re: [PATCH v2] libvhost-user: Zero memory allocated for
 VuVirtqInflightDesc
To: Yongji Xie <elohimes@gmail.com>
X-MC-Unique: L165I-7RMCeFm_0isW-bDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 11:58 AM <elohimes@gmail.com> wrote:
>
> From: Xie Yongji <xieyongji@baidu.com>
>
> Use a zero-initialized VuVirtqInflightDesc struct to avoid
> that scan-build reports that vq->resubmit_list[0].counter may
> be garbage value in vu_check_queue_inflights().
>
> Fixes: 5f9ff1eff ("libvhost-user: Support tracking inflight I/O in
> shared memory")
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 68c27136ae..ec27b78ff1 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -992,7 +992,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
>      vq->shadow_avail_idx =3D vq->last_avail_idx =3D vq->inuse + vq->used=
_idx;
>
>      if (vq->inuse) {
> -        vq->resubmit_list =3D malloc(sizeof(VuVirtqInflightDesc) * vq->i=
nuse);
> +        vq->resubmit_list =3D calloc(vq->inuse, sizeof(VuVirtqInflightDe=
sc));
>          if (!vq->resubmit_list) {
>              return -1;
>          }
> --
> 2.17.1
>


