Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DA5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B1120671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Skoj3Dpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B1120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnik-0004EQ-0s
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnfF-0006TQ-17
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:03:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnfD-0004ue-V8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590076998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=577uByj+utB3WmKsW7Sx2nf9e7K/WWiqzqykQ3ucTKA=;
 b=Skoj3Dpce0gSkgJCOB1CplCJCNv8XtJxMB55ihMi8fTUfwhR3EAGNWfRiVLOTzAvXV3bgs
 lhTGMzvof/hDbP/Pbvq9zdlzdNx09pzn1Ao21HtTqhXhbJIYUP6FLYzObBm04pezewROts
 Uh+nJeuZ+6ld6lUUet572VUKOUy+N6U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-c559O1ltPUKbqo_EuXxtpA-1; Thu, 21 May 2020 12:03:16 -0400
X-MC-Unique: c559O1ltPUKbqo_EuXxtpA-1
Received: by mail-wm1-f69.google.com with SMTP id t62so2845027wmt.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=577uByj+utB3WmKsW7Sx2nf9e7K/WWiqzqykQ3ucTKA=;
 b=DSQKT4owU46/QhjwOtqabEuOSL28EN/UTRnmrMR6dxV4/487IMjMulTNOb2kkUfO/1
 UCxJspw1SpR2MiFqlAf0h6YdXeNRzTVFCscECkTo5QIMu++qcy+HL21elhJIb0lnHsFk
 FWkl+UoEMDpGksFla+7iNgEdr67vTXRF43Qumc1NaCtX2gd0CtJGM7NiYkSk5viGpL3A
 DdnDUIpTb3cVTdLhIE1SLeBsjIdSPk5DpMtjyHrRtw0N+knpEFpjTS7EkHjhckxs1omt
 RTo/IREXklf7WwbfJ3AEq2YymznNrfvEeGmsxg6lTeMRr1/XBaG+EHAdE6qIcwAtS8OP
 MtuA==
X-Gm-Message-State: AOAM532v26mW1dLmSRmFkI4ZImlieqQaSBiuLE7LXs9OX7CdoMHlN+rj
 XjeegcD0szn6Dy+4HR2YAoJO9kFmEenWjrQO6TCRwN2DNzjSQoeJY3xQYsqHK10WwE94tzSVT8B
 ipiNooj3P4PazZ2c=
X-Received: by 2002:adf:ea05:: with SMTP id q5mr8666059wrm.87.1590076995294;
 Thu, 21 May 2020 09:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt0pmKuFkHvq+4qHDTsMuN0/SlPGxBSPoYt/9sGBsmehiTuNKiDF3dLZCUJmh1biyFB5wFuA==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr8666030wrm.87.1590076994991;
 Thu, 21 May 2020 09:03:14 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id c16sm6669111wrv.62.2020.05.21.09.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 09:03:14 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] hyperv: VMBus implementation
To: Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
References: <20200424123444.3481728-1-arilou@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fd3d2c9f-f163-f430-caf3-6468b6ac7548@redhat.com>
Date: Thu, 21 May 2020 18:03:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424123444.3481728-1-arilou@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, liran.alon@oracle.com, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/04/20 14:34, Jon Doron wrote:
> This is a rebase of the old patchset from Roman for HyperV VMBus
> implementation.
> 
> How to use:
> -device vmbus-bridge
> 
> Later on new paravirtualized devices can be implemented on top of it
> (Network/SCSI/etc.)
> 
> VMBus is a collection of technologies.  At its lowest layer, it's a message
> passing and signaling mechanism, allowing efficient passing of messages to and
> from guest VMs.  A layer higher, it's a mechanism for defining channels of
> communication, where each channel is tagged with a type (which implies a
> protocol) and a instance ID.  A layer higher than that, it's a bus driver,
> serving as the basis of device enumeration within a VM, where a channel can
> optionally be exposed as a paravirtual device.  When a server-side (paravirtual
> back-end) component wishes to offer a channel to a guest VM, it does so by
> specifying a channel type, a mode, and an instance ID.  VMBus then exposes this
> in the guest.
> 
> More information about VMBus can be found in the file
> vmbuskernelmodeclientlibapi.h in Microsoft's WDK.
> 
> v4:
> Decided to ditch the patch that envolves handling of EOM as there is
> still a discussion going on with it in the KVM mailing list.
> 
> v3:
> Fixed an error asan
> 
> v2:
> Rebased on top of latest patchset from Roman and Maciej
> 
> Jon Doron (6):
>   hyperv: expose API to determine if synic is enabled
>   vmbus: add vmbus protocol definitions
>   vmbus: vmbus implementation
>   i386:pc: whitelist dynamic vmbus-bridge
>   i386: Hyper-V VMBus ACPI DSDT entry
>   vmbus: add infrastructure to save/load vmbus requests
> 
>  Makefile.objs                    |    1 +
>  hw/hyperv/Kconfig                |    5 +
>  hw/hyperv/Makefile.objs          |    1 +
>  hw/hyperv/hyperv.c               |    8 +
>  hw/hyperv/trace-events           |   18 +
>  hw/hyperv/vmbus.c                | 2778 ++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c             |   43 +
>  hw/i386/pc_piix.c                |    2 +
>  hw/i386/pc_q35.c                 |    2 +
>  include/hw/hyperv/hyperv.h       |    1 +
>  include/hw/hyperv/vmbus-bridge.h |   35 +
>  include/hw/hyperv/vmbus-proto.h  |  222 +++
>  include/hw/hyperv/vmbus.h        |  230 +++
>  13 files changed, 3346 insertions(+)
>  create mode 100644 hw/hyperv/trace-events
>  create mode 100644 hw/hyperv/vmbus.c
>  create mode 100644 include/hw/hyperv/vmbus-bridge.h
>  create mode 100644 include/hw/hyperv/vmbus-proto.h
>  create mode 100644 include/hw/hyperv/vmbus.h
> 

Queued, thanks.  I'll take a look at the EOM handling threads next.

Paolo


