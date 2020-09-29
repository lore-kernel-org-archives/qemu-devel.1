Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957FCC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D956620C09
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emetDnwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D956620C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCfz-0000Pi-PP
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNCf0-0008IR-A5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNCey-0003m6-5I
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:15:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601374498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFhYOkchDSO0fcxkj/KjCtciREzFb9EfosxOB3hFcbM=;
 b=emetDnwVUlI5CvWy5ih4NwevSNl/Aoe2C7Emidn0fwW6SotUQpmZH9Gzn+8Qtm9yvtj8i5
 k2S7rDjPijXJrZ/rL10Z7a0MIyXaGRBHw5SayPAh/TX7Odaf2gHfWNL01386H/Pciv+qx6
 zif6idWReSgVS46b4ZKkBFpl6COPkNw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-9IRsV0J_PGOb6CGzDeSZWA-1; Tue, 29 Sep 2020 06:14:56 -0400
X-MC-Unique: 9IRsV0J_PGOb6CGzDeSZWA-1
Received: by mail-wr1-f69.google.com with SMTP id l15so1552219wro.10
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dFhYOkchDSO0fcxkj/KjCtciREzFb9EfosxOB3hFcbM=;
 b=nuaZuzBVI9S6AvjoHw3EqlHaYEySXiGjkLjAu+N56U+gHzA5qMLH1gWWCABv6KBDsE
 j/RRKnKmRfpSbdX4USuyEx38tzCVn8sxQif9/+osTfTuW9HaNGseYzOxVR5i0+vNB+tD
 FdnEO/PEN+HnA8PUQ8V51G7KzvBKUIIa7u52lAWeP+ry55x0syGTCIUXFwZzTYm3vt9O
 Nq5noa1pC5w1cFtzAnE+RaYeKd/fAHAVvPN+X9CfjzlADItl9maOrsEOaXitOD/JHLxN
 Qr9QtvBuG8UmG6VgMyK6jH0MF8OBHL+uzEGQ5i83h2wH9wpuOKmRZb557k31jWTDPOES
 nbDQ==
X-Gm-Message-State: AOAM532Fy50cHOaYAJaOvxO1H2G+MRcCpLcXUZ2DxgMA1CnXFAJ4qNba
 D3ZU9g1hLFsBShbwvuo0YN2ZHFI1T28NdJZvqCdciF84swub9yKa3zXNHR5jYqEbhsXnnUVzKqf
 pgboClJg+H7n097o=
X-Received: by 2002:a5d:4246:: with SMTP id s6mr3321172wrr.414.1601374494872; 
 Tue, 29 Sep 2020 03:14:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6SxgIJHFzkvbBT0wJD9Jy2y/w6w6GwXQTUV1cHrpz/0EaT4KJ06q/I8vprggDIsgGMkWzNQ==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr3321147wrr.414.1601374494581; 
 Tue, 29 Sep 2020 03:14:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dbe:2c91:3d1b:58c6?
 ([2001:b07:6468:f312:9dbe:2c91:3d1b:58c6])
 by smtp.gmail.com with ESMTPSA id o4sm5062572wru.55.2020.09.29.03.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 03:14:53 -0700 (PDT)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
 <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
 <9d6215d4-d0cd-67e4-3048-77127194f7e8@redhat.com>
 <CAJ+F1CLowpdHaJ58Vt7GYukAYvYAfuEJvnuw_ZM5kO_4=gh9XA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c1783d1-70f4-d751-3d5d-83459cb1db45@redhat.com>
Date: Tue, 29 Sep 2020 12:14:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLowpdHaJ58Vt7GYukAYvYAfuEJvnuw_ZM5kO_4=gh9XA@mail.gmail.com>
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

On 29/09/20 09:45, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Sep 22, 2020 at 9:08 PM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>     > So a QEMU D-Bus interface could have a name like org.qemu.Qemu51,
>     > org.qemu.Qemu52.. for example, if we can't provide better API
>     stability...
> 
>     That would be a problem for backports.
> 
> Yes..  Backports could expose a subset of the new version interface? Or
> the interface can be divided for each Qmp command. (unorthodox)

That seems like a workaround for an IDL that is not the right solution
for the problem.

>        qapi::qga::commands::GuestShutdown::new()
>            .mode("halt")
>            .invoke_on(qapi_channel)?;
> 
> 
> Or simply use the same approach as qapi-rs
> (https://github.com/arcnmx/qapi-rs) which is  simply generating data
> structures based on the schema, and not binding commands to Rust
> functions for ex.
> 
> qga.execute(&qga::guest_shutdown { mode: Some(GuestShutdownMode::Halt) })


That would not be backwards compatible as you would have to set all
optional fields.  Every time the command grows a new optional argument,
all clients would have to specify it; if a command becomes optional,
you'd have to add Some() around it.  So I would say that...

> Less idiomatic, but it also works around the optional arguments and
> ordering issue.

...  the builder pattern is not a workaround: it's the best and most
common Rust idiom to achieve what QAPI expresses as optional fields.
Likewise for keyword-only arguments in Python.

> Yes, the python binding will have a similar issue. And if we want to add
> typing to the mix, representing everything as a dict is not going to
> help much. Fortunately, there are other options I believe. But I would
> rather aim for the obvious, having non-optional & ordered arguments, and
> interface/methods versioning.

You shouldn't just state what you want; you really should take a look at
how the ability to add optional arguments has been used in the past, and
see if an alternative RPC without optional and unordered arguments would
have been as effective.  D-Bus is probably a perfectly good API for
qemu-ga.  The experience with qemu-ga however does not necessarily
extend to QEMU.

The main issue with D-Bus is that it conflates the transport and the IDL
so that you have to resort to passing arguments as key-value pairs.  QMP
does the same, but the IDL is much more flexible and not QEMU-specific,
so we don't pay as high a price.  Remember that while the specific
transport of QMP ("JSON dictionaries over a socket with 'execute' and
'arguments' keys") is QEMU-specific, the concept of using JSON payloads
for RPC is very common.  For example, REST APIs almost invariably use
JSON and the resulting API even "feel" somewhat similar to QMP.

In fact, The first Google result for "openapi backwards compatible
extensions"
(https://github.com/zalando/restful-api-guidelines/blob/master/chapters/compatibility.adoc#107)
might as well be written for QMP:

* [server] Add only optional, never mandatory fields.

* [client] Be tolerant with unknown fields in the payload

* [server] Unknown input fields in payload or URL should not be ignored

* [client] API clients consuming data must not assume that objects are
closed for extension

* [server] When changing your RESTful APIs, do so in a compatible way
and avoid generating additional API versions

* [server] MUST not use URI versioning

and so on.

If you want to "reinvent" QMP, instead of focusing on D-Bus you should
take a look at alternative IDLs and protocols (D-Bus is one but there's
also Protobuf and Flexbuffers), see how QAPI declarations would map to
those protocols, see how you would deal with extensibility, and rank
them according to various criteria.  For example:

* JSON "just works" but needs a custom code generator and imposes some
extra complexity on the clients for the simplest commands

* D-Bus has a good ecosystem and would keep simple commands simpler but
has issues with upgrade paths and is uglier for complex commands

* Protobufs probably would also just work and would have better code
generators, but would require some kind of lint to ensure
backwards-compatibility

* etc.

> Well, I wouldn't say it's not a problem. It makes working with QMP as a
> client quite an unpleasant experience overall imho...

With automatically-generated bindings, the experience writing a QMP
client is as pleasant as the code generator makes it.

Paolo


