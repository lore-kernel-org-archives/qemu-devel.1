Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9051C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A748208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK4Jq5F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A748208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP1jI-00089r-K8
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:22:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hP1iH-0007hl-C4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hP1iB-0002so-C2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:21:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hP1iA-0002pw-9u
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:21:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id l2so6907841wrb.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=k/XUqm90+eMcWm1U7/Bf7hjCL68GWmY87Y0I5RgNxJw=;
	b=lK4Jq5F8ufKE7SvUpEcMhkfSu/jEQ96KgZTLbfzyrJxQNAtckkZ+Zmf0IUiKMchSWM
	niVwNtqXjd3eYYHTlXB7CkjIIZcUEXAfrw6b2Ib+8ggXYHRE4ua2TQa5Dv+W2wgkcx+x
	U+VqFgHfWVBy8gkPvKwPaO/7xwwfhrCufygskLKQvsFqAy8xERdzOaqyb1pYV4p/ZZpE
	jFCYR951Kut5Z46raiYrr3bJNDdZ0y2QdpUliqAJoq8N2agNRdcXrUQPLuB6qK2fx05V
	22oQyx5i9/p4h3XlFEO6Txo4wbxDy1eClITnFlEmqDIBYHILZ3+5tC3R3TzkxSPpVsWQ
	XZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=k/XUqm90+eMcWm1U7/Bf7hjCL68GWmY87Y0I5RgNxJw=;
	b=Lywbajp+iFeUz1t1rCf0/uHG6EnwiTA4EoT9hEuL8jp5m1PC5QIkaReDSAxiLNdnyN
	zTsTinHB2f0UjDVXSvSj/WRFf55f69T5ugxjap5dofIaWVPflObgeTn9Mv3Eg43t7Auw
	/RrucrNf20P4OyGNVNUQ9TXEHFwVrJ6hUjVRx4DnWxTeHTBu9uBg3/wrW1NAgnnTli+t
	fub7SHHs4/KSfJqDbMs1aRzZgALp0picerJkevPu3NIcie30fziJx4/KbQm0Ge5qwwdJ
	2WhRvS4w0f150JXPpesLYoQ79X7a8zFf+j/Zk6+3bovPJ3mqRmbdvqL06642VpZWQfXL
	9AQw==
X-Gm-Message-State: APjAAAW1UPFGNxuYuZlD0/IReLCg22wrNrTZAtaps7MmZHEWiwKqiPnz
	tB7LYw0Er6sKGQZjMhTDRIiBvLUTgow=
X-Google-Smtp-Source: APXvYqyEzCMoNDBhUMk/1pBMutuDrkiPitO66Ns1x3ps59VSjyJTQ9osPru70ucfES9ChB+YaHr6tQ==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr6665963wrr.63.1557480057957; 
	Fri, 10 May 2019 02:20:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0d:c0b:ba00:6fce:9bd8:fb12:6a42])
	by smtp.gmail.com with ESMTPSA id 7sm7135659wro.85.2019.05.10.02.20.56
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 02:20:57 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
	<b6064b77-5ca4-03e1-80ef-027313096cb2@gmail.com>
	<CABSdmrkW6G23ZGDA7iLucM45vL0HHGsr2F76H0Mf8S0xkhPnsQ@mail.gmail.com>
	<3e619b5c-8fb3-2655-2d92-37598db098d8@gmail.com>
	<20190510085947.y62lttdtrg5cxx6b@sirius.home.kraxel.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <3fb8b79d-9f68-2342-d3ae-3aefa873109b@gmail.com>
Date: Fri, 10 May 2019 12:20:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190510085947.y62lttdtrg5cxx6b@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 3/3] ramfb enhancement
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Hou Qiming <hqm03ster@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/10/19 11:59 AM, Gerd Hoffmann wrote:
>    Hi,
>
>> Got it, thanks. Is a pity ramfb is not a PCI device :), it was worth the
>> question anyway.
> If you look for a simple pci display device check out bochs-display.
> It's simliar to stdvga (so ovmf and bochs-drm.ko can drive it just
> fine), but without legacy vga emulation, only a linear framebuffer is
> supported.  And code size is a fraction of stdvga ...

I actually need the ramfb display in conjunction with kvmgt.

I want to be able to save the VM state to disk, which is actually a kind
of 'live migration' as far as I understand, but live-migration can't 
work since
we use device assignment  (vfio-pci-nohotplug device).

I was hoping to be able to hot-unplug/hot-plug the vfio device,
but as the name suggests, can't do so since
the ramfb display uses fw-config to pass the configuration to firmware.

How hard/possible is to make ramfb display a PCI device and move the
configuration from fw-config to PCI configuration space?

Thanks,
Marcel

> cheers,
>    Gerd
>


