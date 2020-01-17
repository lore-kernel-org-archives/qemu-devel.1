Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F3C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F202083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COJL5VZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F202083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTjH-0002uD-AN
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isThM-0001Ec-GO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isThI-0000Lg-Gv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:38:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isThI-0000Ky-8e
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579275487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQKKNBpX7lMv6Q0woal+0JMHUbqgudtlmSX4gmraNx8=;
 b=COJL5VZEYh9rH9Bzqxell2G4U8h+lFGLdcqD41sC58NL0Z1ZUnVepMaW3LDuLPjUNmd+/J
 aCQ25OE7JVW6tzL/+IQg4DRosyAnburQHVb6IL9aI7YKC9ZLz4y3xagKPzxX4GZzrrqYFj
 sFmyU3koNPVLrLelNOZIBf/Ob2frFcY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-Tw3ZzMR6OX6p1EqBSDWLpA-1; Fri, 17 Jan 2020 10:38:05 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so10634924wrh.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 07:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BQKKNBpX7lMv6Q0woal+0JMHUbqgudtlmSX4gmraNx8=;
 b=AfH2yXLlkFOxY4GPJ1gnXVWSBZUX78Sho6Gb8fDZyoM2dP5N7P/Ua9+df0ir2xmsOa
 gPzhPwMAmSGIXpIJMrE0CX6lhq2fkgflDG1CsekjmWD6+sKmu2ZE7+lfzid3YCugvajG
 a03dDfxewD9hlekxia/eHeU6bcRswZQqSaS9vtrUUX6aIkgEbuJEY302j6Xk0nrh6PCv
 kdz6LXHj1nShcTEO+19bN8TZw0Tsiyg5J0XdldzBKiEuJixzaQNUZ+aY3dZsMGPSs2DC
 EYNC+QTgUVWwywXKy7+6CHgGCQywpjqLGtln1r/IR0ZLC/W0j0PHz/qC6sS3DQ88KLJP
 aHBA==
X-Gm-Message-State: APjAAAX2XlWVNaW5luGL0QnQTUvNxAi9+Ddr1/4EsHgTYRXtKaGFmFcS
 TUx6ip4OK8uue6ajUTOOFPkYqG1mNXX5um1NSbl9XvfgQ1l8nWh0Yt0KfmUr7Qm+Rg4pKoUoJZr
 7R76UnwX0rOH+4y8=
X-Received: by 2002:a05:6000:1288:: with SMTP id
 f8mr3895219wrx.66.1579275484385; 
 Fri, 17 Jan 2020 07:38:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJrtrrJI67LAVdcughziljepH4Xv5DYny/a4FcOjVJ4I6Q3WuPPQtxlro9OmSyYNrXjJUdhg==
X-Received: by 2002:a05:6000:1288:: with SMTP id
 f8mr3895187wrx.66.1579275484127; 
 Fri, 17 Jan 2020 07:38:04 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c15sm34011187wrt.1.2020.01.17.07.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 07:38:03 -0800 (PST)
Subject: Re: [PATCH v2 66/86] ppc/{ppc440_bamboo, sam460x}: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-67-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001152149120.24151@zero.eik.bme.hu>
 <20200117114629.5b245c83@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d3d50fff-3449-ba3e-12f2-5b74e20a1e4c@redhat.com>
Date: Fri, 17 Jan 2020 16:38:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117114629.5b245c83@redhat.com>
Content-Language: en-US
X-MC-Unique: Tw3ZzMR6OX6p1EqBSDWLpA-1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 11:46 AM, Igor Mammedov wrote:
> On Wed, 15 Jan 2020 22:33:46 +0100 (CET)
> BALATON Zoltan <balaton@eik.bme.hu> wrote:
> 
[...]
> v2 basically works the same as original code, except of that
> instead of fixing up ram_size, it ask user to fix CLI to
> the same value.
> 
>> but I've not yet given up to keep current functionality
>> (also for other boards where this series would drop it). If you don't like
>> a generic callback then how about letting the board optionally specify in
>> the machine class next to default_ram_size some constraints such as
>> min_ram_size, max_ram_size and an array of valid_ram_sizes (like
>> ppc460ex_sdram_bank_sizes[]) that the generic code doing the allocation
>> could check and clamp sizes to the nearest valid one emitting a warning
>> and only bail out if constraints are not given. This would cover most
>> cases expect the e500 where it has an alignment without max so
>> representing it as a list of valid values is probably not practical (could
>> also have ram_alignment but then a generic callback may be simpler). Would
>> that way work for you?
> 
> I agree that we need to consolidate ram_size checks,
> that would allow to clean up boards that practically do
> the mostly the same. In the end it would allow to introspect
> supported ram_sizes which would be good for upper layers.
> 
> I even started something in that direction but dropped
> all of that patches as not directly related to this
> series purpose.
> Phillipe is also trying to something like this for raspi
> board.
> 
> As for clamping, I still think that it's not good idea
> to accept invalid value and fix it up.
> Users should get what they asked for or get a clear error
> (it's double true if user is management software as it
> won't read any sort of warnings, well not all human users
> would head warnings either as far as QEMU continues to run)
> 
> Anyways, most maintainers agreed to dropping fixups
> and generalizing checks or generalizing fix up for convenience
> of users frameworks are out of scope of this series.
> 
> Someone can work on these refactorings later on
> (assuming someone is enough interested in it)
> 
> PS:
> If you insist on fixing ram_size up, it would still be possible
> to do so locally within board. One can take all RAM that user
> provided and then create clamped memory region alias.
> It's rather ugly but will do the job without affecting generic
> code. (though I wouldn't volunteer to write up such a hack)

I think from the virtualization point of view, you don't want to 
allocate unused resources. Is that why you say it is "ugly"?

 From the emulation point of view, it is easier to stay as close as 
possible to the hardware, where sometimes resources are wasted to 
simplify the design (or reduce production delays).
If it matches hardware, clamping doesn't look "ugly" to me.


