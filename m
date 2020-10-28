Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11577C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6412479E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfC+y7cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6412479E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmd7-0003Zr-Pd
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXmbs-0002vi-8E
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXmbq-00016X-23
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603895969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzXQAwGrWmmBxNWVZggoJTaP84ND82hZ4GviCk8a8PA=;
 b=WfC+y7crbQDupZF/HW/zgK1II7JegQfNuTZK5l8OAG2BnOe7zPN1FmLwohKQ3yI94aw7ZF
 JdF3xGZmg0eWOKQmStfaTZPqUbTnRKTUlxc6wckf5tfLVskibYnIR3hWzKPx/CD932KMaq
 E4cChFNlVrGDS+YEOP/2e2NNF/F2XUc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-KlhpIlZgMuqvQesjnTbjOA-1; Wed, 28 Oct 2020 10:39:25 -0400
X-MC-Unique: KlhpIlZgMuqvQesjnTbjOA-1
Received: by mail-wr1-f69.google.com with SMTP id i1so2166930wrb.18
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 07:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nzXQAwGrWmmBxNWVZggoJTaP84ND82hZ4GviCk8a8PA=;
 b=fqukA77jv5RlUQZ5OHpY4/qKn/cLmhFticizzAp2Ickk/Dn34aVf7gsFx3LXCY+H5t
 dcLRweqRk8WMK6ZVx5qPcRU2lcdV32oe21wozQ7fiOMtACSpi6KNnm7cvS77NkgMgRHx
 zHuLok8ysc2yBn/c5YntYuaD3AhrAfP8YVPFBCCHOgOStAObmVDsQOBXSisUN9unZUB3
 NzNC3EifAOIiE69iR6m3nev58KM5MAhOSA/Bhx79wumbUeSkHGoESHqs8K8WU/+ueXlF
 2e28bmBkpu4CzP76RskOKp8PLN14ug8s7p4EMEj6GMSGaRSY6SZkoMfT9bY6H8vI7v8a
 uVIQ==
X-Gm-Message-State: AOAM530ndiYHs1Zj0PODUkKz29NwZeE9f2ZudAJK/N5HZgEnceYCpYIS
 /dPgLl9Ytr2+D2I6SRYHGXLo2P0WCQK7FgBJeHXn3zSyqawiFIas3ed4lsXawa8Dqd2IG1JTugD
 Wobaw+VJsI4vbHHI=
X-Received: by 2002:a5d:67c4:: with SMTP id n4mr9202968wrw.125.1603895963774; 
 Wed, 28 Oct 2020 07:39:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsGNUHmBbKc8mr2qWjgitiDs+piLASWYjcnjy+jDfJ20DOJoiPeLzk3fEO3DzOhBKXq3/ADA==
X-Received: by 2002:a5d:67c4:: with SMTP id n4mr9202944wrw.125.1603895963535; 
 Wed, 28 Oct 2020 07:39:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id i14sm6482812wml.24.2020.10.28.07.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 07:39:22 -0700 (PDT)
Subject: Re: [PATCH 0/4] qemu-storage-daemon: QAPIfy --chardev the stupid way
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20201026101005.2940615-1-armbru@redhat.com>
 <d00ef574-b2c4-887c-6a37-79f6cf6eeae0@redhat.com>
 <87a6w63kbw.fsf@dusky.pond.sub.org> <20201028114625.GA7355@merkur.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53ba80fe-8e4c-88c6-181d-f3b33bf3e9bc@redhat.com>
Date: Wed, 28 Oct 2020 15:39:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028114625.GA7355@merkur.fritz.box>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/10/20 12:46, Kevin Wolf wrote:
> I don't think this is the right thing to do at this point. Making more
> use of QOM is an orthogonal problem and would only make solving this one
> harder.

Making more use of QOM will make this a non-problem.  You'll just use
object-add and -object and, when you figure out the QOM schema, it will
just work.

Paolo

> The problem we have and we're trying to solve is that we have
> chardev-add (which has a QAPI schema) and -chardev (which doesn't). We
> want to get an option that is described by the schema, doesn't duplicate
> things and is still convenient to use.
> 
> Whether this option starts with -chardev or with -object doesn't really
> make much of a difference. The QAPI schema you need behind it will be
> almost or even exactly the same.




