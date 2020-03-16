Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F222C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/um+fmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F222C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDm1P-0008EY-O3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 05:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDl24-0001Yy-9x
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDl23-0002MJ-BJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:23:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDl23-0002En-5e
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584347010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=th1CuOjYh6hNHqFjjcXMqr0tgWtWdl26IqVJEcJRP4w=;
 b=B/um+fmZ32IICOCGpuIZM+S6qdD6CNj91CYgUswgfJmfMQ9GBfNWDwbIMjsbSMIAfjlFGG
 FyWhTv60bw86W8rTCwCzKFQOOSzBYAYHJy8p80ULpG5wapKxjYwNvgzCd1Qgi7zzlyEiL6
 hXU8c56fL+6CZbiq5UydsV4IGWPnJPY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-qfTEmfHWPQuGsvtpMaz4nQ-1; Mon, 16 Mar 2020 04:23:29 -0400
X-MC-Unique: qfTEmfHWPQuGsvtpMaz4nQ-1
Received: by mail-ed1-f69.google.com with SMTP id g11so14433244edu.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 01:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=th1CuOjYh6hNHqFjjcXMqr0tgWtWdl26IqVJEcJRP4w=;
 b=lBAseg6Uq1LwosoiXjKV5zgiY3+1P5hoIXouTqv2EarLZ1Ia+H1gcDmswDd7bl17kw
 stAz8P0jFYmUaP1qnY2rDi9Uis+LvId+Z/ahWRzjZvKIgF0gWW09Vc35p4XvwfJCl1ze
 MdG5BC9QeKW72PqqsXJwC1fEkt3Wn93/UW+GJnPwTvBrYise7nFzVqqrQ8b7SEOW5Fyp
 a7iDU98nv6SDTL4owYDHb4ZGApiWx3rHX6cV+bhiV/Doyi2hq4+pNkbvv0tS6OxYG5XZ
 A2rtzWx4DvZ+ta/UgZkdsRB27RJ4yKNIk8CTFigj0Mtk1vP5Cju1J0b4RVO/0F9K1HXH
 X8Bg==
X-Gm-Message-State: ANhLgQ3XndH1va6yGIq0p/2SBKjkVD2OQr//GG1hrz0IvSlr2GPHjgZp
 SqyqhAXCIG1uxaCB8psdubbTxcxvdZn62ZTATJvAj1CKqEdgjkht3aCsDuyBKwq6YkGTrQn4Jf/
 DJ3PGDvP9UmK8pU8=
X-Received: by 2002:a50:d7d7:: with SMTP id m23mr10017623edj.277.1584347008186; 
 Mon, 16 Mar 2020 01:23:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt/J9IO+V8CKsGj2cJ++xKaqB+RasHyDr8LwGVfQpqVIgs0iVBa764L0KD737Ylc3F2Ijss6A==
X-Received: by 2002:a50:d7d7:: with SMTP id m23mr10017586edj.277.1584347007837; 
 Mon, 16 Mar 2020 01:23:27 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id g5sm4374247edn.9.2020.03.16.01.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 01:23:27 -0700 (PDT)
Subject: Re: [PATCH 4/8] hw/ide: Move MAX_IDE_BUS define to one header
To: Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <eb14ddee41be26f38ee0fe5ff0ff42c79afe9731.1584134074.git.balaton@eik.bme.hu>
 <8736a8n62u.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <acdb4bbe-9a4a-8d31-87fc-ab4d037e56ff@redhat.com>
Date: Mon, 16 Mar 2020 09:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8736a8n62u.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 7:53 AM, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
> 
>> There are several definitions of MAX_IDE_BUS in different boards (some
>> of them unused) with the same value. Move it to include/hw/ide/internal.h
>> to have it in a central place.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> This one feels a bit questionable.
> 
> The number of (PATA) IDE buses provides by a host bus adapter depends on
> the HBA.  It happens to be 2 for all HBAs we implement, but it could
> really be anything.
> 
> Similar for SATA, where the common number is 6, but could really be
> anything.  I can't see offhand whether any HBA we implement provides a
> different number.
> 
> By moving MAX_IDE_BUS to include/hw/ide/internal.h, you bake the
> accidental commonality into the interface to the IDE core.  I'd prefer
> not to.

I agree with Markus here (I kept this commit tagged because I was 
thinking the same but didn't know how to express it correctly. Thanks 
Markus!).


