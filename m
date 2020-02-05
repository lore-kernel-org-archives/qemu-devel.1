Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BF8C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034D92072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWHXgnaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034D92072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKce-0004Rt-82
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izKbu-0003tQ-RE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izKbt-0008Vt-QN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:20:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izKbt-0008Ut-Lb
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580908853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4TZdlWncRAr0Vhan4aAyu/vOXNaN3eNbVxaNVzW71s=;
 b=AWHXgnaAC1zb2DFgHA2Asi63BW0Ym02/Ymhj4cw+TCj4cCvfSYBQ3OfzgZF/fxLP0XSi/i
 m+SbCy6PsFiG24UzWqP8CajuyXwSW8dwn/xCwgYzFRYoRr4d9kaPzDUeDxnuZeq2fUlTGU
 QTB7oi0ufz2OegbWSf/e/OwTRbCBWqk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-e9jyUu8OPqq8pWET7NGFeQ-1; Wed, 05 Feb 2020 08:20:51 -0500
Received: by mail-wr1-f69.google.com with SMTP id a12so1168223wrn.19
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 05:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s4TZdlWncRAr0Vhan4aAyu/vOXNaN3eNbVxaNVzW71s=;
 b=WtsIuiyjqhEGToSLOO0EbDtR/k1n1oSbf6tshXN4BCnfTxLaw/Mk1E8+hb38BrmdeT
 xBBRqpYvW125YUIqN/eubPMBTs+UXZ1N/1SI8hvwC41u1JLfJ0+0y1rKIWckMLUqDpi0
 YuPMfd+Z8cc9zVkdKierxtCvPMA3mhlHdmv2vjDkliwmNKo5y/7smocowXwECZ7BzPAr
 RVf+Vr3ww5Vl5EuA93fPJX6wHQNV0MmEuJ4ZKQxKY5CFOvn5au8XdG4Hf6TansQf3Z9s
 bpqYVS1sAYDahjio5DSERxnfttHyEmBrj7yI+c3KCjFD7f63J62SgZnv9w8xaTu8UW26
 EPTg==
X-Gm-Message-State: APjAAAXGeEmajbp5Wqq3YFEjpErQfMq3t/5Jb1rJFfmSlU55lo5BMKbF
 nWynpR8pl2yS7no34BEHGSvrKzG/SF0+rROZ+oBN4oCVo+XwuGpCKGO64J3+0YiPebGEeIca22q
 88cNSv+Kh2FYKVAA=
X-Received: by 2002:a1c:1dd0:: with SMTP id d199mr5621319wmd.42.1580908850034; 
 Wed, 05 Feb 2020 05:20:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCR79U5jQ31IUs6z2Iw1l6dmB1Ji7PJn08ADeUEanef35zBTN5m7/w+RxJZ4zckRUvhe0LgA==
X-Received: by 2002:a1c:1dd0:: with SMTP id d199mr5621309wmd.42.1580908849853; 
 Wed, 05 Feb 2020 05:20:49 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id 4sm7887652wmg.22.2020.02.05.05.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 05:20:49 -0800 (PST)
Subject: Re: [PATCH v4 00/80] refactor main RAM allocation to use hostmem
 backend
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <20200204160830.02afbd2e@redhat.com> <20200204163909.5ce2cb2a@redhat.com>
 <CABgObfZuzA7qNxp4KbaGJ4oVT1YX+1KLL=cZgCKa9sWSV2tFeQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2612f4db-d43e-f094-b259-f444d80a2aa3@redhat.com>
Date: Wed, 5 Feb 2020 14:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABgObfZuzA7qNxp4KbaGJ4oVT1YX+1KLL=cZgCKa9sWSV2tFeQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: e9jyUu8OPqq8pWET7NGFeQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:05 PM, Paolo Bonzini wrote:
> Sure! I probably won't send a pull request for a week or so though.

Eh I need to rush to get my raspi series fixed/reviewed/merged before 
that :(

> 
> Paolo
> 
> Il mar 4 feb 2020, 16:39 Igor Mammedov <imammedo@redhat.com 
> <mailto:imammedo@redhat.com>> ha scritto:
> 
>     On Tue, 4 Feb 2020 16:08:30 +0100
>     Igor Mammedov <imammedo@redhat.com <mailto:imammedo@redhat.com>> wrote:
> 
>      > On Fri, 31 Jan 2020 16:08:30 +0100
>      > Igor Mammedov <imammedo@redhat.com <mailto:imammedo@redhat.com>>
>     wrote:
>      >
>      > Paolo,
> 
>     forgot to add address to CC
> 
>      >
>      > could you take a look at patches 1-7, 73,75-78 and
>      > if series looks to be in acceptable shape, merge it via your tree
>      >
>      > > v4:
>     [...]
> 


