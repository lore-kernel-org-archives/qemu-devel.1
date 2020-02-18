Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA9FC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEF62176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcwk7naN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEF62176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j468s-0001bz-4n
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4688-0000ZT-Co
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4687-0001ma-FK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:53:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4687-0001m0-Bq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582044830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXJ4OslWS+fP+A0VgLTUfQ4PDSDCeLon02HmC95leHU=;
 b=dcwk7naNh4ObbT/RW+LM8nIOHpN1ERv9SnkNacvyHNxJNclziCKdPgdAPUJZoZUTpC1ewO
 hco1MLo2TAmOkbPeNwq3kGIeLd6W8/MunwurPCOHGVGvf7hdSuzMxNL2YwS5GB44q271ng
 irCn7cYmw5mY8KgcmEyHsQqzS5FfULQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-LuROVOzeM7yLuqh4QDWn3A-1; Tue, 18 Feb 2020 11:53:46 -0500
Received: by mail-qv1-f71.google.com with SMTP id s5so575376qvr.15
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a0IbxTOx9P3fYQXQ9kizouMPjRFVKh+zyFqNyVfxAN4=;
 b=iMdcnBOS2gsmRVQaM0n/BuCDytsv2olArxLQUmpGOnatBMnVWmy/P0FdCYGKBJOa56
 GKi7ZF+GxmSiHU7iUQdWi8jEWI+aFA7ABbvw1tK1OLlGeLyPQFqvY0v2Q7yZJodLNGZS
 Qaf0lS50gwUhaRagwmI6yHDZkvNgHtnXwD8NzZ4eiTy/on0Y+zh47xXxm/TbLZaLU/Xh
 3W65KtyTfuZiACNBG1PlJUf2V7Dv0N2p525Jh+MZD5UAvby7RcigPXOSIVj4VeZNIYDk
 1F50eIIBoUXyoYWMw42iKANAGR7BqyQnXVOWIw5hSWgGaPo4a5XdFZTQzY9Y906USpM+
 GaIg==
X-Gm-Message-State: APjAAAVaUzsyrIrNtmvfB3CZQyGk0gYwKMnybrseKm4xK0TadNSrNyVq
 yZbflK8/JrOvvdjLxkr7bnuHIsyiYXBtcH3urtKbtAbZK/QQNXUill4yGpNw7GLvw8a44QPPEFj
 tKSxzN+fw/7G/vRE=
X-Received: by 2002:ac8:694f:: with SMTP id n15mr18295696qtr.372.1582044826231; 
 Tue, 18 Feb 2020 08:53:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBabtvFZfloJ0DKG9h4ocNsrK7kKaFhaTx3+mDiD+O0kI7b5tp2Cex3uyX3U7Gum4Roh5VFw==
X-Received: by 2002:ac8:694f:: with SMTP id n15mr18295673qtr.372.1582044825816; 
 Tue, 18 Feb 2020 08:53:45 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id v10sm2041881qtp.22.2020.02.18.08.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 08:53:45 -0800 (PST)
Date: Tue, 18 Feb 2020 11:53:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Matt Borgerson <contact@mborgerson.com>
Subject: Re: [PATCH] memory: Fix start offset for bitmap log_clear hook
Message-ID: <20200218165343.GB1408806@xz-x1>
References: <20200218101910.6593-1-contact@mborgerson.com>
MIME-Version: 1.0
In-Reply-To: <20200218101910.6593-1-contact@mborgerson.com>
X-MC-Unique: LuROVOzeM7yLuqh4QDWn3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 03:19:10AM -0700, Matt Borgerson wrote:
> Currently only the final page offset is being passed to the `log_clear`
> hook via `memory_region_clear_dirty_bitmap` after it is used as an
> iterator in `cpu_physical_memory_test_and_clear_dirty`. This patch
> corrects the start address and size of the region.
>=20
> Signed-off-by: Matt Borgerson <contact@mborgerson.com>

Looks correct, thanks!

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


