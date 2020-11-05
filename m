Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256F6C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D732072E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JY49kP0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D732072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kad1f-0007ft-BN
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kad0N-0007EX-J5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kad0H-0006r6-Mq
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604574021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1UViqaY2dw2tJ/uiPRbcc3la6348uy0QyvJfmG6SVc=;
 b=JY49kP0ensAiR9pPkvJ55541OsCvgYqDnyBO/u3UaNaWRsMseBxRvnZC23CGTZqms/LBYI
 dTZHv1XoBQ6xXYzbbmFIm9gwl5ZLNmv/eC/RVG5l3XGXUnjs1AESGJA6RGsKbm5pGzCeJZ
 72vnqmCE+P7tBA8Wd1GmqMlSClCzMAY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-a622r0YoPVCIWDLbTeZVYw-1; Thu, 05 Nov 2020 06:00:17 -0500
X-MC-Unique: a622r0YoPVCIWDLbTeZVYw-1
Received: by mail-wr1-f69.google.com with SMTP id w3so550064wrt.11
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 03:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X1UViqaY2dw2tJ/uiPRbcc3la6348uy0QyvJfmG6SVc=;
 b=dXcQDvBW8Fm8BJ4ElTEFpaWKZ0LEjpq8TiNEmMMAHQQTNghWp3/Z01yQZNn9hbi4D/
 AFRA/coxNlEZ1xjglrgwh9UWKRvIYcVphjLBvzzbYwJiCkFF4DuRM7fek4Zf9XtiIUXA
 LLuZqZIvFiUxTo19ObbmVfRP3ASznI32AETRwnVN38HPp52FPHBD5U4sJUrNTWu4qMtF
 L2+L+L7RYOW+r3jkD3XZxa50eUOujR2LlKWgZP8Vp0Bgl/i4RYMYFwqVmdLucW+y41cF
 osJLTxM6emAa2mZ+K35cmQGO6w/oznUX28Q76uNM5eST/v/0ajQyAf3PhkMIPI3npgtc
 n3Xg==
X-Gm-Message-State: AOAM530Y7SDssBc/HGUMKQXQdGrbfaIZD73wPpvdkux4JajMngQIx5nD
 6pGloibCTDAqj8rCbsNSdO5WEmeTpPH2b2cwahBlSrWCsx34ZfqKlGuyB4Pz94mR3GqhSiNr7C1
 iK5n10Pi8uZk7nIM=
X-Received: by 2002:adf:cd0c:: with SMTP id w12mr2144994wrm.305.1604574015940; 
 Thu, 05 Nov 2020 03:00:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybpmotyKASMAB+t7/PgRClyJnCN9SPeZuQ/cw9KvOuv0EQ8kS0mbpjFsUNU3T9k8SUs/TxWg==
X-Received: by 2002:adf:cd0c:: with SMTP id w12mr2144953wrm.305.1604574015658; 
 Thu, 05 Nov 2020 03:00:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id k18sm2066625wrx.96.2020.11.05.03.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 03:00:14 -0800 (PST)
To: Stefano Stabellini <sstabellini@kernel.org>
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
 <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
 <21e90ddb-fe8a-c780-2741-9b7a2f7f1c9a@redhat.com>
 <alpine.DEB.2.21.2011031722100.3264@sstabellini-ThinkPad-T480s>
 <CABgObfaAH1fty0y0Z10GALnhy4kL_FqSxPZc2-=PwJgtSrOX0g@mail.gmail.com>
 <alpine.DEB.2.21.2011041742580.3264@sstabellini-ThinkPad-T480s>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
Message-ID: <462761e7-c466-bb61-1777-cf644c6ad615@redhat.com>
Date: Thu, 5 Nov 2020 12:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2011041742580.3264@sstabellini-ThinkPad-T480s>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/11/20 03:48, Stefano Stabellini wrote:
> I repeated all the steps to make sure. The first time I was using
> Samurai because Alpine Linux comes with it and not Ninja. Then, I
> removed Samurai and built and installed Ninja by hand from
> https://github.com/ninja-build/ninja and that actually works. Yesterday
> it was late and I was distracted by global events -- I must have failed
> to update Ninja appropriately. Sorry for the confusion.

FWIW I sent an Alpine merge request to support "ninja -t query".  We 
should add an Alpine container and pipeline once it's merged.

Paolo


