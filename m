Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD78BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F59C2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoOGxE06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F59C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxkE-0001AR-Rh
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdxjV-0007R0-4D
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:12:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdxjT-0002xz-Qi
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590592356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pv8i+eOqZdwHvfY5KHNhm/5cLGSC01I3ErcEmzTB94=;
 b=PoOGxE06j8JJ6JIaZj+HYnYc6CDFhwjjR/jDtZ7vMz15MrMoxv++RyjF6y4Q7jlyk4PA1G
 I8AffFBQWzZNUJWMHQZ7IgVKMq9wY0EQKXuf11jUT+zuZ85LlWP3aFxbF8Aj0xYiPh24Df
 JGqrRwqJYwt+9oW4hTqB6fu+5eQ6eJc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-Da2JiKSPNsetvhUHwsisIw-1; Wed, 27 May 2020 11:12:35 -0400
X-MC-Unique: Da2JiKSPNsetvhUHwsisIw-1
Received: by mail-ed1-f70.google.com with SMTP id i93so6185831edi.4
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4pv8i+eOqZdwHvfY5KHNhm/5cLGSC01I3ErcEmzTB94=;
 b=t6n32dF42V5WlcuzYXGKV/8vw7zB+0XBWHDL8myPVGRVgY/afJlAB2KD5TBhTAW1aI
 dcMoZo4xG6x8qpKv819rmFpBlx0LyPaAwztKqdiVE43nboDbZzlATYMYEtTb++CzP6GM
 9Sl/c1vOd/yUi8n/pHrjvVHkDtrmPdWVq4YsSd9HQCVGkhLUnUFjt4ilmKvY59bIGNGv
 21s9pBNSMPCHUYF1CE47QlByJzAuhoOp0PF7IXr7Ebw6skHsFKADj1HHWGZ5vnO1hTCF
 IwjhlL6RRkyzXD/IWLjftbVSk0E/woJz0SSrLWF4QcRUsBCVh3izwGlKBDJOdRWMoxpl
 aO/Q==
X-Gm-Message-State: AOAM531VkEfcObpxUwc7gc2ZwDHsTfPnlXfVvur26IOLO+6z2JdFE00q
 Gdr8vTIWecibn+bxowwiryXIfu1HhhfKQWcC1gzM6rkAk2EAVTt/sauDqXllUka2PgKIKUnBjuB
 urWxufsSVeGlpylM=
X-Received: by 2002:a17:906:b7cd:: with SMTP id
 fy13mr5020181ejb.133.1590592354003; 
 Wed, 27 May 2020 08:12:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqOEwoxI0rjbWQN3QwGXgzDzyx+cq1rQcnUR4OrL9MwC9ET2xY9uRIBIF58f17kyhIHqDJZg==
X-Received: by 2002:a17:906:b7cd:: with SMTP id
 fy13mr5020160ejb.133.1590592353723; 
 Wed, 27 May 2020 08:12:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id o19sm3136515ejc.77.2020.05.27.08.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 08:12:33 -0700 (PDT)
Subject: Re: [PATCH 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-10-armbru@redhat.com>
 <CAFEAcA_S_JsuPG4UN-_zhhdZppBhiwm3-4bocO7O1XdjxC9bAw@mail.gmail.com>
 <87wo4xxya0.fsf@dusky.pond.sub.org>
 <CAFEAcA-9CU8QPeafAf_VSh-Gu2WxLpEoRdUZpv+TOF0Rpq-MXQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d42145a1-2af7-a342-aaa7-d4f472c80e0b@redhat.com>
Date: Wed, 27 May 2020 17:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9CU8QPeafAf_VSh-Gu2WxLpEoRdUZpv+TOF0Rpq-MXQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/20 17:05, Peter Maydell wrote:
> I disagree with these. We're in a realize function, the API
> says "on errors, report them via the Error* you got passed",
> so we should do that, not blow up. &error_abort only makes
> sense if (a) we have no better way to report errors than
> to abort (which isn't the case here) or (b) if we can guarantee
> that in fact the thing we're doing won't ever fail
> (which we can't here without knowing more about the internal
> implementation details of the MOS6522 device than we
> really ought to).

Note however that before replacing &error_abort with error propagation
you need to make sure that you are "un-realizing" yourself properly.  So
it may be better to have inferior (but clearly visible) error
propagation behavior, than untested (and perhaps untestable) buggy code
that looks great on the surface.

Paolo


