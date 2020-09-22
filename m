Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C95C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA9D235FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5IaKS4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA9D235FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlmw-0004Ru-Cz
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKlm4-0003SH-Ck
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:08:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKlm1-0007j1-PP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600794492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDeShg7mtwj3x675zuZhoTSV2Y/W8hI0i33lrasebmQ=;
 b=U5IaKS4cnQjViDBeGP2/ps2PCU7JVP3IZ8JGN8AvS+2c0fV5hrQPg9SW0iZg16GM7ZgdY9
 V5DJn/pEiP6N1GarSnDOFfNTRBj7Jt/Q+ovfrrLYqA4a0J0rKDTs6UGm5bQH1/hrrYgZNY
 PJFK4lKMzkIamxtRUqILgeSAdPgUQtg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-Ifmf36QOPtiFk7NyfzIGDw-1; Tue, 22 Sep 2020 13:08:09 -0400
X-MC-Unique: Ifmf36QOPtiFk7NyfzIGDw-1
Received: by mail-wr1-f70.google.com with SMTP id a2so7660427wrp.8
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iDeShg7mtwj3x675zuZhoTSV2Y/W8hI0i33lrasebmQ=;
 b=HDVicjclFWQQYWxbzNaIIRroS8D1TCns27fAx8aLyR68Tu3ZDViUL2afB0qmqBPGA3
 zpJWtT0TE/NveluoP53uRACvYudhBm2v6xnmo6l9mx+De76MRI2c+sH4ussUnw+xke2X
 V40k08I2EwNgKulIcLbr/RTj+BUes0v4iQdovyN3zQUFZ1gqiKJrJSFC75Ksx1eojz5M
 +sD+P5hv2poqq8FhyiIklWx1Un0kcMs6lcexgDs0tR7ZDTw4cYc0grvucwpjPuh4kn85
 p1xr/r8rDynfJ/QVZ/2rNp/0kJcUv45dXDo4EdiK8vveUCjryTLgxOAFvNeBiJ6vFd9I
 nkDA==
X-Gm-Message-State: AOAM531KPDb0BIeDzaLdDWa7nL6cxYeeweDrFrzY6YMBtwFODoT+c4vK
 G6Bg0nzIee+cEzwQTT/2nrGjPmXHgx5DzCgkvgKFHJQaJicyfGOqeHNgG6Tm/tRTaKRAUmDpAOa
 uOrNmBFFkiIuM4/c=
X-Received: by 2002:a05:600c:4149:: with SMTP id
 h9mr2069997wmm.86.1600794487209; 
 Tue, 22 Sep 2020 10:08:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyKfPt5PfM3oCaGnHpPdQQ496+dCyGOiZibmXV/fqtdIuxrx1pTqezcsBNfpZkipDmy4ItKw==
X-Received: by 2002:a05:600c:4149:: with SMTP id
 h9mr2069971wmm.86.1600794486903; 
 Tue, 22 Sep 2020 10:08:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id q13sm30025912wra.93.2020.09.22.10.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 10:08:06 -0700 (PDT)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
 <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d6215d4-d0cd-67e4-3048-77127194f7e8@redhat.com>
Date: Tue, 22 Sep 2020 19:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: John Snow <jsnow@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez Pascual <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 18:35, Marc-André Lureau wrote:
> The D-Bus specification doesn't detail versioning much. What is
> recommended is to have the version number as part of the interface name
> (kinda like soname):
> http://0pointer.de/blog/projects/versioning-dbus.html (this is
> documented in several places iirc)
> 
> So a QEMU D-Bus interface could have a name like org.qemu.Qemu51,
> org.qemu.Qemu52.. for example, if we can't provide better API stability...

That would be a problem for backports.

It seems to me that the bindings issue is only a problem if we insist on
having positional arguments like we do for C, but if we can avoid
functions with a zillion arguments we could.  For example in Rust, it's
idiomatic to use the builder pattern

    let thread = thread::Builder::new()
        .name("foo".into())
        .stack_size(65536)
        .spawn(run_thread)?;
    thread.join()?;

and I think the same would work in Go or even C++.  It would look like

   qapi::qga::commands::GuestShutdown::new()
       .mode("halt")
       .invoke_on(qapi_channel)?;

with some kind of double dispatch implementation:

   trait QAPIChannel {
      ...
      fn invoke(command: dyn QAPISerialization)
          -> dyn QAPISerialization;
   }

   impl GuestShutdown {
       fn<T: QAPIChannel> invoke_on(t: T) -> () {
           let args = self.as_qapi_serialization();
           t.invoke(args);
           // could "return from_qapi_serialization(result)", likewise
       }
   }

In Python, you can use keyword arguments and there are even keyword-only
arguments ("def f(*, key1, key2)"), like

    qapi.qga.GuestFileOpen(path="/etc/passwd").invoke_on(qapi_channel);

When you do something like this QMP-style APIs are not a problem.
FlatBuffers is another serialization format that supports this kind of
extensibility (https://google.github.io/flatbuffers/ explicitly compares
it to JSON, even).

Paolo


