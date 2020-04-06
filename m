Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D31C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2CC2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpb5yrMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2CC2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOal-0005GM-1s
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLOL3-0001gi-N6
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLOL2-0005zo-MY
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:46:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55828
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLOL2-0005yu-J2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586166399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NSYbYw054NJkVL1fjapqeca668ySsYwttmemYsyJFg=;
 b=dpb5yrMuvFLw2wPuagsWdBrBngm9CC3rriQch4AyDLfhAq2RHTyVxYDnN7rnzSZAaMJngZ
 SfOJ902Zg662T3uV87owNZqwOOeqbdpG4t43W0TzWswrFVB4DQQ5vQfWrAa3/A9C5Ajoe3
 Ct1ImRyPdTuGeICnWD3JRjWN2xRfrlo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-_Y_96KRcM3OMfdo4raZXjw-1; Mon, 06 Apr 2020 05:46:38 -0400
X-MC-Unique: _Y_96KRcM3OMfdo4raZXjw-1
Received: by mail-wm1-f69.google.com with SMTP id o5so4703178wmo.6
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 02:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iO2rTxUejhgnMtVFCGlSVDFN+aK0Hsbfz46oSCWfJHk=;
 b=Oa1BxreD1USjms5MdcYHUuisJ8a5FMhHds7OKXvmCVuyii2q+E0MxWGA/Z5tjlrVuE
 p4YO69CfklJQPc1B7OoKATB0xMfo49nNmAvAH4neOb7xHpHzFsaaimQdpUv2nXTqZktQ
 N62l4FVhOihH8aCH4WWyNVpSqB1hazKWjIUDPQJ8tmv11MqIGIL43byM2fU79GsK6j1g
 ybDZlnO7e6PyMe0ogmi6rLvm+gym8Q782M6NyGljmai2CetPmr0ZcF9XnFPmGFXD9f0G
 Uj4yKcwoPKyrnc7iZRZ0Srg9HIhVJ+YtbPvg8/Fqpk9XV42qmMCFUCPR8Rxsmfi7/HTu
 /skw==
X-Gm-Message-State: AGi0PuYbXWZGW5CtEf2LFo86MSh6xIF1Paq7YCWJ0n0a2Wbus/9/9EWk
 71BnSSAyYJsJoA7hAytT1/7PNNb6Z8hop7zKxLfy1UuAg4Xr5T6mHCIwHLXqr/R+Q16K2+H1ALs
 Xuwf7Mnw1P8iHrAo=
X-Received: by 2002:a7b:c343:: with SMTP id l3mr22544379wmj.38.1586166397206; 
 Mon, 06 Apr 2020 02:46:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypKuD8AFuVst9vzuntesfb9xe5JjUaehSfhYlqaiN9ob+zKyrlBmhNrTgqsWjFD896+Pc2r8JA==
X-Received: by 2002:a7b:c343:: with SMTP id l3mr22544357wmj.38.1586166396946; 
 Mon, 06 Apr 2020 02:46:36 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id 189sm24744000wme.31.2020.04.06.02.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 02:46:36 -0700 (PDT)
Subject: Re: [PATCH] qom-qmp-cmds: remove unnecessary alloc in qmp_object_add
 to fix memleak
To: Markus Armbruster <armbru@redhat.com>
References: <20200313075858.15860-1-pannengyuan@huawei.com>
 <87a74fdznz.fsf@dusky.pond.sub.org> <87k12t9l7e.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3fe7d100-9e13-3d3e-c40a-1c19502fb0b4@redhat.com>
Date: Mon, 6 Apr 2020 11:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87k12t9l7e.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com, ehabkost@redhat.com,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 euler.robot@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/04/20 08:34, Markus Armbruster wrote:
> Paolo, looks like this has fallen through the cracks.  If you'd prefer
> me to take it, let me know.
>=20
> Markus Armbruster <armbru@redhat.com> writes:

Actually it was in my latest pull request, but between this version,=20
Marc-Andr=C3=A9 and mine you might have missed it:

commit 7f5d9b206d1e86425faa5b84b551068bf044b823
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Mar 26 10:41:21 2020 +0100

    object-add: don't create return value if failed
   =20
    No need to return an empty value from object-add (it would also leak
    if the command failed).  While at it, remove the "if" around object_unr=
ef
    since object_unref handles NULL arguments just fine.
   =20
    Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Message-Id: <20200325184723.2029630-4-marcandre.lureau@redhat.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo


