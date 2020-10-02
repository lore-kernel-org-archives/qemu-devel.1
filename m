Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752CAC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0180206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mee8x1B5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0180206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONvS-0005nM-Vt
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kONuO-0004VB-2I
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kONuJ-0003AN-Gi
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601656062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9FGxVdJQh56tur5iRMhECcIX0dr8pDw/1Nl+ZJ0HcgY=;
 b=Mee8x1B5gkFhT0DiPEt9WDYD5p8f02jGUefSaywKRSBR3sbDVLXidKKk7eKfWf9s/sE7GT
 OR/gKtQEkTynMGV0UWcme4LsztB+H6zdYtlYLHIhN0h7FoEaWk5+QLgJwPnaIe7Z1ob3fL
 yNtiuMHATP9xlieDBw5lD3i1Qs8PAoI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-xX0GxgZ1NTmUjkVH9kJLtg-1; Fri, 02 Oct 2020 12:27:38 -0400
X-MC-Unique: xX0GxgZ1NTmUjkVH9kJLtg-1
Received: by mail-wr1-f69.google.com with SMTP id d13so728901wrr.23
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 09:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9FGxVdJQh56tur5iRMhECcIX0dr8pDw/1Nl+ZJ0HcgY=;
 b=gzS55Aj7HYtrJJ1hoYo3VHXDAJqDqTN+P4Wyw+DPM+y3Wx0gR7eBmsZEs134bAYlCq
 J5lv+o7UNuazdCv0SETo0jMNcgMkXW17Q1dTA6bqVXe9bi5/WrQHhCcmrx5qtN6F4DAG
 lLO5RrMgqx1nY++juI96Runv+e+jrrie0O4BoFBFa4WCfMRy1H96+cZJ9+PDDttMT+fx
 RATvual6CmA35UQfz6nGUEmzZ2DEgnuQkKx4py2ptexaH5pWdJWpO3KHdA6BcS+4JPOC
 MqfC86V4Cde60cqPT9WOHUo4/B9aM9XO7qW5TGUd3VWV5kc1rf1zVpOXHodBVhsJtZnn
 7Zhw==
X-Gm-Message-State: AOAM532qJdAsdWu8/rrz02UcJye2iaTOX0n1GRc/MGMzpz8mgCMixMw2
 ApG3rQDJ5Z1mnVCjLUKJeJY79D1OaqEGRfhCJZEm3LpPwijBXIZZo/ssL7oFzx7w7Rvj5KSZN2Y
 Bmc8il8KYxidNEG8=
X-Received: by 2002:a1c:b103:: with SMTP id a3mr3860154wmf.68.1601656057341;
 Fri, 02 Oct 2020 09:27:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr4rgY81fLau7XMXNPuZJ6VNjeVp2yfDZT5oHn3m2YSwq6LvaWSddEXktSx7YY5oqF/hnthA==
X-Received: by 2002:a1c:b103:: with SMTP id a3mr3860143wmf.68.1601656057139;
 Fri, 02 Oct 2020 09:27:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id c8sm2021894wmd.18.2020.10.02.09.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 09:27:36 -0700 (PDT)
Subject: Re: [PULL v8 00/86] Misc QEMU patches for 2020-09-24
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 qemu-devel@nongnu.org, ehabkost@redhat.com
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <a0b8e23a-cccb-3c5d-dbf7-f489c0d95f93@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c9a0783-f7ea-7872-f5f4-44ba9e65a1b2@redhat.com>
Date: Fri, 2 Oct 2020 18:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a0b8e23a-cccb-3c5d-dbf7-f489c0d95f93@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 17:58, Michal Prívozník wrote:
>>
> 
> cd442a45db60a1a72fcf980c24bd1227f13f8a87 is the first bad commit
> 
> Sorry for noticing this earlier, but is this known? The build starts
> failing for me after this commit:
> 
> /usr/bin/sphinx-build -Dversion=5.1.50 -Drelease= -W
> -Ddepfile=docs/devel.d -Ddepfile_stamp=docs/devel.stamp -b html -d
> /home/zippy/work/qemu/qemu.git/build/docs/devel.p
> /home/zippy/work/qemu/qemu.git/docs/devel
> /home/zippy/work/qemu/qemu.git/build/docs/devel
> Running Sphinx v3.2.1
> building [mo]: targets for 0 po files that are out of date
> building [html]: targets for 20 source files that are out of date
> updating environment: [new config] 20 added, 0 changed, 0 removed
> reading sources... [100%] testing

No, this is new.  It works with older versions of Sphinx (I have 2.2.2
despite being on Fedora 32 which is pretty recent).

For now Sphinx 3 is not supported by kerneldoc, we probably should apply
a patch like

https://www.spinics.net/lists/linux-doc/msg83277.html

Paolo


