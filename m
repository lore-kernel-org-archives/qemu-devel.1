Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE9120709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUc0zPwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE9120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb0eP-0002bJ-41
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 07:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb0dT-0001hF-58
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:42:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32750
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb0dS-0001Ld-AC
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589888532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yaysbhkhicn1Ru1ZEMMVMvi0BgSX4QtdKWZN/r/+Ous=;
 b=GUc0zPwrgTZ/aX13EwOP6a1+iHJ/J0fCM/4Zdld1CRRAhU84YP9Uv+wb/33PKJcykhVpZa
 1sg+R7LxnymaNvTjm2c9ZuVzUCbnpnbDR36eqW0ghRleOT27a4SDGjiF5GKfZ3loHTIXo3
 dM4qK0G/1QSxNr0V0kXTHWaGyvCmT9Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-tQenrL1POjiJq9-lQhKL2w-1; Tue, 19 May 2020 07:42:11 -0400
X-MC-Unique: tQenrL1POjiJq9-lQhKL2w-1
Received: by mail-wm1-f70.google.com with SMTP id a206so875645wmh.6
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 04:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yaysbhkhicn1Ru1ZEMMVMvi0BgSX4QtdKWZN/r/+Ous=;
 b=rtmRG3B8zzlSYcn/Hki1bYGftYrIzWVHLjo1fljuLaklRUs5QVknIAjNCO/cUtFveG
 mXbcPnuJS/0Q7R3fOW5JP7axgkDjv0f9hkvdQqveRsjszsyhdEfEgrTp0Ggmk6NXLqb4
 oWecyZy9wpumr1LCWWc9+OMHwv+Uji4VtiRiCFoOWIA5nVQYbJcxh4iAE5KlOlpijjB7
 uZ8JjrZX4gIEH3TFxPGj+Fyn5+Iky4Xshm60g/fpCh+rYMs1KEZznvcfMyMyILOZObMa
 t4nelWze9A/hH2bYxn3z7mjzl7pnEqLSsu4Mo99NEKTa3ypdZee12uNG3PslJpMrt7+y
 lCUw==
X-Gm-Message-State: AOAM533GCsv1G8JLQjT/fqZ96XMO5csD3w0C6FtzkWYJE3QmRn3hM/Hz
 Y4GTptsHZNeLYxso7iYcxDE4Z91AVo2dlzc8zdd96flqvwqnr6c2guZbI6x1LetK37sOOFKkb6d
 AdzccQhjeF7Qdfvw=
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr26742850wrw.16.1589888530068; 
 Tue, 19 May 2020 04:42:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKidhxAGXTqNm6asekwimbwv6A1vuhnnKHVtfTdRdzY4fZBvNm+6ovHplBN55Lg4o7wVmt5A==
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr26742825wrw.16.1589888529830; 
 Tue, 19 May 2020 04:42:09 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r11sm21625621wro.15.2020.05.19.04.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 04:42:09 -0700 (PDT)
Subject: Re: [PATCH 04/24] aspeed: Don't create unwanted "ftgmac100",
 "aspeed-mmi" devices
To: Markus Armbruster <armbru@redhat.com>, Andrew Jeffery <andrew@aj.id.au>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-5-armbru@redhat.com>
 <9fc4a6e2-fa90-ba62-91cf-e22eb3ef4cdc@kaod.org>
 <eb1b203d-44ba-4b89-b96b-4e7bf993ac67@www.fastmail.com>
 <87v9ks5vg7.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9cfcba4e-1237-8eb9-7c83-490729f082fe@redhat.com>
Date: Tue, 19 May 2020 13:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87v9ks5vg7.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 7:45 AM, Markus Armbruster wrote:
> "Andrew Jeffery" <andrew@aj.id.au> writes:
> 
>> On Mon, 18 May 2020, at 21:49, Cédric Le Goater wrote:
>>> On 5/18/20 7:03 AM, Markus Armbruster wrote:
>>>> These devices are optional, and controlled by @nb_nics.
>>>> aspeed_soc_ast2600_init() and aspeed_soc_init() create the maximum
>>>> supported number.  aspeed_soc_ast2600_realize() and
>>>> aspeed_soc_realize() realize only the wanted number.  Works, although
>>>> it can leave unrealized devices hanging around in the QOM composition
>>>> tree.  Affects machines ast2500-evb, ast2600-evb, palmetto-bmc,
>>>> romulus-bmc, swift-bmc, tacoma-bmc, and witherspoon-bmc.
>>>>
>>>> Make the init functions create only the wanted ones.  Visible in "info
>>>> qom-tree"; here's the change for ast2600-evb:
>>>>
>>>>       /machine (ast2600-evb-machine)
>>>>         [...]
>>>>         /soc (ast2600-a1)
>>>>           [...]
>>>>           /ftgmac100[0] (ftgmac100)
>>>>             /ftgmac100[0] (qemu:memory-region)
>>>>      -    /ftgmac100[1] (ftgmac100)
>>>>      -    /ftgmac100[2] (ftgmac100)
>>>>      -    /ftgmac100[3] (ftgmac100)
>>>>           /gpio (aspeed.gpio-ast2600)
>>>>           [...]
>>>>           /mii[0] (aspeed-mmi)
>>>>             /aspeed-mmi[0] (qemu:memory-region)
>>>>      -    /mii[1] (aspeed-mmi)
>>>>      -    /mii[2] (aspeed-mmi)
>>>>      -    /mii[3] (aspeed-mmi)
>>>>           /rtc (aspeed.rtc)
>>>>
>>>> I'm not sure creating @nb_nics devices makes sense.  How many does the
>>>> physical chip provide?
>>>
>>> The AST2400, AST2500 SoC have 2 macs and the AST2600 has 4. Each machine
>>> define the one it uses, generally MAC0 but the tacoma board uses MAC3.
>>>
>>> Shouldn't the model reflect the real address space independently from
>>> the NIC backends defined on the command line ?

If the SoC has N ftgmac100 peripherals, you need to mmio-map the N 
instances, else your guest will get MEMTX_DECODE_ERROR trying to access 
it, regardless command line NIC plugged.

>>
>> That's my feeling too, though I'm not sure what to make of the unrealised devices
>> in the QOM tree. Does it matter? It hasn't bothered me.
> 
> Depending on what the initialization code does, unrealized devices can
> be anything from a little wasted memory to open bear trap.  I don't
> really expect the latter extreme in the code, as I expect bear traps to
> quickly catch the developer that set them.
> 
> I guess the unrealized devices cleaned up in this patch did no actual
> harm.
> 
> Still, it's an unhealthy state, and that's why I clean it up.  "[PATCH
> 24/24] qdev: Assert onboard devices all get realized properly" should
> ensure we stay clean.
> 
> 


