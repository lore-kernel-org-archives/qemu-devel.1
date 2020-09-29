Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF9DC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24CC21D41
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHoRdWV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24CC21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDRU-00073u-MR
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNDNc-0002Mu-R8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNDNa-0002YU-QD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:01:08 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601377265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjbuKTo8zbjx5ifTPlt4UM+4ebqCnC9ciETKQazC03I=;
 b=fHoRdWV+G1hoRRSWo0R/ozkWOqKZq0zxDOYW25NYRz9huelb2d13FibkzjRQCty4itkarW
 EKWlkwZ/lmzITNidI50GEDt7B7snD46kJrarpNAX/gxYsrUB9YB8yiTUW9tAzWTsbtEgEA
 1xhVik0I4+5BIqyZdBz+hLe4V86c+a0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-6MQ1yI2ENBWqwbt1Aq3fqw-1; Tue, 29 Sep 2020 07:01:02 -0400
X-MC-Unique: 6MQ1yI2ENBWqwbt1Aq3fqw-1
Received: by mail-wm1-f72.google.com with SMTP id c200so1679455wmd.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GjbuKTo8zbjx5ifTPlt4UM+4ebqCnC9ciETKQazC03I=;
 b=CGdxiz7XpkH8QZOmhCmpl3JaOreTPwbZ9QoOyIVNr8080d9OZaS6jb2vmKUpeLXmfU
 yk0onydOx5e1P57ceEdjNqDtCACcDbieaP2l2p4kXTvTQE8W2+h6tXdySwuPq/JGjU+Q
 dZ83qBQcaWq9UBVSzbSakYQWDDS7gnJy/HN+9RGiQbaNNFj48mDdOeKReQX7TrSpwHt1
 FUOxCiHOyqazU7XPnJ1e6x7wm74pN6DCEc+I45uOj8cRE/4gps551AfbttGMjRKgf1lH
 QXHXuLJwbQFxdWOsTjf7kKjBYczge/H6GEenYMkjRo2FCgmhnrf5MKEcx7nD1A1aZcK2
 vzPQ==
X-Gm-Message-State: AOAM53121vF0xiDn6YfuIhPuSoQxN5VAUF5ou/3BVqnqba7luNx8h21Y
 0Ik+21/X1ZNcsOWnxe1brRBaEOAtlkzSogBruy8VydXlqXDrGU6Csu5BKu5QgkuGgOKMgzsjCai
 nTcOyf9MiwF5lb4Q=
X-Received: by 2002:adf:e410:: with SMTP id g16mr3624660wrm.76.1601377260597; 
 Tue, 29 Sep 2020 04:01:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8etp3w2m6FNOtKivOe+uZXZ9aJ8Rro/iH5klUHl1/dpEScYAAbNQEFn+oTP4YzUwrFpH+Ng==
X-Received: by 2002:adf:e410:: with SMTP id g16mr3624626wrm.76.1601377260340; 
 Tue, 29 Sep 2020 04:01:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dbe:2c91:3d1b:58c6?
 ([2001:b07:6468:f312:9dbe:2c91:3d1b:58c6])
 by smtp.gmail.com with ESMTPSA id e18sm5535449wrx.50.2020.09.29.04.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 04:00:59 -0700 (PDT)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
 <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
 <9d6215d4-d0cd-67e4-3048-77127194f7e8@redhat.com>
 <CAJ+F1CLowpdHaJ58Vt7GYukAYvYAfuEJvnuw_ZM5kO_4=gh9XA@mail.gmail.com>
 <8c1783d1-70f4-d751-3d5d-83459cb1db45@redhat.com>
 <CAJ+F1CJgEe3++UHDfT3iOGyu+r1tM4A_9jRXoKC0P-k-Mhq29w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb20f8e4-6bc9-3518-a983-86fad1915e49@redhat.com>
Date: Tue, 29 Sep 2020 13:00:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJgEe3++UHDfT3iOGyu+r1tM4A_9jRXoKC0P-k-Mhq29w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/09/20 12:34, Marc-André Lureau wrote:
>     That would not be backwards compatible as you would have to set all
>     optional fields.  Every time the command grows a new optional argument,
>     all clients would have to specify it; if a command becomes optional,
>     you'd have to add Some() around it.  So I would say that...
> 
> 
> Not necessarily, with ..default::Default()

That's true, I always forget about .. (though you'd still have to add
Some() for now-optional fields).

>     > Less idiomatic, but it also works around the optional arguments and
>     > ordering issue.
> 
>     ...  the builder pattern is not a workaround: it's the best and most
>     common Rust idiom to achieve what QAPI expresses as optional fields.
>     Likewise for keyword-only arguments in Python.
> 
> Except QAPI makes all fields potentially optional (and unordered),
> that's not idiomatic.

Yes, for some APIs you can always add hand-written, more idiomatic
versions.  Or you could mark them as fixed-arguments in the schema and
let the code generator do that (but then you need to add a compatibility
check).  But that would be an explicit choice, not something required by
the transport.

> D-Bus is machine-level oriented, it's easy to bind to various languages,
> it can be pretty efficient too. It's not designed to be a good network
> RPC. QMP tries to be a bit of both, but is perhaps not good enough in
> either.

No, only tries to be a good network RPC; not a particularly efficient
one, but future-proof.  And it mostly succeeds at that---with one
notable exception: JSON parsers that mess up with numbers bigger than 2^53.

>     If you want to "reinvent" QMP, instead of focusing on D-Bus you should
>     take a look at alternative IDLs and protocols (D-Bus is one but there's
>     also Protobuf and Flexbuffers), see how QAPI declarations would map to
>     those protocols, see how you would deal with extensibility, and rank
>     them according to various criteria.  For example:
> 
>     * JSON "just works" but needs a custom code generator and imposes some
>     extra complexity on the clients for the simplest commands
> 
>     * D-Bus has a good ecosystem and would keep simple commands simpler but
>     has issues with upgrade paths and is uglier for complex commands
> 
>     * Protobufs probably would also just work and would have better code
>     generators, but would require some kind of lint to ensure
>     backwards-compatibility
> 
> Again, the issues we are discussing are not specific to binding QMP over
> D-Bus. Binding QMP to various languages has similar problems.

Marc-André, we are totally in agreement about that!  The problem is that
you have already decided what the solution looks like, and that's what
I'm not sure about because your solution also implies completely
revisiting the schema.

I say there are many candidates (the ones I know are Protobuf and
Flexbuffers) for serialization and many candidates for transport (REST
and gRPC to begin with) in addition to the two {QMP,JSON} and
{DBus,DBus} tuples.  We should at least look at how they do code
generation before deciding that JSON is bad and DBus is good.

> I would rather make those problems solved at the server level, that
> doesn't require any change to QMP today, just a more careful
> consideration when making changes (and probably some tools to help
> enforce some stability).

Problem is, "more careful consideration when making changes" is not a
small thing.  And other RPCs have evolved in a completely different
space (REST APIs for web services) that have chosen the same tradeoffs
as QMP, so why should we not learn from them?

Paolo


