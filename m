Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703B2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93A3208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsaDtk+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93A3208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRv0d-0006eR-O7
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRuzm-00062j-Lc
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRuzk-0005lT-GS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602498235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXWLrGicl1DfIwm3r9PqDD0cqYcjr4MFWPxd+k2PnVM=;
 b=KsaDtk+wI4UfwsPrQcEkDlD69z9aA1Hc2+fNSy5lboHZ+B4hqvs6OigI2YPB/Fl9+VII86
 M49kQXwq0+/RkhfDVwuKzX9Xc4R7E6zOxOh39ZdxQUplli/94nJ08T66xvo0n6eFpQCxFK
 SPkTSyxPTxmRnlDsQcdSxaHUfPMU5WM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-q4xfohlSMiCoeKs8ZRYKZg-1; Mon, 12 Oct 2020 06:23:54 -0400
X-MC-Unique: q4xfohlSMiCoeKs8ZRYKZg-1
Received: by mail-wm1-f70.google.com with SMTP id r19so5594086wmh.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 03:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AXWLrGicl1DfIwm3r9PqDD0cqYcjr4MFWPxd+k2PnVM=;
 b=G5gutmt+fVqdJXxYX1h5a4m8NYbc+/vXo9w9ZbXHovpA0oJYOmZwnHO3UMfQ19z7cd
 Ky08jOIA1pp4WKs7kWsFo/ZDnxmresHxlbiP/288PlIY9tHdUnBtAg8ArxL1ZBFGSmAT
 W/jpF3wa6GBVcl/w7H+TitnEM6nt2k9SUSLA1hbD5hYkKJkg+UD5UPkiz5DTrZ6gAQHA
 fdEWZUNz3OhGri/0VX2TPUnVK1vCGqizWJzTtaG1pq2QywzzNa3+f+uEYOs0bboJR03p
 Q8xpfMfyFLgVLToFLnn0Q9aTOhzNWhu8AmyofnqKHkhqgBPw4IC1HbeWgTNHLAEVTlyL
 Xw0Q==
X-Gm-Message-State: AOAM532D1Af7RRQ/F+l0KTBQY5Hj738BJ5Nd0P42RSwbVsZ59HE8z6v0
 GnH2mlCv2s8MRkbktfZBjZCyFxnxfN2dex53BOVo3iUJ34qLOrfNXAyQZj5XPXGxZ9GpMCMR4zD
 CsKlCGr6/8Hcp/vI=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr8438518wrs.101.1602498232595; 
 Mon, 12 Oct 2020 03:23:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFEKsnTwCsHPd4xz2R9pRqhAfqGz9dXSfVHFp6F4PKV9eEKefxy9r/JeKwDmkfIQBaumbiuw==
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr8438417wrs.101.1602498231188; 
 Mon, 12 Oct 2020 03:23:51 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a15sm12127643wro.3.2020.10.12.03.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 03:23:50 -0700 (PDT)
Subject: Re: [PATCH] spapr: Move spapr_create_nvdimm_dr_connectors() to core
 machine code
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <160249772183.757627.7396780936543977766.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <18bbc4e0-79d6-7af9-cdb9-3f72a36d1af4@redhat.com>
Date: Mon, 12 Oct 2020 12:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160249772183.757627.7396780936543977766.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 12:15 PM, Greg Kurz wrote:
> The spapr_create_nvdimm_dr_connectors() function doesn't need to access
> any internal details of the sPAPR NVDIMM implementation. Also, pretty
> much like for the LMBs, only spapr_machine_init() is responsible for the
> creation of DR connectors for NVDIMMs.
> 
> Make this clear by making this function static in hw/ppc/spapr.c.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr.c                |   10 ++++++++++
>   hw/ppc/spapr_nvdimm.c         |   11 -----------
>   include/hw/ppc/spapr_nvdimm.h |    1 -
>   3 files changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


