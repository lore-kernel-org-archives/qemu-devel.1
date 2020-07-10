Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA0CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 22:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6940B2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 22:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkHEUtVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6940B2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju1ma-0002g9-LQ
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 18:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ju1lw-0002An-Nn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 18:45:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ju1lu-00044J-8z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 18:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594421132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LF2fOKBGuMeuXlGewjdotMctgnGZ9q58vKmwAYxyhRw=;
 b=NkHEUtVjgGq5A75MqRXHmOT+R1sSEwfXRGgu69epFCts2pUVbK28e7nG1vqwGdGLflVLjt
 15Kq9R2vDlpUP8mutWGEV2xNsy7Jjm+Oh2IpspHA119mxjfull8/c19T9XUtWl39d/4EHv
 rOtiy1fZaSSAwOwPcpNNp5mEZt8pNBQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-hKiH96CaNKSLobHp3cX_3g-1; Fri, 10 Jul 2020 18:45:29 -0400
X-MC-Unique: hKiH96CaNKSLobHp3cX_3g-1
Received: by mail-wm1-f72.google.com with SMTP id o13so8254409wmh.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 15:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LF2fOKBGuMeuXlGewjdotMctgnGZ9q58vKmwAYxyhRw=;
 b=XqGvRm4aQbrZZ9kcyIh1zvD22HdeedzK+UWaxgXTaC4KmPehvetLPMkup/KOG0z5UJ
 0gKzHjVn84DFztBr77BhKLFIe5eQbVcKM9tvszSGtpg4lSiU3q+mrhO9KbULkXNkBksl
 Nz8T3f+KlDq4ZRI3lx3qrWRgVC5re86IReOUZvuHm58KTOcHUgq81UWksOo2MVcvyH5B
 K4Fdn2v/mTz+NDyXPcumQPFuGj/5Xtzm/hxpxDt6LYl0/sS43IIwoyTLK8/61bL9ILDq
 G1IneJMau3FxAlYngmao0dZ2SAEKmXAb7SmQ4wcytPQJOE3TcG/muu8u+cN9v+Zz7EBr
 sjPg==
X-Gm-Message-State: AOAM533ofJzX9JGJz4hwNuV2R9yIPytQTK6fYUZK6u0axXGGAHTvtfEB
 9iJ4zjzpI6iGcNbYqz5Xw/KXMPr1wlKqOgBGwlNt7FqkiIgAuDKb60wXhtiFoRbCNuNkx3pQGR+
 lcWmoDzPVrXlEl/8=
X-Received: by 2002:adf:b190:: with SMTP id q16mr501864wra.356.1594421128814; 
 Fri, 10 Jul 2020 15:45:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYjcMh2epn2F97nwKH1u4vIg6eVXyk8cH3zecrI1vx4qoM+clsdpxnr8KXspCJggACswTk5g==
X-Received: by 2002:adf:b190:: with SMTP id q16mr501834wra.356.1594421128555; 
 Fri, 10 Jul 2020 15:45:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ef:39d9:1ecb:6054?
 ([2001:b07:6468:f312:ef:39d9:1ecb:6054])
 by smtp.gmail.com with ESMTPSA id f14sm13081264wro.90.2020.07.10.15.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 15:45:28 -0700 (PDT)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <996dc455-548e-5964-9c87-f4abe5b63907@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <146b0cf2-509b-6a48-e82b-b93740e4c60d@redhat.com>
Date: Sat, 11 Jul 2020 00:45:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <996dc455-548e-5964-9c87-f4abe5b63907@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 18:45:32
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/20 06:36, Thomas Huth wrote:
> 
> In short this goes away if I again set icount to enabled for qtest,
> basically ensuring that --enable-tcg is there and then reenabling icount.
> 
> qtest was forcing icount and shift=0 by creating qemu options, in order to misuse its counter feature,
> instead of using a separate counter.

Why would it need a separate counter?  In both cases it's a
manually-updated counter that is used for QEMU_CLOCK_VIRTUAL.  The only
difference is that shift > 0 doesn't make sense for qtest.

Paolo


