Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C52C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6990A22D3E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5tdFgF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6990A22D3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Yz5-0001cd-5r
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 02:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3Yxn-0001A7-Mr
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 02:01:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3Yxl-0007pu-IK
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 02:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596693672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2i7owJrGSoSu6Yueyw4/OyGO3Epd55Z/GxShxQhIabY=;
 b=V5tdFgF8yzdIkx+U/RkNR0qx4U88ybXnN0A9irJIz/zfQD/tni+/px5BYjn8hWrt9Re06f
 zEuxXBKaMOt9ng0vDK+cPyGFLyeqNWFQg9V1L/OekzjIMpdEipFLYIee5vQ/WktiUr60lp
 H/rkH5Lvea8BXZSwFsXDk1Nee76iOCw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-DgMm1vmCO_6PMfiSukefAQ-1; Thu, 06 Aug 2020 02:01:10 -0400
X-MC-Unique: DgMm1vmCO_6PMfiSukefAQ-1
Received: by mail-wr1-f69.google.com with SMTP id r29so9998604wrr.10
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 23:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2i7owJrGSoSu6Yueyw4/OyGO3Epd55Z/GxShxQhIabY=;
 b=VedZZlIMnu+NzfKGTTlU+IlsgfCx1efKxvP5nHbfwzX6j0yEsaa8lFvpcEGEKZ0n2j
 NY2TsmIrk11HV+8Mhv8RTUCKpfRSChEsGVzExGM33nwaBZWUev5TAFD44Khd+acseLpY
 d/DoBdzjuswtd9/ZwrV5+VW0teVZMuAlpgwVuQuhQNxjZwGWCVxUv1sh4LSrNciubDHb
 5QxypRiMTneh1oc5/zzeMgSAaUPj9CIZaGM20U9EYV5aqYS0UgSkZ+qx/nUeDVYNILma
 5vCbaNt4EhlGMzxItcXs8yAv8VQwbP6UxqFfk9QOzAzFhJ7UGGxZd6/kLHWTOqpn3XJf
 NjCQ==
X-Gm-Message-State: AOAM531470dZz/h/N+gA8iLxs5obXJWuNz3yeqyH0oZbD4BA5KwIontd
 wzsv3Dr2CLpwImfN5VvBNJbtCOeQwxMsUJ2cwqqyGI1NW/Aq8qYyI7GfrrBTY8QjKO+yF3F2OwN
 rOEHS9KMq6c6JKpQ=
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr5530094wrr.48.1596693669235; 
 Wed, 05 Aug 2020 23:01:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcJ7GiPqIAPFZvV+npNE7ck548Oqj/+ChYpe2zB/AGRmE54GlN8hI3XIoYN4ztRw+Gzv7G7Q==
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr5530059wrr.48.1596693668915; 
 Wed, 05 Aug 2020 23:01:08 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id w1sm5265836wmc.18.2020.08.05.23.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 23:01:08 -0700 (PDT)
Date: Thu, 6 Aug 2020 02:01:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [PATCH v5 0/2] add new options to set smbios type 4 fields
Message-ID: <20200806020034-mutt-send-email-mst@kernel.org>
References: <20200806035634.376-1-fangying1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200806035634.376-1-fangying1@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 11:56:32AM +0800, Ying Fang wrote:
> From: fangying <fangying1@huawei.com>
> 
> Hi, this patchset was previously posted by my teamate Heyi Guo several
> months ago, however we missed the merge window. It is reposted here to
> make it an end. Thanks.


Thanks, I will tag it for after the release.
Pls ping me after the release to make sure I don't drop it by mistake.

> Patch description:
>  
> Common VM users sometimes care about CPU speed, so we add two new
> options to allow VM vendors to present CPU speed to their users.
> Normally these information can be fetched from host smbios.
> 
> Strictly speaking, the "max speed" and "current speed" in type 4
> are not really for the max speed and current speed of processor, for
> "max speed" identifies a capability of the system, and "current speed"
> identifies the processor's speed at boot (see smbios spec), but some
> applications do not tell the differences.
> 
> Changelog:
> 
> v4 -> v5:
> - Rebase patch for lastest upstream
> 
> v3 -> v4:
> - Fix the default value when not specifying "-smbios type=4" option;
> it would be 0 instead of 2000 in previous versions
> - Use uint64_t type to check value overflow
> - Add test case to check smbios type 4 CPU speed
> - v4 https://patchwork.kernel.org/cover/11444635/
> 
> v2 -> v3:
> - Refine comments per Igor's suggestion.
> 
> v1 -> v2:
> - change "_" in option names to "-"
> - check if option value is too large to fit in SMBIOS type 4 speed
> fields.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> 
> Ying Fang (2):
>   hw/smbios: add options for type 4 max-speed and current-speed
>   tests/bios-tables-test: add smbios cpu speed test
> 
>  hw/smbios/smbios.c       | 36 ++++++++++++++++++++++++++++++----
>  qemu-options.hx          |  2 +-
>  tests/bios-tables-test.c | 42 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+), 5 deletions(-)
> 
> -- 
> 2.23.0


