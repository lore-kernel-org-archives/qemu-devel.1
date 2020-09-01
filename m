Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AB6C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37671206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTk/XWws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37671206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDcD-0002DA-B8
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDbV-0001lD-T8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:14:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28407
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDbQ-0001bL-NB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598994843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMzSUbuaS0SLP3V0nKz6raRAbmrCMnOI9nSqqBp6t90=;
 b=DTk/XWwsqiDJLwZWlzBs3kNKtsFnBPq5j0Sq9i34WT7aPHCac0OxdaL18Q6AGzixmOQOj2
 gNSKeorEOAd6kwxsScW9cxsgA9GEBEFlC1EJo9CC8i2kIiq+qpsT622r/ZnKFadLleQEIv
 Uvb2FTM1t3eMklkVanmrPcE33QMmePg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-wy8CUikGOwu1IVF1Z0klkw-1; Tue, 01 Sep 2020 17:14:01 -0400
X-MC-Unique: wy8CUikGOwu1IVF1Z0klkw-1
Received: by mail-qk1-f200.google.com with SMTP id g6so1864657qko.21
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 14:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oMzSUbuaS0SLP3V0nKz6raRAbmrCMnOI9nSqqBp6t90=;
 b=oSBHLxia0wM2L2PGzNs1BNkvrHoyVmsxDuSkXqpnbz4C4jTMpvUBZiZ3f1PIvMRhbf
 /k3j9ueYtiySfZmpGTcojhtgdrufOAwIX0XDZhsQcj63X05fXjQkad4MLuODmCfmSjjJ
 HwiIh3urBidvwMdzDno/MeXzva4IvKwnAaHaXCgiieu37tWCLYW4og5TkCKjrmLr5r59
 xSOWEV0WBt0QEtxxoAziYXImvPAbtmKf36PkZnZLiFRG9v8cWu43EQicSmBN4/jT+tWg
 F8DMSWaW+yaul9TGSMR+ywttxtdqeJn1ckjwjN89E4OOJpBQCPF25RaPpma/s6QJZ+UV
 EIdw==
X-Gm-Message-State: AOAM531L5GBhiAzF4tQOK+QJkEglgSiocaTreukF6iJngM/DKeBgIxGc
 UFHuWIt6FhV6azW855PqjIgC2YeS+S0ZgdCH9VxdkLjRIlffJ3awvk9yWthv0t33MGrzocriKkD
 +gz3f5rfsplo+AhU=
X-Received: by 2002:ac8:f57:: with SMTP id l23mr3890625qtk.166.1598994840997; 
 Tue, 01 Sep 2020 14:14:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2jSXrxJMOiA7e8jitZ9yOubd+YmH7YcxHvkHPsdGZijX9z41IAdO0D3TcJKdirU1S1m4mRw==
X-Received: by 2002:ac8:f57:: with SMTP id l23mr3890592qtk.166.1598994840761; 
 Tue, 01 Sep 2020 14:14:00 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id b199sm3148134qkg.116.2020.09.01.14.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 14:13:59 -0700 (PDT)
Date: Tue, 1 Sep 2020 17:13:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v8 0/5] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200901211357.GH3053@xz-x1>
References: <20200901142608.24481-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200901142608.24481-1-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 04:26:03PM +0200, Eugenio Pérez wrote:
> I am able to hit this assertion when a Red Hat 7 guest virtio_net device
> raises an "Invalidation" of all the TLB entries. This happens in the
> guest's startup if 'intel_iommu=on' argument is passed to the guest
> kernel and right IOMMU/ATS devices are declared in qemu's command line.

Thanks for working on this, Eugenio!  Sorry to let the original one-liner patch
grow into a patchset... :)

I think it at least looks very good to me in general, besides another trivial
comment on patch 4.

-- 
Peter Xu


