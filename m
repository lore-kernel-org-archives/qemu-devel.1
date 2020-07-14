Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3EAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071C2221FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2vQEcFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071C2221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNgt-0007HC-A6
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvNg7-0006X5-Sw
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:21:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvNg5-00028q-RO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594743669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+8cuElV7urTDeBXt9SGgsI57OjIGEfYH+WapIy/aIz0=;
 b=e2vQEcFMJM6X9DOFfd4rJEmNo20To8oSybTjA2m8eNaCDHU/BwqvSe/G3tnXyUpGfKEaof
 WUTkZKOVpXXthG9JL0uKMh+2JOoaVsY1CGENlbT2qLpRMPycXKwJsIM2HSyK3XQlIdUX/6
 GCJrvMvcn7BJD5+8olCkU7JKjECewG0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-eLH6ANFCMa2fjMLZjmj0og-1; Tue, 14 Jul 2020 12:21:07 -0400
X-MC-Unique: eLH6ANFCMa2fjMLZjmj0og-1
Received: by mail-wm1-f71.google.com with SMTP id v6so4707771wmg.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+8cuElV7urTDeBXt9SGgsI57OjIGEfYH+WapIy/aIz0=;
 b=jyIA+fa8UbBcGWV/oI1zaXaBct1tHGmlRBkMQ4vZiw6MPbzGi80XsYPUa4BjTd+gK0
 wkKL3nf2xG36Wx59HfnF7O6fVFSWz6suuYIexo4kzkspUZ8H/4ncKrkoUA/dYRJGHoGU
 G+GxwF6D1dOUHMEBYxQDI4LX8/CQQqoI8jPwMzUlFa7kPSllurmof4P9sYH4IFPbaldH
 d9Ah8jjk110BGNDgWvfdwUkAMdT5ylL177sC4Lc0VtGceW26L5yTYSRP2JsPFCZsEIeD
 8hOyPaTMfpYgnxo1tRj7zEXrdBbpEkZvlDSecYeUxLQEiBN4+MpWcCK2jg5nXLSOE5/t
 lY8w==
X-Gm-Message-State: AOAM532U6J9Z7hlW0Gxb+gpWXw6ed/FYFvknTbEfrnWr8C26tiyRW42K
 ae0mCd1tOeHQkGrDQv5DDRPRQHzPnMPjyU/vJ3caNrV806w9XAgzRz5eEZ5t+LJ3LDwF9q2IGYJ
 mqY+j+sL1t58ZAso=
X-Received: by 2002:a5d:6107:: with SMTP id v7mr6670678wrt.174.1594743666249; 
 Tue, 14 Jul 2020 09:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjYktlRL47mWLioXCMu1hg5dosc/T+cGYFb2n6QjDJAGjHBMffL/6fSqtjuuNXqVSyIsVFaw==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr6670648wrt.174.1594743666026; 
 Tue, 14 Jul 2020 09:21:06 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 190sm5221323wmb.15.2020.07.14.09.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 09:21:05 -0700 (PDT)
Subject: Re: [PATCH for-5.1 3/5] qom: Change
 object_get_canonical_path_component() not to malloc
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200714160202.3121879-1-armbru@redhat.com>
 <20200714160202.3121879-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <10950d76-a58a-0e5f-ba79-71159c9ad4a3@redhat.com>
Date: Tue, 14 Jul 2020 18:21:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714160202.3121879-4-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, thuth@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 6:02 PM, Markus Armbruster wrote:
> object_get_canonical_path_component() returns a malloced copy of a
> property name on success, null on failure.
> 
> 19 of its 25 callers immediately free the returned copy.
> 
> Change object_get_canonical_path_component() to return the property
> name directly.  Since modifying the name would be wrong, adjust the
> return type to const char *.

Yeah!

> 
> Drop the free from the 19 callers become simpler, add the g_strdup()
> to the other six.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qom/object.h       |  2 +-
>  backends/hostmem.c         |  2 +-
>  block/throttle-groups.c    |  2 +-
>  gdbstub.c                  |  2 +-
>  hw/arm/xlnx-zynqmp.c       |  6 ++----
>  hw/block/nvme.c            |  5 ++---
>  hw/core/machine-qmp-cmds.c |  2 +-
>  hw/core/machine.c          |  5 ++---
>  hw/mem/nvdimm.c            |  5 ++---
>  hw/mem/pc-dimm.c           |  5 ++---
>  hw/misc/ivshmem.c          |  5 ++---
>  hw/ppc/spapr_drc.c         |  3 +--
>  hw/virtio/virtio-crypto.c  |  5 ++---
>  hw/virtio/virtio-mem.c     |  6 ++----
>  hw/virtio/virtio-pmem.c    |  5 ++---
>  iothread.c                 |  9 ++++-----
>  net/net.c                  |  6 ++----
>  qom/object.c               |  7 +++----
>  qom/qom-hmp-cmds.c         | 11 ++++-------
>  scsi/pr-manager-helper.c   |  3 +--
>  scsi/pr-manager.c          |  2 +-
>  softmmu/memory.c           |  2 +-
>  hw/ppc/trace-events        |  2 +-
>  23 files changed, 41 insertions(+), 61 deletions(-)
...

> @@ -303,7 +302,7 @@ type_init(iothread_register_types)
>  
>  char *iothread_get_id(IOThread *iothread)
>  {
> -    return object_get_canonical_path_component(OBJECT(iothread));
> +    return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
>  }

(Note for later, this one can return const).

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


