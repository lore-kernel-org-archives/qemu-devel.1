Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1521C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6B1206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqTxe265"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6B1206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCgXe-0002Yb-NF
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 05:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jCgWv-00029o-JZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jCgWu-0006M6-K0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:22:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jCgWu-0006KB-GY
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584091375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8V3AWdy4+WE+ZqPdYu6cuPN0NWV4yxGlgYXsnIFD6s=;
 b=OqTxe2651ETH6WR04bDW3plg3WZdoxV++fVWgGXuJ2qy5D3xXiiORU38UdRinGhifY2Ct+
 dAlvNL5SnAlOk0KJEmV1J8XoRIgpkSqrpTx+ezwGnS1oXaI7UDvSRnIzSBrh2NE+D9A3m3
 L8dWp4buFA4As6eWtCEVDATGRTQdUlM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-vCZAYp4zPmCn-VJDg7KRFg-1; Fri, 13 Mar 2020 05:22:54 -0400
X-MC-Unique: vCZAYp4zPmCn-VJDg7KRFg-1
Received: by mail-wm1-f72.google.com with SMTP id a23so3187956wmm.8
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 02:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T8V3AWdy4+WE+ZqPdYu6cuPN0NWV4yxGlgYXsnIFD6s=;
 b=bo7jioI+BoeQXRDdGL9eGxXIfUhuMvZ5343Kf+ShlJH3CZO5WSnLKjHSj3DhF68HG2
 DZmVsc3Rc6reZAXNLRMRlJmPc8R9CQh42zPkVjxqG855N9Vls2xSIyqdRyz2h0H9EB50
 qlbP4wXgHk1xGSeT3jcmuCr/f1fSEjgjJtgxD/QNGVyQRxkCG+doqEeIOwMM7p+RyOx8
 4KzZn1cIwsr/IaCFc4twDGI+SxPWMnTgRKD82IoD4zbOKv4IIxOFH0ctFMxopP+R5GME
 OkSIzrNZ/GDzs/H0KHtxpYGyXcFL5UJg0STJH2Vho0TMTpqcHkfQyFbquZwxPJqODjLc
 pIWA==
X-Gm-Message-State: ANhLgQ1gV4Domu6lGHL0Pm/i/kEyRlkBEAFYWn6fRdKO0uVhm6dYurAK
 npvCWPqfyE44Jb3OFFdZdBO5fCdCcexE4UQzlHQ128noXbh2NsG1zMvprNsaJc1F1Gilf7kjEfY
 8Gk9lbg2jBz96mHU=
X-Received: by 2002:a05:600c:286:: with SMTP id
 6mr9847429wmk.101.1584091372862; 
 Fri, 13 Mar 2020 02:22:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsDU1/0D5s3SZeXTx3NzU2MhGnrbHWC5Yu1f5/X7Q+70cU5vXJpwo8Jop//gEuDU4CTg3nhIA==
X-Received: by 2002:a05:600c:286:: with SMTP id
 6mr9847405wmk.101.1584091372669; 
 Fri, 13 Mar 2020 02:22:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac?
 ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
 by smtp.gmail.com with ESMTPSA id 61sm29764493wrd.58.2020.03.13.02.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 02:22:52 -0700 (PDT)
Subject: Re: [RFC] cpus: avoid get stuck in pause_all_vcpus
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
References: <20200310091443.1326-1-longpeng2@huawei.com>
 <8ed76f64-1a24-a278-51f3-19515e65ff39@redhat.com>
 <a6c8eac3-a714-ff6f-2bd6-1fa1d1037a81@huawei.com>
 <e4dc19fd-bee2-251f-1fef-b41cd6da6c23@redhat.com>
 <e7a49ec8-6a71-78a9-05c6-f6967e1d55f2@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b380490-dafc-39ef-1bf7-d3f4e54c14ad@redhat.com>
Date: Fri, 13 Mar 2020 10:22:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e7a49ec8-6a71-78a9-05c6-f6967e1d55f2@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 "qemu-devel @ nongnu . org" <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/03/20 09:36, Longpeng (Mike, Cloud Infrastructure Service Product
Dept.) wrote:
>> You're right, do_vm_stop sets the runstate after pause_all_vcpus.  We
>> can move that before and it should fix your case too.
>>
> Uh, it seems to work. So can I send a patch based on your suggestion ? Or feel
> free to do if you want to fix it by yourself.
> 

Yes, please.

Paolo


