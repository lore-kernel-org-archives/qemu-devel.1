Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A3CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682A322D00
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAAtzus6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682A322D00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gmO-0002Hi-9m
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 10:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3glj-0001YF-73
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:21:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48449
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3glh-0008QL-2h
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596723676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJMqPsH2horapr+2/wmkadSJQmFY1hbY9nk0oCTs6fk=;
 b=gAAtzus67ba0Io7igjU3NhB5H2t9dQue5Z8LkyvYPSd2iMiOqc/exuAaW/ZMQ3WdkEZUMX
 M9+XZjg/tRK+m6guxJphbq19pdPHT9CnpH07OQR7TxEC99jxuQUcRGCiVK77rw5t30utlI
 eZBTxBhW4DKk0Qoy2gPIzCiUmTSRAIg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-Sp3wzH4iP5-GyrG6_2KKGQ-1; Thu, 06 Aug 2020 10:21:14 -0400
X-MC-Unique: Sp3wzH4iP5-GyrG6_2KKGQ-1
Received: by mail-wm1-f71.google.com with SMTP id i15so3685046wmb.5
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 07:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tJMqPsH2horapr+2/wmkadSJQmFY1hbY9nk0oCTs6fk=;
 b=Iif7SpTUttKV5YusGDWjeUyeixeBUoH6Utra9wwhFXlRPzmF3uSglofhrOe++HgoDS
 21MGxoXI58BdQ1xXbQlRjjVcaF5Iwsn3KA20Sw0nCnvc5Fc08hB1TI6fyG+iuk6BrHWA
 2QLF+a0Xy3ZQiS8NQvrshDmzTZWMJRCGotSPknOs7+9GpwejRr+eH/m+copTqSUBJjiJ
 xQ8iPbt/8hNkRXTGGxvwlBYdNCeCRu0AFwwAKOg9D71qfbLFhAZ1WcfLjsJiBf0x4rBG
 7fS+Xg05qM+AZRoqLU2sPqHuYWGL4vwyDR74mOGgV9E+GRD9WouhgQBbZkjfzwxRuDG9
 ouGA==
X-Gm-Message-State: AOAM532GAsv6155qO+OiR1RY25AqXb7g1G8DI8cCyrsS/f8aYN6WBN3S
 umik54G7ocMy3k8qztENZorv33siluRP3l0OxnzhkJjwX1SKpb63JpLqXywGTA1aZkPkpua+rOR
 zLwRCfnkDNH9EHnM=
X-Received: by 2002:a1c:988a:: with SMTP id a132mr7990196wme.14.1596723673721; 
 Thu, 06 Aug 2020 07:21:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpIaoq/7ysLXL+FuLOOjTbDfn4nSH4MnuNiJl7DqkJLkpaPpl3VbdTZ9BpjYrWOeF8INK8Ug==
X-Received: by 2002:a1c:988a:: with SMTP id a132mr7990173wme.14.1596723673487; 
 Thu, 06 Aug 2020 07:21:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id d23sm6690549wmd.27.2020.08.06.07.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 07:21:12 -0700 (PDT)
Subject: Re: [PATCH] softmmu: Add missing trace-events file
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200805130221.24487-1-philmd@redhat.com>
 <87wo2dmde8.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c510787-119e-5849-9c3f-fa01fb3d3c80@redhat.com>
Date: Thu, 6 Aug 2020 16:21:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87wo2dmde8.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/20 15:27, Markus Armbruster wrote:
>> Commit c7f419f584 moved softmmu-only files out of the root
>> directory, but forgot to move the trace events, which should
>> no longer be generated to "trace-root.h". Fix that by adding
>> softmmu/trace-events.
> Dang!  I'd like to have this in 5.1 if at all possible.
> 

Does this matter at all for usage of tracepoints?

Paolo


