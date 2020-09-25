Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAEDC4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FB121775
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkXzGFog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FB121775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLtew-0005sL-N2
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLteL-0005R7-NK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLteJ-0007JD-9u
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:44:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601063093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ah0O3R1X56h+2rF+zGhXAPE6xJQI1NGAKYANPAXeKPo=;
 b=FkXzGFogv4GetYoh63LuLFOF7oVqIAtrUmYZOts3FgEkZiQW+zL8SBl0N/U7U7P59oJUb+
 oEkqEBsaNea7uzltJ2Q7m0Y1b1SCek2VHPwJmba+xbt0cD2o93L8LjLuMi5sd9aRaPCxyV
 G1GITSCtYfxKrb9/w6bn56WQseUoRX0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-NXF6lGp8Oc210naq6EmOYg-1; Fri, 25 Sep 2020 15:44:51 -0400
X-MC-Unique: NXF6lGp8Oc210naq6EmOYg-1
Received: by mail-wr1-f71.google.com with SMTP id g6so1479925wrv.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 12:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ah0O3R1X56h+2rF+zGhXAPE6xJQI1NGAKYANPAXeKPo=;
 b=J14xdp0TCxK4bOv9q3tUezRH+Cfdb0rDd50smnVfSDUNS3NIGVsOZTMQ/yftMlEVdo
 YbCbqc5gw6xjZHVI8O5UpIAHIGi9Ckv5IZIUZ+Zqnok8fqN1+n4sJ+SU/OJ/E1mz/Msi
 4KxaMBdH9abuXi9BACh3xIXUxfgDaTNQCCKTqX6NQf3sONEhJ59vn9g2IKXLr4bOM6pl
 ARboZsfDU+1ODrDMKa+GfUKqo+LagRKXHLFU3qfpOvM0u4OeWtWewHJ7rQw2uqKhlb6m
 ioojnV3iQDR7DgRLiKTDPKqjUSyoLiA4bhASdfU1dExD4KTSF27dvugyLm87II2tXfKm
 mLHg==
X-Gm-Message-State: AOAM5307Wz2/+NqxMsVfepB9dw8A01MYI1NjGoUTDgQL3uO0QjKR7CkG
 oIoK727cqSg22ZQQ+y8grEY3jw6qrVPlCj5QXgAOk6evqpHEjfy8LuAptZyhr8Db8DVZpoF1rQF
 rNAgk1S89dnwjipw=
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr6723535wrt.157.1601063089616; 
 Fri, 25 Sep 2020 12:44:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuQvG9hQC3j9o0rL2JKR48nE2DWlSpcC0gTub5WXt+EjatCjggkH6CCofKfcMPZ76deEPPJg==
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr6723519wrt.157.1601063089430; 
 Fri, 25 Sep 2020 12:44:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id d19sm96436wmd.0.2020.09.25.12.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 12:44:48 -0700 (PDT)
Subject: Re: I wanna fixes plugin on windows, any suggestion
To: luoyonggang@gmail.com
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
 <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
 <CAE2XoE9F5_gGsiFutW99mbPUbUb2rmG+2+9pEDKrhvu9QRwYvw@mail.gmail.com>
 <a808929b-f93c-f68d-da4e-02133b4fcb54@redhat.com>
 <CAE2XoE_Qe9MBSJ_UAduLWX5xjBbj5Jqype-XT9Uh7muLbEeZLA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b316515-0bc4-ec79-4aa0-d84129b29ba7@redhat.com>
Date: Fri, 25 Sep 2020 21:44:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_Qe9MBSJ_UAduLWX5xjBbj5Jqype-XT9Uh7muLbEeZLA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 21:30, 罗勇刚(Yonggang Luo) wrote:
> 
>> You'd have to create a .lib for qemu-system-aarch64.exe, one for
>> qemu-system-arm.exe, etc.  On Linux the same plugin will work for all
>> emulators.
>>
> OK, this made the things clear, the possible solution is to using
> function pointer to expose
> all Plugin-API functions

Yes you could pass the functions in a struct.  You can talk to Alex
Bennee about that.

Paolo


