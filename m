Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C799820801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVbwIZb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C799820801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjleF-00022P-19
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjlOd-0000kv-BV
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 11:15:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjlOa-0006jB-J4
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 11:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591974902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6KB07jwi2F6z8moct9YY9DDxKzEhWNccWd41dfLnhI=;
 b=aVbwIZb8iI3leLlf4fLrXwJG4W3sHuOZcxogMQk6vdko+IhhlJMU+SOdB0KxHmhvTdlOne
 P2jJzew5TusOVWx1Uz4xEeUu4IeaBsjnUEgBRsAVGxYJfsxhdh215vLWre00hwxoIUc4p+
 6PLtQucB8bxT1sR7fmxSwXLaJ/6jrJ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-EpwVnDoUPkSwMZRAoF34CQ-1; Fri, 12 Jun 2020 11:14:59 -0400
X-MC-Unique: EpwVnDoUPkSwMZRAoF34CQ-1
Received: by mail-wm1-f71.google.com with SMTP id a7so2060152wmf.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 08:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u6KB07jwi2F6z8moct9YY9DDxKzEhWNccWd41dfLnhI=;
 b=Q8thwXbRB3RZGc2tAQoMUfwWVZDfWcRHxyFLJfLLXnOtKtx5pljICNZZsi9gijhXOu
 hMLsdnng93X0vBHGXy5Wioi/7L1F62O64vqyiSCbDhd6rrvl0YZJ8qJG7II/KKXj39GV
 q283Jdf7Iw0fJ6pjIPF9GoEvIQP1fjfFXKXwDqCMn4ScRm3pDPva8aGkEWITCrjHd1kY
 LJrQestNuKyDHhjre4KJVvds7af0sBAq2eNy+RJrmpdysnMQVtgaJ+QvlSCyzzaIFPeA
 I6E/B44XlKSOP4nOiPga/M3R8yKaGQMgw7csdc4Bst9KdDOYdZjNo6G0HSDPCN31qegB
 RzRw==
X-Gm-Message-State: AOAM533QZkVBGHH6nGW7QIPKyK9633gItLiVvOiRUyy5rvEUlLEPDkIl
 rXqZK9UsT1Nse3iTiQZ0Luw4zNeJOrCNvpbyftwEgUFA9Kk6Vk4ra+eyvgovIkL7lzP74ejUG00
 2VAX8erNRx6neeIA=
X-Received: by 2002:adf:fe07:: with SMTP id n7mr15000500wrr.240.1591974897868; 
 Fri, 12 Jun 2020 08:14:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkN9VNZeiQeBxw1l3GOTkUX2c3Q0x4xerY/1ChgmyVJ4erR6D1/wqAEhbTsA9XH4sJddYNYw==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr15000472wrr.240.1591974897518; 
 Fri, 12 Jun 2020 08:14:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d?
 ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
 by smtp.gmail.com with ESMTPSA id g18sm9981640wme.17.2020.06.12.08.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2020 08:14:56 -0700 (PDT)
Subject: Re: [PULL 000/115] Huge miscellaneous pull request for 2020-06-11
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
 <CAFEAcA-qrxBdn5aA0kaituroTX8c1yFGdRux0_X1Y+W5_s-WHA@mail.gmail.com>
 <6e1f1fa5-2a23-b586-a3b4-1394c82794d7@redhat.com>
 <20200612145357.GC76007@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fcffbb56-37d4-c575-171c-4915927af4b7@redhat.com>
Date: Fri, 12 Jun 2020 17:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200612145357.GC76007@SPB-NB-133.local>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Joseph S. Myers" <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/20 16:53, Roman Bolshakov wrote:
> It seems rebase is not needed. The queue doesn't include the patch:
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08076.html

Thanks, it had a conflict with

commit f291cf54148e5b9e51c55b9056e4be546492a9ca
Author: Philippe Mathieu-Daudé <philmd@redhat.com>
Date:   Tue May 26 19:24:23 2020 +0200

    sysemu/hvf: Only declare hvf_allowed when HVF is available

    When HVF is not available, the hvf_allowed variable does not exist.

    Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
    Reviewed-by: Cornelia Huck <cohuck@redhat.com>
    Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
    Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
    Message-Id: <20200526172427.17460-4-f4bug@amsat.org>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

but I've fixed it up now.  (It wasn't clear from the commit message that
this patch could not simply be dropped.  Unfortunately I didn't have an
OS X installation to test it).

Paolo


