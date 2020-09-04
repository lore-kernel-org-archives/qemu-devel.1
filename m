Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128DEC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83FA3206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCEXrxsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FA3206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEGWM-00052O-GQ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 14:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kEGVW-0004Mq-Q8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 14:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kEGVU-0004ny-Qo
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 14:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599244335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzpqcPteGfr6abqNT9T6vmLthKYLeGhaKGRpVY103II=;
 b=fCEXrxsQ93qVSbYdoNJfxF5+iMo6dV7iuimXj2wR/j/N1lvR7ZYzD+arJfeekNLx7c5/yy
 zB7Egt/Cvb3BPTAkhInyrfZCw1J93Ui3haeN9O5WhziePwJ9gdBoEQXLvfHcZgXb3oWn5q
 8DBfQVQ5ViZgvyHfuWaeR/F3Vs2ITYY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-bieTVGaAMFuDlWk_dS0kwQ-1; Fri, 04 Sep 2020 14:32:13 -0400
X-MC-Unique: bieTVGaAMFuDlWk_dS0kwQ-1
Received: by mail-qt1-f199.google.com with SMTP id f5so4898578qtk.11
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 11:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vzpqcPteGfr6abqNT9T6vmLthKYLeGhaKGRpVY103II=;
 b=oKrOPLXAypyxyT7BCrE7U6MBkxtasT15hw7q9r+J/4gTus9MvHa4V2XcdoqedKeuu8
 NizUkGC9LoxDQ+X3vW0lJ+oK57AfISSge+EJ9Fo6s/wy31ASzvtXMPmFrrQSs+UE16Kj
 GPHN7gJgPFvpDMyC3AlF19Bx09ZpGDZZi/7GBZ+MvmimwCMBzsGZQYC3qh3cAHdkyju0
 Ax1FDfbVsILFgVCaEfG1YfnWqn2IckkAkIYIiKE/0GnJDUKdx+JOW0Qrc9XPKw3sVCK0
 mjFOOF015WR8rre5WBsy8T1eTW2Ux7goyoSn+WeV7raFQ1xVKb2Xjz8b12V5xX9P89st
 WHkQ==
X-Gm-Message-State: AOAM531EXRE+art8O+U+AstPRRlBOmdNJDthnQmQ9KXcspQdhhLflW/Y
 IRkF4FKOKynfSryZ+sr1hd5NP8VxHUKohKO3J/Je1c52zMzT/xdoBDYdz4jjSGSWQcr9ByuPlku
 cS6x8eyI5B5BWjVc=
X-Received: by 2002:a37:a09:: with SMTP id 9mr9640628qkk.258.1599244333096;
 Fri, 04 Sep 2020 11:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxIwjKDe+q51Sa4Du1MQdgdnUMAOetVM2J1hsYQlrT+NHgOr9THBrYYXcfYsKeZaWOSehddQ==
X-Received: by 2002:a37:a09:: with SMTP id 9mr9640592qkk.258.1599244332727;
 Fri, 04 Sep 2020 11:32:12 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id g123sm4909284qkd.127.2020.09.04.11.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 11:32:11 -0700 (PDT)
Date: Fri, 4 Sep 2020 14:32:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH 4/5] intel_iommu: Skip page walking on device iotlb
 invalidations
Message-ID: <20200904183210.GA148776@xz-x1>
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200903161446.29615-1-eperezma@redhat.com>
 <20200903161446.29615-5-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200903161446.29615-5-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 11:45:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 06:14:45PM +0200, Eugenio Pérez wrote:
> Although they didn't reach the notifier because of the filtering in
> memory_region_notify_iommu_one, the vt-d was still splitting huge
> memory invalidations in chunks. Skipping it.
> 
> This improves performance in case of netperf with vhost-net:
> * TCP_STREAM: From 1923.6Mbit/s to 2175.13Mbit/s (13%)
> * TCP_RR: From 8464.73 trans/s to 8932.703333 trans/s (5.5%)
> * UDP_RR: From 8562.08 trans/s to 9005.62/s (5.1%)
> * UDP_STREAM: No change observed (insignificant 0.1% improvement)
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


