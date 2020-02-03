Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10275C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03672086A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHnLYhJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03672086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydYY-0007PX-31
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iydXw-0006hX-BG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iydXv-0005s1-DT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:21:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iydXv-0005rR-A1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580743315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9At+nZaEasKYhmfApI+6SBZ6Q2I6/7ZwO8vjx03Ra6E=;
 b=DHnLYhJfg2lWnVUd8x4OnoMTq5Jj16QizSxxMpD9gKFreGHhopnXkvQGIXUoXA+xrDYhSt
 FXHtl1kJ/np9Rjr7Oyio9pGosPAsg/KhpXUHk7pAetED1q5ulrjo3wfxpAwm7l/FYBrx+r
 Gl8z2SI6Lzok0qx4mQw9GsF6SIL0HaM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-DruZxawwNVmZ6qJSKpODIw-1; Mon, 03 Feb 2020 10:21:53 -0500
Received: by mail-wm1-f69.google.com with SMTP id y24so4136385wmj.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 07:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9At+nZaEasKYhmfApI+6SBZ6Q2I6/7ZwO8vjx03Ra6E=;
 b=bUw9FA+wRdfZaW+zniIQl+9OsTcsw/kIYreUwV6D18jFyYFsxE0plXcAjKbkUUrmxE
 qrez3PEEDCj5GSnTDpmMoYNBGA4p0HcFvANw86EKdJdr2qr24dmUzFSO17HRMHDHYyDy
 JdQZvggcxlX8DQTWNzKalUnrhszdeui+LmjNkgRslDtQd3Ehp3WNOhj/ipS1HgoHjsy8
 hICjHx7Zslp9FAFX6Gr+epai8vqcJBTC3/MVM/wu9tMUGkS05moCbREXYt9+HCWN1wGO
 PuMbyuwz5+RhMFPR2fXjQCybpcUrtTpZLGMl6W2oKvhhuVtWZ+Y5xh9pfGCuuQm2ShkC
 pGcg==
X-Gm-Message-State: APjAAAXUSeNJlHeRBRxoyv+GQtUQlm7ccQUPM/J2CfjG9QwcLtVaGr99
 /NcUJf07vyPcXKqglnrDZRcD/ugCDpiktF5xVActo2sOKb7EACOXJl0S/xYvZCvil+wsHN7PN1Z
 ozS2vDEzL6Vv26GA=
X-Received: by 2002:adf:df0e:: with SMTP id y14mr15519034wrl.377.1580743312286; 
 Mon, 03 Feb 2020 07:21:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5RNZtTZJTmA3h7uvl5RHC0ZtGeOSdMR2KykWwTvGXF6HR120/45i+TpQ2iWMROw5Hkyt5qw==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr15519006wrl.377.1580743312108; 
 Mon, 03 Feb 2020 07:21:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id a1sm25657079wrr.80.2020.02.03.07.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 07:21:51 -0800 (PST)
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
To: Markus Armbruster <armbru@redhat.com>
References: <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org> <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
 <CAFEAcA-545QS9mnM6hwa6TxUpw_pDQ3Pa8tkf4qtzWS1Zi_fxQ@mail.gmail.com>
 <CABgObfaB=wHXyJbQR163bZdFHhWdCc4D8sWRHzte019_hSTuhA@mail.gmail.com>
 <20200131152243.GA24572@paraplu> <87sgjvbkvj.fsf@dusky.pond.sub.org>
 <b2a329bf-4795-14f0-473c-2a7cdfa4d262@redhat.com>
 <87mua02dyn.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1e1e489-9db4-383f-9734-a99626a2d548@redhat.com>
Date: Mon, 3 Feb 2020 16:21:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87mua02dyn.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: DruZxawwNVmZ6qJSKpODIw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/20 10:54, Markus Armbruster wrote:
>> Types are documented as above; however types other than link<> and 
>> child<>, which are QAPI types, can be user-defined types (structs, 
>> enums) and this is not included in (1).
> Specifically, three of four kinds of type names are documented:
> primitive, child, scalar.  The fourth kind is not, and it can be
> anything.  It need not be a QAPI type name.  In any case, you just have
> to know what the type name means.

It is not enforced, but it is supposed to be only QAPI type names
(primitive or not), child or link.

Paolo


