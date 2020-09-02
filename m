Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3196DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8B920826
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7BGlshO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8B920826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNcr-0006M1-5D
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 03:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kDNbs-00057G-8e
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:55:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32091
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kDNbq-0008LE-O8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599033309;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeCAJkUb+h6KimGOZfxLjvhINNCPL15NrlPSw5Ccpc0=;
 b=g7BGlshOx3SRqXUVR4A93N+6vQ7p6NqyGT3hWf5Xp8aG+2yiHLifyV7BMSc2ICb7qkt1Xm
 y1NmsKpBSIB27xbEiVnVjmOVKIPAYHOEij3lztWcq1ycsQwEEGVarwCEwQV8lZGcJtyJpm
 Ylbxvbfu4yO43Nw6jnTaYZT0R8S8MuQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-1RL1FF3XMsq9w78w2HzZHg-1; Wed, 02 Sep 2020 03:55:06 -0400
X-MC-Unique: 1RL1FF3XMsq9w78w2HzZHg-1
Received: by mail-wm1-f72.google.com with SMTP id a5so1284566wmj.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 00:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WeCAJkUb+h6KimGOZfxLjvhINNCPL15NrlPSw5Ccpc0=;
 b=mCjn8J9+g9IIFu+HCvZlasex4AcqhexQbP3m3SgD+JT68ZV4EO5wNF0pXMb/DW4dW9
 Yj9YpvtApoWq5nbzlWVfg3ldo7OSYJ/lR/lFkPbYm1tojQHplVU3T4YmCYkYStGBdL3v
 OVqSLpyj76Lvbhjk5hWKRgVBP8ncldCTGj8OCfMEX5Jh+8GEBAWQV6Xpa1Je8loI2RfF
 gNT8dXQlPb/VA+AZISQ7f50GKH5LaTcDZN/1Th0l7+mEFmTYenBCfTw6laSMK+t2W0Ak
 ddqyYzhJw3NWsk3qygo/xOVBpVka4ZJ9uDsiKlwyVAKEpIhUuv+qKC9oSzxh+7Q5JutW
 qWNA==
X-Gm-Message-State: AOAM533w0F++ZvUEBGGxU6vdRkiFy9MJp15M+9Q2Q3hCq5j457ykQS6N
 RrZQLnHPNfj3qMnOy4N+iQJ1fBFfAICXKPiFZVVRmpIQ6WCWrmBajH9pft/nzRNx9aNTuB+JjoE
 J3cuMQczOqosHXk0=
X-Received: by 2002:a5d:468f:: with SMTP id u15mr5770966wrq.336.1599033305228; 
 Wed, 02 Sep 2020 00:55:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpfyb3Uk53EhQy77OKBGdv2Xdtu0QxnXLlQroiIxX8/miTrjaZkt1v51yKtj1J0BEvyMQ9Nw==
X-Received: by 2002:a5d:468f:: with SMTP id u15mr5770943wrq.336.1599033305047; 
 Wed, 02 Sep 2020 00:55:05 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id z203sm5747738wmc.31.2020.09.02.00.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 00:55:04 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v8 3/5] memory: Add IOMMU_DEVIOTLB_UNMAP
 IOMMUTLBNotificationType
In-Reply-To: <20200901142608.24481-4-eperezma@redhat.com> ("Eugenio
 =?utf-8?Q?P=C3=A9rez=22's?=
 message of "Tue, 1 Sep 2020 16:26:06 +0200")
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-4-eperezma@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 02 Sep 2020 09:55:03 +0200
Message-ID: <875z8wr4tk.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: quintela@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:
> Adapt intel and vhost to use this new notification type
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


