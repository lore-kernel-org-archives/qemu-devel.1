Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD6C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B704D206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sybRgILL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B704D206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD84Y-0001gX-Rb
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1kD83R-0007XB-Pc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:37 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1kD83N-00069w-L2
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=FoTSIO4liSZ40nlvRo1JYMp/cLuJTM8o2YUgwldWZEw=; 
 b=sybRgILLjZzFMZ7LS+MGuNuOZ7MMbJpkVg2AUZz3hycWOmGBaQ2CrRV2X2ywnJsooIi4ruspRIdWwVTPUtoUmeW2cv6WJjISK3kmYFogLpz4GgQHp5TeCxgK3sf6gZnoAoPOZzU0DTa8oP3HdJrZuarMkqWbXRIUQsnueFRW4leP9TaTbh2ubz9YYQQjhsv6F0HqIOHU+7zj8Y1esYjs0qvkujcncExO7T9DLDiqx+FZa6S5a2SqWnKxYjcR8d2m7a+S7zWLDMYSgzZoFXb8mvTY9od8V2m0zVw7w1uoyP4UaiSfHB3H67zU8mdmstVU7pH1/GzE+WuF1keZ6AxZtQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kD82h-0004EG-6H; Tue, 01 Sep 2020 17:17:51 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kD82g-0000Jb-SU; Tue, 01 Sep 2020 17:17:50 +0200
From: Alberto Garcia <berto@igalia.com>
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Roman
 Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v6 00/16] QEMU cpus.c refactoring part2
In-Reply-To: <20200901072201.7133-1-cfontana@suse.de>
References: <20200901072201.7133-1-cfontana@suse.de>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 01 Sep 2020 17:17:50 +0200
Message-ID: <w511rjl8r1d.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 09:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 01 Sep 2020 09:21:45 AM CEST, Claudio Fontana wrote:
> * in some cases the virtual clock is queried before an accelerator
>   is set or ticks are enabled with
>
>   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL)
>   
>   by the qcow2.c code (ending up in 0); maybe this should not happen
>   at all, as it could hurt migrations with the clock jumping up from
>   0? Should it be QEMU_CLOCK_REALTIME? (Berto, Paolo)

As far as I can see the only place in the qcow2 code that uses
QEMU_CLOCK_VIRTUAL is in the timer that clears unused cache entries
periodically.

I used QEMU_CLOCK_VIRTUAL because it didn't make sense to me to expire
cache entries when the VM is stopped.

I'm not sure about what would happen during a migration, is the qcow2
cache migrated at all? And if it is, would the clock jump up suddenly?
If it's just that I understand that the effect would be that the timer
would be fired earlier than expected, but I don't think it's a big deal.

Berto

