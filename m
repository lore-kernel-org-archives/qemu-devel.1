Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B49C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6939320936
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMIY8KRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6939320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKKm-0003W0-DP
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNKHz-0002JX-Q5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNKHy-00047T-1b
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:23:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601403825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPi5AkA0xx1boHrxC/POs7iQSYce+moXr9PCpqRTQkQ=;
 b=PMIY8KRtFOSeoUOAxFeETBO3kNhtW/tGRZuSwdZcnXZvqoF7x5HcNcdLKuJuL3ZKVIa71R
 kISJxul2g1dSUUfMvDX43rU+Jf0geae/ZQtouz9y3Ax4/Ig3/7siKhpltxqAk3ZjLK/p5A
 2L3zYUF1qbYRaqU8SvE5famZnPSeFKU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-6kIs4kegODOv0JvRb6D0zg-1; Tue, 29 Sep 2020 14:23:43 -0400
X-MC-Unique: 6kIs4kegODOv0JvRb6D0zg-1
Received: by mail-wm1-f72.google.com with SMTP id t8so2023388wmj.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 11:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HPi5AkA0xx1boHrxC/POs7iQSYce+moXr9PCpqRTQkQ=;
 b=bxeQ8yHbV0Kmqj05Ciz0usx4Bna5DwuV3ESUsbFgAIc0zznzFYucpGqLoPNmIHxf5t
 OUHQTAanVNiucPfBIfh7NBJ0szT3b+T9iQSTSNbsjx+yiMbjqYbvnatqgq8XMX6BtOz1
 ykNbl4Q853xGchFT1QpA14oCJBPcH9ltztBrYiMMR2fri0S49CzAAOfxSvOphYIxZAOi
 mHXdd/6qcannzGSZfBwaUNZ1dKAomyn2HvCUlqY0NAknt9ZSmEqxAvgmNZ8Q7TlZt3ZK
 CLBBsDXPoCjvZn5nvhV8Jiw1aGvlRtnnnwv059UwolfsSbAAqoc6iSDGw5EqaWKgaXIu
 M4lg==
X-Gm-Message-State: AOAM532KnnhiqGY3s6OqVapm2uKBfyeSZoTSHgmP44OcidGfclsAPk3p
 ilMkbaDpgNXA0T+k/wWkf4XDd2y1US3I9glTZNPHCR8y8YTXfEKCE3mnH7azgA/rYxGc083EFAS
 8yd56oQXeIEoArQg=
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr5912566wmk.15.1601403819540; 
 Tue, 29 Sep 2020 11:23:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7dhv9kxsRRc5zbwgWHKiwOIe2ETbTERmDbOyvFGR87uU+lcs0zlJqxSvXDyrPBKq177HCeg==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr5912542wmk.15.1601403819245; 
 Tue, 29 Sep 2020 11:23:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dbe:2c91:3d1b:58c6?
 ([2001:b07:6468:f312:9dbe:2c91:3d1b:58c6])
 by smtp.gmail.com with ESMTPSA id 11sm6106777wmi.14.2020.09.29.11.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 11:23:38 -0700 (PDT)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Sebastian_Dr=c3=b6ge?= <slomo@circular-chaos.org>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <eeead7ec-ebde-637d-de06-31c9b343b3b8@redhat.com>
 <399aad6c-5d86-8988-a44a-e91d650e7273@redhat.com>
 <CAJ+F1CKPyBfjPoaRc5j24swo8Bfy0D7m+txNk5cyAi47rOz2bw@mail.gmail.com>
 <093067ee-e849-be8c-6e02-167d28d3e3ed@redhat.com>
 <CAJ+F1CL1kzvHRmMOTq38r0PNyCJhzyqWeiNb71e7sabaWOwdsQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ddd2e282-3e0e-1c0e-2af3-7ca59c322ef9@redhat.com>
Date: Tue, 29 Sep 2020 20:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL1kzvHRmMOTq38r0PNyCJhzyqWeiNb71e7sabaWOwdsQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/09/20 19:55, Marc-André Lureau wrote:
> My understanding of what you propose is:
> - ForeignConvert::with_foreign
> - FromForeign::from_foreign (with implied into_native)
> And:
> - ForeignConvert::as_foreign (with the BorrowedPointer/stash-like)
> - ToForeign::to_foreign + ForeignConvert::as_foreign_mut (which seems
> wrongly designed in your proposal and unnecessary for now)

Might well be, but how is it wrong?  (I'd like to improve).

> I don't have your head, so I find it hard to remember & work with. It> uses all possible prefixes: with_, from_, as_, as_mut, to_, and into_.
> That just blows my mind, sorry :)

Ahah I don't have your head either!  The idea anyway is to reuse
prefixes that are common in Rust code:

* with_: a constructor that uses something to build a type (think
Vec::with_capacity) and therefore takes ownership

* as_: a cheap conversion to something, it's cheap because it reuses the
lifetime (and therefore takes no ownership).  Think Option::as_ref.

* from_/to_: a copying and possibly expensive conversion (that you have
to write the code for).  Because it's copying, it doesn't consume the
argument (for from_) or self (for to_).

* into_: a conversion that consumes the receiver

It may well be over the top.

> Then, I don't understand why ForeignConvert should hold both the "const
> *P -> T" and "&T -> const *P" conversions. Except the common types,
> what's the relation between the two?

Maybe I'm wrong, but why would you need just one?

> Finally, I thought you introduced some differences with the stash
> design, but in fact I can see that ForeignConvert::Storage works just
> the way as ToPtr::Storage. So composition should be similar. Only your
> example code is more repetitive as it doesn't indirectly refer to the
> trait Storage the same way as glib-rs does (via <T as ToPtr>::Storage).

Yes, that's the main difference.  I removed Storage because I didn't
want to force any trait on BorrowedPointer's second type argument.  It
seemed like a generic concept to me.

The other difference is that Stash is a tuple while BorrowedPointer is a
struct and has methods to access it.  Stash seems very ugly to use.

> I am not making any conclusions yet, but I am not exactly happily going
> to switch to your proposal yet :)

Sure, no problem.

Paolo


