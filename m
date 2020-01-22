Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00F3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9FD2465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dxe/DpPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9FD2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuJhs-0007kk-F8
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 12:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuJgd-0006zQ-2c
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuJga-0007W5-9n
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:21:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuJga-0007VI-5V
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579713658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCroRi6nqsUmGX8YgY/sDSTUH/n3JSjMuzA2J5b0Beo=;
 b=Dxe/DpPG4+Rn5u46SqZaZGu8gokps6jPgDjt2Zsb/Z235kOTHksgSAKvd9c7v80VvpJRC1
 73amb1Aebz021DUDukr2FP/rIQB7Fz/GnjYe6gXxDPCHp6KQ64CFTHGjapYF/GAgEBufmz
 LJvix3BK+bJ8NjQ7EsphmtTqZAwcZIs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-VOr3z2wAN-iYdeyD11DEYw-1; Wed, 22 Jan 2020 12:20:56 -0500
Received: by mail-wm1-f70.google.com with SMTP id 18so182930wmp.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 09:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KCroRi6nqsUmGX8YgY/sDSTUH/n3JSjMuzA2J5b0Beo=;
 b=YFidfY9xnW5yle58sO72JrYy52538qheL89gOY/X9sXkbry9gF78hbKzILxC7qVVDd
 aotFBMfgwKFhxkLXltq3WU/WLHcTDSKgN2LNVUhgdyQ6mzlfWcDK3b2NvD6T5RHPuMUH
 2Ii9b3RiyWKQBvVzI0o0jRMR+BzGo3DO12HdyWp/sOBA7evD+pemFyzSTPXLF6dsBfjW
 Vo0P0UfKLrAhW3KPViyCHwgDspIhyCofrpgCP56Eb3j0UsJKFsiYOvj6qroZp2nAcXPI
 40EznPZ/28INdGxMjEx1qqXO7r7maPXRoGccWIs4OD0F8fUUBcv0ZH8rHdHOyhfp+3Ax
 J+1g==
X-Gm-Message-State: APjAAAUYVHS7cddRJR2HRL/3SgPM7B0xDBOHhVEQkGi+ySB8VnkJjg3c
 LUkNVqhRoKX/ssHLhzp0GxoLQIgsuVoCmgjfyPfnG73kRYz7weE31NyN7q4onN73TtS5a5Ee4S/
 9u3V+l/m/RVTKRIQ=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr12140173wrs.11.1579713654938; 
 Wed, 22 Jan 2020 09:20:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLElHfx7qP9UzKoYboZnHHsYj29YDbu8FyHHGubFcuu9QfVMOjScikzmEUPqWT02X8AqiM7g==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr12140158wrs.11.1579713654706; 
 Wed, 22 Jan 2020 09:20:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id r15sm4781861wmh.21.2020.01.22.09.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 09:20:54 -0800 (PST)
Subject: Re: [PATCH v2] qemu-cpu-models: Document -noTSX, mds-no, taa-no, and
 tsx-ctrl
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
References: <20200121184940.26520-1-kchamart@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5fe2c318-6212-feb5-960a-d6b96c022d3f@redhat.com>
Date: Wed, 22 Jan 2020 18:20:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200121184940.26520-1-kchamart@redhat.com>
Content-Language: en-US
X-MC-Unique: VOr3z2wAN-iYdeyD11DEYw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/20 19:49, Kashyap Chamarthy wrote:
> Question: How can a user validate that TSX is indeed disabled for the
>           guest?

Look for rtm in /proc/cpuinfo, or look at the TAA entry in the sysfs
vulnerabilities directory.

> +@item @code{mds-no}
> +
> +Recommended to inform the guest OS that the host is @i{not} vulnerable
> +to any of the MDS variants ([MFBDS] CVE-2018-12130, [MLPDS]
> +CVE-2018-12127, [MSBDS] CVE-2018-12126).
> +
> +This is an MSR (Model-Specific Register) feature rather than a CPUID
> +feature, so it will not appear in the Linux @code{/proc/cpuinfo} in the
> +host or guest.  Instead, the host kernel uses it to populate the MDS
> +vulnerability file in @code{sysfs}.
> +
> +So it should only be enabled for VMs if the host reports @code{Not
> +affected} in the @code{/sys/devices/system/cpu/vulnerabilities/mds}
> +file.
> +
> +@item @code{taa-no}
> +
> +Recommended to inform that the guest that the host is @i{not} vulnerable
> +to CVE-2019-11135, TSX Asyncrnous Abort (TAA).

Asynchronous

> +
> +This too is an MSR feature, so it does not show up in the Linux
> +@code{/proc/cpuinfo} in the host or guest.
> +
> +It should only be enabled for VMs if the host reports @code{Not
> +affected} in the
> +@code{/sys/devices/system/cpu/vulnerabilities/tsx_async_abort} file.
> +
> +@item @code{tsx-ctrl}
> +
> +Recommended to inform the guest to @i{disable} the Intel TSX
> +(Transactional Synchronization Extensions) feature.

Not "to disable" but rather:

Recommended to inform the guest that it can disable the Intel TSX
feature or (if vulnerable) use the VERW instruction as a mitigation for
the TAA vulnerability.

Paolo

> Expose this to the
> +guest OS if and only if: (a) the host has TSX enabled; and (b) the guest
> +has @code{rtm} CPU flag enabled.
> +
> +By disabling TSX, KVM-based guests can avoid paying the price of
> +mitigting TSX-based attacks.
> +
> +Note that too is an MSR feature, so it does not show up in the Linux
> +@code{/proc/cpuinfo} in the host or guest.
> +
>  @end table
>  
> -
>  @node preferred_cpu_models_amd_x86
>  @subsubsection Preferred CPU models for AMD x86 hosts
>  
> 


