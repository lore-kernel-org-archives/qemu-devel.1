Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D48AC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637632082E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVoHodmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637632082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5og-00083G-GK
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX5ny-0007Op-7k
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:24:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX5nq-0003kx-FF
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588955085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N16PM56c20HjCHU6EZjPv7GwWM6Oo3yOuvlJmbCHhxw=;
 b=QVoHodmbPOAz0tUIrhsus1P/dTvdgnVpcD2N7FgcBLkHjvq8EgmdAY11TxYt7mZLOzIHLe
 J9Ftm+cznebw6ABLy+dqbysSwI9sKpNOV4CNwdFEIn5fwdrfTsq1iU1eJbPXHf0oFDSx2x
 CM8wq+UfBTtrUQ5Qy10bae82rRx2VlU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-ywLsNgQmOYWs7ArcDytXHA-1; Fri, 08 May 2020 12:24:39 -0400
X-MC-Unique: ywLsNgQmOYWs7ArcDytXHA-1
Received: by mail-wm1-f72.google.com with SMTP id s12so5398083wmj.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 09:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N16PM56c20HjCHU6EZjPv7GwWM6Oo3yOuvlJmbCHhxw=;
 b=UkXGCcppbzUzWXFIyPFd0G3HfZgNMCvZ4OsXmNTDAUd9zU9/WKHEvTyTu916WAacQ1
 r7DMkcUCbg8Mnx/JhP3BxzOkIepckN/rWVINcvy/+9gsltK3Rn2wiMXM8TahU4x/SM6x
 Pbkt1jcU9mPS5FCj0XAveEThBNtp653LCpae0x+w10s1zEbqELY4RQeQdEY6qQk/cTYW
 tYrwaqIbt8GWAt1Emzq1k+Mu52caNOHgf2P5hOuqsftr3ND+dJG5M4ISpmPcfIBeIxDA
 ek1WHfNFVdpzBGjWLfRlOdE+ndl39b6t5VmDQZs8yQfUy2e62qb0HuHMUfFL1cKqoFZh
 bmaw==
X-Gm-Message-State: AGi0PuYAkN0Tq9B0oZ1e8EpPPsV5sHYXOlf6elSmawsj2/2lUtMqeX6p
 O7xm1oYqAkBQCkWOVR1ZNiDt36fTEcOwrmcLu6zP1ae32/W2Kb+OuN70Y5iRZWXTO00HcCKRf5A
 YdsEkaPPC1C0PCfY=
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr18112732wmb.156.1588955077782; 
 Fri, 08 May 2020 09:24:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypKAp90iCgoFfDb77/IePwZh6jVXnTtXgZSwrIbiGSq2NaoUT9Y1Pzpt+rmCaRKfutfkjwU/FA==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr18112700wmb.156.1588955077442; 
 Fri, 08 May 2020 09:24:37 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h137sm23015935wme.0.2020.05.08.09.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 09:24:36 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] user-mode: Prune build dependencies (part 1)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200504152922.21365-1-philmd@redhat.com>
 <7f19b263-5493-779b-cf86-b0499c7dc80d@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ecac9003-ef59-8cca-3aec-6aa26a9e092b@redhat.com>
Date: Fri, 8 May 2020 18:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7f19b263-5493-779b-cf86-b0499c7dc80d@vivier.eu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 11:31:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 10:33 AM, Laurent Vivier wrote:
> Le 04/05/2020 à 17:29, Philippe Mathieu-Daudé a écrit :
>> This is the first part of a series reducing user-mode
>> dependencies. By stripping out unused code, the build
>> and testing time is reduced (as is space used by objects).
>>
>> Part 1 (generic):
>> - reduce user-mode object list
>> - remove some migration code from user-mode
>> - remove cpu_get_crash_info()
>>
>> This series is fully reviewed.
>>
>> Since v2:
>> - Rebased due to conflict when applying patch:
>>    "util/Makefile: Reduce the user-mode object list"
>>    because commit 01ef6b9e4e modified util/Makefile.objs:
>>    "linux-user: factor out reading of /proc/self/maps"
>>
>> Since v1:
>> - Addressed Laurent/Richard review comments
>> - Removed 'exec: Drop redundant #ifdeffery'
>> - Removed 'target: Restrict write_elfXX_note() handlers to system-mode'
>>
>> $ git backport-diff -u v1 -r v2
>> Key:
>> [----] : patches are identical
>> [####] : number of functional differences between upstream/downstream patch
>> [down] : patch is downstream-only
>> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>>
>> 001/12:[----] [--] 'Makefile: Only build virtiofsd if system-mode is enabled'
>> 002/12:[----] [--] 'configure: Avoid building TCG when not needed'
>> 003/12:[----] [--] 'tests/Makefile: Only display TCG-related tests when TCG is available'
>> 004/12:[----] [--] 'tests/Makefile: Restrict some softmmu-only tests'
>> 005/12:[----] [-C] 'util/Makefile: Reduce the user-mode object list'
>> 006/12:[----] [--] 'stubs/Makefile: Reduce the user-mode object list'
>> 007/12:[----] [--] 'target/riscv/cpu: Restrict CPU migration to system-mode'
>> 008/12:[----] [--] 'exec: Assert CPU migration is not used on user-only build'
>> 009/12:[----] [--] 'arch_init: Remove unused 'qapi-commands-misc.h' include'
>> 010/12:[----] [--] 'target/i386: Restrict CpuClass::get_crash_info() to system-mode'
>> 011/12:[----] [--] 'target/s390x: Restrict CpuClass::get_crash_info() to system-mode'
>> 012/12:[----] [--] 'hw/core: Restrict CpuClass::get_crash_info() to system-mode'
>>
>> Philippe Mathieu-Daudé (12):
>>    Makefile: Only build virtiofsd if system-mode is enabled
>>    configure: Avoid building TCG when not needed
>>    tests/Makefile: Only display TCG-related tests when TCG is available
>>    tests/Makefile: Restrict some softmmu-only tests
>>    util/Makefile: Reduce the user-mode object list
>>    stubs/Makefile: Reduce the user-mode object list
>>    target/riscv/cpu: Restrict CPU migration to system-mode
>>    exec: Assert CPU migration is not used on user-only build
>>    arch_init: Remove unused 'qapi-commands-misc.h' include
>>    target/i386: Restrict CpuClass::get_crash_info() to system-mode
>>    target/s390x: Restrict CpuClass::get_crash_info() to system-mode
>>    hw/core: Restrict CpuClass::get_crash_info() to system-mode
>>
>>   configure              |  4 +++
>>   Makefile               |  2 +-
>>   include/hw/core/cpu.h  |  7 ++++-
>>   arch_init.c            |  1 -
>>   exec.c                 |  4 ++-
>>   hw/core/cpu.c          |  2 ++
>>   target/i386/cpu.c      |  6 ++++-
>>   target/riscv/cpu.c     |  6 +++--
>>   target/s390x/cpu.c     | 12 ++++-----
>>   stubs/Makefile.objs    | 52 +++++++++++++++++++++----------------
>>   tests/Makefile.include | 18 +++++++------
>>   util/Makefile.objs     | 59 +++++++++++++++++++++++++++---------------
>>   12 files changed, 108 insertions(+), 65 deletions(-)
>>
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Tested-by: Laurent Vivier <laurent@vivier.eu>

Thanks!

Paolo, since it is a bit of everything, do you mind taking this series?
For your convenience, you can use this link with all the patches and the 
tags already applied at once! :p
https://patchew.org/QEMU/20200504152922.21365-1-philmd@redhat.com/mbox

Regards,

Phil.


