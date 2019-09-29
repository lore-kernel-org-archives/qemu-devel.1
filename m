Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98657C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 18:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC1C20815
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 18:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brw5BfrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC1C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEdhv-0003r4-CZ
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 14:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iEdgg-00037C-Ou
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 14:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iEdgf-0000He-D8
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 14:12:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iEdgf-0000CV-3a
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 14:12:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id y19so8518304wrd.3
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2019 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X/aRNGmEubqqqJ2Obnnv7ec/BJj0Pg670lU/1ceOKRI=;
 b=Brw5BfrUt7btO8H2AuXsZJQMnybyW9FqND01f/LTxYMctbfxScpmSBWARQaV18jFXQ
 4tDdNtfYtPLhxLxW6agrDr6iN6b2ctaZRinRqvFTQs55104e2w9f+oIglaqzjARb13D9
 1mRC0I4H5aDypRHdWR2vdlKHl6Cslkpz/dZXXtIy7JEVrehKMzYl1zKuJOAi5TuzSukj
 clZKpHKYnS40oNjhB4WlhiOl4XTR8c2bzFhp8Wi9yUE17TEIqqFMrLcy8rC7CF+oGF+v
 hHrWEBCE2YIXqvXo6Wfr5ZS+bTG94n/ToBCUhM4GKz1da4+70h5jgc4TyckcFHR3yb0B
 2kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X/aRNGmEubqqqJ2Obnnv7ec/BJj0Pg670lU/1ceOKRI=;
 b=sxKh4hjoBd1xOC66dc99fIkaFKwMNY8jzO6jRIIo47KUwXf1lsLmEkVKbvwy9UofZU
 O7UlAuDKZZu3nfh7q6PsxI0jQjbwcmXAt8PDJMs+krimq+WaVSdM+825xMcLIgzbYpNa
 EbRRdjdMiDM651HLCaDH7t7wvsJ+AfluilE4dpMwLGHrBd9H1buC+P38q747+4fV+WKT
 EkaR/f0LuIGRkl6qY0EuWUBTNZWxeKsuRON3Ym9942pEknm369iHlW8X66yVSWzlDu7c
 MO/rCo6oIQph4lbQYGpYMeSS4UUd5AJ+R/V5kz/g/ow87b2MOiMksjcEr2iYsygyzVEa
 jQ6A==
X-Gm-Message-State: APjAAAXUP0kK+cZhDjcAOAc1hrHhkBv1Q7fpeRP6ZzVnKJiwGAX84GFb
 Lp7MAs5oBv0eVWYCzOj3SpHjgCKo
X-Google-Smtp-Source: APXvYqxjYhfXdtWLrqP/GJOD7KzckoGoCRB/vejdTnyPCuZU8W5BKdau+5jgFAZ94Fl9HoLpaQZjrw==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr8139975wrw.237.1569780766168; 
 Sun, 29 Sep 2019 11:12:46 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc::5?
 (2a01-036c-0113-e8f4-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:e8f4::5])
 by smtp.googlemail.com with ESMTPSA id f66sm13280058wmg.2.2019.09.29.11.12.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 29 Sep 2019 11:12:45 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [PATCH v4 21/24] paaudio: channel-map option
To: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
 <8f650662fd6cc50baaede260581aeb560eed44fb.1568927990.git.DirtY.iCE.hu@gmail.com>
 <87o8zbma1m.fsf@dusky.pond.sub.org>
 <55ea6ac9-9651-e322-fd84-22b4bedb3a93@gmail.com>
 <87impgy3hw.fsf@dusky.pond.sub.org>
 <20190925141331.kjxraaw3ijzkbiq4@sirius.home.kraxel.org>
Message-ID: <a32c555d-9315-7c3d-e7be-d196ad3dd0b1@gmail.com>
Date: Sun, 29 Sep 2019 20:13:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190925141331.kjxraaw3ijzkbiq4@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-09-25 16:13, Gerd Hoffmann wrote:
>    Hi,
> 
>>> Oh now that I looked again at the pulseaudio docs, channel-map doesn't
>>> have to be a list, it can be also a "well-known mapping name".
>>
>> Unambiguous because the well-known mapping names are not valid channel
>> position list members.
> 
> Do we have well-known mapping names for the common use cases?
> So maybe just support these?
> 
> cheers,
>    Gerd
> 

It's surprisingly hard to figure out what are these "well-known names", 
I could only find them in the source:
https://github.com/michaelwu/pulseaudio/blob/16e3dccfa88455ebd329de27a98a3d979a8bdc8e/src/pulse/channelmap.c#L538

It doesn't provide much over the "auto detect channel maps from the 
number of channels" pulseaudio already has (the only ambiguous case is 
surround-41 vs surround-50).  IIRC I originally added this feature 
because USB audio and pulseaudio didn't agree about the order of 
channels, for example in 5.1 pa defaults to 
left,right,rear-left,rear-right,front-center,lfe while USB audio expects 
left,right,center,lfe,rear-left,rear-right order. You can't specify this 
with the well-known names.

Regards,
Zoltan

