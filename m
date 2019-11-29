Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BDFC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F32A2176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9PD3GL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F32A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ial3Q-000744-Ai
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iakzZ-0005Vi-L0
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iakzV-0006L0-DY
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:27:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iakzU-0006Ee-TS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575052059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ajtSm/6Xh6jI6hCMKGqELWItIu4HcFCdsxL5TjdOio=;
 b=e9PD3GL2FI2gqKaB/KopY4eggsiXnyRKJ1hribsaT/vhq+MhhYMTc7Gm9ypBLD+/8KrCeD
 rtHtPN8d3tEIW5tBRlfmNZQ8eO/j8tLJFGPdT/TuHQDKmUa9OxoTw5r1HlXmgEn+/cmiBP
 pwkxQ9E4cuLeOXC/5iMOl2S93VWzWYQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-RStfoyO-Nw-jJDumBqSStA-1; Fri, 29 Nov 2019 13:27:35 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so15900659wrm.18
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 10:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ajtSm/6Xh6jI6hCMKGqELWItIu4HcFCdsxL5TjdOio=;
 b=HaC99N0smMCB78S7e+u4Jjp/lLMUkKGpmpYckYCbVINmCo5PTzK3l9ynk6efBgUiba
 bTYJeDt5NL5wpYh48yPwRjjBFxIlgbmz5wbgA6y7PodhMxTcFl4o+JuvfXjVsnORvo/r
 VxOVvXs9mBLsyw+6UZ8n7Rn6ovzmlA3g53H6r6V4tW+tTi2s9R+kPlUAg0Dpya0AXIW+
 hukuAwu0kFwIT9TMfDTd4KcCr2TKSamRas9P8Zy4JdmzKVEdc0Tn/PwnyBz3cEVEDT4M
 P304A2f3hv7DBRq2WE04Yar+0v+Fc9BOQ6+NTUy6xGyAm2UGsfjebaE4M45DTjLtEMkq
 ajfA==
X-Gm-Message-State: APjAAAWVrJyCBsdutlTprEVXO6FFl1u2+mV5dht7ANe0J6CYJ+OVDsnY
 xJcHmilTeNdkpDUJy99MdpAEWhDek6SGtR2QlH+3xgT5HMDiwCkZy64JhVrpkvRpb5zPRIltwvf
 kTQUxkegYhLtZwcg=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr19502107wrq.206.1575052054461; 
 Fri, 29 Nov 2019 10:27:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGp3oI0kSTqkIiLLpTWP/LtGFc+wxj8uaVoAM9WFhtG3x9rI18HF28fjsEmjAHHJbB5f91nw==
X-Received: by 2002:a5d:4692:: with SMTP id u18mr19502083wrq.206.1575052054154; 
 Fri, 29 Nov 2019 10:27:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0?
 ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id 205sm17357857wmb.3.2019.11.29.10.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 10:27:33 -0800 (PST)
Subject: Re: libcap vs libcap-ng mess
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191128190408.GC3294@work-vm>
 <20191129093409.GB2260471@redhat.com>
 <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
 <20191129180103.GA2840@work-vm>
 <1e59f880-1a62-3230-c56a-533f2b797525@redhat.com>
 <20191129182021.GD2837@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c024ad69-2b94-cdd0-e9d3-617188d82bc3@redhat.com>
Date: Fri, 29 Nov 2019 19:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129182021.GD2837@work-vm>
Content-Language: en-US
X-MC-Unique: RStfoyO-Nw-jJDumBqSStA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/19 19:20, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> On 29/11/19 19:01, Dr. David Alan Gilbert wrote:
>>>> It's not entirely trivial because fsdev-proxy-helper wants to keep the
>>>> effective set and clear the permitted set; in libcap-ng you can only
>>                      ^^^^^
>>
>> (Wrong, this is "modify" the permitted set.  The permitted set is
>> already cleared by setresuid/setresgid).
>>
>>>> apply both sets at once, and you cannot choose only one of them in
>>>> capng_clear/capng_get_caps_process.  But it's doable, I'll take a look.
>>> I'm having some difficulties making the same conversion for virtiofsd;
>>> all it wants to do is drop (and later recover) CAP_FSETID
>>> from it's effective set;  so I'm calling capng_get_caps_process
>>> (it used to be cap_get_proc).  While libcap survives just using the
>>> capget syscall, libcap-ng wants to read /proc/<TID>/status - and
>>> that's a problem because we're in a sandbox without /proc mounted
>>> at that point.
>>
>> The state of libcap-ng persists after capng_apply.  So you can just call
>> capng_update({CAP_ADD,CAP_DROP}) followed by capng_apply.
> 
> But the internal state needs initialising doesn't it? So that when you
> capng_update it tweaks a set that was originally read from somewhere?
> (and that's per-thread?)

Yes, it's per thread.  The state can be built from
capng_clear/capng_get_caps_process + capng_update, and left in there
forever.  There is also capng_save_state/capng_restore_state which, as
far as I can see from the sources, can be used across threads.

>> Does virtiofsd have to do uid/gid dances like virtfs-proxy-helper?
> 
> It looks like it; I can see setresuid calls to save and restore
> euid/egid.

Ok, then perhaps you can take a look at my virtfs-proxy-helper patch.
The important part is that after setresuid/setresgid PERM=EFF if
uid=0/gid=0 and PERM=0 otherwise.

Paolo


