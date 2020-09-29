Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425A6C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33362083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kiy4toQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33362083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNF3X-0006jd-OO
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNEvf-0006rc-4j
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNEvd-0000RG-CS
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:40:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601383219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13PK4Ssg5BzCyVg+1FPKTBVp7+n3837igy5oAPUIZpw=;
 b=Kiy4toQXm3BzzR8an4fIV8G1gpPPF7UoEyCWReE2UEju1YDcvVpMYwfmhu3JjP+85wpICO
 1rggc/esf5gVPcqbeGTjrxe015QEEy6jSipyRs1crr6Fvpi4IF4ag3iDpoLICMQ0sLKONN
 oWwm5cKA7rDqmsjBNaiE+vuxrnSbKtk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-xEzJsAKhM26z9wuEoD1BeQ-1; Tue, 29 Sep 2020 08:40:17 -0400
X-MC-Unique: xEzJsAKhM26z9wuEoD1BeQ-1
Received: by mail-wr1-f72.google.com with SMTP id o6so1705238wrp.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QAlP+ij8tfJHvxKOp3BUIiXO/b6YWfeSbmy1Ysd4Ny4=;
 b=OKRmmi08nHsmO2s2ORaau/mZr391m/yQUj5gQGrbdQ1mG7X84X91HfevtFgJb9AJ8f
 tfdleZOaxDeEbYMm61QgWlRVkxKlcU+utioHuRvb++uEolAm/YuPB/JqoBY7FcFiRMA0
 SZaFYKn0lVowOTiAXb8vM/MJYdWaPffHCO1zihd81Sifguo+QGKQY2B9cZiiMx9NOuYN
 n4qA10ilAWlQTFtNhUyMuiFEKSI39mnKM6O81nkYmDAMcisMM81NX/xT5dlh4A6jceHK
 XP376kC5olWQ1qYAhrSXTADVTZoVw4t61+dJLca/Cm+Z+HRFHFCZhOK76foWDy25oHtE
 gihg==
X-Gm-Message-State: AOAM530rXDavgfQ7zBUg/4OyvUm7bPho+GbN3BmALaCafj2VlWboI0bm
 Unv/EZes6GAAJrwoS5Bbg7DSS8u0eTn54Qtqhel9tVTaA0VqEtBtZB7rRlT933tHV+w5hfrgATs
 7eK2BDqDtZeviQD8=
X-Received: by 2002:adf:ec47:: with SMTP id w7mr4396691wrn.175.1601383216737; 
 Tue, 29 Sep 2020 05:40:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFCmxwtB4O6OEUfrh6r3XsxYR3JwkdMbLFg15zKQ7+lCyquBa3AnUMwEBqKX/A7KkLolVqBw==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr4396673wrn.175.1601383216547; 
 Tue, 29 Sep 2020 05:40:16 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id i33sm6542861wri.79.2020.09.29.05.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 05:40:15 -0700 (PDT)
Date: Tue, 29 Sep 2020 08:40:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL 0/1] acpi: fixup
Message-ID: <20200929084000-mutt-send-email-mst@kernel.org>
References: <20200929111255.381871-1-mst@redhat.com>
 <ed9c633d-63c0-4e84-4eb1-adf634416bec@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ed9c633d-63c0-4e84-4eb1-adf634416bec@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 02:36:09PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/29/20 1:13 PM, Michael S. Tsirkin wrote:
> > The following changes since commit 213057383c9f73a17cfe635b204d88e11f918df1:
> > 
> >   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-09-29 11:10:29 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > 
> > for you to fetch changes up to f142e4ede72853aaa7d306bc79b099caed45769b:
> > 
> >   tests/acpi: drop unnecessary files (2020-09-29 07:10:37 -0400)
> > 
> > ----------------------------------------------------------------
> > acpi: fixup
> > 
> > My last pull included a ton of useless files by mistake.
> > Drop them all.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> It might be cleaner to directly apply this as a "buildsys fix",
> sometimes Peter accepts to do it.

Hmm I do not know how to generate this ...

-- 
MST


