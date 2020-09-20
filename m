Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D2FC43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 12:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A57920796
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 12:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KICPi75V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A57920796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJyBp-0001w7-3e
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 08:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJyAU-0001Nn-IH
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 08:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJyAR-0002sj-T8
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 08:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600603806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fvZsjZLj5FO+AzTfbS3ye5pbyZviuwwq9BZdwHAwoI=;
 b=KICPi75VyFpy8Tb/ylhDmYTTgerXY591LMez3KX6oEQXJ14WYEw8YzYNuoNNP+LamiXMPP
 PPojfY4beMWAnvCno0Y4zIExKAqNxL0rja8FcshICjulFGrRb3JsUs5akcX/JGkkKddxaY
 VEuR4/SP34mlmK3ZeYD3zOHLDjjLEAE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-NxM-6ZZ1OIOPKucae9wliA-1; Sun, 20 Sep 2020 08:10:04 -0400
X-MC-Unique: NxM-6ZZ1OIOPKucae9wliA-1
Received: by mail-wr1-f70.google.com with SMTP id v5so4494368wrs.17
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 05:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6fvZsjZLj5FO+AzTfbS3ye5pbyZviuwwq9BZdwHAwoI=;
 b=qHhUP2Zm1BBaaBx9ZqiCz8XKUqCaJZW3iLkfwx8gjiAcL9Twa42AaeepXUkdn6BXfd
 A53TKxnGLWj9CTAOLUuh/UR9EhbzbTPHy+FsoKSP27BcBAcWAq8UE+5GGiDC8L8GGTYY
 GIh+er/skTLbva1+cFs+Mm2O0BJkuqNFbvwjceGHJr7VoRRBxyKvjQHEZTuP1HtYuRAV
 AE2Lis9aFARchYVQXRKegEHH4mMiZ/AZu5B+jtFRWoBtjfgcUs63wzDOJKX1WCEIUUds
 sOeMWTcqj5n4RfnE+BgjwnoZxeqSxrJSjKLlzxpGe+EiW3/J9Kd7gKGMAVApIfCGWFKq
 N5pQ==
X-Gm-Message-State: AOAM531A2x0tJiF032j5x/C2MyBH562vKdBjKgLP2KzQTONHYxYHfISC
 bAZN1mGkBLtfPyiqt6imoiB0rDkaBREVawKlPKY7TfJ8g7DeXaz+nCPPA9re8gxax1WoAM9DvIZ
 3Lwg4qG3X7vVIg/I=
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr7472332wmh.93.1600603803362;
 Sun, 20 Sep 2020 05:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaJdYk4LY+/bx3gAd/KNLbGGzSCyS8kvkLuko6WHOi2lOP91MCuEOkMDCsxn3fke8O1Y9n3Q==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr7472314wmh.93.1600603803116;
 Sun, 20 Sep 2020 05:10:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:458b:b280:cf0:4acf?
 ([2001:b07:6468:f312:458b:b280:cf0:4acf])
 by smtp.gmail.com with ESMTPSA id 91sm16213634wrq.9.2020.09.20.05.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 05:10:02 -0700 (PDT)
Subject: Re: [PATCH] smp: drop support for deprecated (invalid topologies)
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20200911133202.938754-1-imammedo@redhat.com>
 <20200911110407-mutt-send-email-mst@kernel.org>
 <20200914093720.6c3583c7@redhat.com> <20200918205742.GB8041@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a023af0-72b2-0e6e-b3cc-24e4f71c5aa8@redhat.com>
Date: Sun, 20 Sep 2020 14:10:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918205742.GB8041@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 07:54:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: libvir-list@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 22:57, Eduardo Habkost wrote:
> On Mon, Sep 14, 2020 at 09:37:20AM +0200, Igor Mammedov wrote:
>> On Fri, 11 Sep 2020 11:04:47 -0400
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Fri, Sep 11, 2020 at 09:32:02AM -0400, Igor Mammedov wrote:
>>>> it's was deprecated since 3.1
>>>>
>>>> Support for invalid topologies is removed, the user must ensure
>>>> that topologies described with -smp include all possible cpus,
>>>> i.e. (sockets * cores * threads) == maxcpus or QEMU will
>>>> exit with error.
>>>>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
>>>
>>> Acked-by: 
>>>
>>> memory tree I guess?
>>
>> It would be better for Paolo to take it since he has
>> queued numa deprecations, due to context confilict in
>> deprecated.rst.
>>
>> Paolo,
>> can you queue this patch as well?
> 
> I'm queueing this in machine-next (sorry for not noticing it
> before I sent today's pull request).

It's not part of my pending pull request, so whoever comes second will
drop the patch.

Paolo


