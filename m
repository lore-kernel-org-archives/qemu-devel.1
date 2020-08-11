Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323F2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8534206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPS302wH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8534206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Wy3-0005Sg-2Q
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5WxG-00051b-30
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:16:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Wx9-000801-DI
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597162601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I45LvoAKUSlTu2+c72OT0X/AAXFmMGyO703dgqMUPgY=;
 b=VPS302wHh3Df76w5zgW8vKg84JvEf6PZ/TCt6BNiJWO3z+Kto9Jhk3MBFDvyLTbCeHm3pW
 wA3LrjUG8D3Ezb8ym+YaiG4KXtUGWT5N5D5Ic0qP/k1qlXNC/zVj/mCmy5Ur5KBK8RJoNg
 K/sGCcyEzkySqhbKK0bf4EZPjy03UWM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-QCyKLLglPDyIh-6IsAKiAg-1; Tue, 11 Aug 2020 12:16:38 -0400
X-MC-Unique: QCyKLLglPDyIh-6IsAKiAg-1
Received: by mail-wm1-f70.google.com with SMTP id p23so1156132wmc.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 09:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=I45LvoAKUSlTu2+c72OT0X/AAXFmMGyO703dgqMUPgY=;
 b=NmJKww7utO4x3Ji85VMUuecb7XfRlkFL4riOM/yvme1axSp/d9T8A0SjVNlCVSjrcw
 XSs9N4HyWz26lUhAE6C90nAAzLjB57nl3S1kuHQ0SrcnNAfFCYbfv4kKPrxqSbw5L1ON
 NDyKlRh2ERFflE9BUmIal2toe1beAPg4nknJa0hudoWZcksrsK3UCDd+cps285gpuRZ/
 bhpkXSR4tFH75qO7Epm6NyVanQs62oqTLVh8NyhfNXTZx8vim8exiLxpv5MY/uuXcddF
 w0vz0p+KHB1d2tIrfY6WU4sKo6bE+nnIt6Yh8Xi5SVjXyfVfPEK+NzkgiNODsKrwHhCu
 sWCA==
X-Gm-Message-State: AOAM532zDtOJj1KjgJiBsHi4ZY/qAmTk88llKbjbdJ6yrr5c8kh07OZW
 WoSjAPGZgtRENC4/Sh0mwbFfaWF4XCKAQ/DVAUbj764208lQgW7TdJ9MpV40gxXJwjZpgueuJXW
 +CpnlbA8zbgQ9fao=
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr31889659wrs.132.1597162597094; 
 Tue, 11 Aug 2020 09:16:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx5z9NdcgZvv38xz3EVQmpKQLZ9H3lyVTELXoAG+jzyAR0hu/ratHHSBIY9oo3JzXNIgAiYA==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr31889638wrs.132.1597162596841; 
 Tue, 11 Aug 2020 09:16:36 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l10sm26629953wru.3.2020.08.11.09.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 09:16:36 -0700 (PDT)
Subject: Re: [PATCH 131/147] meson: link emulators without Makefile.target
To: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-132-git-send-email-pbonzini@redhat.com>
 <20200811145957.bbfq7laqme4rxwsp@mozz.bu.edu>
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
Message-ID: <7834ee3b-40a3-e011-00e1-186052d458c2@redhat.com>
Date: Tue, 11 Aug 2020 18:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200811145957.bbfq7laqme4rxwsp@mozz.bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 4:59 PM, Alexander Bulekov wrote:
> Hi Paolo,
> I looked through the code changes related to fuzzing and tested the
> following builds:
>  - qemu-fuzz-i386
>  - qemu-fuzz-arm
>  - qemu-system-i386 (with --enable-fuzzing)
>  - configure --enable-fuzzing with GCC (should fail)
>  - ./scripts/oss-fuzz/build.sh (in my local environment) 
>  - ./scripts/oss-fuzz/build.sh (in the oss-fuzz Docker) 
> I examined the symbols to ensure that the fuzzer linker-script is doing what it
> needs to be doing. The sizes of the binaries have roughly stayed the same, and
> there are no major differences between the symbols.
> Only the oss-fuzz Docker build failed with a complaint about the linker-script,
> but it fails for the current master, too! I think the problem might be related
> to the fact that the docker uses a bleeding edge clang-12 compiler. I'll have
> to look into it more.
> I ran the existing fuzzers for a couple thousand runs. It looks like there is
> some problem with the virtio-scsi arguments, but it's not specific to
> fuzzing. It will probably be caught once this runs through CI:
> 
> ./qemu-system-i386 -display none -machine accel=qtest -m 64 -M pc \
> -drive id=drv0,if=none,file=null-co://,file.read-zeroes=on,format=raw \
> -device virtio-scsi-pci,id=vs0,addr=04.0 \
> -device scsi-hd,bus=vs0.0,drive=drv0 \
> -drive file=blkdebug::null-co://,file.image.read-zeroes=on,if=none,id=dr1,format=raw,file.align=4k \
> -device scsi-hd,drive=dr1,lun=0,scsi-id=1 -qtest /dev/null -qtest-log /dev/null
> 
> Immediately crashes with:
> ../block.c:442:10: runtime error: index 0 out of bounds for type 'const char *[0]'
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../block.c:442:10 in 
> ../block.c:442:10: runtime error: load of address 0x5581a17161e0 with insufficient space for an object of type 'const char *'
> 0x5581a17161e0: note: pointer points here
>  00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00
>               ^ 
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../block.c:442:10 in 
> =================================================================
> ==26813==ERROR: AddressSanitizer: global-buffer-overflow on address 0x5581a17161e0 at pc 0x55819e05f1bd bp 0x7ffed60bdcc0 sp 0x7ffed60bdcb8
> READ of size 8 at 0x5581a17161e0 thread T0
>     #0 0x55819e05f1bc in bdrv_format_is_whitelisted /tmp/qemu/build/../block.c:442:10
>     #1 0x55819e05f1bc in bdrv_is_whitelisted /tmp/qemu/build/../block.c:463:12
>     #2 0x55819e075e5f in bdrv_open_common /tmp/qemu/build/../block.c:1680:32
>     #3 0x55819e075e5f in bdrv_open_inherit /tmp/qemu/build/../block.c:3420:11
>     #4 0x55819e07d1db in bdrv_open_child_bs /tmp/qemu/build/../block.c:3053:10
>     #5 0x55819e074b61 in bdrv_open_inherit /tmp/qemu/build/../block.c:3367:19
>     #6 0x55819e07dac4 in bdrv_open /tmp/qemu/build/../block.c:3513:12
>     #7 0x55819e2d78c5 in blk_new_open /tmp/qemu/build/../block/block-backend.c:421:10
>     #8 0x55819d4242ee in blockdev_init /tmp/qemu/build/../blockdev.c:617:15
>     #9 0x55819d4242ee in drive_new /tmp/qemu/build/../blockdev.c:1005:11
>     #10 0x55819da17085 in drive_init_func /tmp/qemu/build/../softmmu/vl.c:1000:12
>     #11 0x55819e61bd4c in qemu_opts_foreach /tmp/qemu/build/../util/qemu-option.c:1172:14
>     #12 0x55819da0aab2 in configure_blockdev /tmp/qemu/build/../softmmu/vl.c:1067:9
>     #13 0x55819da0aab2 in qemu_init /tmp/qemu/build/../softmmu/vl.c:4145:5
>     #14 0x55819c72a5b8 in main /tmp/qemu/build/../softmmu/main.c:48:5
>     #15 0x7faba3b86e0a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x26e0a)
>     #16 0x55819c680659 in _start (/tmp/qemu/build/qemu-system-i386+0x254d659)
> 
> 0x5581a17161e0 is located 32 bytes to the left of global variable 'whitelist_ro' defined in '../block.c:437:24' (0x5581a1716200) of size 0
>   'whitelist_ro' is ascii string ''
> 0x5581a17161e0 is located 0 bytes to the right of global variable 'whitelist_rw' defined in '../block.c:434:24' (0x5581a17161e0) of size 0
>   'whitelist_rw' is ascii string ''
> SUMMARY: AddressSanitizer: global-buffer-overflow /tmp/qemu/build/../block.c:442:10 in bdrv_format_is_whitelisted
> 
> This doesn't happen on master.

The problem is in "[PATCH 139/147] meson: replace create-config
with meson configure_file".


