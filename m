Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5914C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8212078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4DPHEHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8212078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDLL-0003PU-QP
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 16:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDKW-0002ra-Hr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 16:56:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDKU-0008J2-Oh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 16:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598993793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lBeqwJpFmXl9ayNaMgeeCPdRJV+bQn685kYWhyYuFoc=;
 b=F4DPHEHQ3hVH9FR9Aj5JzRRuRRxI2J+JHz01biC+a050REQTmdd+IrlYOA6yTUDRoEQlH5
 csrm6YAaZ8f22PyDRc65UkuRSBFc35+ke7CuFiX6vAQp3eSQkslktc+lUnGh4jN1Znbrl7
 vwH8bkBCS1wIep0eTth4/IhvnFczwWY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-GUmeZl21P5ej4HJal_v2Tg-1; Tue, 01 Sep 2020 16:56:32 -0400
X-MC-Unique: GUmeZl21P5ej4HJal_v2Tg-1
Received: by mail-qk1-f200.google.com with SMTP id y187so1845734qka.10
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 13:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lBeqwJpFmXl9ayNaMgeeCPdRJV+bQn685kYWhyYuFoc=;
 b=OCPGriNwq3OMu3gpoW1ADuuXbkT0LZlsHEb7xlbRUBjI+SlxYJEYc5IV/mV6CpplYf
 WP++OB8Djk8TGEvjdU1WBvIFdBxWgepqVaqQUVbJwYwTROlz3pxfg88SMDhox0T1cxOG
 Tm9T46wegG4qxMWw3Pllw+pUOHMkSwYEdOsH2D/b5XOp0sq+vo2efLVzna3/w+39ujec
 CWdGOVNRJo1lOHduBYkHo6y3d4Y2H1aJaigr9sbntVYNzvLQdvrRwnyhUTEIiKhCu+kA
 ZK8RCRxUmkGNDZHASwCqSXoWkn+hNA9W4eepjKoiGzMAnEc8U6wBU5JveHUs9URcfn9c
 Eavw==
X-Gm-Message-State: AOAM532o1zotbF30dKeMcUCPUl/pRpEAQPKS9bzCMfaYzkuS+B73txXw
 HLDfS22haxuo8XtInhFGlHkwLzyfXl+yHBmLd2S4JYFUSZxcrodUL2OULQqawop8/K9/0pI+aDS
 iozmOiY5NlaLSdRI=
X-Received: by 2002:a05:620a:16c4:: with SMTP id
 a4mr3861357qkn.333.1598993791961; 
 Tue, 01 Sep 2020 13:56:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIPbN2mVbzwN1U4aeukpOcyCQ1ZpPyVmRNDUeDzXtEXoE0zuA51W3bZhqQSSpPeIIeiSj3MQ==
X-Received: by 2002:a05:620a:16c4:: with SMTP id
 a4mr3861342qkn.333.1598993791775; 
 Tue, 01 Sep 2020 13:56:31 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id t69sm2876350qka.73.2020.09.01.13.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 13:56:31 -0700 (PDT)
Date: Tue, 1 Sep 2020 16:56:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v8 3/5] memory: Add IOMMU_DEVIOTLB_UNMAP
 IOMMUTLBNotificationType
Message-ID: <20200901205629.GE3053@xz-x1>
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-4-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200901142608.24481-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
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

On Tue, Sep 01, 2020 at 04:26:06PM +0200, Eugenio Pérez wrote:
> Adapt intel and vhost to use this new notification type
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


