Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F6E20885
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvGT6SQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F6E20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlur6-00059H-02
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jluhQ-0005cg-3d
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:35:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32518
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jluhN-0008JL-Ph
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592487320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLfFWWN786UTNglIQiVmrgn3+v9wpuJECNM2po67mSo=;
 b=SvGT6SQph6GVo7+ChZmCwreA38cqvnI7TydLPQc8FcB+V70+STsi1oTgOrWoD3wC/LV1nr
 +AaUQvgKAiACVW+0ivD1mukK1Pz8YUndo+r0qMnD2rHiR7f+G4A4jmEgxAdLAGzeEgAgyW
 4OZ6ZGwLY7orGO+9YE9+oVuI1+BVamY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-_y-85SouP3OZMj2N_sc1cA-1; Thu, 18 Jun 2020 09:35:19 -0400
X-MC-Unique: _y-85SouP3OZMj2N_sc1cA-1
Received: by mail-wm1-f71.google.com with SMTP id r1so2590721wmh.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 06:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aLfFWWN786UTNglIQiVmrgn3+v9wpuJECNM2po67mSo=;
 b=Mmualw3LQXf23an6ODwsvkQpGCcLYAsyEBZTZl3JFsu5ymocb+9p3INp0gzy3PI4rf
 mger0gWB5N7FwAXKhYTIj4RTicWIU5zyWMU2kHRrJXA14nZ6Hi132XIrpo9TS2wO8Mi6
 06x0Te6RsKAS8fGbHtOGtY9A+Nw4HxfB6J2WGmGLr/m/TLEyzCww3Zb6gw71b0jBYaVM
 UIPtoexFq2rMHKtcVDwWfJQ5TeVioCP6LQXNVxO5Am+hVIXV3Zbt5a9KvXVC7QK+j++o
 mCZtG5LmlZEPsxSiWTGk8+FBkkxB0jZ8dSO33BAoKqY67Pgah0Kf0bLn+puA3wxq2HEw
 lCUw==
X-Gm-Message-State: AOAM532CqctCu+ceFC0y3dCTi56EAvlhP4eWaD6un5IdyDIJOGbuHWAc
 YQM3Gj5dIj2jmOW42s6Tw1LR2ayUPNP2apSX87yTgZw3Gpnolw4RW3HN5FuLMea5+o5lZ3Skz4t
 f57etSwPLbF/M+38=
X-Received: by 2002:adf:e782:: with SMTP id n2mr4536586wrm.417.1592487318012; 
 Thu, 18 Jun 2020 06:35:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzke9/QOSpZW4+85a3TVRyoYXZmMZdPZKXwkgZ5qvG+1Ceu7D0MQvrZWgqgjV7D1PCYk/MHkA==
X-Received: by 2002:adf:e782:: with SMTP id n2mr4536563wrm.417.1592487317780; 
 Thu, 18 Jun 2020 06:35:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id b187sm3633299wmd.26.2020.06.18.06.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 06:35:16 -0700 (PDT)
Subject: Re: [PATCH v1] memory: assert MemoryRegionOps callbacks are defined
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 P J P <ppandit@redhat.com>
References: <20200618121218.215808-1-ppandit@redhat.com>
 <87r1ucv7pe.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51f137f0-89ee-e130-a43e-c82d0b3623fa@redhat.com>
Date: Thu, 18 Jun 2020 15:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87r1ucv7pe.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
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
 Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/06/20 15:12, Alex Bennée wrote:
>>
>> @@ -1495,6 +1495,9 @@ void memory_region_init_io(MemoryRegion *mr,
>>                             const char *name,
>>                             uint64_t size)
>>  {
>> +    assert(ops);
>> +    assert(ops->read);
>> +    assert(ops->write);
> 
> If you look at memory_region_dispatch_write you can see that
> mr->ops->write being empty is acceptable because it implies
> mr->ops->write_with_attrs is set instead. I think the same is true for
> read so I think you need something more like:
> 
>      assert(ops->read || ops->read_with_attrs);
>      assert(ops->write || ops->write_with_attrs);

Also, !ops is acceptable since you have a couple lines below:

    mr->ops = ops ? ops : &unassigned_mem_ops;


>> +    assert(ops->read);
>> +    assert(ops->write);
> 
> Do ROM devices need a ->write function?

Yes, ROMD regions are treated as I/O regions for writes.  However they
don't need a read function.

> Also doesn't this break a load of running stuff without fixes for all
> the various missing bits? How far does make check-acceptance get?

This might actually be really close with the above assertions fixed.
For example, commit 08565552f7 ("cputlb: Move NOTDIRTY handling from I/O
path to TLB path", 2019-09-25) got rid of io_mem_notdirty.

The only cases I found with "git grep" are:

- tz_ppc_dummy_ops which is broken and should just use NULL ops

- hw/nvram/nrf51_nvm.c's flash_ops which is fixed if ROMD regions are
changed not to require a read callback.

- designware_pci_host_msi_ops which is broken and should have a dummy
read callback.

Needless to say, this is something that the submitter should have done,
not the reviewer.

Paolo


