Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E82DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4415F2087C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAAnrUzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4415F2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ZM9-0006Na-E0
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1ZLJ-0005tN-Tg
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:01:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1ZLH-00038F-7E
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596218474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sn28enFnpLd3/JdhPHHStBRRimvlVA926SS7iVz1HnM=;
 b=MAAnrUzhEZo6vWDvEBrpzFPMSWiaPDpxzqgLUiLDWwV9U7i/RRRtROgVBDHHozzi1fFZtj
 RTVIAhHDlkpjxQeJkmBV5DfOVlP81Kp4T6A8ui0Kp5ccHM6AeUCiN7pDgZX+EdOBphUyKP
 bvELhrhFSfwGF5UGvBDJmRYSOMyj8Wo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-O9AiD3MaOcqBP9sg4Yz_gw-1; Fri, 31 Jul 2020 14:01:12 -0400
X-MC-Unique: O9AiD3MaOcqBP9sg4Yz_gw-1
Received: by mail-wr1-f69.google.com with SMTP id t12so9522130wrp.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 11:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sn28enFnpLd3/JdhPHHStBRRimvlVA926SS7iVz1HnM=;
 b=L4d0Ny5ZbEbqhba7vlh3OhCQQmlaubH56RMs5/PUQupr5fAouDJt8BWgsV5OKiE63v
 nugNZgxYF8XZqgofXzWu3vFav8VP7M3xUBTI6LGg2/snpPAsl+HOtVz8pp38Qf5cI1ZX
 A3wO88k1HOTzWsgpdtP1kOKYqaIFAhxVRVWe2kbGpE/YkfcjY62WPRJ+S5XjHrYLit+G
 eF4FTcobhCiUq6M2PUjCyeNobtbIrgVbImnLb44V3IH1i8Mj9xMkNXi445e+EMAT31FR
 tXG1KaqRLKUgV1+GKNm6kAM6xeWX2K+1CpeBJkdK1QuERqGO47qHd5JTR+Tt70wF3ohJ
 Thgw==
X-Gm-Message-State: AOAM5307IAbCLd59S0jqcw0g5wOW2wt+4BfBJrUeAiBlM5SXTYYGmkji
 OFA4Is3GQuYRt0g5VqHFoRjMUDO70gMeJr33QRzE5e9AGGSikq+hOXJnsJHwhoYfTl8FCuJ0Qry
 kcm/dURIZalQIiew=
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr4411059wro.24.1596218471284; 
 Fri, 31 Jul 2020 11:01:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJcsGjLe1KnHVbPfLEOzNRVu5X/wCY85mDS1udRC9viMZ4ZY/8pDT+RAqEiGmYwFyqVjdqmw==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr4411018wro.24.1596218470914; 
 Fri, 31 Jul 2020 11:01:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445?
 ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
 by smtp.gmail.com with ESMTPSA id e5sm15422074wrc.37.2020.07.31.11.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 11:01:10 -0700 (PDT)
Subject: Re: [PATCH] schemas: Add vim modeline
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <6ceef1ab-5078-d77e-6e6c-4e1bfc01418a@redhat.com>
 <bb0f4298-414c-6b89-c9c2-7c9d86541daf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a304b5ed-8dba-5ac0-a264-fa8ca1487cb5@redhat.com>
Date: Fri, 31 Jul 2020 20:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bb0f4298-414c-6b89-c9c2-7c9d86541daf@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:39:31
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/20 19:53, John Snow wrote:
> You have misunderstood me.
> 
> The critique I am relaying, but not raising, is that we already use a
> custom JSON parser in two or more places, and so replacing one instance
> of this with a new format actually complicates QEMU instead of
> simplifies it.
> 
> I disagree with this concern on the premise that moving one non-standard
> JSON usage to a standard usage is a win because it reduces the total
> number of instances of proprietary formats.
> 
> Further, if we remove ALL instances of proprietary JSON, then we're back
> to the same level of complexity internally, but with a reduced level of
> complexity for outside observers.

I think we should first build a consensus on using "real" JSON (plus
Javascript comments) for the schema, which is easy, and then somebody
can try his hands at removing the custom JSON parser.

I wouldn't conflate the QMP and schema parsers.  For example, QMP does
not need comments and schemas don't need either bigints or printf-style
% interpolation.

Paolo


