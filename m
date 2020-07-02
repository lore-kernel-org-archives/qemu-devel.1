Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595122084C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOhQ7QZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595122084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvuK-00025B-JR
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvth-0001Rc-Jb
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:52:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvtg-0006m9-0x
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593683567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3YlFma+XIAuqlihUP5XBiQVpABGoM7sG6YBTAkkkCos=;
 b=IOhQ7QZC9aFNWScu33UJFP0UY8odZFdouS06fIVuJWwWOk2JHa+VFpyvWIo6LJAWuMcle2
 slRB5LzsZ8ICJFJXn/lOPAdW7yjXeXLoButOMu18fzsBAceQhVhu4IQUYETNqG5e0pVRQC
 qrZsqhC4vTt8qbevlRVhlHpYOPPBjoE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-W3bPZMJ_PBC9cR8dwBORdw-1; Thu, 02 Jul 2020 05:52:45 -0400
X-MC-Unique: W3bPZMJ_PBC9cR8dwBORdw-1
Received: by mail-wr1-f69.google.com with SMTP id j3so4965712wrq.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 02:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3YlFma+XIAuqlihUP5XBiQVpABGoM7sG6YBTAkkkCos=;
 b=Fs/r+D5S2wpL2GlfJBxgUgHilV4vijbF5x8E5BhxxOBZ6aolT4U+ru2YjKVwGB5So3
 0jyy8WgboEnANFs+IiRcXR/2GvDPKEEX2J0133f0d4raA4OfEMowZz3PyYPOr37iVJJJ
 gUIkJ2I34TqN3KFUfwGZ+/oE3CYobydAyDXMzxYV42Fiw2MtHnkP2MeP6IDw0PlAfaz7
 TfnWX3Z35F6TJ96RdxDOqyUkYeZHvLz9ZjtW+62jmYzkXl2GqZ/FwQFmrcquZwNME+x/
 Cqscr5pIc958T8hxwWnt9ddSIPnT1VIyE2Haf5RC2Irx/hPnq0Ao/dFD1xFk5vdy6REM
 PDfg==
X-Gm-Message-State: AOAM530khdfEErAdfF8TElIZOxEi2TxDCog19teD3no+MsyTXLar1CHO
 pzzSfT7pwoILJqs+2jY4E0Fs9r+uC0ANDwAhLqaRTvt1iyttRoFaa0u7xUnk8fnJZTczxQvgd7w
 tTmchO1g8UG1t6Hs=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr1934521wrj.14.1593683564865; 
 Thu, 02 Jul 2020 02:52:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTVZM0tYjWK8S+XRRstuJyB9mstW9mwmrhynvY6Rm0/W5oEaDM5SkGm8gAxzc6Pf+1SD8f8Q==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr1934500wrj.14.1593683564629; 
 Thu, 02 Jul 2020 02:52:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.gmail.com with ESMTPSA id 33sm10799350wri.16.2020.07.02.02.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:52:44 -0700 (PDT)
Subject: Re: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU
 created
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200701182100.26930-1-philmd@redhat.com>
 <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70b04307-fe22-c9bd-3194-f2612d41e197@redhat.com>
Date: Thu, 2 Jul 2020 11:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1878645 <1878645@bugs.launchpad.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 22:35, Peter Maydell wrote:
> For the monitor, that
> would be the current "default cpu" as set by the "cpu"
> command (cf monitor_set_cpu()). The bug here will be that
> somewhere along the line we are probably missing plumbing
> sufficient to pass down "which CPU do we want".

Yeah, the fix is probably to add a functions that returns either
current_cpu or the monitor CPU, and use it in device emulation if
applicable.

The problem with current_cpu is that it affects stuff like run_on_cpu,
and that is guaranteed to cause havoc to code that expects to run on a
given CPU and therefore doesn't use locks.

Paolo


