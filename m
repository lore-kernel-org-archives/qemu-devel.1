Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6753CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C90206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU7YKHhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C90206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyVYd-0002ci-Be
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 03:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jyVQe-0000yz-4G
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 03:14:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jyVQc-0005rp-2k
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 03:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595488444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9V6BqOi9flILNmeNlLypC6u44ImVyXdiXy9zMXz80oc=;
 b=FU7YKHhgOX2qm5EQkQaLitu5dTbTnkNqFp0feuYV9lVs5hdvD4XFuFQmfP27oLw2mS5/nt
 xX/BjN4j5CaZG3U9kXreuqY11KjunfvjR1ZcFD/ADXJI03djMyQPv4T4lc8i/MAq2HEaxw
 xHqTRG9fFeFKf7heR+GaTIizE2EBJoM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-owKaLiCDMVSAkYMGhugN1Q-1; Thu, 23 Jul 2020 03:14:02 -0400
X-MC-Unique: owKaLiCDMVSAkYMGhugN1Q-1
Received: by mail-il1-f197.google.com with SMTP id o191so520200ila.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 00:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9V6BqOi9flILNmeNlLypC6u44ImVyXdiXy9zMXz80oc=;
 b=ud/0aBwBzn4n8o32Mn5e9mlTusajZ8bsD0JRA0YBsNyQxcYSHxWYtTrC3+e+b5UMK4
 SDRkba/t8x1Sbh2lTrmSqIAiTnRvFVcg/8n6sLRyxLiFgeP8llmODi7R8MzqdoPGf3v5
 nc3S22Vs+t3fRAPgNIVEgayLmP9I0532w3OGLLKxWk7ggUtu8zXBQYpmZnzi8Blkb5y6
 9+hZmqTbhbKl1+5icUX7z7DCmlNJ4Vw6PI4FoTSYKNPDdKFYu4UaAdt0Wn03m/5yat44
 x3DUL/bupQhCFLBZnjxFBT8Gu9huy1kOzAeQyq3iwg4oAqAh42y/fzZo9stJPvcK5ple
 qaBg==
X-Gm-Message-State: AOAM530vPqoVtg8Kfiz5WzUQmpORrzsSyEUDS0AM/oXsQo/JZkUefGQ6
 sW1G3c8ZRtdvTI9N9SqzPfBXhpP3w19y0jJICMjieQ6elVa3rb3gsyBikqXfimjKtpnhp6qBFFl
 uZq2Md0tTUupJqgPtNmqfWSNyjk/A5Ag=
X-Received: by 2002:a6b:b4d1:: with SMTP id d200mr1270822iof.70.1595488442083; 
 Thu, 23 Jul 2020 00:14:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAdB9N9/P+fTZFc13pIKuxudzFBbmkfd7ex16Dt7KNwvrJrhE8Yo9lVgKWJ49ZKDIV7IAKgI4o+fed4iDfUOQ=
X-Received: by 2002:a6b:b4d1:: with SMTP id d200mr1270807iof.70.1595488441800; 
 Thu, 23 Jul 2020 00:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <1594799958-31356-1-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1594799958-31356-1-git-send-email-raphael.norwitz@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Jul 2020 11:13:50 +0400
Message-ID: <CAMxuvayiibGhCQqo01g_ffy_W4DaJ440gRVzY2MvD1FFA5-DCw@mail.gmail.com>
Subject: Re: [PATCH] Fix vhost-user buffer over-read on ram hot-unplug
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 17, 2020 at 8:21 AM Raphael Norwitz
<raphael.norwitz@nutanix.com> wrote:
>
> The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS vhost-user protocol
> feature introduced a shadow-table, used by the backend to dynamically
> determine how a vdev's memory regions have changed since the last
> vhost_user_set_mem_table() call. On hot-remove, a memmove() operation
> is used to overwrite the removed shadow region descriptor(s). The size
> parameter of this memmove was off by 1 such that if a VM with a backend
> supporting the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS filled it's
> shadow-table (by performing the maximum number of supported hot-add
> operatons) and attempted to remove the last region, Qemu would read an
> out of bounds value and potentially crash.
>
> This change fixes the memmove() bounds such that this erroneous read can
> never happen.
>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Fixes: f1aeb14b0809 ("Transmit vhost-user memory regions individually")
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 3123121..d7e2423 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -672,7 +672,7 @@ static int send_remove_regions(struct vhost_dev *dev,
>          memmove(&u->shadow_regions[shadow_reg_idx],
>                  &u->shadow_regions[shadow_reg_idx + 1],
>                  sizeof(struct vhost_memory_region) *
> -                (u->num_shadow_regions - shadow_reg_idx));
> +                (u->num_shadow_regions - shadow_reg_idx - 1));
>          u->num_shadow_regions--;
>      }
>
> --
> 1.8.3.1
>


