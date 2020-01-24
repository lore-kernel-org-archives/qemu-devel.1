Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A24206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXTnicgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A24206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuw28-0006gc-M3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuw1W-0006Ge-S5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuw1V-0005AF-4z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:17:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuw1U-00059Z-WA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579861028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3UTYY8dX4DbW59tR8mPX2yb/BMKhJa1/w8WZ+G9Xkw=;
 b=VXTnicgXDszDccu7fld4U5NYOLcr4lMUp0pzHyS1N8oqd8FgGkUiSMmFIR9yjBIZCM4oKr
 wFJWKxt74LTe0shZbBhDJwbbznOmZd8QpsMXKJSrkmB9ostvcg0nS+TBz8ZPgSUOxnUby7
 J7SrWT+6Lv4TGhc7O3JaI+8Yhz1xZkE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-BHitnJqTNW6ChaI-Di2b8A-1; Fri, 24 Jan 2020 05:17:06 -0500
Received: by mail-wr1-f71.google.com with SMTP id f10so935193wro.14
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G3UTYY8dX4DbW59tR8mPX2yb/BMKhJa1/w8WZ+G9Xkw=;
 b=V1RZko75OGH5aVw3VKMbrsp4x55FnHyDcDG3aHwmsGo8TULT1PnZdvyS6KHpyBFFml
 3SAfgVeLqFDowruTmIQXXcON7ayIAykes6eU8w8tK4ON/Zu/Ng9xnN5fM0TqC+0urZTF
 X3fpq30ArpbUbsudL//Oo6bRUT48aHZ1tQ+KXUsy+996FhKuLeOo2dmkVGdfvcdgm0Fm
 Z2hNv5zQcr6Vi2P7R9uTEB0HmrppFh7kXle9katdIK2PU+tOZdzJ5ptn5xmIEq6HjGOt
 +jZH1PaldCIWdchFgB09CJnGqyxqFXYSpxPzv5teFzxmRxwSFvv+cYODlnHA1jmIoOzW
 B8bQ==
X-Gm-Message-State: APjAAAUpw5Tw9HrCut3kJUnEW0kez/ooJSVIxnh/IxPkr577pXJPNUC+
 9E/oxc8A9l3JYd1S+pa5BTu5k1637BZWfqSG2Ycm1KbJGUaJoRj4WafoGEwAd1CjvXIMq4jFv9b
 4IrzYkzJinhxpWcw=
X-Received: by 2002:a5d:448c:: with SMTP id j12mr3350506wrq.125.1579861025119; 
 Fri, 24 Jan 2020 02:17:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEbZzMOgO928+/f7DQHtEzW7ao4jwHZiTBAeQMJO2dvmjltLAc+SYRoc1jO68dTEfEasE/xw==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr3350482wrq.125.1579861024898; 
 Fri, 24 Jan 2020 02:17:04 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id y139sm6328863wmd.24.2020.01.24.02.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 02:17:04 -0800 (PST)
Subject: Re: [PATCH v8 00/11] Multi-phase reset mechanism
To: Peter Maydell <peter.maydell@linaro.org>,
 Damien Hedde <damien.hedde@greensocs.com>
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
 <CAFEAcA8G7zGwRkbGRjyK4P7KZ9V+cboBHwnTH=jJs4NWu7rMMA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81bde2c9-76d3-f5a0-3e54-089028be9dfb@redhat.com>
Date: Fri, 24 Jan 2020 11:17:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8G7zGwRkbGRjyK4P7KZ9V+cboBHwnTH=jJs4NWu7rMMA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: BHitnJqTNW6ChaI-Di2b8A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 11:05 AM, Peter Maydell wrote:
> On Thu, 23 Jan 2020 at 13:28, Damien Hedde <damien.hedde@greensocs.com> wrote:
>> v8:
>>    + patch 3&5: ResettableState::count type from uint32_t to unsigned
>>      (Philippe)
> 
> We'll have to change that back if we ever want to migrate
> the count (migration insists on fixed-sized types), but
> I guess we can do that when we get to it...

Oh I forgot about migration :( (this was just a suggestion, not a 
requirement).

If you are happy with v7/v8 you can consider to apply v7 instead, the 
only difference is a one-line change in Makefile.objs (which ends no 
modified) and few Tested-by/Reviewed-by tags:

https://patchew.org/QEMU/20200115123620.250132-1-damien.hedde@greensocs.com/diff/20200123132823.1117486-1-damien.hedde@greensocs.com/

Regards,

Phil.


