Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ADFC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75521206DC
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5CBobAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75521206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkAv-0008Vm-5o
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHk7X-00067e-SZ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHk7W-00052W-74
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EzecsJg9Fh3dS8x+TkglzzQYkiZ0FE7OMxFGe/ALsZw=;
 b=d5CBobAot4P6O7jsO3RG0ZXweZuiMCcJ70sh1iAEEH8UwkKBe9nSJpBVHQwiIP43HpWmhF
 1gzzXoFNM04Tj6NU+Y9hBwJxqE5XyU0Zw/LegIDhTHzCp5DiYzY1lZrT0tEP95hKZrUmyt
 vQBpRf33UzSIHVgkBMDLZW3bd1yy+Gk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-AtSSKz9LMnK2iGvX0euiEQ-1; Mon, 14 Sep 2020 04:45:47 -0400
X-MC-Unique: AtSSKz9LMnK2iGvX0euiEQ-1
Received: by mail-ed1-f72.google.com with SMTP id d27so8940672edj.21
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 01:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EzecsJg9Fh3dS8x+TkglzzQYkiZ0FE7OMxFGe/ALsZw=;
 b=ln14vz6kUjfHz6zOftb5zET6ReEhw0r3IbnfV4u2KYTxndJ7Qwbjji4Wocr5lsQ9D8
 TGtmPRktn23gyyeW5YzXPQxp/2WvvSTtBMnaHrHhGiggojzNR74Pqd/TxY8SygH9E2Ix
 xLIh5XidzoGLFSWI1M1bMxqGg22/VBgIKGzdGOCJdamiK3x8XY7B3s1fohIvWuHlok3v
 6qY0lCgnda6G1Yb3mS0qmss9Q2hiE9wrrdr2HLBnjVTx6+US+5wM6/Np6+Mupr7lGKfe
 XEDUDgheWIT38s56Xkw18WPDjioBro1vVss+k85CVNwGAvkCEfOPmA/wFRydtVMmnx3k
 CoNA==
X-Gm-Message-State: AOAM532zzy4yRQBbNtPkKuDg07hFfvoR3OxCYsv3EsKWik02XlJLbjzp
 /RdHQZoamL228k1JNwXmBPBKmv9rlrIziG53Gnz3ZdJCNZHwoPOVuD3+7rKrr66GXFoSns0DouM
 fZQj+2ooXARcBUWQ=
X-Received: by 2002:a17:906:6411:: with SMTP id
 d17mr13335749ejm.93.1600073145952; 
 Mon, 14 Sep 2020 01:45:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHz0kkyNkT95NHsn/ybR1vmhj/UDXS51tu2jGF0lArEdkdEMmwcVWD3HRAJ25aKKYAv4QfAQ==
X-Received: by 2002:a17:906:6411:: with SMTP id
 d17mr13335726ejm.93.1600073145687; 
 Mon, 14 Sep 2020 01:45:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d245:909d:fc9e:f86b?
 ([2001:b07:6468:f312:d245:909d:fc9e:f86b])
 by smtp.gmail.com with ESMTPSA id l10sm8712699edr.12.2020.09.14.01.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 01:45:45 -0700 (PDT)
Subject: Re: [PATCH v8 27/27] Revert "configure: add --ninja option"
To: luoyonggang@gmail.com
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-28-luoyonggang@gmail.com>
 <34306ec4-bafb-20dc-f90f-ff320fa4b575@redhat.com>
 <CAE2XoE8Ly=bhkLPbnUm1eg91Re0rf-UkAy25f8LgPLJUaYyHNw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7b83b76-ff7a-85cb-0676-559d5680f070@redhat.com>
Date: Mon, 14 Sep 2020 10:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8Ly=bhkLPbnUm1eg91Re0rf-UkAy25f8LgPLJUaYyHNw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/20 18:14, 罗勇刚(Yonggang Luo) wrote:
> I am hurry to revert --ninja option because when the meson are changed, the
> make -j10 can not automatically re configure, that would raise ninja can
> not found error 

My understanding is that with 0.55.2 you don't need --ninja at all (the
default search works), and also the previously configured build tree
should work.

What's the issue there?

Paolo


