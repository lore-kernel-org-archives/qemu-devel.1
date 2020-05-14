Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12473C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64522065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSUKbFko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64522065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDAx-00009v-Uh
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jZD7P-0003Dt-Ov
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:37:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jZD7O-0006UN-7k
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589459859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0y6nJaMZhXP1jolp25B2s089NXrD2AuMR5kyFxxMgG4=;
 b=MSUKbFkoOQvz3yFGd1FYF9Hrxq7dcqprptTd6Xp8tbnysT/MDlm9OYtLJJdzj1uk/JOywU
 Fu6rz5FIet2bHB4bbKXvYpXOtHVZ0IHNh2qAL/k/EJ3Hq81ThozlBIaojzfZox8zrYPE0w
 vIArRNvvCMTsXk1CzvuZzppuZL6Fxes=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-hAqFIhhjPRqryGXHndKkuw-1; Thu, 14 May 2020 08:37:36 -0400
X-MC-Unique: hAqFIhhjPRqryGXHndKkuw-1
Received: by mail-wr1-f71.google.com with SMTP id 90so1500327wrg.23
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 05:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0y6nJaMZhXP1jolp25B2s089NXrD2AuMR5kyFxxMgG4=;
 b=OX9dTMh1dTHR/HweeIB/koYbPSy1SpyHQvSG0VOCCe+cgqYLwhhHvZ6ASdZX0/jpjo
 FHPkAiOPVxeJRi1CVd5Dz8IbAw1PvGFCinuymhN5a9s/vdgS7NjnW/7G3CKvWXOocxBu
 0/SqjfzhyAsYM2AQtE60RuWfCDy9iiDpMOg21N+ni4Y0/QQNCIajKndCwFD9SjaGHE8N
 LLOqMLFTVRYGh8ev03ynhYLu9KwmVzrqBQLRhEr5PgD8UZxVuebKEOCbn3Aq8Zr7lWf6
 zWzTtBd5KWlKwDaddZq0DWzP1QwUdWfrus4NxgiIHe0A7TpHSUQ+nclOnNqOyzTES0QC
 6Ysw==
X-Gm-Message-State: AOAM532g7UWtRlxY1n/Oj8ukwnOquz08zPmXn9gWQ5JJS8yZ1QWAm3YC
 9rXfIZea51qTjSRc8T7BXcK05yoQjrycJdlyfzgSGs3gos0X8l8bYa7X64wXYJY5u7Exsr2K/hw
 SBUNN4f6etH+eR+c=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr7524649wmi.86.1589459855867; 
 Thu, 14 May 2020 05:37:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSqviVDlr3rvpQkracila8FKxEp+YQcIFf6IDAWtK/JY0A7U7k0TvLCjhcsTUljEMklNJX6A==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr7524632wmi.86.1589459855641; 
 Thu, 14 May 2020 05:37:35 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.85.171])
 by smtp.gmail.com with ESMTPSA id 2sm3970739wre.25.2020.05.14.05.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 05:37:34 -0700 (PDT)
Subject: Re: proposal: deprecate -readconfig/-writeconfig
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
 <20200514085622.GB1280939@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1287b3b8-9fd0-04d5-1dd2-66b695dace5d@redhat.com>
Date: Thu, 14 May 2020 14:37:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200514085622.GB1280939@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/20 10:56, Daniel P. Berrangé wrote:
> On Thu, May 14, 2020 at 10:09:21AM +0200, Paolo Bonzini wrote:
>> IMHO configuration files are in general a failed experiment.  In
>> practice, they do not add much value over just a shell script because
>> they don't allow configuring all QEMU options, they are very much fixed
>> (by their nature).  I think it's more or less agreed that they are not
>> solving any problem for higher-level management stacks as well; those
>> would prefer to configure the VM via QMP or another API.
>>
>> So, any objections to deprecating -readconfig and -writeconfig?
> 
> Libvirt would like to have a config file for QEMU, but it would have
> to be one that actually covers all the config options QEMU supports,
> and ideally using a data format in common with that used for runtime
> changes. So for libvirt's needs the current readconfig is entirely
> useless.

Yes, this is what I was thinking about.

> For a less general purpose mgmt app, that targets some specific use
> cases I could imagine people might have used readconfig. [...]
> If we deprecate them, the only alternative users have right now is
> to go back to passing CLI args. [...] We'd be deciding to kill the
> feature with no direct replacement, even though it is potentially
> useful in some limited scenarios.
> 
> If we have a general strategy to eliminate QemuOpts and move entirely
> to QAPI based config, then I can see -readcofig/-writeconfig may be
> creating a burden of back compatibility on maintainers.

I don't see QemuOpts going away anytime soon, but I do see more QMP/QAPI
and less command line in the future as far as management tools are
concerned.  QemuOpts and HMP will remain for direct usage, for the
foreseeable future.

So I guess we can keep -readconfig but deprecate, or even remove,
-writeconfig.

Paolo


