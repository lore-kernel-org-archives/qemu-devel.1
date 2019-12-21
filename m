Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E375C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 13:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578C721655
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 13:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZOj9jUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578C721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iif36-00061O-Fg
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 08:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iif2Q-0005Qe-Un
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 08:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iif2O-00076Z-Px
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 08:43:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iif2O-00073g-Jm
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 08:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576935800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JD0mbg52OUGlDcpVMiwsNyHTTSD8PNUusphZebUvI2Y=;
 b=HZOj9jUymR8hBCEGYebR8R0E0dMGkA8TjaNF7sdbuqHHtgVpNhPcj+sUlV0NIlV+Z56fE/
 4a2BK9EUdoI79QAY3zVIP/Q9QmLzMMijNncYDLoWaHLu/f+k02moUtmQBlZ0zUNVb3cD2b
 7BflAIEIRYgSpJGOr/FQZMM8PYQy++w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-wvJHZdjVMgOxPx5H15Jq_w-1; Sat, 21 Dec 2019 08:43:17 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so5203943wrq.12
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 05:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JD0mbg52OUGlDcpVMiwsNyHTTSD8PNUusphZebUvI2Y=;
 b=ndQH5HqpGqh6qW28mew5wY7sYFb1U0r7fkM0QVF3yUBLCabYa5tlC5bAieNQGSbLpl
 GBJKyPwD2TwxXUV3kJ5B495W/zCX3UOYm4e8DJMtcI+2HVqBWibEXLlYMcW/rpfvH+q5
 N2Har4nLHpm3YnoQ4CBvTN/G70OyvAVxsDdTEe7sKn9QOtR5kNlENW1hXamqb+fDaQpD
 EMieMTUgC2f5kcj3AGdLBEnJDlfjSdmYulgAST2AGQVz6VpeKxbfUl6nx5mhVj8CAbI2
 cStnUfpMn1SvkbjDo43R3wkcBM6CRYKo/PpNnM4vxh21CPQkrMHkmGterCatF7dL5Mn9
 Vf4w==
X-Gm-Message-State: APjAAAWSuwmoI7UmTS8yHwT6A+UwbFlCLDYtfRQzdCIzSQ27YKIG2yDO
 +XtWX0tvbkYYC89uaUbE4TGZ49QkuiOh8l/xENwcleaf3h5tdLh6b1BSFZk8kAs0GRm279uXpHZ
 CnZshSYvJLIivHQU=
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr22079635wmm.70.1576935796734; 
 Sat, 21 Dec 2019 05:43:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSjGMHAPy9zRCs6BzDjnNA6/Ba5Z8beOBTYqmQPU9ThAmehVSsZTEp5aknQsKzHvyEntwKmA==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr22079598wmm.70.1576935796435; 
 Sat, 21 Dec 2019 05:43:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id c4sm13219286wml.7.2019.12.21.05.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2019 05:43:15 -0800 (PST)
Subject: Re: Can we retire Python 2 now?
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <8736dfdkph.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c8bc635-96cc-ab3d-01d3-db97013cda3e@redhat.com>
Date: Sat, 21 Dec 2019 14:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8736dfdkph.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: wvJHZdjVMgOxPx5H15Jq_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, KONRAD Frederic <frederic.konrad@adacore.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/12/19 17:29, Markus Armbruster wrote:
> Python 2 EOL is only a few days away[*].  We made configure bitch about
> it in commit e5abf59eae "Deprecate Python 2 support", 2019-07-01.  Any
> objections to retiring it now, i.e. in 5.0?
> 
> Cc'ing everyone who appears to be maintaining something that looks like
> a Python script.
> 
> [*] https://pythonclock.org/

Fortunately Betteridge's law of headlines is not always true.  :)

Paolo


