Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95736C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B04420759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvSYcBqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B04420759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNc18-0003jN-Bh
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNbzk-0002gW-15
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNbzi-0003Vy-Cs
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:18:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601471885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RibcTPJb5Zq7PCVPFosBD7AQt0RarvGmMZy6yMQy6Qc=;
 b=NvSYcBqQd7MV+XF5CiGOh/zf9hU0LVN1uMYst0Y0YVyq6VubV6Zu5R2X8l7JiYaDKTO36O
 z9It2qBiD8ksGvsCiPxH5UKU5vdPpcpt87sSWWPEDmLPG4dvVrsZSDagpus+7z7m+QtGu/
 k8XubdbqmM5x2Me2uykfQ8KUEb2PX0k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-GRmzHOVJMX2gm5zjIRtc5Q-1; Wed, 30 Sep 2020 09:18:03 -0400
X-MC-Unique: GRmzHOVJMX2gm5zjIRtc5Q-1
Received: by mail-wr1-f72.google.com with SMTP id v5so609444wrr.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 06:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RibcTPJb5Zq7PCVPFosBD7AQt0RarvGmMZy6yMQy6Qc=;
 b=PZTWMzZI40shlM1UCLzhwHXFKkE8HHL6qXM4aIouYLsif+tJC9gKBR2IPpHtHdAxZw
 wRqscWxfH5SGcXDaQ7xsAkE9+xJLfPSCxvpYUCN2q5gbiCyqul6ZzYc8uXozrymT+54S
 c12Prvu/364gP3oWYV56Bg1/SIPNEqJtZbwRr69eiKcQ7WSH20LuNwuI6zPFqjBTPmB+
 a/ZaOmzxGPon1W+0vaIcAdEHc2m6YOpdZ19V0tOnMypjYgXdQkAqfsL8Dtilc7Sq/WiB
 r0ypzn37HmOM7+P6BHrpC7HqToQvyk8BzZrSuJEVueyIu/z3UEQX2n+VHiTjK0vtNGUy
 1Emg==
X-Gm-Message-State: AOAM5334G/UqI1/2tCDdEba76mpsoZ2D5keQzjDnbSNOReicbBU8unqf
 ZuQiyG13m2q8GIcQxtiT4aLzjUCPSAfcBP/Y2hvWVL5cj8gxGfuvDFE6BHmNq+NJgBaxowZgBl0
 zNiwJcDuocpYJtyE=
X-Received: by 2002:a05:600c:2118:: with SMTP id
 u24mr3020544wml.59.1601471881942; 
 Wed, 30 Sep 2020 06:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvR9v+AADxXGN/7w1gG1Uwti9rLguDEldc/2LUbSFnr0vtMA2K/KTMPgkFcY4ePRdJIqHheA==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr3177047wmy.51.1601471880395; 
 Wed, 30 Sep 2020 06:18:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4?
 ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id s11sm2864634wrt.43.2020.09.30.06.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 06:17:59 -0700 (PDT)
Subject: Re: [PATCH] job: delete job_{lock, unlock} functions and replace them
 with lock guard
To: Elena Afanasova <eafanasova@gmail.com>, John Snow <jsnow@redhat.com>
References: <20200929134214.4103-1-eafanasova@gmail.com>
 <b055221b-c436-1ff3-b986-5a522178fde8@redhat.com>
 <db5d1fc04bdb15da6c9ecf65402a784aab856ede.camel@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <072ee259-f3e1-a354-abec-58cfe3d0d4ac@redhat.com>
Date: Wed, 30 Sep 2020 15:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <db5d1fc04bdb15da6c9ecf65402a784aab856ede.camel@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/20 14:15, Elena Afanasova wrote:
>>> +    WITH_QEMU_LOCK_GUARD(&job_mutex) {
>>> +        if (ns != -1) {
>>> +            timer_mod(&job->sleep_timer, ns);
>>> +        }
>>> +        job->busy = false;
>>> +        job_event_idle(job);
>> Is this new macro safe to use in a coroutine context?
> Hi, I suppose it's safe. It would be nice to get some more opinions
> here.
> 

Yes, the macro is just a wrapper around the qemu_mutex_lock/unlock
functions (or qemu_co_mutex_lock/unlock depending on the type of its
argument).

Paolo


