Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7DAC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1922722249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGTTkUG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1922722249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu0r-00045f-2b
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUtzq-0003FG-0V
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUtzo-0003jo-Ba
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603209379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtWvl8nlLkFHzSOYM9skQyMfI3OVf/eTkUnCggWZHxY=;
 b=hGTTkUG0sfO7GClsD/R1uGQBSAlnNCaWC32X58gDSeHHdpOdwnWXpee5X5KVlAaO118qdL
 jKMsn26+vcpdCGtCTeR39byfsRmokSkIHayikIZKMJTpsyQppeiC7MX+i1EKt7nK9fgDYp
 eNNY/spw7vRYbeHGrfB19IdTaK45uvw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-P0hIQncKOIKDXzTVbz3yhA-1; Tue, 20 Oct 2020 11:56:15 -0400
X-MC-Unique: P0hIQncKOIKDXzTVbz3yhA-1
Received: by mail-wr1-f70.google.com with SMTP id v5so1000583wrr.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qtWvl8nlLkFHzSOYM9skQyMfI3OVf/eTkUnCggWZHxY=;
 b=HNNNeAlycFxbtAKqpQIWUspOdiliwYb4idRAK+6CyzvZXUdbolYBy3oDwnOcf2fGKc
 keoGhQmXmD4RC9JTewjmDsLalQYBuPkT1HyjGJBvrQx9qNvTRm5AAj90cC4g0SwNR02W
 mEYzArLqDhgiZ1yENbTsKwe0VhWnc9t/nNV84t6Fwtd5PuX8cpCxV5bKfrhoNoAA/gkW
 gTxAJ1APLKFOLnkrZJZ4fpy84B9lSL/XcjqO+X9WyHhbDsZlnqE2XbZ0yL4Xl5VDrWdw
 +WsWcleLyD/VC+YaDaYF7JUVu5hEy8exLcM05a6BkI/cryAEkA3mrcBeDWQVLwmL1dUx
 1awA==
X-Gm-Message-State: AOAM533ZdVD2nqS7YWR3DPOjm5gZp9B9khA40m1EkhXLq8iu1QxqpfaU
 Qkbw2nJVVgegUYyVYguH+jfUYKM2wGadrazGEE7Kwg0lcBdaAfsX5g2KNUMSU1z+Vte0/AlSsok
 16xUGBgt+63FFa9s=
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr3517474wmb.173.1603209374228; 
 Tue, 20 Oct 2020 08:56:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ1oHO0/ErRe6BrHvDOp0Djk8qGyUpEoeRpvuWcD0LE7DXYf+CtaFbDigXNNungqohOYlmIw==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr3517452wmb.173.1603209374026; 
 Tue, 20 Oct 2020 08:56:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id n9sm3548869wrq.72.2020.10.20.08.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 08:56:11 -0700 (PDT)
Subject: Re: [PATCH v5] sev: add sev-inject-launch-secret
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201015143713.14682-1-tobin@linux.ibm.com>
 <2f1be055-58c8-dcf8-debc-8956636d8ef8@redhat.com>
 <20201020135444.GR5733@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4bc6348-cda5-e7f5-3753-61f4d3ba0116@redhat.com>
Date: Tue, 20 Oct 2020 17:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020135444.GR5733@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, qemu-devel@nongnu.org, dgilbert@redhat.com, tobin@linux.ibm.com,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/10/20 15:54, Eduardo Habkost wrote:
> On Tue, Oct 20, 2020 at 11:03:51AM +0200, Paolo Bonzini wrote:
>> On 15/10/20 16:37, tobin@linux.ibm.com wrote:
>>> -static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
>>> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
>>>  {
>>>      MemoryRegionSection mrs = memory_region_find(get_system_memory(),
>>> -                                                 addr, 1);
>>> +                                                 addr, size);
>>
>> You need to check size against mrs.size and fail if mrs.size is smaller.
>>  Otherwise, the ioctl can access memory out of range.
> 
> Good catch!  I'm dequeuing it.
> 
> Is there a reason memory_region_find() doesn't ensure that by
> default?

IIRC memory_region_find() was used to do DMA in the very first versions
of "virtio-blk dataplane" so you would call it multiple times in a loop.
 So it's like that because it maps the way address_space_map() works.

> The call at virtio_balloon_handle_output() looks suspicious,
> though, because it looks for a BALLOON_PAGE_SIZE range, but
> there's no check for the returned section size.

I think it's not a bug because ultimately it's checked in
ram_block_discard_range, but it's not pretty.

Paolo


