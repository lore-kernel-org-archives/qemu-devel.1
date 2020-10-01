Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B227FC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2828D21481
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYrdwm8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2828D21481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNxDO-0004G6-8p
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNxCf-0003qW-U0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNxCd-0003kD-0p
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601553409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kKYjzexrcRKyJc3eWEhp+JUa2LDnXieEC0EpOIgdmk=;
 b=CYrdwm8ofpVkIKEBIeUKVY1ihEZcBiUN0A3ZPs7u3M/XaT8S4ndh0xi0rNRwJZxHoRVtZp
 S216vrvZh5n3wR7ge7QKpHP14kCVCmaFCx/q7OeeSBB6y80lrlrK/drGQOUhYiX9biO4af
 nnO1PRlPP1QflXBlFg1NVPkon3+leA0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-ry1dPXvxMV60q8iu_XOKBQ-1; Thu, 01 Oct 2020 07:56:45 -0400
X-MC-Unique: ry1dPXvxMV60q8iu_XOKBQ-1
Received: by mail-wr1-f69.google.com with SMTP id j7so1966066wro.14
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 04:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5kKYjzexrcRKyJc3eWEhp+JUa2LDnXieEC0EpOIgdmk=;
 b=b09zs0ufOjHrpHwdG/Am1PokWHB113Q0afAyPtQzQMaxcA5oYn7zP2aHX0egJpDOwG
 u05/yM07WZw9xTsdorrvTRRzH49M9nJRY7AhgmvVmZZzSPVTKCV5pNKIgY1yhKxXL+GB
 PjgO3J6wVjSJDYwFCLVAT6U0RnzDQVcz2G5EIjPMkzRuU7G9s+Oeb4EQHMknoRfKokYk
 +07PZphoRMB/IfhERe7nFG0GnwnYjvaaqN5j7OtXeivv8XKEY7asAGWIaMmXKbtol55r
 8ynNvG1THs1ENG4IbC0N8hHsOtWpYFD+YxTceDfZyN+Wz7w6l6mD0J2Q7U6ud9dHRptU
 RVAQ==
X-Gm-Message-State: AOAM5327Moa6F4qTjpL3QWnP+kO5yW5ChvmyhlNwMfhR6bU+tyNZ/PZk
 xT/HBE+tiivxxa2Nn4Waw28EdYFAf5/nUIy99NENQxYPR43L49S+Rsir4pd7FtmHFPeDlG56R0H
 uEnCj+TDR1k73vK4=
X-Received: by 2002:adf:ec86:: with SMTP id z6mr8730940wrn.109.1601553404174; 
 Thu, 01 Oct 2020 04:56:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytqsKQjD5iKZCwbQT6cw2hWwfFR3cWxC6lV/sFHQzB8RNTkaCG3mrSQIKuo7vwkUNxQiWbdQ==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr8730924wrn.109.1601553403968; 
 Thu, 01 Oct 2020 04:56:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:86de:492a:fae3:16f2?
 ([2001:b07:6468:f312:86de:492a:fae3:16f2])
 by smtp.gmail.com with ESMTPSA id v2sm8943023wme.19.2020.10.01.04.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 04:56:43 -0700 (PDT)
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <9648157.mzsJ5Dm3EP@silver> <0cafb215-e49e-902c-4794-bdb696a892d6@redhat.com>
 <2296259.KyODYMqAT8@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6f5cc89-bdac-13a9-d7bc-c7b63a10da79@redhat.com>
Date: Thu, 1 Oct 2020 13:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2296259.KyODYMqAT8@silver>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/20 13:34, Christian Schoenebeck wrote:
> Paolo, I'm back at square one after changing to single-device model as you 
> suggested:
> 
> GTest: run: /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/pci-
> device/pci-device-tests/nop
> Run QEMU with: '-M pc  -device virtio-9p-pci'
> (MSG: starting QEMU: exec x86_64-softmmu/qemu-system-x86_64 -qtest unix:/tmp/
> qtest-18032.sock -qtest-log /dev/null -chardev socket,path=/tmp/
> qtest-18032.qmp,id=char0 -mon chardev=char0,mode=control -display none -M pc  
> -device virtio-9p-pci -accel qtest)
> qemu-system-x86_64: -device virtio-9p-pci: 9pfs device couldn't find fsdev 
> with the id = NULL
> Broken pipe
> 
> This fundamental virtio-9p-pci test obviously needs a complete 9p command 
> line, that is either a 'synth' driver one, or a 'local' one. But simply either 
> picking one or another is inappropriate here. This test should run once for 
> 'synth' and once for 'local'.

You're right, this is in fact also a problem for virtio-blk and virtio-net:

    /* FIXME: every test using these two nodes needs to setup a
     * -drive,id=drive0 otherwise QEMU is not going to start.
     * Therefore, we do not include "produces" edge for virtio
     * and pci-device yet.
    */

    /* FIXME: every test using these nodes needs to setup a
     * -netdev socket,id=hs0 otherwise QEMU is not going to start.
     * Therefore, we do not include "produces" edge for virtio
     * and pci-device yet.
     */

I still think we should do it like this, because it's closer to the way
that libqos will work long term.

Paolo


