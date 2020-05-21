Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA6BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE75206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkvgMN65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE75206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnt6-00038R-13
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnrY-0001xB-6s
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:16:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnrX-0000q4-Bk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590077762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4D0sx/D1436pJxtm/MlnvGJCUdD9C0g+yedjUMX2Xw=;
 b=gkvgMN65EtzWws+ayNuX8Gl/pvuu/oYrULFwWXjj3DGb7pZMsn3d8de4Qek8ecdHzDFPAc
 D5WRRWZUfDYsPIHqXXmrP42jXosyrmw26yLW/fwCfSxhj9N6PzYt/hljkyw1c3kLz4ECCQ
 M5GZZ8BLfGzhOxrLrCYkmDIOxTNwt1M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-qtPjvPExNOqQu_4TV4VkNw-1; Thu, 21 May 2020 12:16:01 -0400
X-MC-Unique: qtPjvPExNOqQu_4TV4VkNw-1
Received: by mail-wm1-f70.google.com with SMTP id l26so2030559wmh.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a4D0sx/D1436pJxtm/MlnvGJCUdD9C0g+yedjUMX2Xw=;
 b=dKZYXDXMw6Z6jYYixDS4+4qtbJe/gw2/aTqAcjh81WiNi0SomyJM2+JIAztfaSAMCL
 kp8+6ncpHvhlZt2EVcznmHWE5PnIg6JVEsWzzSy/fBjLLqlHU/JUK38c7lWhETTa3oKO
 d88pxnvVOLbRGlTdA6Vyl3YzJSpEbmrjCTahm3gEEH9dOY5Sx5/QoLFZvQiky1btkBgh
 XMMuj94RIQnpJih7woy/j6ukxvH5A2Pu4DBmK3URz3ymE8g3qZ0fxCiix3e9JoyojfOr
 FUeZnU+JGkgDlx/3Qiy4d1PUwfE9YKxooDI1JN9w6d1ZheAYjUpsplxAXnM9ToVoXNJz
 efFA==
X-Gm-Message-State: AOAM533ohlsO/1k8w3OnQawm+aReQLRkmYkSVbwZ/bjm+moYGHfzcUZU
 y80CyXR2Y90jXhkThRnuoVRyx4Pmg5YgCKrEV0Yyhi2TC5ReV3oRh03DB4RAoV9ue8rgMmLNiS+
 f/YzIfTqO1b9AhOk=
X-Received: by 2002:a5d:4484:: with SMTP id j4mr9028901wrq.325.1590077759474; 
 Thu, 21 May 2020 09:15:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh992BCndRUljsznW6t7d3zH9DAqffSmHMG8eKn9Swl0EwD9FJGATxKQbzX2RFjgU1myIa+A==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr9028881wrq.325.1590077759249; 
 Thu, 21 May 2020 09:15:59 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id y5sm1740913wrs.63.2020.05.21.09.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 09:15:58 -0700 (PDT)
Subject: Re: [PATCH v3 00/16]: hw/i386/vmport: Bug fixes and improvements
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee1150ef-fd40-c76b-7cc7-518002429634@redhat.com>
Date: Thu, 21 May 2020 18:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/03/20 17:54, Liran Alon wrote:
> Hi,
> 
> This series aims to fix several bugs in VMPort and improve it by supporting
> more VMPort commands and make command results more configurable to
> user via QEMU command-line.
> 
> This functionality was proven to be useful to run various VMware VMs
> when attempting to run them as-is on top of QEMU/KVM.
> 
> For more details, see commit messages.
> 
> Regards,
> -Liran
> 
> v1->v2:
> * Fix coding convention [Patchew Bot & MST].
> * Create new header file for vmport.h [MST].
> * Move KVM_APIC_BUS_FREQUENCY from linux-headers/asm-x86/kvm.h
>   auto-generated header [MST]
> * Elaborate more that vmx-version refers to the VMware userspace
>   VMM in commit message. [MST]
> * Use le32_to_cpu() on BIOS_UUID vmport command. [MST]
> * Introduce VMPort compatability version property to maintain migration
>   compatibility. [MST]
> 
> v2->v3:
> - Repalce VMPort compatability version property with multiple boolean
>   compatability properties. [MST]
> - Prefix "vmx-*" properties with "vmware-vmx-*" to avoid confusion with
>   Intel VT-x short name. Prefix suggested by MST. [MST]
> - Remove VMX_Type enum and instead hard-code default vmware-vmx-type
>   value and only reference open-vm-tools for rest of values. [MST]
> - Add reference (link) to VMware open-vm-tools code. [MST]
> 

I actually agree with Liran on most comments, so I just dropped the
GETTIME and GETTIMEFULL functionality and queued everything else.

Thanks,

Paolo


