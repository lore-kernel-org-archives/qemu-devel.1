Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5F4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA222076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="In8R++Ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA222076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiFWu-0001Gu-3f
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 07:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jiFVV-0000oM-Oo
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:59:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24167
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jiFVV-0005pP-2n
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591613995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRjrP0qzXMKFZl/S3aoIMD0vNRgGdXVCiZ6uxB8HkPw=;
 b=In8R++WwDnHEv9ppCrKKFLhnaOnU4m4fQgC3BReJL6j4uvdDAwkEkmazfyIezlEnPw7loj
 vTo0/00UACuwYRGWcf4bzB7bFxSI7twTJNuIDkHCFPY7saa0UCSaDOTQq2lim71sMur+OZ
 L6aqOEHHw2tVEYzbArRzr3SrTgTlVDs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-T-2TAMzbMdysLIwuTGdKFA-1; Mon, 08 Jun 2020 06:59:54 -0400
X-MC-Unique: T-2TAMzbMdysLIwuTGdKFA-1
Received: by mail-wm1-f69.google.com with SMTP id p24so5120639wmc.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pRjrP0qzXMKFZl/S3aoIMD0vNRgGdXVCiZ6uxB8HkPw=;
 b=oR3PawbI5IPzzN3xzLUn7mMwOzzKF0ZdgOayDKY2ZoWrHFDs1gsOobitev3PEE0/Ek
 JYc3jwZZfqFWg14xiF6wvjN/Yvd9EQv+HL8TYBO2njfBXWOEoS/wqI2o2T7eRU8ybPKS
 RqocDB4ZC+e1QEinhwMGBOclZODKQieGf++dgHXa9VUmDlMC4h7zCAQLbKERSkNdxN3X
 kym11tNsOp0uwd0mEtlMgUWA3vS4QNwdmQT9+VF10G65QopGzGjxCKdzwQoiEIrb/rCr
 mIRqWXXa+lLgOCPuOmDxpIz3cTL5TqrwujMymAp6mcnVymWeGgv2hFtcPCFPHE9Ksz1y
 hm3A==
X-Gm-Message-State: AOAM532KBqdSsaJkcRwk/KFTxLQ/fZfsO3yzJ31kwl+ArqVSak2r3rda
 7m8FcNskLTB7+KmUvjYLdD7P8hlRyGnVWSCSu684uRJDyKwF4somvK/TcIUYTADrziGV6IzsddB
 Btzgc3hYdS/+eOiw=
X-Received: by 2002:adf:a350:: with SMTP id d16mr23708092wrb.237.1591613993094; 
 Mon, 08 Jun 2020 03:59:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM7kuWFBkElNiu0kfqrAHdL+Unn1lvZYzSJp90BZaqoX17NojaGsXhYTnCzZEnVgLbTp9ayw==
X-Received: by 2002:adf:a350:: with SMTP id d16mr23708072wrb.237.1591613992911; 
 Mon, 08 Jun 2020 03:59:52 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.87.23])
 by smtp.gmail.com with ESMTPSA id t188sm17837981wmt.27.2020.06.08.03.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 03:59:52 -0700 (PDT)
Subject: Re: [PATCH 00/55] qdev: Rework how we plug into the parent bus
To: Markus Armbruster <armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
 <5f7c749a-ccbe-5ff6-3889-696d5de05fc0@redhat.com>
 <878sgxvn9q.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8393f947-6573-cfce-4f63-9c027ab7ff04@redhat.com>
Date: Mon, 8 Jun 2020 12:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <878sgxvn9q.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/06/20 12:56, Markus Armbruster wrote:
>> Great stuff, I only had some comments on the commit messages.  I still
>> have to review patches 47 and 48 more corefully.
> Does this translate into any Reviewed-bys?  On v2, maybe?
> 

Yes, please add my Reviewed-by on v2.

Paolo


