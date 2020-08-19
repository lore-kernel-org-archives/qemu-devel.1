Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08DA20888
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezWiRTfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08DA20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8R9V-0006yn-08
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k8R8I-0005pR-7c
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:40:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56371
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k8R8F-0002Jm-DD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597855210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvx1PubyBKAzg8T/9vG5A1Kawx1VD1yyunwPD//mz5s=;
 b=ezWiRTfxmNoTodtiNC18ZcPqBmmZUSWfunAEOT0vUp4xHQmUCSAEBz7DwPVR+H7Kf+GCTP
 7uLB6ecXCT1DDlstJ5Le4bTqtMWuYPNMg0gNWmtoBX4iSBTOmpV7oxBWs9V2B1ohqNu1Sf
 tQdXyuRvs2gn9v23FrgT8T7zhelrFnA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-OR6EE1FAP76kep3PMn8oxA-1; Wed, 19 Aug 2020 12:40:06 -0400
X-MC-Unique: OR6EE1FAP76kep3PMn8oxA-1
Received: by mail-qv1-f70.google.com with SMTP id d1so15948127qvs.21
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 09:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qvx1PubyBKAzg8T/9vG5A1Kawx1VD1yyunwPD//mz5s=;
 b=WaNgA0Le/Q9dkTlE3Mlvk2Ri3dg0WDkMF/s5cQf0anufYSuswel+SrfZ7Bdicmj+5K
 oeMQbF6zcRc0EBBlvLJbN29Y+emwdJ5rcv+cwBPphtH+ANKDTu+oGRxYImCTXHZhxrWJ
 DCjjgvmJo/DnjcbIaFNJtvinLhwUjLBFaXurGMdqvb7cTvCcz1kRfmQGRf52W2BfD8n5
 Lsp9W2rPwNjwdsHorloPhffi3RClTdpw5KU8HeyF/eZuyo64pmN7tvBgB98Ds1DW12yn
 pmR30gxSIKYpyVLkJwyNh1MQIwcRV01VF2FbH/UumNBHEqvtPNsULOvo1ELhOM0+cGuc
 Dh2A==
X-Gm-Message-State: AOAM531F3fYmZJ5FReZfvycreDsfAwr2ymysaLT9zkbU0kJzGFe/rEgK
 Ji+g4PuTmUbMWQDY1KNAfHelc2RmDVT79Rj2nl1GfqRUSQ+5gZDyh3Ur8yilCNHxv/Ld0DOsYJO
 LuY9aN7k8cZcTasU=
X-Received: by 2002:ac8:428f:: with SMTP id o15mr21812988qtl.213.1597855205712; 
 Wed, 19 Aug 2020 09:40:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyObD2dwi7z18wK+MwCqWiF/0OFg+gqVeuRmHvNpF35g+0FnDdP29y4n3kSpK6SrU4MhMgyyw==
X-Received: by 2002:ac8:428f:: with SMTP id o15mr21812969qtl.213.1597855205490; 
 Wed, 19 Aug 2020 09:40:05 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id f31sm29091534qte.35.2020.08.19.09.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 09:40:04 -0700 (PDT)
Date: Wed, 19 Aug 2020 12:40:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v4 2/2] memory: Skip bad range assertion if notifier is
 DEVIOTLB type
Message-ID: <20200819164002.GB305409@xz-x1>
References: <20200818130151.31678-1-eperezma@redhat.com>
 <20200818130151.31678-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200818130151.31678-3-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 03:01:51PM +0200, Eugenio Pérez wrote:
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

The changes on the callers of memory_region_notify_one_iommu() seems to be
still missing (and, to embed the type into the notification process)..

-- 
Peter Xu


