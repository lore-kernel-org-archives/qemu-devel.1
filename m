Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086EFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29DD206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxuDErya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29DD206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7xdl-0000CG-3y
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 05:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7xdA-00087w-RB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:10:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50357
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7xd9-0007hg-Bt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597741806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOKhHwHV+n0QibABihhGJ2NUQHLjmi+LaCvMAxhZCSU=;
 b=bxuDEryaRzu7/J49vqusXwN8yzsxmrPFB5yLW7It6o2RV+mldQnm/v3hXpyr/WfuYriXyz
 wf1iCNQDTERmF9z8O76fbv8GEZpKOtmXGY/JWkPeHpwyOTWtf4LFF0KXJere6FGgRX1r+q
 8jirpR5RzHWW33G3QXAi91SjqtElDsE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-5VKc3YHZOi6Dg4VO90mDjQ-1; Tue, 18 Aug 2020 05:10:04 -0400
X-MC-Unique: 5VKc3YHZOi6Dg4VO90mDjQ-1
Received: by mail-wr1-f71.google.com with SMTP id l14so8006918wrp.9
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 02:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GOKhHwHV+n0QibABihhGJ2NUQHLjmi+LaCvMAxhZCSU=;
 b=QDOa4+25uGkVGD81IycXTZh/wOpV+XP8P+Q6TTjwLWExbWSomslhWV6mkedpX/Dt69
 wI5+a9tjszAKlCbklLqyip1R+D6TQs+krB4HkK+PYqDwjJwo1bTlWMaCR6asEAlyVF6J
 qfYhEoDI9LeoQTrebhtdXodspiZB07FcyJWccVe+nXbFmPZuUTJf1upoolonjgI9klt8
 VWDVwhwT5UV6aB1lYgyMiD8BRE/5aomXAc3eOxF2uYEhYcvWc5OkUu60mxblVnguzXE7
 PLJx/NTVuZ8EO+rn4IUc5uzwX9ZRy+T9BqSabyC1dPxWqL9QFZuHf8B+naQ4R1rTKfju
 nX/A==
X-Gm-Message-State: AOAM533aMSIpqBxfzYeZHkbxt7w/sLjvfFg6U3WJ3Ku8ntpbunKDVrYj
 64RMmeE8BY+xRUSyLfNvjHx68xYb4FO543Pah2Z/SpFMGV1h+gPJeWyi6/Ueb46GqdvRJE/mDIj
 1xhdy5V4b7TicosQ=
X-Received: by 2002:adf:a102:: with SMTP id o2mr18941109wro.319.1597741803683; 
 Tue, 18 Aug 2020 02:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzma+orWjdtizYvVCrKrOiwglFVK/LpzfIbbj0cMSqcbTZLi684r+yUj3bPR27onGscv4/aRA==
X-Received: by 2002:adf:a102:: with SMTP id o2mr18941086wro.319.1597741803447; 
 Tue, 18 Aug 2020 02:10:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977?
 ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id t189sm33714122wmf.47.2020.08.18.02.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 02:10:02 -0700 (PDT)
Subject: Re: [RFC PATCH] os-posix: fix regression for install-less datadir
 location
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200716141100.398296-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c8090d3-9f81-77ba-6f8e-3f26b11ed77a@redhat.com>
Date: Tue, 18 Aug 2020 11:10:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716141100.398296-1-marcandre.lureau@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: joe.slater@windriver.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/20 16:11, Marc-André Lureau wrote:
> os_find_datadir() used to check the ../share/qemu location (regardless
> of CONFIG_QEMU_DATADIR). It turns out that people rely on that location
> for running qemu in an arbitrary "install-less/portable" fashion. Change
> the logic to return that directory as a last resort.
> 
> (this is an alternative to the patch "[PATCH 1/1] os_find_datadir: search
> as in version 4.2" from Joe Slater)
> 
> Fixes: 6dd2dacedd83d12328 ("os-posix: simplify os_find_datadir")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

For 5.2 I plan to support fully relocatable installs, so I think this
will not be needed.

The idea is to write a function like

char *get_relocatable_path(const char *dir);

That takes CONFIG_QEMU_*DIR as the argument, turns it into a path
relative to bindir, and tacks it to the end of qemu_get_exec_dir().

So for example all references to CONFIG_QEMU_DATADIR would invoke
get_relocatable_path(CONFIG_QEMU_DATADIR), which would return something
like "/usr/bin/../share/qemu".

Paolo


