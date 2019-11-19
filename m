Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2C020872
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRzUmJiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2C020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWxl7-0002wp-5w
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 02:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iWxkD-0002WX-Nt
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iWxkC-0000rs-Mb
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:16:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45961
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iWxkC-0000rA-JG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574147771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADVuekd2kTQIG4v8bImQVYY2DF0hYYeEFPt7fYqXTLw=;
 b=MRzUmJiPqjpdBBGRrw7rU2w9SdbUp0g+EpqDlKP8sm8V1GUqCluZoBtlpHU69pFi6BZj3p
 ZhLrLgwVjmwqhh1pXH26B8eSXZn0PJgdxWIjXfl8A3Iqah42lPHyzNeDlNqculCnvG6DFs
 re88wqGwmgBwt2J6ec8dmMarF0DXBTw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-zi0GdKMMNwCxNGB5f2JQNg-1; Tue, 19 Nov 2019 02:16:08 -0500
Received: by mail-ot1-f69.google.com with SMTP id m15so11512189otq.8
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 23:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ADVuekd2kTQIG4v8bImQVYY2DF0hYYeEFPt7fYqXTLw=;
 b=Mr3TMNkcqFczIDq92217mZx9ORaRfLzX5Zz+j+6iEnJxAF0p8U2YXON4embeammf3M
 Dg4ngl6Fy55MRh9P2ciCri3XAnmLD1DAR5PaF8gS2FbMyeobRbfPeqYBdtt5ceuujvnP
 eobGeTnPUl53r98E6LUouhDRWsDhRoaNGnMjuRn5vUXsWdLeokwyHVF/t+rk2mHldgMk
 U/4qcYW0L/ZBnGFDg8HTpIqkoKwvcvYbZ8TrpuffnkviHaBnjPLmDAflkn6lOpLGOt//
 TkPpk2wXszINmgQDjMRWNJK66Nr9YJh+dOv8o6glShc7b2tk5nGY/u+Xsn9KJ73rsdtJ
 XiKw==
X-Gm-Message-State: APjAAAW83me8uDXgMF1aiGzSUxsWsGKOlW5tUL/ZGdJcR7wtNvvhbG1T
 9DrXeYYfB+oDdvoeH8MHKN+VViFOJ/MdMlSC5rdPodfWuF9H2SZHzb+RFinCGP7AW5kBKgixNl9
 rhNgX1pjdlbMX2+q6J5iMEOEZ/YAceJg=
X-Received: by 2002:aca:62c6:: with SMTP id w189mr2846275oib.33.1574147767319; 
 Mon, 18 Nov 2019 23:16:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSIlTEMMN7Mjx1mcfi3XA00Ff4ndBtHwh5b9xt92R4lx48r9fA9oNt7C2JKyqbxFjay1DpX8Ocpb1783Tnxac=
X-Received: by 2002:aca:62c6:: with SMTP id w189mr2846257oib.33.1574147767025; 
 Mon, 18 Nov 2019 23:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20191119034851.2285-1-xieyongji@baidu.com>
In-Reply-To: <20191119034851.2285-1-xieyongji@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Nov 2019 11:15:55 +0400
Message-ID: <CAMxuvawB-MMPK+X-w-wY2ABAFmXJhG4vwY0D4bfpKCCYfvhLOg@mail.gmail.com>
Subject: Re: [PATCH] libvhost-user: Zero memory allocated for
 VuVirtqInflightDesc
To: Yongji Xie <elohimes@gmail.com>
X-MC-Unique: zi0GdKMMNwCxNGB5f2JQNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Nov 19, 2019 at 7:49 AM <elohimes@gmail.com> wrote:
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
> ---
>  contrib/libvhost-user/libvhost-user.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 68c27136ae..e76d6e9920 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -992,7 +992,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
>      vq->shadow_avail_idx =3D vq->last_avail_idx =3D vq->inuse + vq->used=
_idx;
>
>      if (vq->inuse) {
> -        vq->resubmit_list =3D malloc(sizeof(VuVirtqInflightDesc) * vq->i=
nuse);
> +        vq->resubmit_list =3D g_malloc0(sizeof(VuVirtqInflightDesc) * vq=
->inuse);

For better or worse, libvhost-user.c doesn't depend on glib (although
it's included by qemu common headers).

So I'd stick to calloc, until we do a whole-file switch to glib, to
avoid mixing functions.

>          if (!vq->resubmit_list) {
>              return -1;
>          }
> @@ -1605,10 +1605,8 @@ vu_deinit(VuDev *dev)
>              vq->err_fd =3D -1;
>          }
>
> -        if (vq->resubmit_list) {
> -            free(vq->resubmit_list);
> -            vq->resubmit_list =3D NULL;
> -        }
> +        g_free(vq->resubmit_list);
> +        vq->resubmit_list =3D NULL;
>
>          vq->inflight =3D NULL;
>      }
> @@ -2263,7 +2261,7 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>          elem =3D vu_queue_map_desc(dev, vq, vq->resubmit_list[i].index, =
sz);
>
>          if (!vq->resubmit_num) {
> -            free(vq->resubmit_list);
> +            g_free(vq->resubmit_list);
>              vq->resubmit_list =3D NULL;
>          }
>
> --
> 2.17.1
>


