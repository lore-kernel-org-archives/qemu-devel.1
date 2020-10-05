Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8551DC46466
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17EF20774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQiPT/jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17EF20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQvG-0004Fc-Op
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPQuB-0003n4-0L
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPQu7-0008Hj-K1
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601905909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwnvKkTIEX1hLZTP6g4MaygMOcmle/VcAqV9CA59kyE=;
 b=QQiPT/jAUcojt5I4ptI3rw7q4IcN/OjVqHYNtzSCMB0biyJ9V1PLSP/ecI8lHALCqmm8CI
 dHoWKWaOI4USloUxWmmweAIkAcE0tlWr8RfVi0F6mEuluLT48uysGSxHpvA3esZp8c++5Q
 eQv10VYVZ7IIq6hrHPsAbuN/fWd1jYM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-_2tErJKbMGa_tFygnYuIEQ-1; Mon, 05 Oct 2020 09:51:48 -0400
X-MC-Unique: _2tErJKbMGa_tFygnYuIEQ-1
Received: by mail-wr1-f71.google.com with SMTP id 33so1714459wrf.22
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 06:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LwnvKkTIEX1hLZTP6g4MaygMOcmle/VcAqV9CA59kyE=;
 b=IhaFElIuMc4r2BZ1/pPkJPLB4OliMzUln013XTDdcTIP1OLOl2zLRriyjLX1BC3QPO
 DlkqN8kmkdLxL/8XXveXke+s1XbVzH7fhh15VfhhwIM5B16XauXZ0W+Ygi1Zqgqqei4c
 2MRKNPxFqHxzv9AIL0YnpChGq39X+l7PQzYjzm+WFD/BIH3PENd3eSpK78NCQgyql6jF
 PzqzZroy60fPW43drATW8kqtHEO6q4vhAm9saaFtRDunuX76LDRvn8HVDWarsHBG7+SV
 F6FPxzUpug67j0Y1ugftfsaJNOewHi9sr2t2n8fMH+E7ztjIBq2PTYtHgU2TCuWwCwYB
 g2Ig==
X-Gm-Message-State: AOAM532xr/9q1y+skwyuuI4EYQVu1ZW2A1RJtfgh9PvOYgP46cCuscoq
 77COyqZbDFN0pemVBQD+GzbwrjbLljuKWCmjArXw3cKXoMQ5pZk2ZB/RLDGoqmm+20YN4vFzSFl
 gcnV5nh5SIYSvmsk=
X-Received: by 2002:a1c:9894:: with SMTP id
 a142mr16592096wme.167.1601905907282; 
 Mon, 05 Oct 2020 06:51:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrvI3ZeRmpvgF1dhCypTpq8rxwqQOxI8XKSZa0WgSjxycubreOuSeXC669gXvvpcxPcm6+bw==
X-Received: by 2002:a1c:9894:: with SMTP id
 a142mr16592076wme.167.1601905907063; 
 Mon, 05 Oct 2020 06:51:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2e86:3d8b:8b70:920c?
 ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id v9sm36238wrv.35.2020.10.05.06.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 06:51:46 -0700 (PDT)
Subject: Re: [PATCH v7 00/14] Reverse debugging
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160174516520.12451.10785284392438702137.stgit@pasha-ThinkPad-X280>
 <1d81369e-3e20-444a-1ad4-197edc0245a9@redhat.com>
 <1c91f71b-c144-65c2-82b4-1121fa9a7c07@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa049022-b89c-921b-436f-a7240e811bf3@redhat.com>
Date: Mon, 5 Oct 2020 15:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1c91f71b-c144-65c2-82b4-1121fa9a7c07@ispras.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 alex.bennee@linaro.org, mtosatti@redhat.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com, philmd@redhat.com,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 15:45, Pavel Dovgalyuk wrote:
> 
> That's very strange.
> None of the patches affect RR for AArch64. Is this the real failure or
> just a coincidence?
> I also tried running this test on my local machine and got normal
> execution time for replay:
> real    0m0,968s
> user    0m0,657s
> sys    0m0,625s
> 
> By the way, this is an early RR test. Now we have more complex (and
> easier to reproduce) avocado-based RR tests (for aarch64 too).
> I.e. record and replay in this test are divided into two "tests",
> and can cause races if running in parallel for some reason.

Good to know.  I'll keep this series in my tree so that it reruns, and
will keep an eye on whether I see similar failures in the next few days.
 I have seen other similar timeouts (e.g. in xtensa test-timer) that
weren't related to RR so it's possible that it's a false positive.

> Shouldn't we just drop this one?

Feel free to send a patch to Alex for it.

Paolo


