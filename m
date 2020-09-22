Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D760C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E76207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdGDKKND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E76207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKepD-0000BQ-GM
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKen4-0006mA-FU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKen2-0008G5-By
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600767647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcZXDbmm8K6dc/e0q/aUuC34Xa0RXIv+ARL8iLaiLKA=;
 b=YdGDKKNDhKlX7S6B9s8SrxdcGDwnV1MsYW4g5tozCClubb7RdZA11wfcpG9WHJuGfO46cA
 57ie76kpwQabeGpcp0rammg7WwfRomK5tHrE8B/9hZmEe/uqp4ltNNzTgU0nqYKtYq2FCa
 PkxcjIWAXQzu7UT/jkn0rNRDRdYY9g0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-t6ppbCiONRyYRvvvxP_JhA-1; Tue, 22 Sep 2020 05:40:45 -0400
X-MC-Unique: t6ppbCiONRyYRvvvxP_JhA-1
Received: by mail-wr1-f72.google.com with SMTP id r16so7141780wrm.18
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JcZXDbmm8K6dc/e0q/aUuC34Xa0RXIv+ARL8iLaiLKA=;
 b=B9cfJ7jYAG2hZnklE8OcS4CVcLfxjOyO+G3dLJ9A/+d3YN6Q7FQQWC3zMVdoCtIegg
 iEgjScjFJmZaNCLbzMeRcsw+cAjjSnUWyKggCgrDBMyoZUUyKod5c41lKsyH1Rv0T+3j
 qY7UKdqpRozm0nshHqhq+MPxyao8ZftAVT1cabkYqur/7nAEDWHR+tQBg3zmU0eWXdRq
 DfBu5bTj1yuwNzTeF/3EGMApjHW2ZkTCIHQkNCxZhR3LsNuhlDEKP7DH3/EEbsiR+qk/
 TaPHe0VDsMRd8Ok8eStKQOwszcuj/D3Y+lPbnXf8NwvEtxlESAz86emNboIl/NR66bCL
 MWPA==
X-Gm-Message-State: AOAM532OlVPMul0fqcpFMR8PaqL3Kc2Pajx6RPUUMUlOQLzRtyC8UhiH
 v+XIKQL4UQKO07A267RN+Kcf7bK/UgvG+XRU9BHb0157go7VxFOJvkPCc1SGtSdlbmXSUP2Iixq
 l8fdY6qMZFvhKORU=
X-Received: by 2002:adf:83c3:: with SMTP id 61mr4168374wre.287.1600767644410; 
 Tue, 22 Sep 2020 02:40:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgU+HI/ERoonjI/3fcPuubutXZeWfGi1H0e2BOTW+Gl0d29bP38JyJljoi79ytg5GQHl63CA==
X-Received: by 2002:adf:83c3:: with SMTP id 61mr4168350wre.287.1600767644144; 
 Tue, 22 Sep 2020 02:40:44 -0700 (PDT)
Received: from [192.168.10.165] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id s17sm26920605wrr.40.2020.09.22.02.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 02:40:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] hw/xen: Housekeeping
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200908155530.249806-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b4dc535-166d-9377-27ff-5d75f8978191@redhat.com>
Date: Tue, 22 Sep 2020 11:40:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908155530.249806-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 17:55, Philippe Mathieu-Daudé wrote:
> Hard to make an exciting cover of this series.
> 
> Basically:
> - Make better separation between Xen accel and Xen hardware,
> - Move stuff around to restrict PCMachineState to hw/i386/.
> 
> Since v1:
> - added missing include in stubs/xen-hw-stub.c
> - added missing 'exec/cpu-common.h' for ram_addr_t
> 
> (Due to a bug in 'make', while rebasing the archives
>  might not be updated... so I missed this missing
>  hunk as hw/core/libhwcore.fa didn't rebuilt stubs/)
> 
> Philippe Mathieu-Daudé (6):
>   hw/i386/q35: Remove unreachable Xen code on Q35 machine
>   hw/i386/xen: Rename X86/PC specific function as xen_hvm_init_pc()
>   sysemu/xen: Add missing 'exec/cpu-common.h' header for ram_addr_t type
>   stubs: Split accelerator / hardware related stubs
>   hw/xen: Split x86-specific declaration from generic hardware ones
>   typedefs: Restrict PCMachineState to 'hw/i386/pc.h'
> 
>  include/hw/i386/pc.h     |  4 ++--
>  include/hw/xen/xen-x86.h | 15 ++++++++++++
>  include/hw/xen/xen.h     |  2 --
>  include/qemu/typedefs.h  |  1 -
>  include/sysemu/xen.h     |  2 ++
>  accel/stubs/xen-stub.c   | 41 +-------------------------------
>  hw/i386/pc_piix.c        |  8 +++----
>  hw/i386/pc_q35.c         | 13 ++---------
>  hw/i386/xen/xen-hvm.c    |  3 ++-
>  stubs/xen-hw-stub.c      | 50 ++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS              |  1 +
>  stubs/meson.build        |  1 +
>  12 files changed, 80 insertions(+), 61 deletions(-)
>  create mode 100644 include/hw/xen/xen-x86.h
>  create mode 100644 stubs/xen-hw-stub.c
> 

Queued, thanks.

Paolo


