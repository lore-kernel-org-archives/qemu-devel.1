Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF1FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0960E206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdWryUHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0960E206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtw9-00066b-A7
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jxtuu-0004zx-Po
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:10:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50374
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jxtus-0003Qa-3J
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595344248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYtx0/kxbKRvrVWKzSYssk7MuM9i+n5A8NH0KDI5/NU=;
 b=AdWryUHvY1Tw5p1cQZf5SM6tiGzCBY342riZFNFRPtZoIX2AZRuU0jxWhW7NMdtQJeB3VA
 vUShICNx0sC7nRiM1F42zETU7MXNnW0nD006S/U76Z+2TGDlLuo3dJ964GiBTgI9hDohxs
 TC5aLoqbzJ0JSTpUSipRd9w7g+iGjag=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-3l1i3zdYMaW6JMiXI1O7sA-1; Tue, 21 Jul 2020 11:10:46 -0400
X-MC-Unique: 3l1i3zdYMaW6JMiXI1O7sA-1
Received: by mail-qv1-f72.google.com with SMTP id e6so12560233qva.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 08:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AYtx0/kxbKRvrVWKzSYssk7MuM9i+n5A8NH0KDI5/NU=;
 b=Q4FW/FLO0/s6EZS2wjsqvDrg/bUDTr0ki+B4hPNBsih3kCSZW+amXDY80EjKvytOwY
 XF0ydFVLqchnvWmlQXvTppvZERWH71If/fdnxvRtz2WC4VNUqI/TnfluKuvstcOYdWpJ
 pBgr/b23S+LhgobbLM5K+zfFw4DQiJJjIl8eCvWwtGtt0tkU7fkg7EBrdu1XZNn2h4r7
 lp5r3bQ/dEvnV7zSP0gVRgJxz0tD+fLDsktTqG0rfoMhwhVcTrg8RITV491KRJsw6Ury
 GsdAdZ+JKTOx9tr92YJPYhRXwj655hj7dubVlKhFYwhwd0j2P8/ehmTA8efq8uRkGCbU
 pcSw==
X-Gm-Message-State: AOAM533O34fSFbFQG0nqH1unTReY46KL12LDQxsmLmgOoJXXkcMXHx6N
 JUt4I7dwWuqXlpcAeNMPTEmbP+6FyZrM5TJnDSywNj2CQTlMcx1mUc4KWXjcgMM6iozIghmSbc3
 3gFYh/7LGVoVj68o=
X-Received: by 2002:a05:6214:2d2:: with SMTP id
 g18mr26617935qvu.215.1595344245945; 
 Tue, 21 Jul 2020 08:10:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO+/tCaDEs8+tg/gaU8dH1G/u3AlHn9rMf4JRyXTZ0X4WQ7JXemUkSZlujB7WhKTuPphx4Vg==
X-Received: by 2002:a05:6214:2d2:: with SMTP id
 g18mr26617900qvu.215.1595344245677; 
 Tue, 21 Jul 2020 08:10:45 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id x23sm2521561qki.6.2020.07.21.08.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 08:10:44 -0700 (PDT)
Date: Tue, 21 Jul 2020 11:10:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200721151042.GQ535743@xz-x1>
References: <20200709141037.GF199122@xz-x1>
 <fb2f8d35-3f04-55ac-e0c0-7eeedbaf2429@redhat.com>
 <20200710133005.GL199122@xz-x1>
 <05bb512c-ca0a-e80e-1eed-446e918ad729@redhat.com>
 <20200716010005.GA535743@xz-x1>
 <b0319440-6e53-f274-59ba-6dbc67de69be@redhat.com>
 <20200717141806.GE535743@xz-x1>
 <d772c597-e6a2-ab88-43c5-b35b77d6c84e@redhat.com>
 <20200720130346.GM535743@xz-x1>
 <31f7ee27-e649-b547-9cf8-35a88a1aa491@redhat.com>
MIME-Version: 1.0
In-Reply-To: <31f7ee27-e649-b547-9cf8-35a88a1aa491@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:17:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 21, 2020 at 02:20:01PM +0800, Jason Wang wrote:
> 
> On 2020/7/20 下午9:03, Peter Xu wrote:
> > On Mon, Jul 20, 2020 at 12:02:06PM +0800, Jason Wang wrote:
> > > Right, so there's no need to deal with unmap in vtd's replay implementation
> > > (as what generic one did).
> > We don't even for now; see vtd_page_walk_info.notify_unmap.  Thanks,
> 
> 
> Right, but I meant the vtd_address_space_unmap() in vtd_iomm_replay(). It
> looks to me it will trigger UNMAP notifiers.

Should be pretty safe for now, but I agree it seems optional (as we've
discussed about this previously).  Thanks,

-- 
Peter Xu


