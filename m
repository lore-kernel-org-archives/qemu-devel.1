Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C0C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9EE21527
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWercQAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9EE21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMWm-0007eQ-4C
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXMVj-0007D2-83
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXMVf-0001JG-FN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603795640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95w0jb5vtNjTaf3zg8h5aoAi3tA3lKLUS1TtUVs7SRk=;
 b=VWercQAuMA7wbF3HH0f6b7s4lVjXrEJp31zEcbstuaLPT8pSCIqyOAs1Npz3cSH3cmNLMq
 oHYgk3ttvyJITnnuwAy7ILXgpaXrx/x2e8NOsnX/GlLn0XlA6trWQAzjyCQMhT5eT0Ska5
 lwJciEWyyZfG1tUSn+8fmGcYqKuPc6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-MsTBEj5tNhu4npl3OK1C3Q-1; Tue, 27 Oct 2020 06:47:18 -0400
X-MC-Unique: MsTBEj5tNhu4npl3OK1C3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D790C186DD30;
 Tue, 27 Oct 2020 10:47:17 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DC235D9E4;
 Tue, 27 Oct 2020 10:47:16 +0000 (UTC)
Subject: Re: [PATCH] arm/trace: Fix hex printing
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201014193355.53074-1-dgilbert@redhat.com>
 <CAFEAcA8CYt-rkovgj_5kMtygsPNm3C4F6yi4s3cb0bduz7+NaA@mail.gmail.com>
 <04136efa-9229-6c7e-d43e-0033a354c2d4@redhat.com>
 <CAFEAcA8uZZUzXq2sJFC8puGn_OZFT8kmPTmTuOB+-e-7A5ntrQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2a1865cd-7b1d-f63d-7624-ccbb6678855e@redhat.com>
Date: Tue, 27 Oct 2020 11:47:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8uZZUzXq2sJFC8puGn_OZFT8kmPTmTuOB+-e-7A5ntrQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 10/27/20 11:38 AM, Peter Maydell wrote:
> OK; I'll apply this patch to target-arm.next; feel free to send
> a patch updating the other tracepoints to hex.

sure, I will.

Thanks

Eric


