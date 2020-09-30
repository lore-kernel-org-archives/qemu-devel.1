Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAC1C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D330F20754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8hmPPRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D330F20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcjD-0007fr-Ja
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNchK-0005w6-5K
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNchH-0007lx-M9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:03:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601474586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKQ5cleean4ncOTNdDwSEIFXgDg7Y+2njqyY1nePeCQ=;
 b=h8hmPPRoSVlWYQvEgh9p+J6pYlMUxLekGQUcICJy5TcU0+nw3xwoDJhohdKY/PD+2VnsfF
 ZrH8Dhg4ZGjL77Tr4yfgVNT6FkcGInLPtH2zBsvy8om88wgAvm9h340YBPy0/C+lTq3wfo
 V0UMcGUPMSQyi1uCLBxMnoBQyMowwwI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-TWyAsjXUOg-42szo3GbhSA-1; Wed, 30 Sep 2020 10:03:04 -0400
X-MC-Unique: TWyAsjXUOg-42szo3GbhSA-1
Received: by mail-wr1-f69.google.com with SMTP id w7so658668wrp.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 07:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HKQ5cleean4ncOTNdDwSEIFXgDg7Y+2njqyY1nePeCQ=;
 b=iRaa23kyHHD27FefwRwGrmx4uvuEehvgh6NTGXCtrzkqUymq36VHMMrYdAhqajZ4nq
 BLAj6vslaBo5AQuwRUQeVBavS5lavvRaHeMbjylTpQH0Q2E+738QIKC1WUMj4pEXe0xz
 0I8BSb/nQFJLcSBnvAyZeEikVgNo1qZkEikQkNqrmuYfgXsR1Cwma7ok0ZnX5vZ4zMlO
 BzCAM2LxpZq6ViGVh9R+WwgnCiom+88mTJd8/AcBcq5wi11q9AEmnyS2kD1bi5ahXEq2
 FDXRStkkMrBcEWE5gkY0+GUWfzSRQ1LTATGlEj6STwzFAX04IB+JNjE++RrG2ri0KBgO
 lG2Q==
X-Gm-Message-State: AOAM530EFGhzFPJMdgrqpNryG4nOn3/IDHHPAcT4R8w2BgVTboxTbMDA
 AxcedHBZeInn1O/sqjpTOVFajmdzVflftcJiZOmSaVI1uZM8MyTjmyFP4VUTmyr/+dc9ApV7P5U
 zYloYdoDE0ZxIcPo=
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr3652722wrw.198.1601474583484; 
 Wed, 30 Sep 2020 07:03:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPBugUo9jYq2EfCQSVPL5cQtxjk/Z5PPRDKtTOWr8luDAJ3aa3gOyBzcMXIHW4rX6TCb2gnQ==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr3652663wrw.198.1601474583058; 
 Wed, 30 Sep 2020 07:03:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4?
 ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id n14sm2824460wmi.33.2020.09.30.07.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 07:03:02 -0700 (PDT)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <eeead7ec-ebde-637d-de06-31c9b343b3b8@redhat.com>
 <399aad6c-5d86-8988-a44a-e91d650e7273@redhat.com>
 <CAJ+F1CKPyBfjPoaRc5j24swo8Bfy0D7m+txNk5cyAi47rOz2bw@mail.gmail.com>
 <093067ee-e849-be8c-6e02-167d28d3e3ed@redhat.com>
 <CAJ+F1CL1kzvHRmMOTq38r0PNyCJhzyqWeiNb71e7sabaWOwdsQ@mail.gmail.com>
 <ddd2e282-3e0e-1c0e-2af3-7ca59c322ef9@redhat.com>
 <CAJ+F1CL7r31u1bQLRGmbZt-BPLM3XefFdY9O3Mk=VMmgJ76aiw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59a29e14-57d8-4246-14ce-375f6c9ce4dc@redhat.com>
Date: Wed, 30 Sep 2020 16:02:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL7r31u1bQLRGmbZt-BPLM3XefFdY9O3Mk=VMmgJ76aiw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
 =?UTF-8?Q?Sebastian_Dr=c3=b6ge?= <slomo@circular-chaos.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/20 11:15, Marc-André Lureau wrote:
> Why BorrowedMutPointer provides both *const P and *mut P ? The *const P
> conversion seems overlapping with BorrowedPointer.

"&mut T" implements Borrow so it seemed obvious to have as_ptr in
BorrowedMutPointer too.  Though I certainly should implement Borrow in
BorrowedMutPointer.

>     > I don't have your head, so I find it hard to remember & work with.
>     It> uses all possible prefixes: with_, from_, as_, as_mut, to_, and
>     into_.
>     > That just blows my mind, sorry :)
> 
>     Ahah I don't have your head either!  The idea anyway is to reuse
>     prefixes that are common in Rust code:
> 
>     * with_: a constructor that uses something to build a type (think
>     Vec::with_capacity) and therefore takes ownership
> 
> ForeignConvert::with_foreign (const *P -> T) doesn't take ownership.
> 
> The Rust reference for this kind of conversion is CStr::from_ptr.

Ok, I'll take a look.

>     * as_: a cheap conversion to something, it's cheap because it reuses the
>     lifetime (and therefore takes no ownership).  Think Option::as_ref.
> 
> as_ shouldn't create any object, and is thus unsuitable for a general
> rs<->sys conversion function (any).

as_foreign function does not create anything, it reuses the storage to
provide a pointer.  It seems similar to as_slice for example.

>     * from_/to_: a copying and possibly expensive conversion (that you have
>     to write the code for).  Because it's copying, it doesn't consume the
>     argument (for from_) or self (for to_).
> 
> and that's what glib-rs uses (and CStr).

Sort of, I found the none/full suffixes not really idiomatic for Rust.

>     * into_: a conversion that consumes the receiver
> 
> That's not used by glib afaik, but we should be able to introduce it for
> "mut *P -> T", it's not incompatible with FromPtrFull::from_full.

Right.  It's just a different way to write the same thing.  Usually it
is a bit more concise because it allows more type inference.

>     > Then, I don't understand why ForeignConvert should hold both the
>     > "const *P -> T" and "&T -> const *P" conversions. Except the
>     > common types, what's the relation between the two?
> 
>     Maybe I'm wrong, but why would you need just one?
> 
> No I mean they could be on different traits. One could be implemented
> without the other. Or else I don't understand why the other conversion
> functions would not be in that trait too.

The other conversion functions require taking ownership, and I was not
sure if it would always be possible to do so.  For no-ownership-taken
conversions, however, it seemed to me that you'd rarely be unable to
implement one of the two directions.  I might be wrong.

In general though I agree that the changes are mostly cosmetic.

Paolo


