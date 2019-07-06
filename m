Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12A7C0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 19:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3A32075C
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 19:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vR9AJOTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3A32075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjq0V-0003AI-OT
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 15:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42802)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hjpzT-0002e7-0S
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 15:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hjpzR-0001HX-Rj
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 15:04:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hjpzQ-0001AD-So
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 15:04:53 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so12650958wma.4
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2019 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=UeNh02d7UKosEgVlOSHFnmwmb1e2sfBjxtflYVMg1gg=;
 b=vR9AJOTFPbeaN5grqeGgnZ5Yx8xmG/OhltmHiAuTfwPXmW04PmbSGBGaVgHfsouNS4
 m3I1vDqDZUCSyD08Os8QISHz4Sq2Jin+CSqafWLZVfrdvB8L4nzRcVTiyN4CO1vlNR1Z
 nV3gv5U+2VDHbaO06R61lUYz3JpUPmyLa2by1+jE6EcA093YEQsCm594XAiqiU5si3Fr
 S4zgv8uX+JNN/B4fr3iVXo6B1HRhbnHoK3NT09jPXUL1P3NkB6n2GazSiIJ9LiYKP9EK
 0iN7W5opo+oujo1ZiG/L0tZX4NR9DI5v7CrDEI+ki5bicIxoHboU6yhBJozGXixueU7y
 SBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=UeNh02d7UKosEgVlOSHFnmwmb1e2sfBjxtflYVMg1gg=;
 b=rLW86F5+j6lXoCOc4MfY1YOoUJE/AdfgO1jgsaY4lueiwNxMBIAjuoiVcnPsssTLOb
 hojCgtZirLqzl8DKARtLy/tOrKKWXHvicJFn15nqSw3Fwc9V2l+X39wvBOMzNvPzwFP2
 dbcXGVAaN2sCI9Ghhxy0Hu9N09oo9J4fNgoEjVuo/3qW25gmrvnijykezwxSPVcI9aUP
 BoYGWQu5VGLXPf+L04jn8tyQF+dh4ErztZ3tw2FSDhFS/oxZX9UWvP0JRAkduygsgmVJ
 Fq0T+wDHyC1rtppJ6R1MWv5CWWO/Xb44cKp6g2uzTnTIfWFRRujfAx+nhSpaQ70rg/OM
 sTWg==
X-Gm-Message-State: APjAAAV5DRLUJva/0hnWGcjXTwiKlstDGO8oHLR8o8wUm3FL1b/WnQ3+
 TAPOv6HGowvjjY7qQmWYunc=
X-Google-Smtp-Source: APXvYqxqw/4nBF8xZhTPNAR99Pdui1EfpEdNc/P1+NxONKcEzFPxi9khhjP0M8QgyLs75SiOdNyXeg==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr8544129wme.125.1562439882813; 
 Sat, 06 Jul 2019 12:04:42 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id w7sm8311489wmc.46.2019.07.06.12.04.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 06 Jul 2019 12:04:42 -0700 (PDT)
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org
References: <20190706040940.7884-1-skrtbhtngr@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <26ae890e-ca8a-6a5b-0d93-67cd266c8e93@gmail.com>
Date: Sat, 6 Jul 2019 22:04:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190706040940.7884-1-skrtbhtngr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC v2 0/2] Add live migration support in the
 PVRDMA device
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
Cc: Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sukrit,

On 7/6/19 7:09 AM, Sukrit Bhatnagar wrote:
> Changes in v2:
>
> * Modify load_dsr() such that dsr mapping is not performed if dsr value
>    is non-NULL. Also move free_dsr() out of load_dsr() and call it right
>    before if needed. These two changes will allow us to call load_dsr()
>    even when we have already done dsr mapping and would like to go on
>    with the rest of mappings.
>
> * Use VMStateDescription instead of SaveVMHandlers to describe migration
>    state. Also add fields for parent PCI object and MSIX.
>
> * Use a temporary structure (struct PVRDMAMigTmp) to hold some fields
>    during migration. These fields, such as cmd_slot_dma and resp_slot_dma
>    inside dsr, do not fit into VMSTATE macros as their container
>    (dsr_info->dsr) will not be ready until it is mapped on the dest.
>
> * Perform mappings to CQ and event notification rings after the state is
>    loaded. This is an extension to the mappings performed in v1;
>    following the flow of load_dsr(). All the mappings are succesfully
>    done on the dest on state load.

Nice!

> Link(s) to v1:
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04924.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04923.html
>
>
> Things working now (were not working at the time of v1):
>
> * vmxnet3 is migrating successfully. The issue was in the migration of
>    its PCI configuration space, and is solved by the patch Marcel had sent:
>    https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01500.html
>
> * There is no problem due to BounceBuffers which were failing the dma mapping
>    calls in state load logic earlier. Not sure exactly how it went away. I am
>    guessing that adding the PCI and MSIX state to migration solved the issue.
>

I am sure it was connected somehow, anyway, I am glad we can continue
with the project.

> What is still needed:
>
> * A workaround to get libvirt to support same-host migration. Since
>    the problems faced in v1 (mentioned above) are out of the way, we
>    can move further, and in doing so, we will need this.

[Adding Daniel  and Michal]
Is there anyway to test live-migration for libvirt domains on the same host?
Even a 'hack' would be enough.

Sukrit, another way you could do it is by enabling nested virtualization
and have 2 Vms as hosts. I suppose the migration will take some time 
though...


Thanks,
Marcel

> Sukrit Bhatnagar (2):
>    hw/pvrdma: make DSR mapping idempotent in load_dsr()
>    hw/pvrdma: add live migration support
>
>   hw/rdma/vmw/pvrdma_main.c | 104 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 96 insertions(+), 8 deletions(-)
>


