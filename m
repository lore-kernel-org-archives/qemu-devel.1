Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963CDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8A720772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnXtJmWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8A720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIS8-0002IS-LS
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIDv-0005ez-IA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:07:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58084
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIDt-0007TA-R4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgdh5XnFk6045WTIDPahGD6XWi9Av6OMK5UmBjgvK6g=;
 b=CnXtJmWez8573QjfB538qn1uRRUSyELgw+RI8diudKRmH5oVE5dhJzF5SBlhnd7YR/Aujb
 OjS0oLWydOck6hRnu8efisdCstVABwQtocIo6Mq0M0X1PRmS4E4RDoZKFVWObxbIPWZbr0
 1XXofR+lQS1kJLG5r8QqjCvNs2Iymns=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-jCz_Gd2AOe22eO_9ycYA7Q-1; Wed, 08 Jul 2020 11:05:19 -0400
X-MC-Unique: jCz_Gd2AOe22eO_9ycYA7Q-1
Received: by mail-wm1-f69.google.com with SMTP id z11so3284100wmg.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 08:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dgdh5XnFk6045WTIDPahGD6XWi9Av6OMK5UmBjgvK6g=;
 b=mXLbi0YeBizzAys34/lhEYdq6APzCnFw/awnBcNvpUSJ1RhBlMd2/BkQlVBs3JZ1Rd
 /1js/Fxxh95eqlUjVPPcdvMYE/cjuQkQbRaswLmuC45+Ks/7/MLGlxtDPSKjkbXMw19B
 6yQuyvxZHoqogi+E2UAOzd1ZMXS0cS836d/TUwXm/vYPh9YsO2UMbkQUBkBVlWfdgsWn
 P5+419rQeDkIH2ZvhAS3dvGm3aTv4TXo2yblKuDvf0H9rnGaae5YBjNZTmEWB9JRX58F
 04o9fYtknOYKZxMtntbs+LcaMJyls4JDCgODm7hTr0aFXlHcoEaJNg8YX4Hh0SvOwiIa
 p4fQ==
X-Gm-Message-State: AOAM533lkghqIb5sBdeIOf6YFL7xxBlMKWy9ocX+c1WJ8U043vM7/rC0
 8CXcNV834Aiiqru/K60fh8nRys/kuicCV4n7bfTxKN5RgmL6urQD1zSSjEjy3p9TmPHl9R5dsbf
 xQ+8rnhFtS1Mkago=
X-Received: by 2002:a5d:484b:: with SMTP id n11mr56600665wrs.320.1594220718538; 
 Wed, 08 Jul 2020 08:05:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKTRS1XOg1ilJ+1ZWz7zHmvG0DFO85S/YWOzxEM1KivPc8TecLIrFaTZpAcJ86Ykc51I3P8g==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr56600637wrs.320.1594220718342; 
 Wed, 08 Jul 2020 08:05:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id e17sm288121wrr.88.2020.07.08.08.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 08:05:17 -0700 (PDT)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
Date: Wed, 8 Jul 2020 17:05:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
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

On 08/07/20 17:00, Claudio Fontana wrote:
>> Bisectable, 100% failure rate, etc. :(  Can you split the patch in
>> multiple parts, specifically separating any rename or introducing of
>> includes from the final file move?
> Hi Paolo,
> 
> will take a look!
> 
> Is this captured by some travis / cirrus-ci / anything I can easily see the result of?
> 
> 

Nope, unfortunately we don't have an s390 CI.  But if you can get your
hands on one, just "./configure --target-list=s390x-softmmu && make &&
make check-block" will show it.

>>
>> 	#if defined CONFIG_TCG || !defined NEED_CPU_H
>> 	extern bool icount_enabled(void);
>> 	#else
>> 	#define icount_enabled() 0
>> 	#endif
>>
>> (This way, more TCG-only code in cpus.c gets elided).  You can integrate
>> this change in the next version.
>>
>> Paolo
>>
> 
> Weird, I tested with --disable-tcg explicitly (but may be some time ago now, as I constantly rebased).
> 
> Will take a look at the introduction of this #defines in place of variables,
> as this mechanisms will not work in the future for target-specific modules.

This is only done for per-target files so it should not be a problem.

Paolo


