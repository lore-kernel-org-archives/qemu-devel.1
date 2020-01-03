Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447FCC00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1226B222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0v+K7Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1226B222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inHDI-0002oe-3n
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 02:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inHCV-0002Ou-Mn
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inHCR-0002in-VM
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:16:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29355
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inHCQ-0002gi-9D
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578035804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDeQfIMIRxvH3cTwt9AXW4ExziOLk+PROZviRnSfmR0=;
 b=L0v+K7GpvvK52hEEhk6lGe5sXk3VRuU7ba3xKgMDgFX7g5D9VMSfZMN3KLm+nTKTzJFOwZ
 bQi4T+ysAm+Kc7s/76b7TOU97MwNFJzHIE2aGP8nL1rZfEHitGxyeLGvNA9KDAPs+FcPzR
 VMb6GREGnJ3tuxK78h9Yd3xTWBC/Bk0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-ERxjlTUKNpavT-ghm1xfUw-1; Fri, 03 Jan 2020 02:16:40 -0500
Received: by mail-wr1-f70.google.com with SMTP id z14so22847036wrs.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 23:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EDeQfIMIRxvH3cTwt9AXW4ExziOLk+PROZviRnSfmR0=;
 b=iM8/x3phn/EcfelJmd2ssxY2V2Ox5rJmHiFm/JL154N5Z37/Za2S18Q1a+kf039o5G
 kBgViwAMs/OBPHmgoaZEZYAJhbUoJ6KWMbYtvxsfBzjFoZtrqNh9iJBtAFOITIcscFUj
 QUeYgxFithAi+7i7iiFrI0yoqJCRcXF00OPp0CwEvHNUNA7SCpaynAJ9q5iMgxc7eCaJ
 3i7xJt+NBAb8j3xpft4yNoQI0tVsLgvIhKelrloGQwxgUvG0ffLd+RQktZi1tpa9b8hW
 xFeXKFj8zH0T9lKSgAwKx6P/vo50eiFU26d0m6tLWJ7zeS3wb3+hoJ0GsW3SGWnJiAct
 HXzw==
X-Gm-Message-State: APjAAAWAtMUGovdn5pvIaCqnIn2+kI/XgLogSMZAR8Z1hCeTbZYMP/jb
 +e8qoN5sCJSqN9MxAAGjvjSNa2qLOkJnlnvLIVEU2vt91sCi0BNm476m5fqcwzM4yfP1kIyZLw0
 stjAgVN5HWoNxwNg=
X-Received: by 2002:a05:600c:507:: with SMTP id
 i7mr18782434wmc.135.1578035798835; 
 Thu, 02 Jan 2020 23:16:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6XcFcwpmRW3NI8HjvdSwHvlvb454a8akLLvb6Gqz05WEff5+qqfNwGdEwPCZkH01Nqo0kVA==
X-Received: by 2002:a05:600c:507:: with SMTP id
 i7mr18782407wmc.135.1578035798640; 
 Thu, 02 Jan 2020 23:16:38 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id y22sm10851799wma.35.2020.01.02.23.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 23:16:38 -0800 (PST)
Subject: Re: [PATCH v3 0/3] Update capstone module
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>
References: <20191015175133.16598-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6651b95d-cca2-1173-027b-cc64b86a8ab9@redhat.com>
Date: Fri, 3 Jan 2020 08:16:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191015175133.16598-1-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: ERxjlTUKNpavT-ghm1xfUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On 10/15/19 7:51 PM, Richard Henderson wrote:
> Tested vs centos7, fedora30, and bionic (with and without
> system capstone installed).

Change noted while testing:

* Raw byte dumped as hexa

   before: no
   after:  dumped by 16-bit

   OK

* Address format

   before: "0x" TARGET_FMT_lx (16 chars)
   after:  "0x%08" PRIx64     (8 chars)

   Shorten this might be OK because we now also dump
   the raw bytes previous to the mnemonic/arguments

   -0x0000000000010014:  mvi       163,1
   -0x0000000000010018:  slr       %r0,%r0
   -0x000000000001001a:  lhi       %r1,2
   +0x00010014:  9201 00a3       mvi      0xa3, 1
   +0x00010018:  1f00            slr      %r0, %r0
   +0x0001001a:  a718 0002       lhi      %r1, 2

* Number argument format

   before: decimal
   after:  hexa

   -0x00010014:  mvi       163,1
   +0x00010014:   mvi      0xa3, 1

   OK

* (Priviledged) Instruction missing

   -0x0001001e:  sigp      %r1,%r0,18
   +0x0001001e:   .byte    0xae, 0x10, 0x00, 0x12

   -0x00010066:  lmh       %r0,%r15,0(%r13)
   +0x00010066:   .byte    0xeb, 0x0f, 0xd0, 0x00, 0x00, 0x96

   -0x0001006c:  sam64
   +0x0001006c:   .byte    0x01, 0x0e

   -0x00010088:  lctlg     %c0,%c15,512
   +0x00010088:   .byte    0xeb, 0x0f, 0x02, 0x00, 0x00, 0x2f

   -0x0001008e:  stcke     808
   +0x0001008e:   .byte    0xb2, 0x78, 0x03, 0x28

   -0x00010098:  spt       80(%r13)
   +0x00010098:   .byte    0xb2, 0x08, 0xd0, 0x50

   -0x000149b6:  stfl      0
   +0x000149b6:   .byte    0xb2, 0xb1, 0x00, 0x00

   -0x000149da:  stfle     0(%r1)
   +0x000149da:   .byte    0xb2, 0xb0, 0x10, 0x00

   -0x00011a34:  icm       %r5,3,0(%r1)
   +0x00011a34:   .byte    0xbf, 0x53, 0x10, 0x00

   -0x0010e8f6:  lpswe     160(%r15)
   +0x0010e8f6:   .byte    0xb2, 0xb2, 0xf0, 0xa0

Is it possible to fallback to the older disassembler on a 
per-instruction basis if Capstone doesn't know about an instruction?

> Changes for v3:
>    * Work around the various include directory nonsense.
>    * Re-add the s390 skipdata callback, as a separate patch.
> 
> Changes for v2:
>    * Drop the installed directory change.  This does force a
>      different include change when building from git.
>    * Drop the s390 skipdata callback for now.


