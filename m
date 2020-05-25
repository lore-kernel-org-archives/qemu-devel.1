Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3672CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AA520723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiakjC+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AA520723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdAEt-00017P-6d
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdAEG-0000GN-8E
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:21:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdAEF-0006eE-E0
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590402066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIVIQtHHWl3AqmrSkaX/ggl/96ej6sUyR59zBaRflW8=;
 b=ZiakjC+z3lDK42TkBQzEVXXLgChzBBLG+NM/M8/6DnLa42bwG3pLE9UiPCF/PJM3PTyNZ0
 EOBjdglrqDhpxIocdfIhPwidJvOaX8CV2vHAOBD5a7cdIFT8qIw48I7xop8Cl/2R8CIyhf
 uUYKfgcZZK2cBxKQ0B6vjuri8YDMA0c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-vLNGGiqvOMWKUppKnv9Rjg-1; Mon, 25 May 2020 06:21:01 -0400
X-MC-Unique: vLNGGiqvOMWKUppKnv9Rjg-1
Received: by mail-ej1-f72.google.com with SMTP id t4so4084457ejj.12
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 03:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mIVIQtHHWl3AqmrSkaX/ggl/96ej6sUyR59zBaRflW8=;
 b=bCA9rOd2CvQd35CGyWWjcuhFQjSCtA7D5G/GC6LKh1cI4q7fXuKLdhLRqCl1QdGbDR
 H6YAuRWRR8wNYvqHkOyUNmYg4RZFQV8WU/A34lKcRmvlCidYww6rlHd+be5rdr1QSlyg
 0q5IuECfzLto173syNX7T6hgcHrOOjsgmWraWOQuWzM256Aag5phF4ov86LHGwIhlXen
 CAQDGw/8xPPJcPIT/BXSxx2S3I3hvs92122rjIEonfNhws/HSOCgiUIGZ4gFIv+euUq4
 oSkTiweiiLkmdRWLueIGSD3QTZrdg64jpCduHmpV03Y4tfUnG9uSvppOI+78gQq3fOts
 MlfA==
X-Gm-Message-State: AOAM532K+EnAcbWp5RGwi4FeSl6qw8KLkzzVJ+5bSEHYBgGPoyzQg0Ct
 VtYSA7KYqNEnHoWDYuMlk9Dtv1oMwB/4i8IsndMuG5WCM81di65wFm+6SpVsEgjvkCtQaVheBPB
 OmynqsLQruhCzX+s=
X-Received: by 2002:a50:f0ce:: with SMTP id a14mr14666806edm.131.1590402059922; 
 Mon, 25 May 2020 03:20:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbYH8vLVwWrPxq7sKFs5VTj4MK7Us6zxg398BcHJMhS15eURrmoSwt71UC5pfde0NCbwQNEw==
X-Received: by 2002:a50:f0ce:: with SMTP id a14mr14666797edm.131.1590402059746; 
 Mon, 25 May 2020 03:20:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id lr21sm15075638ejb.117.2020.05.25.03.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 03:20:59 -0700 (PDT)
Subject: Re: [PATCH] cpus: Fix botched configure_icount() error API violation
 fix
To: Markus Armbruster <armbru@redhat.com>
References: <20200508104933.19051-1-armbru@redhat.com>
 <28c289f3-eb3f-eb1a-f79b-b339437bef8a@redhat.com>
 <87d06sh8m1.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13c9c546-bc43-ce46-e6c3-5e4625d23714@redhat.com>
Date: Mon, 25 May 2020 12:21:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87d06sh8m1.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/05/20 07:44, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 08/05/20 12:49, Markus Armbruster wrote:
>>> Fixes: abc9bf69a66a11499a801ff545b8fe7adbb3a04c
>>> Fixes: Coverity CID 1428754
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  cpus.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/cpus.c b/cpus.c
>>> index 5670c96bcf..b9275c672d 100644
>>> --- a/cpus.c
>>> +++ b/cpus.c
>>> @@ -813,7 +813,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
>>>          return;
>>>      }
>>>  
>>> -    if (strcmp(option, "auto") != 0) {
>>> +    if (option && !strcmp(option, "auto")) {
>>>          if (qemu_strtol(option, NULL, 0, &time_shift) < 0
>>>              || time_shift < 0 || time_shift > MAX_ICOUNT_SHIFT) {
>>>              error_setg(errp, "icount: Invalid shift value");
>>>
>>
>> Queued, thanks.
> 
> This one's wrong, please queue v2 instead.
> 

Yep, got there already.  Thanks!

Paolo


