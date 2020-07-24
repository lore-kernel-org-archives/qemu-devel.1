Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B719CC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80454206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNHMtzlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80454206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxEt-0005f0-RV
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 08:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxEE-000539-4f
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:55:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxEC-00050y-5n
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595595306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jr6j5yjl9m6IfHpx6t7CggHYbcvBuJ1x6wyQVRWNojw=;
 b=TNHMtzlSEaN8paEDl75LQEpC/9bRoIkoITd/LTCIrvAD266ptCr2rJWiEmgtlgqslWqgs5
 l6G/mETQXNaGrUz1m+Xd6vhTjZWCgYfrQaqrEmfZNGi/jOn2aDvt9j/QXsSKqx/+Fcuw85
 n95414vX/aGe1Yf8qQQkKfP+AIV6raU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-J1NJpErYOCu92pT7nH0OUw-1; Fri, 24 Jul 2020 08:55:05 -0400
X-MC-Unique: J1NJpErYOCu92pT7nH0OUw-1
Received: by mail-wm1-f71.google.com with SMTP id v8so3215595wma.6
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 05:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jr6j5yjl9m6IfHpx6t7CggHYbcvBuJ1x6wyQVRWNojw=;
 b=D6xx2tr4TUAC0Fdb2BqZ4SflcEYcrKj4vs0wbJSeT0VdEtHUHjlXJ6WCdLN497BrZm
 JOMSPxnn7FlF2ZdQdDbjVl9jksdU5A0gHOWYN+3jtxbm6B7+Gy3cstUg0LgsKcDtCDx3
 Dlgta9V99Dq7wCM6KFZgd8ffG5uSuAc71UxVWZY4DfUb5z0FpAeQafD9Df8wKbS31FJh
 9bp6QUrtiWWb0Es6q9FcfajjO27WuEzY0DOH7WIWf2+WTQ7sRdhA6y2/fYPmZF3CW972
 Xrx7uFqvA00+QQWoSIpoj2eDdq0koCcN2d8tjQVCN73/1dLXFY5sw3HJ+u1lQcwmN3wP
 r8OA==
X-Gm-Message-State: AOAM533pe++M3Ugw88EArA7PdyS8P4LwKyiQyJ9vCEACfc/4iTK+FBSH
 j/G7zkIrH4jdIoSnlWytFRsop+/jlgiK5TA5Xr0qNM+k1JqnMGRzGkAMwuT1BUYhK2WCk8DsYJA
 MteC7Fsv2+mXNnO8=
X-Received: by 2002:a1c:4c0e:: with SMTP id z14mr8631612wmf.54.1595595303705; 
 Fri, 24 Jul 2020 05:55:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYl31t667XkKQ0rNP4Id08WEeNk47KWk5d3z20+yRNxYm2ntifMPgevb6a5TmJLgWNZ8QeuQ==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14mr8631595wmf.54.1595595303529; 
 Fri, 24 Jul 2020 05:55:03 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id g16sm1193405wrs.88.2020.07.24.05.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 05:55:02 -0700 (PDT)
Date: Fri, 24 Jul 2020 08:55:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ACPI: Assert that we don't run out of the preallocated
 memory
Message-ID: <20200724085448-mutt-send-email-mst@kernel.org>
References: <20200622113146.33421-1-gengdongjiu@huawei.com>
 <CAFEAcA-NDpWCfqQybu=6svi-ZR=MBBxSKz4dRikDXwW8fftsaA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-NDpWCfqQybu=6svi-ZR=MBBxSKz4dRikDXwW8fftsaA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
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
Cc: Linuxarm <linuxarm@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Dongjiu Geng <gengdongjiu@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 06:50:06PM +0100, Peter Maydell wrote:
> On Mon, 22 Jun 2020 at 12:30, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> >
> > data_length is a constant value, so we use assert instead of
> > condition check.
> >
> > Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> > ---
> > 1. Address Peter and Michael's comments to use assert instead of if().
> > https://lore.kernel.org/qemu-devel/ca79ea28-9ea9-18a5-99ad-25c3eb744721@huawei.com/
> 
> Oops, looks like we forgot about this patch -- Michael, are you
> taking it through your tree or should I take it via target-arm ?
> 
> thanks
> -- PMM

Feel free to merge pls.
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


