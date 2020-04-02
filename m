Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA77C18E5B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E25208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc4B1p6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E25208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvYQ-0004fV-9Z
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jJvXI-0003K6-97
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jJvXH-0007Ew-Cu
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:49:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jJvXH-0007Dd-8a
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585817354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0dV5/63rZLQh3fvBJCNm0GxYjPUIZk+Khphu8cahis=;
 b=Tc4B1p6+fTwjJ7/15wnYav9+Ai8kWobUhbMD3b6DMLNl8pwnVzLwk737fdCygAO5h1h9AT
 bsofHCTLBF9qjHsrcbfuT0CqggGJDeyQKY9sYdPOfC8vfQtdO9m6mPskqzDztW2PJUYL8D
 gk7WP4uHKVOSYjK7+PWpyemcPKgnR6Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-8YVgqSioO2OtKs2T0iPVog-1; Thu, 02 Apr 2020 04:49:13 -0400
X-MC-Unique: 8YVgqSioO2OtKs2T0iPVog-1
Received: by mail-wm1-f72.google.com with SMTP id f8so1102571wmh.4
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 01:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O0dV5/63rZLQh3fvBJCNm0GxYjPUIZk+Khphu8cahis=;
 b=J0XX3Pj5dbI+9QFDWdM6ZrixWepR0RIbW9hlJ6Mwkmt5ck5kYefzh0thupAiuNRuWJ
 JjC7M2WyRDPS/2AG+sEoiVcIC1U4FNKypV3CvwMJST5g+dDOfLUVB5XRBTYeDWOO8gL3
 2GXDmYTK+xRSy1IJhBo/a5uahfMEia6QzWn3FrFkn0CmPwwqe7U2lZu2+42Ij5O/0ubo
 pB9f2JjqqNBz1r9pPfGnBel6XvVbKupsQ3VnnWy+WSpsqzchfwh4wY6zxfv/tdFWzKDJ
 VWNt/wfZErAEuS7Nsf3Vucf5/A3Gi7bfmzo6nagZ6tdQEWB/NcOCjPCLns/B4l4MuExl
 JeOg==
X-Gm-Message-State: AGi0PuZqzPIYOGfi0SwfJUNEMPsA8D/DL5dCBa4+jinpajbfBKcY83tf
 y6FJB+O2tUa3ui498Up0FS61o5gWIJ0vzHXRMqAjT/GoJDyMUBgjeiDdMWimXIn2gCM8FJzaQPa
 ryWQtJKfbJ8AO5f0=
X-Received: by 2002:a5d:6441:: with SMTP id d1mr2514656wrw.301.1585817352436; 
 Thu, 02 Apr 2020 01:49:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypIxHpTTxem/c5FkCC2hAVRxofsUY0XMiIq2foB0Ob24iY9pqWLzrcVN+vRqax0+vigcw5aMng==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr2514636wrw.301.1585817352191; 
 Thu, 02 Apr 2020 01:49:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1868:42dd:216c:2c09?
 ([2001:b07:6468:f312:1868:42dd:216c:2c09])
 by smtp.gmail.com with ESMTPSA id p10sm6500851wre.15.2020.04.02.01.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 01:49:11 -0700 (PDT)
Subject: Re: Question about scsi device hotplug (e.g scsi-hd)
To: Markus Armbruster <armbru@redhat.com>
References: <7302c0b9f2327b9b61b4adb465f166e339e46ac1.camel@redhat.com>
 <20200401150944.GA4500@stefanha-x1.localdomain>
 <4bc42bf2-939f-f6c4-ea45-0d08eb42fc2b@redhat.com>
 <87zhbubg80.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b59caec6-062d-735d-dc4e-2fc4db57b607@redhat.com>
Date: Thu, 2 Apr 2020 10:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87zhbubg80.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/04/20 07:37, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 01/04/20 17:09, Stefan Hajnoczi wrote:
>>>> What do you think about it?
>>>
>>> Maybe aio_disable_external() is needed to postpone device emulation
>>> until after realize has finished?
>>>
>>> Virtqueue kick ioeventfds are marked "external" and won't be processed
>>> while external events are disabled.  See also
>>> virtio_queue_aio_set_host_notifier_handler() ->
>>> aio_set_event_notifier().
>>
>> Yes, I think Stefan is right.
> 
> Is this issue limited to SCSI devices?

Yes, because they (and more specifically virtio-scsi) are the only ones
that can be processed

1) outside the BQL

2) by a device other than themselves (in this case, by the adapter).

Paolo


