Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8767C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9ED20797
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIkHLYUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9ED20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0UX-00066Y-NA
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVzcE-0000X6-DV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVzcA-0006oe-Vg
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603469305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lib8ul2hnM2Ay7nyb8PdPlhe2nUjSLdqJ57iNBIPOzc=;
 b=hIkHLYUObYlpwj6zkXHNYkG7oTkTtVt6FNPnm5rx0pCRzot3D8quG0RDCIAbj0109lOqqA
 2EWBfK5pJ9KfdqVXpYrVwxK+cXndHdhP/aJscKsJMUhFanIrkMJKA+KlHKElr7oRU2C8jh
 2rUInvmsXU469Mx7LN61l5+fFncIyNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-JZyZH_sDMBaUkhvoKaYleQ-1; Fri, 23 Oct 2020 12:08:23 -0400
X-MC-Unique: JZyZH_sDMBaUkhvoKaYleQ-1
Received: by mail-wm1-f70.google.com with SMTP id r19so624882wmh.9
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lib8ul2hnM2Ay7nyb8PdPlhe2nUjSLdqJ57iNBIPOzc=;
 b=Q4s29BQnK85JpupVv8rOZnBluKymWrsZLCQi6x8hcC/foqBXd7JH/R8iW5ycDQwoUx
 ScBaKXJyfl7NI22ndWZisU9hO5UoNpaM2wA1fs+7nNbolg8eSr0Ak++wef8bufjF9++f
 EQbCyAZ6Dp5PmbXgEJvyt3z6dARQT2rXI69ZJwpCXT6nhQw1IBHHrLgWBZ9zOoRwAxWa
 KMhWTlcyTLeJiWHyTTuQYJqfxXZ2EOJxG52ZiJNN7MX1ITyiJ7UnT+xVh+ShzPFEAYQQ
 JkBLrcq7skTwCPuqnhdfkceBJ6WGuQLDfFJ1r5GJZUP1aLkuQFR44ZDtCqC4fBD8HvBK
 gPcA==
X-Gm-Message-State: AOAM533NcuTCX2lsYit2BjIm47UED/jJ+oP+yzORTqWdHkjdbJky+c7I
 VU9IUjKnO+++8Oe3RZB4Yn/r6ZSXKHmZgoFycs1RhEzpGUu3mBeZWDEV6mhExXSyYD1Ijy6TR34
 a232rK/34azv2qhU=
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr3209989wmk.91.1603469302450;
 Fri, 23 Oct 2020 09:08:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxThHLjO2aKi6T7AfhEEZxsXH9f0xfl8lPunnF8HxcpLuENP4d1UNYf8qAc8W4kOddZJc6xGg==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr3209954wmk.91.1603469302175;
 Fri, 23 Oct 2020 09:08:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y206sm4461898wmd.34.2020.10.23.09.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 09:08:20 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023103603.GG445638@redhat.com> <87blgtoybe.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/6] qemu-storage-daemon: QAPIfy --chardev
Message-ID: <ae2ffc01-84e3-70bc-c764-b9a69eba6b92@redhat.com>
Date: Fri, 23 Oct 2020 18:08:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87blgtoybe.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 15:40, Markus Armbruster wrote:
>>
>> The benefit of the user creatable object approach is that we dont
>> have to add custom CLI args for different types of object, nor write
>> code to populate QOM from QAPI. The downside is that we're divorced
>> from the QAPI schema, so loose introspection, and have a different
>> type of tedious boilerplate code to write.
> Loss of QAPI introspection is the killer.
> 
> We have QOM introspection, but it's far too weak to serve as
> replacement.  Besides, two introspection facilities is one too many.

Wouldn't Eduardo+Kevin's work on object-add provide that too?

> Nevertheless, we need Kevin's work now to get a decent storage daemon
> CLI while that's still easy to do.  We'll have to promise stability
> soon, and then changes get much harder.

I think we haven't answered the question of whether qsd needs a CLI at all.

I looked recently at qemu_init and it struck me that, in principle, the
only _really_ necessary command line options for QEMU are -sandbox,
-name and possibly -trace (only to be able to trace the monitor).  For
everything else, one could use LISTEN_FDS socket activation mechanism,
or if there's no LISTEN_FDS environment variable open a QMP socket on
stdin/stdout.

For qemu-standard-daemon, that would be _really_ true and not just in
principle I understand that having a command-line can be useful to
developers as it's less unwieldy than JSON, but why does it have to be
stable?  Could we default to only 2-3 command-line options in the same
fashion, and only accept --blockdev and friends if the user starts the
command line with "qemu-storage-daemon --i-am-not-a-script"?

Paolo


