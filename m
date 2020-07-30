Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72320C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7A42075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxIpNXPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7A42075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16Sw-000740-9a
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k16Rq-00068w-Aw
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:10:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49908
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k16Ro-0002UV-0W
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596107403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=luoojh1fwYtgU076SKn33zC8SlsxZeI+EEFUhTRBLZQ=;
 b=RxIpNXPH/2v/9rdaLkTnZgyEnoQuXkHA2QtDKxHQd5FTWe7IBdQB8/3HF4j2zBXNyd+bfh
 7bpXvbr50EfiUb9UPsm+4TF0qrBuZwW1QU7souY+sSFeU7zVXebF8PCwPg+M2okVXO8RZ2
 SXjy/C4jUUHgIEhlIOLHu7LWld0fxMI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-nE-AghStNa-xogpaEowe4w-1; Thu, 30 Jul 2020 07:10:01 -0400
X-MC-Unique: nE-AghStNa-xogpaEowe4w-1
Received: by mail-wm1-f72.google.com with SMTP id a5so2123169wmj.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 04:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=luoojh1fwYtgU076SKn33zC8SlsxZeI+EEFUhTRBLZQ=;
 b=np76Iu0R4wEOBTFctKEJ+NHti8oxiEF2MB+bZaJg1hNJILN713aD8ioWvGtU1tIUY4
 FMfsh2x8XsZTTqKLKmaDBRJBXjGjVcXPyKgeQTPIBgBHuLKYSgigVKXKQIwmQjdR8P0E
 1d+TbudlfUWqY5vChtoxjixGd/rBz/ERee0oyjS3qwffQkwKWanlOBMT9cW+9avU/Tqx
 dlZ727iQvCWsfGnjyQeokWqEQEERWA5aGV08UaaJM3rHs9NyFzdwdbxJi/7TeiHmqZpd
 dlQ6JGgBS6A6TVQnS9jjiGVRj0f48wrWT4D4kHB/1SlI3uhaI+9Bucub3meqvrnepB+q
 uzpg==
X-Gm-Message-State: AOAM532Euw9u7fwUQMDq5sr+hzyX7btcG/iS/p6coSUbjHsE7xiKZkfk
 UOy08Gpyype28gzx8T/q/WYcSgilQdF1d2CtEAzTypF/1oPoXkb02ULyrRYuS5RYb7hhYO8XX1B
 Z1wyDJdu2yoW0Y60=
X-Received: by 2002:a05:600c:21cd:: with SMTP id
 x13mr10672698wmj.155.1596107399813; 
 Thu, 30 Jul 2020 04:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL1x62jMDSSaHG2OrEsV2oaJd4+vtUsRR2QiFvUt5EPSF63rYo7Kh/N1i2PjbxpBA9UymsxA==
X-Received: by 2002:a05:600c:21cd:: with SMTP id
 x13mr10672674wmj.155.1596107399551; 
 Thu, 30 Jul 2020 04:09:59 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id m20sm16844069wmc.1.2020.07.30.04.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 04:09:59 -0700 (PDT)
Subject: Re: sysbus_create_simple Vs qdev_create
To: Markus Armbruster <armbru@redhat.com>
References: <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net> <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net> <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net> <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
 <20200728224733.GP225270@habkost.net>
 <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
 <87zh7i5uj5.fsf@dusky.pond.sub.org>
 <6ee49ad2-8b6b-cb6f-c3c9-b440631cfc75@redhat.com>
 <87sgd91fsa.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d7a9407-1df6-0c9b-0695-2f438f0de129@redhat.com>
Date: Thu, 30 Jul 2020 13:09:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87sgd91fsa.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/20 12:03, Markus Armbruster wrote:
> qdev C layer:
> 
>     frob->prop = 42;
> 
> Least cognitive load.
> 
> QOM has no C layer.

Not really, a QOM object is totally free to do frob->prop = 42.  And
just like we didn't do that outside device implementation in qdev as our
tithe to the Church of Information Hiding; the same applies to QOM.

> qdev property layer works even when @frob has incomplete type:
> 
>     qdev_prop_set_int32(DEVICE(frob), "prop", 42);
> 
> This used to map property name to struct offset & copy the value.
> Simple, stupid.
> 
> Nowadays, it is the same as
> 
>     object_property_set_int(OBJECT(frob), "frob", 42, &error_abort);
> 
> which first converts the int to a QObject, then uses a QObject input
> visitor with a virtual walk to convert it back to int and store it in
> @frob.  It's quite a sight in the debugger.

Yes, but thatt's just because we never bothered to create single-type
visitors.  For a good reason though: I don't think the extra QAPI code
is worth (not even that much) nicer backtraces when we already have a
QObject as a battle-tested variant type.

> qdev "text" layer is really a QemuOpts layer (because that's what we had
> back then).  If we have prop=42 in a QemuOpts, it calls
> 
>     set_property("prop", "42", frob, &err);
> 
> Nowadays, this is a thin wrapper around object_property_parse(),
> basically
> 
>     object_property_parse(frob, "prop", 42, &err);
> 
> Fine print: except set_property() does nothing for @prop "driver" and
> "bus", which look just like properties in -device / device-add, but
> aren't.

Ugly indeed.  They should be special cased up in the caller, probably,
or use the long-discussed "remainder" feature of the QAPI schema.

> object_property_parse() uses the string input visitor, which I loathe.

Apart from the list syntax, the string input visitor is decent I think.

>>> I've long had the nagging feeling that if we had special-cased
>>> containers, children and links, we could have made a QOM that was easier
>>> to reason about, and much easier to integrate with a QAPI schema.
>>
>> That's at least plausible.  But I have a nagging feeling that it would
>> only cover 99% of what we're doing with QOM. :)
> 
> The question is whether that 1% really should be done the way it is done
> :)

And that's a very fair question, but it implies non-trivial design work,
so the smiley changes to a frown. :(

Paolo


