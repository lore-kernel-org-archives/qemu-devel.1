Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DBEC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D948206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dae7NsVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D948206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW051-0000HX-8c
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVzHZ-0004YI-Kk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVzHO-000465-7T
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603468015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFAFn6yjzTaPPEeEDX9PIgSh6b3Myg1TaCjEQmzvdOE=;
 b=dae7NsVxN3NsUoiAIFFonCkjlJdw/FHdMTVfREfUEe5ZT2i4t3EVMRmIyoCIubdz/lculW
 jB8ZJqkV3E/TsKXe32axYbnOcAMjs7T/b+QamswIGZuezj9bmWjbp2YFjr3MugF3v2hjdt
 cgxYkGdS0x7LjNxvlJvoXus+2sV0f4Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-DiJbzc0gMoysQBwq9FqoTQ-1; Fri, 23 Oct 2020 11:46:52 -0400
X-MC-Unique: DiJbzc0gMoysQBwq9FqoTQ-1
Received: by mail-wm1-f72.google.com with SMTP id s25so602773wmj.7
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FFAFn6yjzTaPPEeEDX9PIgSh6b3Myg1TaCjEQmzvdOE=;
 b=nWLHA/bRQ7iiWdIWAt1Q2tbpyOG8963qQWYXU16a9PDGs53bdG5B2V7NTOtnGbfMLM
 tZtOMzWPWA6FGpwkCmBB+hgafbThM89sZLyv0los7eJL1xBGu0lyytP3IL+3qRxAe37b
 8Q62ppGXN7oD65dF0BnY8lTET3XccQDxJvz7vMHBGdB38ZEr7TiWygOS6brxo0VvKaay
 C6bt8CYSceVL3u3G/4AUgR+mg5mh2MgMq5l9hFOx2dY3ccpWNuCyhuE8WIvUrv/vC3xW
 Ssicnhep4Ep3sLPpG+VgQzfKFj4s3Pz6Y4z42In6IJ2HNXE90tNInQGtm4eDNbh8Yg5B
 Ve/w==
X-Gm-Message-State: AOAM533L/Kd5HAiSjEeOA6mJlvhFfCjcf0fhhm1gnqu9RrL5ESRmW9Gk
 7b5rrkZR8OAWgL2Sf6ZYYSPNg+0kypw4MZld7F4qCN7Afj/JjWbSGtZn82m4Sr2EhCfPeePLnku
 okGtSoC1paRd0vRM=
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr3167232wrx.278.1603468011057; 
 Fri, 23 Oct 2020 08:46:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznurcYKrt80x09tt1NzBygNP08ij+JDsAxvch4Gi88jGAqpabDigv55qqLkeTCVuP+Il9QKQ==
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr3167200wrx.278.1603468010775; 
 Fri, 23 Oct 2020 08:46:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id e25sm4396193wra.71.2020.10.23.08.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 08:46:50 -0700 (PDT)
Subject: Re: [qemu-web PATCH 5/7] Simplify and restructure the page footer
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201023152957.488974-1-berrange@redhat.com>
 <20201023152957.488974-6-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54f37d84-a66e-bbfa-b410-2dba44d88ac9@redhat.com>
Date: Fri, 23 Oct 2020 17:46:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023152957.488974-6-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 17:29, Daniel P. Berrangé wrote:
> +	<div id="external-links">
>  		<ul class="style">
> -			<li><a href="{{ relative_root }}/">Home</a></li>
> -			<li><a href="{{ relative_root }}/download">Download</a></li>
> -			<li><a href="{{ relative_root }}/conservancy/">Conservancy / Committee</a></li>
> -			<li><a href="http://qemu-advent-calendar.org">QEMU advent calendar</a></li>
> -		</ul>
> -		<ul class="style">
> -			<li><a href="{{ relative_root }}/contribute">Contribute</a></li>
> -			<li><a href="{{ relative_root }}/contribute/report-a-bug">Reporting a bug</a></li>
> -			<li><a href="https://wiki.qemu.org/Documentation/GettingStartedDevelopers">New contributors</a></li>
> -			<li><a href="https://wiki.qemu.org/Contribute/SubmitAPatch">Submitting a patch</a></li>
> -			<li><a href="https://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</a></li>
> -		</ul>

I would rather keep this column, the idea is that this information can
be found with a quick Ctrl-F "bug" or "Ctrl-F "faq".

Otherwise I agree it's an improvement.

Paolo

> -		<ul class="style">
> -			<li><a href="{{ relative_root }}/documentation">Documentation</a></li>
> -			<li><a href="https://www.qemu.org/docs/master/">Main docs</a></li>
> -			<li><a href="https://wiki.qemu.org/Category:Developer_documentation">Developer docs</a></li>
> -			<li><a href="https://wiki.qemu.org/">Wiki</a></li>
> -		</ul>
> -		<ul class="style">
> -			<li><a href="https://planet.virt-tools.org/">virt tools planet</a></li>
> +			<li><a href="http://qemu-advent-calendar.org">Advent calendar</a></li>
> +			<li><a href="https://planet.virt-tools.org/">Blog planet</a></li>


