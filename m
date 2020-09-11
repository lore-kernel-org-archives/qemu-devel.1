Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B559AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26298204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsCmYNb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26298204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkpK-00049t-5F
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGkno-0002hp-Ps
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:17:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGknl-0005NJ-OZ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599837443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbkqJMJo2H//7VyIbfZ9pUx1qX4/Xo5zdT/HxzuAUkA=;
 b=NsCmYNb/+EN7wZYX6HFUJZiwGCqQU3tk8u8Q3Yc6K6gPlMjCgq0luwXbHZ71s/yfDbmABG
 Fjddxdf2hDvvo63yBexlB2xxVAE/6m3xfa6+NeqZDB+wN+/pe0g+pkCuU2Tw3RIDuC7Km8
 M/nwnhG2xYkWkjJ0889LZWbbPhDHO8o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-V1F48I_gPsKAMcqOElUgpA-1; Fri, 11 Sep 2020 11:17:21 -0400
X-MC-Unique: V1F48I_gPsKAMcqOElUgpA-1
Received: by mail-ed1-f71.google.com with SMTP id bm14so4616726edb.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 08:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cbkqJMJo2H//7VyIbfZ9pUx1qX4/Xo5zdT/HxzuAUkA=;
 b=W37qCx3dx+WyA/pIkr4+m0N9PgEPGcFHy/yKxZkkoEWDeYYC0ibGFUiOrYUxlsT4/X
 f8+ANGsVQZPJwrav7Uz/vptzWPR9fKmpF6EC0hl8f0iFCwbIp15bFDl+S9QFPQl7sOTD
 pK7dlFyfti31Hpf/sDjhQJSZAIBVDS+Qj3Jyl/uROtWl3cxq5zfm0R6nmQq31sJBBRNP
 TdkQt7611IK6ZyBiAU5zXHWYVXdPJLc3akSDht0aFmiOTunkJCu7FINE0M/wqe0jyfMY
 NIWR9+vEGAxH2ZJ1WHHIp1ObMDKE4IcrhIKhp+WoJC3gvdJC6MueE8WngoUgV83cicG+
 ZHcQ==
X-Gm-Message-State: AOAM530a2q2E2pF5Tx9+nPHm+Kwak3Mquk2yrqpZ3TNrpp3an0ww8mg2
 VGSmMHsoJT50mLgNaDPJrU6ZyoLV0jV3htQIoFENl3KnajU8N90a58CxLoR7HoBtxP4MzkA+w3K
 TvUx2yVTTTk5zch0=
X-Received: by 2002:a17:906:1b15:: with SMTP id
 o21mr2449321ejg.377.1599837440263; 
 Fri, 11 Sep 2020 08:17:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIG5zTFF3QDBC2jBZi9hxveeleg+/lr9ByD+sAya8nheL5Gc8GAg8ooHiv/aPPrafL+Okyyw==
X-Received: by 2002:a17:906:1b15:: with SMTP id
 o21mr2449308ejg.377.1599837440052; 
 Fri, 11 Sep 2020 08:17:20 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id h2sm1790644ejk.33.2020.09.11.08.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 08:17:19 -0700 (PDT)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <eeead7ec-ebde-637d-de06-31c9b343b3b8@redhat.com>
 <399aad6c-5d86-8988-a44a-e91d650e7273@redhat.com>
 <CAJ+F1CKPyBfjPoaRc5j24swo8Bfy0D7m+txNk5cyAi47rOz2bw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <093067ee-e849-be8c-6e02-167d28d3e3ed@redhat.com>
Date: Fri, 11 Sep 2020 17:17:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKPyBfjPoaRc5j24swo8Bfy0D7m+txNk5cyAi47rOz2bw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/20 16:00, Marc-André Lureau wrote:
>     - from_qemu_none should be a "to_*" or "constructor" conversion (I used
>     new_from_foreign)
> 
> new_ prefix is not very rusty.

Right, I have changed it to with_foreign so now there is
{as,with,to,into}_foreign, plus unsafe_{from,into}.

These two could even be renamed to from_foreign and into_native at the
cost of making the trait less general purpose.  This way we have the
typical Rust names: as_* for Borrowed->Borrowed, with_*/to_* for
Borrowed->Owned, from_*/into_* for Owned->Owned.

> However, the memory allocator (or the stack) may not be compatible
> with the one used in C.

Hmm, that's a good point.  The simplest solution might be just to get
rid of IntoForeign, it's just an optimization.

> from_raw() is common, and takes ownership.

from_raw()/into_raw() would be equivalent to
into_foreign()/from_foreign().  However as you point out the allocators
are different, so it's a good idea IMHO to separate
into_raw()/from_raw() for the Rust allocator from
into_foreign()/from_foreign() for the libc allocator.

> I would need to modify this PoC for example

Yes of course.  Can you just try splitting the PoC in multiple patches?
 That should also make it easier to review, so far all I did was
comparing against glib-rs.

> But I must say I feel quite comfortable with the glib approach. It
> would be nice to have some feedback from glib-rs maintainers about your
> proposal.

QAPI is not tied to glib-rs, so I don't think qemu-ga will need to use
glib-rs.  I think either we use glib-rs, or if we are to roll our own we
should not be tied to the naming.  We don't use GObject introspection,
so none/full means nothing to most QEMU developers (and to Rust
developers too).

There are other things I don't like very much in glib-rs, for example
the use of tuples and public fields and the somewhat messy usage of
*const/*mut (I tried to be stricter on that).

Paolo


