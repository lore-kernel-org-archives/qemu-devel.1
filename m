Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA96C43467
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0162080D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKfbJgRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0162080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyCX-0000e8-G2
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRyAf-0007xB-RB
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRyAX-0000SL-HS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602510436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWZBPdt6cu6xHHBOpo9uqeX/pLX2HtLQ2M010/B0OQg=;
 b=RKfbJgRWl4VBD6FZmGSRbvIgTGcyAYbZnDJ4GldQQdpS1GmFm3Q95SmL4hKfl7y85uCEFc
 A2hqlgznv9gUmNCYmY5yh65YfAZhQgW3ye0TA/ch5PKCnQyH+SVKBPCN8XHFlkMHpIofa3
 HeVg/I1ABMuooF0WXRPTvUxHFtyHpcI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-pbUCATAsOC-jxnQUcfuhHQ-1; Mon, 12 Oct 2020 09:47:15 -0400
X-MC-Unique: pbUCATAsOC-jxnQUcfuhHQ-1
Received: by mail-wr1-f70.google.com with SMTP id r8so2016998wrp.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 06:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SWZBPdt6cu6xHHBOpo9uqeX/pLX2HtLQ2M010/B0OQg=;
 b=E5Gn6vNlINGvRd+GeZUQ5OIUbDeofTbCCqEInC/pc/1+dMHBf6CzaJ9iQHlhVOIsp+
 1ioDXJL29yvrsZzKKOG6plKDbFvSEcvw206N+fkvu8HwVmcfK9QUju7jVDEoi0kZ8ri9
 v3GZqavCnihnXimLgFQ/DlbCLbd8lM8fJWUhfEtRGc7en2q1ZPHGABq14dXgnk0HjIW8
 RFp+B1yxvSdne05mViF/jez7o7eOv0YF5uyeEaXwrtGmga9Ux9M0OTmOK3wllQG+nff/
 tbX79meJ3nt4XCaFa6b0fYeWket0PYtafZlyBIOqJL7irfWgHKwfhJZAepitsgOSS7Rp
 4xpg==
X-Gm-Message-State: AOAM533O1elTUaViCTUJhXArTqbvay6V1Un6EFcG49EZBx+YziRZdSMN
 XGRMotq7KYXdcLGnTibz9NywWnWP+lZZftChdcEboANNnjF8BaURqccbJXwRSDfhJmeVoi5lgjZ
 nXrDZ/cXqu06Lw34=
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr10688950wmb.173.1602510433847; 
 Mon, 12 Oct 2020 06:47:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9K6gA+FBHaEdLb/H6OgpwOEfjdRH/FgsrUb6v1M5jDB3xImBFxXUC/1/f9CyRl7KvySyj5w==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr10688935wmb.173.1602510433653; 
 Mon, 12 Oct 2020 06:47:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7ffb:1107:73ba:dbcf?
 ([2001:b07:6468:f312:7ffb:1107:73ba:dbcf])
 by smtp.gmail.com with ESMTPSA id o3sm21668558wru.15.2020.10.12.06.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 06:47:13 -0700 (PDT)
Subject: Re: [PATCH v7 02/13] qtest: Reintroduce qtest_qmp_receive
To: Thomas Huth <thuth@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006123904.610658-1-mlevitsk@redhat.com>
 <20201006123904.610658-3-mlevitsk@redhat.com>
 <3dd3b467-6784-470c-cbfb-b7baf611abde@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3098b68-2d6b-6c99-4658-5b3c32227832@redhat.com>
Date: Mon, 12 Oct 2020 15:47:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3dd3b467-6784-470c-cbfb-b7baf611abde@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/20 13:14, Thomas Huth wrote:
>> +/**
>> + * qtest_qmp_receive:
>> + * @s: #QTestState instance to operate on.
>> + *
>> + * Reads a QMP message from QEMU and returns the response.
>> + * Buffers all the events received meanwhile, until a
>> + * call to qtest_qmp_eventwait
>> + */
>> +QDict *qtest_qmp_receive(QTestState *s);
> Re-introducing qtest_qmp_receive() with different behavior than before will
> likely make backports of other later patches a pain, and might also break
> other patches that use this function but are not merged yet. Could you
> please use a different name for this function instead? Maye
> qtest_qmp_receive_buffered() or something like that?

We chose to use the same name because the new version generally is the
one you want and, except for the handling of events, is exactly the same
as before.  In other words, I'm treating the new semantics more as a
bugfix than a feature.

The only trap that backports of later patches could fall into is if they
want to look at events, but it would be caught easily because the test
would fail.

Paolo


