Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFEFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265BF20732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtIa8BYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265BF20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93l3-0004dk-Fv
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93kV-00045Q-DU
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:54:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93kQ-0006IB-Pl
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598003649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enpgWCOeilst93Dh9uETVAYwzwQ8hBHPlDEgKqCFeq8=;
 b=CtIa8BYyypyjUvpQ87LxBbHJfiKys6IL6NlJRwn1cL2yVFOiNM1ccwA1DFTFmUwUIT3QbS
 3OngoRrfHeoHYMB2SOXTZV6UlG4eKied8UXNcwe0JTHyOtELqtvnBEHVCMImdkgbz6gAqK
 TcpxOWO1EH27c3DzRQujZYjlOy/0Dpk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-qMSTJbp4MLydAPS-jQ9syg-1; Fri, 21 Aug 2020 05:54:07 -0400
X-MC-Unique: qMSTJbp4MLydAPS-jQ9syg-1
Received: by mail-wm1-f69.google.com with SMTP id r14so627595wmh.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 02:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GovufO8pWVibqCX5NesbfdOSexh1IG6o1+tbud0r6BI=;
 b=SUs5NJ88PII6I1Brnkz0gn9LKpqbe+tWqj6/ttC/nXYkPz0bwK1XFkJQJ9tnpm/oLE
 330L2D226xIKqtnkCjFnMRqYWHmE6zy0/QxDglnsjKZtw0JMqOcTurxbnnyMJ8z2Mk01
 LwOxXD+D3FIWu5kOEeJepOkZSpjn7DecpCnvbTDM3b60a7ceI52VzW9sNcW4RS8ZJztw
 Xx1kH61qpV83zsi5mx+AfiSRwutz3vKywTEJJonr1rJoO4RMP4V1n6RZLo/VIwrctIQO
 xFo5Ay8iF1qxec7LpTubwyJeEdhZsGm3ER7/ke+Jmy5YXY/vOoMFoqRJg6lVKhcbd+oM
 ipNA==
X-Gm-Message-State: AOAM531wThyOUVcpNpoLzpTcNg/hV6XZtPKh46X04drPzMatJVuzhulf
 evusgTc3ry7iKVKLYvOxsWZcxLMnNzVt9m2/qs5aHyp7rFDjRSZxOjjnNSSih28G2QdBG13FOYn
 BLmRckrn4KKRljW8=
X-Received: by 2002:adf:bbc1:: with SMTP id z1mr1964221wrg.173.1598003646468; 
 Fri, 21 Aug 2020 02:54:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMfeWaYDCYJTAhznYdwi3i8zmDDMjact/i4FvWTK0J1eeMbif6p8kdo6Cw01+SZbOwJqZ3Kg==
X-Received: by 2002:adf:bbc1:: with SMTP id z1mr1964201wrg.173.1598003646206; 
 Fri, 21 Aug 2020 02:54:06 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id x11sm3262831wrl.28.2020.08.21.02.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 02:54:05 -0700 (PDT)
Date: Fri, 21 Aug 2020 11:54:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 05/15] block/nvme: Improve error message when IO queue
 creation failed
Message-ID: <20200821095402.aj5a25z6ueejazxj@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-6-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-6-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 06:58:51PM +0200, Philippe Mathieu-Daudé wrote:
> Do not use the same error message for different failures.
> Display a different error whether it is the CQ or the SQ.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 003809fbd83..53448b7d230 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -648,7 +648,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>          .cdw11 = cpu_to_le32(0x3),
>      };
>      if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
> -        error_setg(errp, "Failed to create io queue [%d]", n);
> +        error_setg(errp, "Failed to create CQ io queue [%d]", n);
>          nvme_free_queue_pair(q);
>          return false;
>      }
> @@ -659,7 +659,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>          .cdw11 = cpu_to_le32(0x1 | (n << 16)),
>      };
>      if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
> -        error_setg(errp, "Failed to create io queue [%d]", n);
> +        error_setg(errp, "Failed to create SQ io queue [%d]", n);
>          nvme_free_queue_pair(q);
>          return false;
>      }
> -- 
> 2.26.2
> 
> 


