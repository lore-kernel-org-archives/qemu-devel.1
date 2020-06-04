Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C228BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8707B206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9g4Mkgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8707B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmNT-0003yC-SD
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmMX-0002uy-Q6
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:40:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmMW-0003yN-WE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591263635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0PzqfruYghGORRB0/GjBV8VloGTJOsFF1gGKBUv4zc=;
 b=c9g4MkgsxlkkurYkOSja/4y0Nt15KEftqC4jpfFoIM2v0916UvEh8t/mXw6WPBniuV63Ev
 T1qAOKuEVDiVrwUvTWCHk9FA1k5V9qx+MKKBBNKs6RYmWeyJ9LBf4VonIk4zvZZEGKPHtY
 XP4msKFTkn/Iwb+SXw8zoLl1ohuVxNc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-ljiCDnIROMiCe5BPDEopWA-1; Thu, 04 Jun 2020 05:40:34 -0400
X-MC-Unique: ljiCDnIROMiCe5BPDEopWA-1
Received: by mail-wr1-f72.google.com with SMTP id z10so2206114wrs.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 02:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=fxk9S/XIW068RmgFwSTzHjTF9FtIDH+DRDT1W1/dlSI=;
 b=s6kesIj1mIMIEzkJsoyYlOrzvf69L5vR829W84har/JhmqOtwtMPpfDz4p+sR+NuDV
 A13ieJ6f1KQiV5ceq9zcd1TjiQrusZPKeO7KxHBbJ/cboEqae4ojcLpQ3yhzAGlNyT1u
 AzhBn8kPGz5lkWjR5MTWQJMB78ftpVsdOJ9UNdljUcU0eGlBshJ6f+Snw6DrttliB9Vr
 5APlsR/Ays5QF3LQBIb6m8Pq/cDJiNbOxj6Eqa+Kgn0Bv8qc7/j4vFTbQwlZLV+tyTWw
 ztiRBgH1ERRFpovvJb5z7Q1wwZB/cYf+7SKUiqGjKtBKQxXAJuNz90WC6d0NEqo9eAvn
 4L1g==
X-Gm-Message-State: AOAM532Ud+7a1xQYeGzI6r9Qo83tQZ1sJBtELBKDMmBuqVlhm26gMZX0
 fHgXiAsciq+sZwlEiTKXzKNgOhjy8CUSjAPsUTMdZxRASpvjEb2wBOwO75+AsaRQJZzAMJSeAo6
 ppRihOt8CuxMN0qA=
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr3433410wmj.137.1591263633264; 
 Thu, 04 Jun 2020 02:40:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi10Y3IS7eZwodAYs1Nr3ZkIHTI9RoJi26z36xPA6sVGqOGq9JXpu6ruFWwRb8e5hMm8EkXg==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr3433389wmj.137.1591263633085; 
 Thu, 04 Jun 2020 02:40:33 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id z6sm6814301wrh.79.2020.06.04.02.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 02:40:32 -0700 (PDT)
Date: Thu, 4 Jun 2020 05:40:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2 1/2] ait-vga: check address before reading
 configuration bytes
Message-ID: <20200604053924-mutt-send-email-mst@kernel.org>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-2-ppandit@redhat.com>
 <20200604084318.GA3050580@redhat.com>
 <nycvar.YSQ.7.77.849.2006041445530.30592@xnncv>
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.77.849.2006041445530.30592@xnncv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Yi Ren <c4tren@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Ren Ding <rding@gatech.edu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 02:48:59PM +0530, P J P wrote:
>   Hello Phil,
> 
> +-- On Thu, 4 Jun 2020, Philippe Mathieu-Daudé wrote --+
> | >> @@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
> | >> +    assert(address + len <= pci_config_size(d));
> | 
> | Yes, maybe I was not clear while reviewing v1, we need to audit the
> | callers and fix them first, then we can safely add the assert here.
> 
> That's an elaborate task. Could we please make that into another patch series?

So let's make this a separate patch as defence in depth in case
there are more bugs somewhere. Patch 1 is a CVE fix. Patch 2
is not.

> +-- On Thu, 4 Jun 2020, Daniel P. Berrangé wrote --+
> | On Thu, Jun 04, 2020 at 01:52:50AM +0530, P J P wrote:
> | > While reading PCI configuration bytes, a guest may send an
> | > address towards the end of the configuration space. It may lead
> | > to an OOB access issue. Add check to ensure 'address + size' is
> | > within PCI configuration space.
> | 
> | Please include a CVE number for this security flaw if there is
> | one.
> 
> Yes. For now I'll send a revised patch to fix this ati-vga OOB access issue.
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


