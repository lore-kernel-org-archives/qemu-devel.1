Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD53C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C5C206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+oj31Ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C5C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjJq-0003V4-DW
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPjIj-0002nR-K8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPjIh-0000Wz-LJ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601976625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpEKUAJKNqHs0hAqjfYxSS9KXE5TyZY/LKeYBIkX2pY=;
 b=B+oj31EcQCB/wl5NCpkYJ2Qw84vmh6hjt6mWeJoiuyl+61xphLK7ZNT5V1GU0Zth1CDFlb
 folblPqW1I2pBMhz5QzU1uoDmxx416412P2wSuf9V1rq8H6Ckgh4NcqIRwFge9xtiW1dBA
 9NXoCXRbM2GMgPFwXgm+3LkAH+N2eYA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ioA5kZ4wP8Kn1T7wU8H_Aw-1; Tue, 06 Oct 2020 05:30:24 -0400
X-MC-Unique: ioA5kZ4wP8Kn1T7wU8H_Aw-1
Received: by mail-wr1-f69.google.com with SMTP id t17so1805956wrm.13
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 02:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vpEKUAJKNqHs0hAqjfYxSS9KXE5TyZY/LKeYBIkX2pY=;
 b=K2rhy5HGsTS9A/Q0ncSr80ZpEi9C3QU7BfpfZ1VbgXYF17uSrWGvNDF/RZ4ekyCWQK
 4rxDGKSpTL9N85JH4+Z17Oo2Ctz6EvQgNYPjg86LymGojeDd9PetMxRV89YvbMhQdNoE
 C0gpy/wVGjykRb6DCKLDxnEGXLq4Ou8VHpIpvNn2mB81CzpAw6DX8O7pRzjPC37DlmWz
 sD9U6SgN7iU3guTY7GFS9OIp+GpFhy2U2fIV5iWR/70MfswNkZ/3uu7dcLjuJX//N0d1
 Va4bmUBqO03BwziN4D4pyZg4RM8iHb7Glja2YQ7gbWtPMs4JrWZzhkDNLS0VN9vSqm5M
 NUmg==
X-Gm-Message-State: AOAM532xiWeBDFEijyB/rw7sX5ce7ucH1NZwq7z4L/xoLT3QAvPkxOPo
 VpbqloXrA44FblUimB1QmBFbDvvYmdoFDWJVCJy8usAqb9f+vwArW8XdVEzmnpk0EZwV3ujjVab
 l1OikAmDBftu6A1s=
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr3644430wrq.381.1601976622796; 
 Tue, 06 Oct 2020 02:30:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXfxK4rZxs/4iHtWUCSyk0Lh/uqriyQtzoHiWbV9Qbfuty+0t/9Dj4iRVMuAlLzXy+t4FK4w==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr3644399wrq.381.1601976622498; 
 Tue, 06 Oct 2020 02:30:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id u2sm3887373wre.7.2020.10.06.02.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:30:21 -0700 (PDT)
Subject: Re: QEMU API cleanup initiative - Let's chat during the KVM call
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <1f0b0576-eb07-bf5a-a4d8-c6a2d18d1a94@redhat.com>
 <20201005134552.GC5029@stefanha-x1.localdomain>
 <8e8a7b4d-e3a8-efe0-47b0-d20186970cee@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b6c8327-7e53-ef1d-e576-1e091ca1e04f@redhat.com>
Date: Tue, 6 Oct 2020 11:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8e8a7b4d-e3a8-efe0-47b0-d20186970cee@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 16:52, John Snow wrote:
> - Markus considers the platonic ideal of a CLI one in which each flag is
> a configuration directive, and each directive that references another
> directive must appear after the directive in which it references.
> 
> - I tend to consider the ideal configuration to be a static object that
> has no inherent order from one key to the next, e.g. a JSON object or
> static flat file that can be used to configure the sysemu.
> 
> They're not compatible visions; and they have implications for error
> ordering and messages and so on.

I think they aren't incompatible.  Even your idea would probably forbid
cycles, so it only takes a topological sort to go from an unordered
configuration to an ordered one.  The only difference is whether it's
the user or the program that does it.

> For the meantime, Markus's vision is closer to what QEMU already does,
> so it's likely the winning answer for now and if a conversion to the
> other idea is required at a time later, we'll have to tackle it then. (I
> think.)
> 
> It's a good subject of discussion. (Also relevant: if parsing is to
> occur in more than the CLI context, the existing contextual CLI parser
> error system needs to be reworked to avoid monitor-unsafe error calls.
> It's not trivial, I think.)

I think parsing should occur in CLI context only, but errors can occur
elsewhere too.

I think the idea for this kind of refactoring is always to first make
the code behave the way you want, and only then change the
implementation to look the way you want.

Currently we have:

    switch (...) {
        case QEMU_OPT_...:
            /* something has side effects, something is just parsing */
    }

    init1();
    qemu_opts_foreach(something_opts, configure_something);
    init2();
    qemu_opts_foreach(some_more_opts, configure_some_more);
    init3();

    enter_preconfig();

We should first of all change it to

    parse_command_line() {
        apply_simple_options()l
        qemu_opts_foreach(something_opts, configure_something);
        qemu_opts_foreach(some_more_opts, configure_some_more);
    }

    switch (...) {
        case QEMU_OPT_...:
        /* no side effects on the initN() calls below */
    }

    init1();
    init2();
    init3();

    parse_command_line()

    enter_preconfig();

    more_init_that_needs_side_effects();

This way, the parse_command_line() and its qemu_opts_foreach callbacks
can become changed into a series of qmp_*() commands.  The commands can
be called within the appropriate loc_push() though.

Problem is, it's 1000 lines of initialization interspersed with
qemu_opts_foreach calls.  But it's doable.

Paolo


