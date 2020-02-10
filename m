Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76F1C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B152082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPVWN8a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B152082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17DT-0005Wt-KV
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j17CD-0004iv-TQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j17CA-0007Ex-Un
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:25:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j17CA-0007Eb-Pw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581333942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFcr+kDhdbToD6dYS/e2hsvNMgMtLb4QX8gVHGYRbxs=;
 b=ZPVWN8a5xFsN8CNY6aOVtkJsrDc6HCHrMN9rfmu6ACpr4evQK7280C2SzBQY5K+7Xbq24f
 P2qrQZpP9PZXbJrXOGeUBbuIbDDKLwvb+E9gBQBNnydrFG0IQqLiOj6clwjqff6SFLyhTo
 4h898S7SmyPnD99JwOZn83msC2wl1E0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-D8GyLo1dPEegS3PqLCMsIQ-1; Mon, 10 Feb 2020 06:25:38 -0500
Received: by mail-wm1-f70.google.com with SMTP id q125so2889865wme.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 03:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DFcr+kDhdbToD6dYS/e2hsvNMgMtLb4QX8gVHGYRbxs=;
 b=rA7ncBqkLme5etcv2DeeXQmJsRSVHCfInYgQ8QFanLJA+ffh+sbqAnMTgWeSns5AQL
 Bcu/z6YfWtxcwxGZ6vzrPt/MtPkiGQWJDN+wgi4BtSB3E4vPpBoXRXt0iKK7OXuaT8Ye
 yD8yBJg8qtCfHQeACBPihfSf7CH5XfQoCU3UQj/CFzZpaZsgzLRaiSnb1u3e5C8R8Xj6
 oFrRm58f0ZL3fKR7a/WQt3abGoKsHhJJODpXjfVOAR5NbqLjUwjyDMhCtfvMLxUWpA9d
 3SvWOGGZS/rscZThc7up64eJeCCKHMhqpBRLjSvZMaaLx/2MUx3W19ctNWvz+W3tr8Ig
 aFGg==
X-Gm-Message-State: APjAAAUqBYxzTtrg5DcE1w3ovWwUJpsTHaWlqkMFwd9WuHx4PwE0qE1A
 uQH6cMfPXgjW/Lh/yjoWWlrNp84AV+9ggtDEnE25nVpVP3rIhw+Sd+KsfA/oiYUAYNJQdqvCcup
 csAZ13s8hIdk8E7w=
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr15044838wmj.177.1581333937234; 
 Mon, 10 Feb 2020 03:25:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqx25MmZr+G16qgpWo9s9YYWOlY+yRo+ap88gdbim+NTAK1mCSGCWFKdCoo+YZKH648mp7wzug==
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr15044820wmj.177.1581333936998; 
 Mon, 10 Feb 2020 03:25:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id a8sm202969wmc.20.2020.02.10.03.25.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 03:25:36 -0800 (PST)
Subject: Re: VW ELF loader
To: David Gibson <david@gibson.dropbear.id.au>
References: <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
 <62d62fab-46a4-240b-037b-409ba859b93d@redhat.com>
 <47e6a49d-f1c7-aaf6-b9ef-7e81773cff6e@ozlabs.ru>
 <8993c6b4-2a2c-b7e5-8342-4db480d0af9d@redhat.com>
 <20200210073008.GE22584@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c40f83a1-6dbd-7223-e825-0ab153a36aed@redhat.com>
Date: Mon, 10 Feb 2020 12:25:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200210073008.GE22584@umbus.fritz.box>
Content-Language: en-US
X-MC-Unique: D8GyLo1dPEegS3PqLCMsIQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/02/20 08:30, David Gibson wrote:
>> Anything you put in the host is potential attack surface.
> Ok, it is attack surface you're concerned about.  That wasn't totally
> clear before this point.

Part that, part having to add backend hooks that weren't needed so far.

>> Plus, you're not doing a different thing than anyone else and as
>> you've found out it may be easy for block device but not for
>> everything else.
>
> Uh.. was that supposed to be "we *are* doing a different thing than
> anyone else"?

Alexey's question was "what is exactly the benefit", so "not doing a
different thing" is the answer (one of them).

>> Every platform that QEMU supports is just using a firmware to do
>> firmware things; it can be U-Boot, EDK-2, SLOF, SeaBIOS, qboot, with
>> varying level of complexity.  Some are doing -kernel in QEMU rather than
>> firmware, but that's where things end.
>
> Well, yeah, but AIUI those platforms actually have a defined hardware
> environment on which the firmware is running.  For PAPR we don't, we
> *only* have a specification for the "hardware"+"firmware" environment
> as seen by the OS together.

PAPR is a specification for the environment as seen by the OS.  But "-M
pseries" is already a defined hardware environment on which SLOF is
running.  There's nothing that prevents you from defining more of that
environment in order to run Linux (for petitboot) or your own
pseudo-OpenFirmware driver provider inside it.

Paolo


