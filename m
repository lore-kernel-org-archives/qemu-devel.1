Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAECC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B6320738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVKO7WH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B6320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbpmh-0001ZJ-65
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 14:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbplw-0000rB-ML
 for qemu-devel@nongnu.org; Thu, 21 May 2020 14:18:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbplu-0000Oa-G3
 for qemu-devel@nongnu.org; Thu, 21 May 2020 14:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590085099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+mjnIE8AA4knMqIk6GCp7bw7eCFQWMuEySWleOZqVY=;
 b=FVKO7WH5lBfyXUYmMeeZv1nOO7Mti6/OSXtLom7OtjNU50W4L3RJVLISd/zaOHYRJHGsjR
 e0w7F/S68CxN/zQrw5vatJO+Q5H/W3wTOkHJ+KD1YendFWchR1bW58rVNcYvIqzvw2ZPre
 uLriSDSsEQartfysRxK7EQfbtcmNPzo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-R2me0CKbPpatvxPBd3Izqw-1; Thu, 21 May 2020 14:18:18 -0400
X-MC-Unique: R2me0CKbPpatvxPBd3Izqw-1
Received: by mail-wr1-f70.google.com with SMTP id q13so3263499wrn.14
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 11:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=v2qesWvQHgR12+A+yWsXxn+hoVKu5UTw0nS0R2lSOYY=;
 b=a7VrFZEeeI1043gzp/MDeYStQZ/E2kblM6h+vjA40mwUgtof16PmkPRy0mmrdSwn28
 qOso6nEeuz3BXE83N1GfwnsR0MFl4yUGJngUNkbTO87kc0fRHUlzcKWSk3gLmmGOaFnL
 TBDbjIwvN9VrrMnu1yCDyiarfBaOUwsKnZiu1nz1NfbXcmwaOtGJKT6Z9BDXAirghvST
 Wy6v2d99SUj1gG5i4I64fCk+84VjzkdznUdhOWNcCJywHojdprzsFXnE8ZGbzIhghNZN
 ujhqj8/qlU/pPK9sgCK7BqltRLB6EyVyACR1xtrDsFaTonn4avd9Pq3bMPySCCi7dOr7
 8JjA==
X-Gm-Message-State: AOAM532C+oydc5EGIiEhIt7CD2SjI6ivIlJH8Qx/20+55qRAfvC3fG5A
 wibpQzWbbQbSPME3vS8Kp7ND5slLeN7JYZk0/xrPncEVytXxLyKNQTQYkjCA5I2fG68eOq+CzYi
 7AP7rMaXYHIRfSuM=
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr10376328wmi.41.1590085095794; 
 Thu, 21 May 2020 11:18:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYIStbjHwxsgDacsi+0eQUjp6wm93IqlkpuH7q2jjzbXtrSjJpMmxs0Y+0kKqLlb8Rgoq5tA==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr10376304wmi.41.1590085095538; 
 Thu, 21 May 2020 11:18:15 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 s8sm4287820wrg.50.2020.05.21.11.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 11:18:14 -0700 (PDT)
Date: Thu, 21 May 2020 14:18:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC][PATCH v2 2/3] docs/specs: Add specification of ivshmem
 device revision 2
Message-ID: <20200521141642-mutt-send-email-mst@kernel.org>
References: <cover.1578407802.git.jan.kiszka@siemens.com>
 <5ddc4ca4f32bfab8971840e441b60a72153a2308.1578407802.git.jan.kiszka@siemens.com>
 <877dx5fcvo.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <877dx5fcvo.fsf@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 05:53:31PM +0100, Alex Bennée wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > This imports the ivshmem v2 specification draft from Jailhouse where the
> > implementation is about to be merged now. The final home of the spec is
> > to be decided, this shall just simplify the review process at this
> > stage.
> >
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  docs/specs/ivshmem-2-device-spec.md | 376 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 376 insertions(+)
> >  create mode 100644 docs/specs/ivshmem-2-device-spec.md
> >
> > diff --git a/docs/specs/ivshmem-2-device-spec.md b/docs/specs/ivshmem-2-device-spec.md
> > new file mode 100644
> > index 0000000000..d93cb22b04
> > --- /dev/null
> > +++ b/docs/specs/ivshmem-2-device-spec.md
> > @@ -0,0 +1,376 @@
> > +IVSHMEM Device Specification
> > +============================
> > +
> > +** NOTE: THIS IS WORK-IN-PROGRESS, NOT YET A STABLE INTERFACE
> > SPECIFICATION! **
> 
> Has there been any proposal to the OASIS virtio spec to use this as a
> transport for VirtIO?
> 
> -- 
> Alex Bennée


I think intergrating this in the virtio spec needs not gate the
implementation, but I'd like to see the current spec copied to
virtio-comments list to possibly get comments from that community.



