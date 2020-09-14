Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6F6C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F7B217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/5tCkNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F7B217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHtyn-0006ro-IB
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 15:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdillama@redhat.com>)
 id 1kHtxi-0006J0-Lv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:16:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jdillama@redhat.com>)
 id 1kHtxf-0004Th-OV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600110982;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=G3HsUXOo+ygXYrN4n0kl8wxCwTvyRm+HX3XzIE8dX9I=;
 b=h/5tCkNfmUauT4tmF9Sv7+sEmBp0tSYL9GY7j+yrCikf0rO/nS9+9ojU/2dBhsV/KIhCBx
 FPKiG4C2Vc684slxTdwTF72agq5y6dOXu0d7TqMwzGcFZlQhXK/dEpCmlvYVOhR43R/T7K
 BB9ligmQXARrmsUp7+RoztSA6vqTtPg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-pfphPDOPNpOHfYustBjsmA-1; Mon, 14 Sep 2020 15:15:14 -0400
X-MC-Unique: pfphPDOPNpOHfYustBjsmA-1
Received: by mail-wr1-f70.google.com with SMTP id l17so231855wrw.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 12:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=G3HsUXOo+ygXYrN4n0kl8wxCwTvyRm+HX3XzIE8dX9I=;
 b=M46NvaYmngB5mT7aOZ+7G07dp67CgF1MHAnMWteZwhf0QB0wf4l028GPyLgVKyhlK7
 0nsPCSwG8z1bMvh3foPvLt71F+xWxGYLaf2x4JTpAiDckgXJbiL/2UQAh+uL1LiDxqBL
 T6g3RdjFLWKx9yUnKMTJncUWY/EN7kdkAwP9RnK0Z1IXLKs0XsodavHdzYcUM/7wriNY
 ZK5+Its5U3CQPtHsoJX1DBydJlJIydWdjBXq9E00vg9iG6g+xDZs2eC/wPuliVvrNr9Q
 tPM8ghwxyD+S+I8l1nVhza2FcxOM3gWHw2Wq63CJIYe/OfTR/0imCe2SLBhiyDzD0fFd
 nDlw==
X-Gm-Message-State: AOAM532BZg1/KQ+O8dht5YthlBrGI0PWxtrEHQkYzsTZ2TohrUIjYRgu
 HsX2FthEk7RZMncV0aHzX5ngSmq5hplMADNtXCVX3WBPfBVdvgOGX8HbniLEpzM2iWX20eFIVj8
 /yJ7zwHVQLfUmLiRbZHg01zJshsn0E9c=
X-Received: by 2002:a1c:a911:: with SMTP id s17mr824721wme.77.1600110912753;
 Mon, 14 Sep 2020 12:15:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzayqThr+NAiNI4jzHmYH826rHO94vZhAJx0GcNC85fWxn2RBzolMiw3DoKiGGmJUZ1LXYkH5iDCPDQo6dveTw=
X-Received: by 2002:a1c:a911:: with SMTP id s17mr824700wme.77.1600110912544;
 Mon, 14 Sep 2020 12:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200914190553.74871-1-sgarzare@redhat.com>
In-Reply-To: <20200914190553.74871-1-sgarzare@redhat.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Mon, 14 Sep 2020 15:15:01 -0400
Message-ID: <CA+aFP1CZ5oPnt1bO4746WNdY3Xsps4_KMTeDvP0YabU86PS8fg@mail.gmail.com>
Subject: Re: [PATCH] block/rbd: add 'namespace' to
 qemu_rbd_strong_runtime_opts[]
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jdillama@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jdillama@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Florian Florensa <fflorensa@online.net>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 3:06 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Commit 19ae9ae014 ("block/rbd: Add support for ceph namespaces")
> introduced namespace support for RBD, but we forgot to add the
> new 'namespace' options to qemu_rbd_strong_runtime_opts[].
>
> The 'namespace' is used to identify the image, so it is a strong
> option since it can changes the data of a BDS.
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1821528
> Fixes: 19ae9ae014 ("block/rbd: Add support for ceph namespaces")
> Cc: Florian Florensa <fflorensa@online.net>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/rbd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 688074c64b..5356753fbe 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1289,6 +1289,7 @@ static QemuOptsList qemu_rbd_create_opts = {
>
>  static const char *const qemu_rbd_strong_runtime_opts[] = {
>      "pool",
> +    "namespace",
>      "image",
>      "conf",
>      "snapshot",
> --
> 2.26.2
>

lgtm

Reviewed-by: Jason Dillaman <dillaman@redhat.com>

-- 
Jason


