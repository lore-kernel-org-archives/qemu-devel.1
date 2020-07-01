Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394B8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B5220760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GR1U+oqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B5220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqbh2-0000Ns-Af
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqbfp-0007xo-9u
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:17:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqbfn-0006We-3I
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593605826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDI96EZxNR4lC7QwUWv4Tn9J0H8cVB6sgJeTS716tq4=;
 b=GR1U+oqkwcoZTvP3x/Xn8L468906C7BtBdPxOOTGfB4RxjUBLkaFuBm2VZTPhqdOm36s96
 dQSVg3lDQdkpegP0wISNfQQjtrNHBlfFGapZ2ctFBImsOd6GSKesLjj0moHUXCdWbOow1/
 ykQRe1ipD7ZiPRl/2bqrAHR0FVBrvg4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-sPbHGqGSNCq7zfKJlU4Bdw-1; Wed, 01 Jul 2020 08:17:04 -0400
X-MC-Unique: sPbHGqGSNCq7zfKJlU4Bdw-1
Received: by mail-wr1-f70.google.com with SMTP id i10so20256265wrn.21
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rDI96EZxNR4lC7QwUWv4Tn9J0H8cVB6sgJeTS716tq4=;
 b=tinM19inRbvXFUFeG9DsQccHz17QB9DoF2FkzcCvLS3LgQs2GQNix64QM2nhUTd5nD
 5fPaC5TsfFopMfppcPZWXpDTgPlLNYflROS+wlnXuTvGDbbfaKJFP23ATbd53TJCgyq4
 8BdLq2WyXVZ6ggOAaeISQSz9t2HrfXFV2zm1Gm3OU/ASmtVRDum4m/KIrXtimwQE9mll
 bk+Rue5Te0AA3Ik9wqWzuDios540eE4/W/VH+o4cbKFxz3gTRS909HylYozv39qHht9h
 qBH8X1SmYhRQE159vTpOJCTOLAZxanwK86sZpl/ikiV+yXRrzVKlpf2YNNyt02V83P4B
 5fsw==
X-Gm-Message-State: AOAM530V4TQbxeC756qpux7/oOJMPqAZ3FTj8mVlFGEl9NeVaIXdvCdK
 KmA0sNO1fymVgm5h6n+3byUhKdQSBfI8sjXk4hi5kLsTKOiI30m1OPaJnn72ud/ohQosuz6RPLp
 DUJIYVKbBNoGccO0=
X-Received: by 2002:adf:80c2:: with SMTP id 60mr13179979wrl.388.1593605823367; 
 Wed, 01 Jul 2020 05:17:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZz6L2RsJJye+Lhkp2I4Dzf1SIx0IOMGc9U/XIVtpFMbWopuiyyEWQ5rqB+VOKyzldfLnfJQ==
X-Received: by 2002:adf:80c2:: with SMTP id 60mr13179967wrl.388.1593605823130; 
 Wed, 01 Jul 2020 05:17:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1142:70d6:6b9b:3cd1?
 ([2001:b07:6468:f312:1142:70d6:6b9b:3cd1])
 by smtp.gmail.com with ESMTPSA id w13sm7031136wrr.67.2020.07.01.05.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 05:17:02 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Avoid abort on QMP attempt to add an object with
 duplicate id
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
References: <20200629112329.27611-1-eric.auger@redhat.com>
 <8bd5b010-1c58-1a38-f234-d7669cd72d35@redhat.com>
 <ef7a4ced-d39e-8d78-e289-9d5f5c440a25@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <569e57b3-3d02-db2f-c843-51b9858485df@redhat.com>
Date: Wed, 1 Jul 2020 14:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ef7a4ced-d39e-8d78-e289-9d5f5c440a25@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 08:51, Auger Eric wrote:
>> Very nice.  I see a failure reported by Patchew, I'll look into it as
>> well if you don't have time.
> 
> So "[PATCH v5 0/3] Avoid abort on QMP attempt to add an object with
> duplicate id" seems to have fixed the Patchew error (I decreased the
> size of the memory object downto 1MB).

Great, I queued that one.  Thanks.

Paolo


