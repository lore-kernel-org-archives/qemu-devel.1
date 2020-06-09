Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C423C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3AD206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be0sv/QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3AD206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiicg-0004Hb-DT
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 14:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiiYl-0001Lb-Gh
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:01:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiiYj-0001kg-OC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591725672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U8ETrQ59J5kqRdP4F1gvOEfNqddezhb1WTFK/IDcu5c=;
 b=be0sv/QOlloEAtpKXtHepMNu+N5mt1V4qrPF+YHo2iceyaEsfhOuXFDmhUVcdy0BYuFnuD
 YA4U/RQ9Aw6NBFBB4vC3/7CL3FAv5YRTiyjoSEZP8YSy9WWBEXqv6TD9AN79570MKgcL0i
 uokuCWwguJjcUzqROKbFh1MvSNNXgqc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-8qpGtiQuNSOeA39xMZ2S3w-1; Tue, 09 Jun 2020 14:00:55 -0400
X-MC-Unique: 8qpGtiQuNSOeA39xMZ2S3w-1
Received: by mail-wr1-f72.google.com with SMTP id s7so8930320wrm.16
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 11:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=U8ETrQ59J5kqRdP4F1gvOEfNqddezhb1WTFK/IDcu5c=;
 b=aTvYKgogPEldQJ8ZEmY2S1sk5uYzty8c4awJTXi5gjuNJOOzE3RDgBPJyo5LQyZkKV
 PNNPU2vAAuVZ4cK28ay8674aEozqVVCnoyObhKLeB+dC/u65r2bH0GYwPTutv8kQrSq9
 x6PIC0uxda96xDw27oU8I8GAYj4BpXUzsU/mOZC6r9lRV2oEeJF7V0izb3KUU4m13Z06
 lJjJ/frfyZsm2NaT/ttvbMhcML+0OCGp5sUZMEsakEZWEWLqKKgkmFitxMzYkBiKygYy
 VaUla9oLd4tcfFUN0etq1ji3W0EegsG/cenfkJV/84q9tcW0hl1BYzJLSer/mdVUNvRY
 iC5A==
X-Gm-Message-State: AOAM530rMdTc44HEK5tc35+PS7F1zXJqth96qJ2ucGq2+QMXUrbW6gm5
 0qzQ6lE/oUDbFPeanpFmugvLuuOx3zvhhTjRJcsxJJ2WQhyZmAXv0L8YPOqNSTqPv5by8DDMWVg
 ZI68xMoJnq8/Zs1E=
X-Received: by 2002:a5d:4245:: with SMTP id s5mr5810165wrr.6.1591725653587;
 Tue, 09 Jun 2020 11:00:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMbBZFsBScvHh4qRDEUp0yKGW/KOhSeekMQXlqZrdN6HvrtCtjnf37PpNNnzRTvrkGhaMlxA==
X-Received: by 2002:a5d:4245:: with SMTP id s5mr5810146wrr.6.1591725653303;
 Tue, 09 Jun 2020 11:00:53 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id r2sm4325219wrg.68.2020.06.09.11.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 11:00:52 -0700 (PDT)
Subject: Re: [Bug 1882817] [NEW] Segfault in audio_pcm_sw_write with audio
 over VNC
To: Bug 1882817 <1882817@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <159172265471.31406.7196816329603804386.malonedeb@gac.canonical.com>
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
Message-ID: <8f0267bf-1020-a3eb-e205-8727aa535e14@redhat.com>
Date: Tue, 9 Jun 2020 20:00:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159172265471.31406.7196816329603804386.malonedeb@gac.canonical.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 7:10 PM, Artyom wrote:
> Public bug reported:
> 
> QEMU 5.0.0, built with ./configure --target-list=x86_64-softmmu
> --enable-debug --disable-strip --disable-docs --disable-sdl
> 
> Running on a headless host (Ryzen 3600), Arch Linux, 64bit latest.
> Guest is also Arch Linux, 64bit.
> 
> Started with qemu-system-x86_64 -vnc 0.0.0.0:0 -enable-kvm -m 4096 -cpu host -smp cores=2,threads=1,sockets=1 -machine q35 -vga std -device
>  ich9-ahci,id=ahci -drive file=vm0.qcow2,format=qcow2,if=none,id=dsk0 -device ide-hd,drive=dsk0,bus=ahci.0 -soundhw hda
> 
> So, a headless VM is running on a server and is being connected to over
> VNC. The virtual sound card is detected and speaker test is running
> inside the VM. So far so good.
> 
> Then, i tell the VNC client to enable audio (QEMU Audio Client Message,
> 255,1,0). QEMU responds with a "stream is about to start" message (QEMU
> Audio Server Message, 255,1,1) and then promptly crashes without sending
> anything else.
> 
> Running it in GDB produces a crash at audio/audio.c:739
> 
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> audio_pcm_sw_write (sw=0x5555575bbf30, buf=0x0, size=1628) at audio/audio.c:739
> 739             if (!sw->hw->pcm_ops->volume_out) {

Isn't it the one fixed by
https://www.mail-archive.com/qemu-devel@nongnu.org/msg705896.html?

> 
> The exact sequence of events does not matter - i can enable sound before
> playing anything, and then it would say nothing and keep working, but
> crash with the same message once anything sound-playing is launched in
> the VM.
> 
> Using different soundhw or adding various audiodev options does not seem
> to affect anything.
> 
> I can't quite figure out if the QEMU Audio VNC extension is supposed to
> work at all or not, but it would be handy to me if it is.
> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 


