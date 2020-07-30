Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F4BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDD020829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdXr8eVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDD020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18ly-0002Q3-3x
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k18lP-00020i-Lh
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:38:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45565
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k18lN-0007qk-KO
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596116303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6lwt3cV1Qvvd4NWGFqO4ECEaaPa128WxRhTUOjfZWg=;
 b=CdXr8eVhba6FMEozcE2pnMWHfpKl02nKHpCQaWw+R2JUj6dX2XPReL6u1GHbmNXFeG1xIH
 0gv0LKAajAmQvy9tIrvs1eV98kMPpGpSGjMZ9ncNvRbJqDz3yWpaSEEuQUMQlUGPMh4QeK
 6mGpa2TGP/XRF4EHDLrd69l2gQpOaJc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-uq0lLcWwNjiOn6PIucV3fw-1; Thu, 30 Jul 2020 09:38:21 -0400
X-MC-Unique: uq0lLcWwNjiOn6PIucV3fw-1
Received: by mail-wm1-f72.google.com with SMTP id a207so1399703wme.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f6lwt3cV1Qvvd4NWGFqO4ECEaaPa128WxRhTUOjfZWg=;
 b=KNoVWCcBH9XCbslD4fZNaxwBsagNaTY5MgUJSsaKkGjARuIu2puhyFszeFWKPb7qIT
 iDDoBAm6BDBALMGejQoqHpSJrZvhBhj+lKo4quMnhFeAybgQYQM8zhCrRx/Fdb/8XxTt
 40bQvGBqAUSBF22ehVNjlSIzEEHHT8uVgGd9b4KLOd2RstFWVlxfyi/aGGEIGv+ZgTyj
 1Eij+LECXo1O23VQ15+/tA9sCHs/4NPux7EGmvCPh2q1GqENJrbDGKxfl3HbbfWMRlaO
 XN0n5TbpArzdhQg3cNV2FFc+knTq3dPMTIFL3sP8Z6/o80Ymge4SDY4TH+JoF0Ks24s3
 SGsw==
X-Gm-Message-State: AOAM530spV6yQkSplEBUJ9zAz/PWyV9CT0utAdW7l0dAK3h1SKxaNBtj
 GCOE7hmmaSQIUj7xJfu2/0fHwDNLuLJ/T76ks1ze2DZder/72P3x2r2pIq930uZoYXG52nIlJ54
 mxejLJRfW0WZnMT4=
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr13750163wmi.34.1596116300266; 
 Thu, 30 Jul 2020 06:38:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt6wbA2hIj2zWwgHbKubPk5WX2p4VxEwEbw3VqKlrD7VMFgvcGpQKQ4cSWqkQtmqHzzCI5Gg==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr13750140wmi.34.1596116300012; 
 Thu, 30 Jul 2020 06:38:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:310b:68e5:c01a:3778?
 ([2001:b07:6468:f312:310b:68e5:c01a:3778])
 by smtp.gmail.com with ESMTPSA id g188sm10730070wma.5.2020.07.30.06.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:38:19 -0700 (PDT)
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
 <0d7a9407-1df6-0c9b-0695-2f438f0de129@redhat.com>
 <87zh7hxjqa.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f024c884-bf7d-e098-2664-64a847dd97d8@redhat.com>
Date: Thu, 30 Jul 2020 15:38:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87zh7hxjqa.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/20 14:36, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 30/07/20 12:03, Markus Armbruster wrote:
>>> qdev C layer:
>>>
>>>     frob->prop = 42;
>>>
>>> Least cognitive load.
>>>
>>> QOM has no C layer.
>>
>> Not really, a QOM object is totally free to do frob->prop = 42.  And
>> just like we didn't do that outside device implementation in qdev as our
>> tithe to the Church of Information Hiding; the same applies to QOM.
> 
> I screwed up the part of my argument that actually has a hope to be
> valid, let me try again.
> 
> With qdev, you can always do frob->prop = 42, because properties are
> always backed by a struct member.
> 
> With QOM, properties are built around visitor-based getters and setters.
> This means you can always do (but never actually would do) something
> like
> 
>     fortytwo = qnum_from_int(42);
>     v = qobject_input_visitor_new(fortytwo);
>     set_prop(OBJECT(frob), v, "prop", cookie, &err);
>     visit_free(v);
>     qobject_unref(fortytwo);
> 
> where set_prop() is the setter you passed to object_property_add(), and
> @cookie is the opaque value you passed along with it.
> 
> *Maybe* set_prop() wraps around a simpler setter you can call directly,
> or even a struct member you can set directy.  QOM does not care.
> 
> And that's my point: QOM does not care for the C layer.

Ok, I think I got it.  In practice it depends on how much you want to
hide the implementation of the properties and (especially for
set-only-before-realize properties) the answer will be "not at all
inside the device implementation".  So inside the implementation you can
always break the information hiding layer if needed (usually for
performance or as you point out sanity), and I don't think there is a
substantial difference between qdev and QOM.

But yeah, I'm willing to concede that QOM the QAPI-- layer of QOM comes
first and the C layer comes second. :)

Paolo


