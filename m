Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F75EC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DFC2080A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fecfbgeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DFC2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVEHH-0002Hv-71
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 09:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVEDL-0005ZU-9Q
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVEDI-0004rU-N0
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603287095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTDnNNR+QgubYC3+rAUl/ezF8IHeL8H9H6c3VVfpacE=;
 b=fecfbgeheZBqlInJIQrbuu+F3cj+guk0dxSofGSWFU2w8lc139n0OvQMfBw2drxibJIzOO
 u6n1b6YSzMkNyK2Mf/GdyWc90I4GsPHL26CYG4o3O+Oi51fMB3H+1dNuZLRf/hAU8acfco
 DQCSoxnBIucKCyffO7fBt5d0IGS4J8s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-NHmvipkBNca7SWNqE6UXSA-1; Wed, 21 Oct 2020 09:31:34 -0400
X-MC-Unique: NHmvipkBNca7SWNqE6UXSA-1
Received: by mail-wr1-f72.google.com with SMTP id n14so2700377wrp.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 06:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nTDnNNR+QgubYC3+rAUl/ezF8IHeL8H9H6c3VVfpacE=;
 b=LHdX3CRQqg6Ys2Xu0SRFUIhmrynQOhLNYFnq/UdVSjboAZ0i0yMaJmIAhkoO7nJzkU
 WeSZBSo/9Q/h1PqCwdxMDesG5ZxYJBTGBFQnr6bvHEVWR7AaQWgZLVXFlHbV3un6L9AX
 e6gmWneUob5mCjLgAOa0aPm9p4PE+lwb4FqbuGqFcEnZxLnJGBDb8dqcn6FFbGpTn26d
 cirIoJKhw40Ay+jFqk1FYFkucvPgBxX+mZmCcMnkDImQxNT5Mx5gVwez1wy1CzE0aSgE
 aQBuWwPUWSfa6I9SmNOhqR8+WUffTRuw60LU4tTIs+r7l38yfKGqzCi6R+QZL563/lfs
 SRtw==
X-Gm-Message-State: AOAM533u8s/HhERrjEsfCO9lQr0AvEfEsQlv/3VswlKbSWPjR3bMknHN
 Hxlw0v20lvdKTlCsLGz+CnnrTtDtA6BEyHp7vI+TsEY3ud0e2Ir9afv28Oh1Ac1/XDK5zIri8Zk
 SQj3Ovq57xMKh17c=
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr3560314wmf.67.1603287092898; 
 Wed, 21 Oct 2020 06:31:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycX3GBucqn66q/g99rIjfwVeGw1ExrR38IMiuPg/I3t2wHGjlR6OF3wRFCGbkfDjb35m+0Aw==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr3560284wmf.67.1603287092646; 
 Wed, 21 Oct 2020 06:31:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id u133sm3415268wmb.6.2020.10.21.06.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 06:31:32 -0700 (PDT)
Subject: Re: [PATCH] pc: Implement -no-hpet as sugar for -machine hpet=off
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201020220150.1326086-1-ehabkost@redhat.com>
 <50e184db-bf46-48c1-b3a2-f4151d00cdf6@redhat.com>
 <20201021123920.GS5733@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d8ec809-6764-48cd-75b7-8f4450756849@redhat.com>
Date: Wed, 21 Oct 2020 15:31:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021123920.GS5733@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/20 14:39, Eduardo Habkost wrote:
>> Should this be within #ifdef CONFIG_HPET?  [...]
> Oops, I wasn't aware of CONFIG_HPET

That's just a config-devices.h (aka CONFIG_DEVICES) definition.

> , and hadn't noticed that
> pc_basic_device_init() uses qdev_try_new().  I agree that not
> failing if hpet=on is explicitly set and CONFIG_HPET=n is wrong.
> 
> Supporting a "require hpet to be on" use case would be a new
> feature and out of scope of this work, though.  I will just
> rename the property to "allow-hpet".  We can still implement a
> OnOfAuto "hpet" property in the future, if we think it's useful.

You don't need OnOffAuto; you can just change the qdev_try_new() to
qdev_new() if you default it to true only if CONFIG_HPET is defined.  It
should work properly, defaulting to on/off depending on CONFIG_HPET and
failing if hpet=on is explicitly set with CONFIG_HPET=n.

Paolo


