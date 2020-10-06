Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11549C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D4A20674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPe4m/ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D4A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjfZ-0002OR-7y
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPjf0-0001xq-6p
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPjey-0003dY-Je
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601978007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7MjYBkLYIsD2WzKxyowIoUX86kCyEL0DENZTr5Xpws=;
 b=UPe4m/ym3K3jkjbIlbQhOMUCrun/nJXNWc7qPcfekwqCuvA1d/oPYTJm9uHQch0zph1MFo
 edQeGqftI33XCzNcdojnDzTOAY7riUyE1lutLgDeMmrCSb1gS+1FGSQnv6AzOAdk71frdI
 /b1iaym8abSWxRRlt0cOSn/wtINHXdE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-PQ1_3Yu2MxiiP5fKudc6Jg-1; Tue, 06 Oct 2020 05:53:25 -0400
X-MC-Unique: PQ1_3Yu2MxiiP5fKudc6Jg-1
Received: by mail-wr1-f70.google.com with SMTP id o6so5131778wrp.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 02:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t7MjYBkLYIsD2WzKxyowIoUX86kCyEL0DENZTr5Xpws=;
 b=N1PHBIFgIw/nUX/RYa0fcmg5xy3FMgAFRHEFNdLcUWvCtub/M5oCmsJIPPvDDKQSA1
 8/Wlfs0HAJYIVC2PMCtI6UAiBAoCmVk6ukFxiPJFv3Lp8qiog3q4nZEJdWp2Aae8PwvI
 coxk9YdRR4tDF6VzEXYn69tBfyjvckmGhSgNpMEM3X8e7wlSyjQnCvKnQMXEpT2WGUOV
 WjfQBfOBp0mXVu7kZs2LDzW4k52aBtWtsPX2ua6oBzRYqTRze+H3x0qNSUDqRNWhdKrL
 vQOI2AVisX9mV7C3fQX4UAXzciPbQ6PD5dEOz0XYzPoVlSH52oYwyRBbxNZODfYkxCTA
 skiA==
X-Gm-Message-State: AOAM532Ad8ovPrTW1wO8rOHjDNzP5qqY+pCqXTRk7FsYTEE1F4h1NTu7
 bBcQwLlVBQ2tkqVFhhhgK9WpxfmXfArfEsStdEHg9+TougtSp+Gbo2Zq3zs/yW9uQ+6UzfIv6Sj
 vZYfNlSQlqlXuUcw=
X-Received: by 2002:adf:a418:: with SMTP id d24mr3956512wra.80.1601978004362; 
 Tue, 06 Oct 2020 02:53:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzETkjy/npycZclORocLmYnFQUBUO8gTRwzwn9lK/+/x3gP/uESNeneAPDmH4QIn3Vw0/VAiQ==
X-Received: by 2002:adf:a418:: with SMTP id d24mr3956484wra.80.1601978004086; 
 Tue, 06 Oct 2020 02:53:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id a7sm3208972wmh.6.2020.10.06.02.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:53:23 -0700 (PDT)
Subject: Re: QEMU API cleanup initiative - Let's chat during the KVM call
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1f0b0576-eb07-bf5a-a4d8-c6a2d18d1a94@redhat.com>
 <20201005134552.GC5029@stefanha-x1.localdomain>
 <8e8a7b4d-e3a8-efe0-47b0-d20186970cee@redhat.com>
 <9b6c8327-7e53-ef1d-e576-1e091ca1e04f@redhat.com>
 <20201006094032.GF2482221@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf219160-1cf9-cb25-e459-d19094bf3623@redhat.com>
Date: Tue, 6 Oct 2020 11:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006094032.GF2482221@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 11:40, Daniel P. Berrangé wrote:
>> Currently we have:
>>
>>     switch (...) {
>>         case QEMU_OPT_...:
>>             /* something has side effects, something is just parsing */
>>     }
>>
>>     init1();
>>     qemu_opts_foreach(something_opts, configure_something);
>>     init2();
>>     qemu_opts_foreach(some_more_opts, configure_some_more);
>>     init3();
>>
>>     enter_preconfig();
>>
>> We should first of all change it to
>>
>>     parse_command_line() {
>>         apply_simple_options()l
>>         qemu_opts_foreach(something_opts, configure_something);
>>         qemu_opts_foreach(some_more_opts, configure_some_more);
>>     }
>>
>>     switch (...) {
>>         case QEMU_OPT_...:
>>         /* no side effects on the initN() calls below */
>>     }
>>
>>     init1();
>>     init2();
>>     init3();
>>
>>     parse_command_line()
>>
>>     enter_preconfig();
>>
>>     more_init_that_needs_side_effects();
>>
>> This way, the parse_command_line() and its qemu_opts_foreach callbacks
>> can become changed into a series of qmp_*() commands.  The commands can
>> be called within the appropriate loc_push() though.
> 
> I feel that both of these approaches are equally broken, as they don't
> honour the order in which arguments are passed by the caller when
> creating resources.

By design, in that I'm only looking at a backwards-compatible approach.

But once you have reached the second step, you can add QMP commands for
each command-line option (that matters), and configure the VM via QMP
commands.  That _will_ honor the order in which commands are executed by
the caller, obviously.

> I'm not convinced that your proposed change takes us in direction, if
> anything it is encoding the current split of parsing vs creation even
> more strongly.

Yes, but it enables the right way too.  Doing things in steps is the
only way to do them.

Paolo


