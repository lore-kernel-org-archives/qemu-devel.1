Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5999FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B2920721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8+geawr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B2920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jegIj-0000N2-7H
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jegHq-0008GM-Jm
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:47:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jegHp-0002n0-GF
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590763624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obT1MOI0lZy6t1FwwaQ7MwLpbPt8R+x/rGC/lszSaUY=;
 b=f8+geawr9jtw3JwERjjJ8jmx2MkUJ1wXurdBw4upPPoWWTXktxs99EmhYZYTKMwlqydTRT
 8QzRrWD/xVr0qn9YVo9u3HqIQU5cg4kBaRWxoRuXjiV3s6+lgi8zp7nzSji8l79esXSWoj
 7WsKX9P8tIteQ/FjOs2HhkepKef7K88=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-vUs1S0dWM5S4AONZwKVNCw-1; Fri, 29 May 2020 10:47:01 -0400
X-MC-Unique: vUs1S0dWM5S4AONZwKVNCw-1
Received: by mail-wr1-f70.google.com with SMTP id w16so1127086wru.18
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 07:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=obT1MOI0lZy6t1FwwaQ7MwLpbPt8R+x/rGC/lszSaUY=;
 b=FzDRVg0QlZRPd/bG7Su310H1PFgJ3QhgkLcGEdLYwXcgbrrr9NK2zJ+un52Y7CGU7O
 7tDObmMqEjh+byLOqvKXkHalooHEqfWHuOh9+CAO9+LuEnOkTWLA4QpYflPpQz/eFdQa
 ViVluNStFrZ4VxBXNyRv0CCovRtoX5kHWHfRwTI3NjGt5RvZG1gPAsHsNCQ4B4Yh8sb3
 96ejddDhggm2MqKTASGbT6ySp54HF2DArQpMWUpB4MDEKGC+JSXguJiBREZLP96lSI7b
 J1Ftgw8NgLnkJHwaUOc1OiYEn+ZVSwFG8Cd5BxA5bFBrRT4Ri5JE7hQGMHgrY/zVuKq0
 I2Rw==
X-Gm-Message-State: AOAM531Gn5z7HnKS7Lda6xPJ+dXO/JBpdcOThFUX9kw164fluejoAmyg
 EFaySTB93qxULG48sP+nDHtYh335t354TqvHo4OQj/kDyUXA+fw/kDtEKl2Y5lKfp/uFeCxOJqQ
 5YZEQR8QpBlaGtt4=
X-Received: by 2002:a05:6000:1c8:: with SMTP id
 t8mr8911064wrx.200.1590763620452; 
 Fri, 29 May 2020 07:47:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVm4ITyiOJB2tH2k4oRyuY8Lop9nBxqHVUqWLY1HfkusnLc2SEZglvdSr360a9ZxS4NA8kqg==
X-Received: by 2002:a05:6000:1c8:: with SMTP id
 t8mr8911042wrx.200.1590763620251; 
 Fri, 29 May 2020 07:47:00 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.89])
 by smtp.gmail.com with ESMTPSA id s8sm9908750wrt.69.2020.05.29.07.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 07:46:59 -0700 (PDT)
Subject: Re: [PATCH] memory: Make 'info mtree' not display disabled regions by
 default
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20200529125325.11916-1-philmd@redhat.com>
 <20200529143436.GA1374520@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b140ccb6-a1e6-6b06-27ff-1783ac37d91e@redhat.com>
Date: Fri, 29 May 2020 16:46:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200529143436.GA1374520@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/05/20 16:34, Peter Xu wrote:
> On Fri, May 29, 2020 at 02:53:25PM +0200, Philippe Mathieu-Daudé wrote:
>> @@ -2920,35 +2916,46 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>>              ml->mr = mr->alias;
>>              QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
>>          }
>> -        qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
>> -                    " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
>> -                    "-" TARGET_FMT_plx "%s",
>> -                    cur_start, cur_end,
>> -                    mr->priority,
>> -                    mr->nonvolatile ? "nv-" : "",
>> -                    memory_region_type((MemoryRegion *)mr),
>> -                    memory_region_name(mr),
>> -                    memory_region_name(mr->alias),
>> -                    mr->alias_offset,
>> -                    mr->alias_offset + MR_SIZE(mr->size),
>> -                    mr->enabled ? "" : " [disabled]");
>> -        if (owner) {
>> -            mtree_print_mr_owner(mr);
>> +        if (mr->enabled || display_disabled) {
>> +            for (i = 0; i < level; i++) {
>> +                qemu_printf(MTREE_INDENT);
>> +            }
>> +            qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
>> +                        " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
>> +                        "-" TARGET_FMT_plx "%s",
>> +                        cur_start, cur_end,
>> +                        mr->priority,
>> +                        mr->nonvolatile ? "nv-" : "",
>> +                        memory_region_type((MemoryRegion *)mr),
>> +                        memory_region_name(mr),
>> +                        memory_region_name(mr->alias),
>> +                        mr->alias_offset,
>> +                        mr->alias_offset + MR_SIZE(mr->size),
>> +                        mr->enabled ? "" : " [disabled]");
>> +            if (owner) {
>> +                mtree_print_mr_owner(mr);
>> +            }
> 
> It'll not only change the default output for "info mtree", but also "-o" too
> because disabled regions won't be dumped any more.  Not sure whether it's
> expected - just raise this question up, because I mostly only use "-f"..

I think it's the right behavior.  Queued, thanks.

Paolo


