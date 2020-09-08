Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801C6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE1E21741
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQWwfbvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE1E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFZlt-0006W2-05
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kFZlD-0005LL-5v
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kFZlB-0000Ea-60
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599556671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zONPNEEByK69cnX4s6/SPvowmCWzT22/Pg9OHZLNMCM=;
 b=IQWwfbvlQ8tvOzM5BVVazQhadUYxxAOg20Ui8rbCZC8G3orE0CtcUiDDK44XH5tNQhamwA
 25K7IYNpqfMk2PaTk1ZZw4oFw6S3VpF1nj/UcgRN+N50Abk3VjIEY39f72P4HQ4wVO3Bqn
 t8dIgXANzXps9a5o3byM6cXNjBT0zdE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-eP6TvhwwM8iKyRUFTv9SVA-1; Tue, 08 Sep 2020 05:17:50 -0400
X-MC-Unique: eP6TvhwwM8iKyRUFTv9SVA-1
Received: by mail-wm1-f70.google.com with SMTP id b73so3266227wmb.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 02:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hNND3JC+L+Ff4r2YayqvJtDdaV6xZTeqzwQ0WVbJfc8=;
 b=lmSMrOjKkdqQvbgrzD90AasDtS2Qy6x+kniBKhsP5eozEtc1EPIsuU3zVp3Mpqn4Q8
 GT2EKYirU0tJg6GizmJrif14Otdtf+oItyOKF/Awf4/lZ/4UeYGWsGWvVeWAbWXFpZ2Y
 gnx1uJRexlVoS9Uv4ZacUCMZ+t8hpkel3cC557V8cN0Zt7O+dgE9rjOQ3BUvCEJjFWty
 kZTE0obCLISg4oembI2+20+pUJuH/z3Xf7PTso/f26EjiQrXmxwKgAWEtQV9cbgWjwGG
 lXVuMebQNlqZCODrYuSmWVgR/P6JtImj/2gvUj8h0YGdEKGMqMc3/c0Hamrsmmp7cnQc
 P2zA==
X-Gm-Message-State: AOAM5330nKAu0VPkkH1yi+Z6STfgAuEt+TT/ZypVyjdgDEqnaW8cAzem
 Ct/LP2jVBc3+LjnjGtrQdrp+VrltrLO73PTHtduuJLc95hDtiCsRCEak/teP5rWFwxnQ6Wh9ywU
 q1j4WYYe3yjAmCrY=
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr3353348wml.176.1599556668859; 
 Tue, 08 Sep 2020 02:17:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUYd+QKAUGh3Rcs33/cTGfrCBbdGR95V+p9tBQm2/wYS3CYyNxDg/MSEejVGCmSG18VsV+jA==
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr3353327wml.176.1599556668630; 
 Tue, 08 Sep 2020 02:17:48 -0700 (PDT)
Received: from steredhat (host-79-53-225-185.retail.telecomitalia.it.
 [79.53.225.185])
 by smtp.gmail.com with ESMTPSA id 8sm35651125wrl.7.2020.09.08.02.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 02:17:48 -0700 (PDT)
Date: Tue, 8 Sep 2020 11:17:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] scripts/git.orderfile: Display meson files along with
 buildsys ones
Message-ID: <20200908091745.kpoenbxefraxdzuo@steredhat>
References: <20200907161222.41915-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200907161222.41915-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 07, 2020 at 06:12:22PM +0200, Philippe Mathieu-Daudé wrote:
> Since commit a56650518f5 ("configure: integrate Meson in the build
> system") we replaced many Makefile by Meson files. Adapt the
> git.orderfile script to display the new file at the same position.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  scripts/git.orderfile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/git.orderfile b/scripts/git.orderfile
> index 73fd818d7f3..a021afc2d51 100644
> --- a/scripts/git.orderfile
> +++ b/scripts/git.orderfile
> @@ -18,6 +18,7 @@ docs/*
>  configure
>  Makefile*
>  *.mak
> +meson.build
>  
>  # qapi schema
>  qapi/*.json
> -- 
> 2.26.2
> 
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


