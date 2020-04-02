Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104E4C2BA1E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB042080C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl/EXqah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB042080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0po-0003pB-Uy
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jK0od-0002tL-F4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xadimgnik@gmail.com>) id 1jK0ob-00044A-8i
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:27:31 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <xadimgnik@gmail.com>)
 id 1jK0oY-0003y9-JA; Thu, 02 Apr 2020 10:27:26 -0400
Received: by mail-ed1-x542.google.com with SMTP id a43so4378539edf.6;
 Thu, 02 Apr 2020 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:thread-index
 :content-language;
 bh=Gs5s/AzhrQY0MsAWHGCRh7EB5NuuIAx0gTTvncvqfKE=;
 b=gl/EXqahrI3LZRtHXzm7a3z4YJSAdAf27Dc661ub6stokk89cDWUnY7bjUvrGkf96I
 7i/EpB1jiIhkF67ojeY504MXIylH+M4bqUEgn60r3uZd/Oz2etLzEqQ2IaC1+86fhywE
 397kvjfV7wS+/SB1TCSZA5OceOj9TuDjDv92KhtEOAvUYW7744++uJD2GEkpLZRGnvsA
 WL0WovrXoZrfzthEJNHU5W+ywHscfycTaIWJKuAkBvAl1Bnbjv8QCn9Rc7zMoFFkRQOM
 vrxPAn9E707ugzCon5b4FR8a+rOavXIKCvpqmF5J32A3n0Tn4zS78gC2Rsv6uH8oUBSA
 tfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :thread-index:content-language;
 bh=Gs5s/AzhrQY0MsAWHGCRh7EB5NuuIAx0gTTvncvqfKE=;
 b=DWltzzt2v31w8cz2gU7dfmAHbIzGERGGoj85c4ze7b5lcE8Vs4ZmTKpqlU6h5JGoAX
 UmzXgNBxvM5Acpiy9yVHoZc4Xt+JDmkRbZgd428/yw4kYscr6j5Yy0AKkt6Y1ypmz2wD
 CPswBpbB4ZT10OS1pC/4ZzVHaxR7R/TBHof+NPxbWFmHlA0C07MNJto/A5x3RsvWtfqL
 XNrO9dRYNjChhoVam2XgAnZOGJ5Ulb0UKd0j2QVcVPmeSwNwPRPE1LV836TOWFGExU41
 iDcS4WAt8pYxa08KQT1UrfKTvaHTIZ1ztyPT2pUZysb2A4ibbx4LdGNnrst/kFnZvaEQ
 3ZaA==
X-Gm-Message-State: AGi0PubaO94K/KfwGQh6S+YjDlp51i1vjB1/uJ9C1W3FPxsalKl11Zex
 kjc8o7NymAVcF5pi+eZvjRE=
X-Google-Smtp-Source: APiQypLuaThFpCbWKxMrtN/Q9dMNyMZEUOQLRr9AFvW3LtVMOz1qHh5CqF8QMja/YifoHG5k6yQl8w==
X-Received: by 2002:a17:906:eddb:: with SMTP id
 sb27mr3610618ejb.207.1585837645042; 
 Thu, 02 Apr 2020 07:27:25 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.185])
 by smtp.gmail.com with ESMTPSA id f18sm1127971ejt.25.2020.04.02.07.27.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Apr 2020 07:27:24 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Anthony PERARD'" <anthony.perard@citrix.com>,
	<qemu-devel@nongnu.org>
References: <20200402130819.1216125-1-anthony.perard@citrix.com>
In-Reply-To: <20200402130819.1216125-1-anthony.perard@citrix.com>
Subject: RE: [PATCH for-5.0] xen-block: Fix double qlist remove
Date: Thu, 2 Apr 2020 15:27:22 +0100
Message-ID: <001801d608fa$d3f0d3f0$7bd27bd0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLmjVOS2S5Ry01+8mL39/r4UrwBIqZE2WIQ
Content-Language: en-gb
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Reply-To: paul@xen.org
Cc: 'Kevin Wolf' <kwolf@redhat.com>,
 'Stefano Stabellini' <sstabellini@kernel.org>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, 'Max Reitz' <mreitz@redhat.com>,
 'Stefan Hajnoczi' <stefanha@redhat.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 02 April 2020 14:08
> To: qemu-devel@nongnu.org
> Cc: qemu-stable@nongnu.org; Anthony PERARD <anthony.perard@citrix.com>; Stefano Stabellini
> <sstabellini@kernel.org>; Paul Durrant <paul@xen.org>; Stefan Hajnoczi <stefanha@redhat.com>; Kevin
> Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; xen-devel@lists.xenproject.org; qemu-
> block@nongnu.org
> Subject: [PATCH for-5.0] xen-block: Fix double qlist remove
> 
> Commit a31ca6801c02 ("qemu/queue.h: clear linked list pointers on
> remove") revealed that a request was removed twice from a list, once
> in xen_block_finish_request() and a second time in
> xen_block_release_request() when both function are called from
> xen_block_complete_aio(). But also, the `requests_inflight' counter is
> decreased twice, and thus became negative.
> 
> This is a bug that was introduced in bfd0d6366043, where a `finished'
> list was removed.
> 
> This patch simply re-add the `finish' parameter of
> xen_block_release_request() so that we can distinguish when we need to
> remove a request from the inflight list and when not.
> 
> Fixes: bfd0d6366043 ("xen-block: improve response latency")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

It looks to me like it would just be more straightforward to simply drop the QLIST_REMOVE and requests_inflight-- from
xen_block_release_request() and simply insist that xen_block_finish_request() is called in all cases (which I think means adding one
extra call to it in xen_block_handle_requests()).

  Paul

> ---
>  hw/block/dataplane/xen-block.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
> index 288a87a814ad..6cc089fc561f 100644
> --- a/hw/block/dataplane/xen-block.c
> +++ b/hw/block/dataplane/xen-block.c
> @@ -123,15 +123,19 @@ static void xen_block_finish_request(XenBlockRequest *request)
>      dataplane->requests_inflight--;
>  }
> 
> -static void xen_block_release_request(XenBlockRequest *request)
> +static void xen_block_release_request(XenBlockRequest *request, bool finish)
>  {
>      XenBlockDataPlane *dataplane = request->dataplane;
> 
> -    QLIST_REMOVE(request, list);
> +    if (!finish) {
> +        QLIST_REMOVE(request, list);
> +    }
>      reset_request(request);
>      request->dataplane = dataplane;
>      QLIST_INSERT_HEAD(&dataplane->freelist, request, list);
> -    dataplane->requests_inflight--;
> +    if (!finish) {
> +        dataplane->requests_inflight--;
> +    }
>  }
> 
>  /*
> @@ -316,7 +320,7 @@ static void xen_block_complete_aio(void *opaque, int ret)
>              error_report_err(local_err);
>          }
>      }
> -    xen_block_release_request(request);
> +    xen_block_release_request(request, true);
> 
>      if (dataplane->more_work) {
>          qemu_bh_schedule(dataplane->bh);
> @@ -585,7 +589,7 @@ static bool xen_block_handle_requests(XenBlockDataPlane *dataplane)
>                      error_report_err(local_err);
>                  }
>              }
> -            xen_block_release_request(request);
> +            xen_block_release_request(request, false);
>              continue;
>          }
> 
> --
> Anthony PERARD



