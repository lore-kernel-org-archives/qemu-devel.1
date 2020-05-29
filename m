Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB0AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92B82075A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLJfHrSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92B82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeagt-0001cI-Vo
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 04:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jeagB-00019v-BU
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:47:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jeag9-0007E4-TZ
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590742068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9bJsbhSW3fHWKzPtUcSAa9MSdguyeuMaxvHKr0e7vE=;
 b=jLJfHrSaG/wQ6j9TMd2eGuKGIip6qcN9gGf9zit6pVKD//4eKb2KOe+3m1NuTKL2wYeuTl
 BObve3wulz+FZu+4TLlRFibostGXQdlheZNIcILH9iHSKUGKqGXJbZAEXSbxG5Ud0ASQ4d
 UYzpPQaKT+fCETHCFGh637C1HL4sE0Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-NGawiLqNP46ZE6FhM_GEzA-1; Fri, 29 May 2020 04:47:46 -0400
X-MC-Unique: NGawiLqNP46ZE6FhM_GEzA-1
Received: by mail-wm1-f71.google.com with SMTP id t62so518879wmt.7
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 01:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y9bJsbhSW3fHWKzPtUcSAa9MSdguyeuMaxvHKr0e7vE=;
 b=P/AN8/KeNI3QEU3pUuW5P53RKMphHoU9QmqB7fhUPkvga1OJT7WWxSOl0mOIIds/em
 zBaYqHfDWlDAZz+flzGGK7ZZK+BSN1rtmgN5PKmEemIxen9lWCc8UBfvYUMb9bLm5qAK
 Vt8pgZqpBjyaXRCmOu1wEzU6wTwp6tYcuBSIaB4mqLDIF+R09H0enU71LpX22brNKkzf
 BccqFSqj8l3xzplSJ4bBSAXeuMHbMbUhRafKW/oAFnRHB4R/GNrK4K6GqYcIsgcqFsFp
 UDTWD8v9wFn6VD99CqFaDkiPXtbiuP+a2dfO421UKYSlIn0p37rMQ9JRYo02K0mjBpM8
 IbpQ==
X-Gm-Message-State: AOAM532lvxDRPZKSRrmHQkFHml/l6TmZMIEqN8/dZZU/K6ULN6r3XKMw
 7/LZxYXynSdl7NgL/N6aiu/nuTTYlOJ+NUwkrtQlhrTSGtDiqb31zxmy8VqIoqSIdvPLLBYzEQj
 j7c2PGM/mXIGqhuk=
X-Received: by 2002:a1c:2702:: with SMTP id n2mr7663107wmn.107.1590742064762; 
 Fri, 29 May 2020 01:47:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeKYaQZC9mQ65ys23NUNLcOeyH7emZvwDvl4y/kkm8wnHuXSemohfl9m6pNgBp3TaGWWBKzQ==
X-Received: by 2002:a1c:2702:: with SMTP id n2mr7663088wmn.107.1590742064526; 
 Fri, 29 May 2020 01:47:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7?
 ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
 by smtp.gmail.com with ESMTPSA id y25sm11500629wmi.2.2020.05.29.01.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 01:47:43 -0700 (PDT)
Subject: Re: QMP qom-get feels useless for child properties
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87lflbns8o.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <037647cc-d7e4-65a6-19d3-977fc6e4f2c7@redhat.com>
Date: Fri, 29 May 2020 10:47:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87lflbns8o.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/05/20 08:57, Markus Armbruster wrote:
> QMP qom-get for a link property returns the canonical path of the link's
> target:
> 
>     $ socat "READLINE,history=$HOME/.qmp_history,prompt=QMP> " UNIX-CONNECT:$HOME/work/images/test-qmp
>     [...]
>     QMP> {"execute": "qom-get", "arguments": {"path": "/machine", "property": "acpi-device"}}
>     {"return": "/machine/unattached/device[23]"}
> 
> This makes sense.
> 
> Fine print: it returns "" for dangling links, I think.  See
> object_get_link_property().
> 
> qom-get behaves the same for child properties:
> 
>     QMP> {"execute": "qom-get", "arguments": {"path": "/machine", "property": "peripheral"}}
>     {"return": "/machine/peripheral"}
> 
> This surprised me.  I'm writing to the list in the hope of saving
> somebody else the surprise and the time to figure out what's going on
> here.
> 
> Returning the canonical path feels useless here.  The only explanation
> that comes to my mind is we have to return something, the canonical path
> is something, therefore we have to return it ;)

It is useful in that the caller need not care whether a property is a
child or a link.  If a property has object type, it consistently returns
a canonical path.

> You either just know that /machine/peripheral is a child property, or
> you recognize the pattern "type": "child<T>" in output of qom-list one
> level up:
> 
>     QMP>{"execute":"qom-list","arguments":{"path":"/machine"}}
>     {"return": [... {"name": "peripheral", "type": "child<container>"}, ...]}
> 
> I believe ad hoc matching of type strings is necessary in other cases to
> make sense of qom-get output.
> 
> I wish QOM introspection described types like QAPI introspection does.

At least in theory all QOM property types should be one of child<>,
link<> or a QAPI type.  Perhaps it should have been just the QOM type
without the child<> and link<> annotations?  Can we change that
retroactively?  (We probably can).

Paolo


