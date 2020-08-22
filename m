Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7350C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 19:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB3E2075E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 19:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux8iCFfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB3E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Zex-0000m0-Rz
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 15:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9ZeJ-0000CD-32
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 15:57:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9ZeG-00022T-5G
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 15:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598126274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QxeO2+UEedrh4hfnNb3xZYdnkNpZCd9ZTj1B6MPLk38=;
 b=Ux8iCFfvKRC1rY5xxYooDad8h1YHJS1X1ylZWGdO8M6El+TJlzfW4tE4IoiS/bHrC99/O1
 vspVU0GFhXui2tqfwbbt3TIjJMsQdXuOXKaLCA+y6JaE1ofujMnTO2Ef4aQGhlLw91ZV6c
 0z+LHOxKcuzWhy3dIcrX/1SHSFb1Y5M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-du8Rz6iWMkSsl2EtoIfWww-1; Sat, 22 Aug 2020 15:57:40 -0400
X-MC-Unique: du8Rz6iWMkSsl2EtoIfWww-1
Received: by mail-wr1-f72.google.com with SMTP id b8so1987769wrr.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 12:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QxeO2+UEedrh4hfnNb3xZYdnkNpZCd9ZTj1B6MPLk38=;
 b=sV+DC2HKewpOfnD3FkNSAOzClM3ZI/HUZM9sZyGuzlzgKKxMmJLshSYCszWfYmdJPl
 4WjZVeaiOO7aqeDn+boS9NfWCdinjOggiBvdUpK8xqrfFf6541HHbhmuRUQ3v5pU3Ik7
 3MtPJKwbHDPIWMdcFG85ylS61RbYRrkx7TEZveeWMziGckpmf0E5AXy0G36ebxUEWGAL
 wxkHsR25eDVaQ38lDexCt0f3B51JCCE0X0/EqQ1Zb3O4rr13akbz1ZKFjys0X5D5Vsg7
 TlEOttzdvOQvBWQSCPlb3+RG40sws/F3aZB/Y/bYFaaurKoAC34+HvLsWHVCIvK7KPIZ
 X5Iw==
X-Gm-Message-State: AOAM530A+sR7ELmfZzTA81mgD9XXQKA5NpWODnHkoYkRx1PCvO4uGOW3
 G19GyONfKVeBK71vw7Iockg1vzo2IeNT7rz1bTRByXCQycKWs7yNBwDDRHjRGxxAygpJYxS2VXi
 FPpyFKUKwo1Om15w=
X-Received: by 2002:a1c:9803:: with SMTP id a3mr9018956wme.57.1598126259220;
 Sat, 22 Aug 2020 12:57:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrr2RztiudOw5ylibRCdtYbNP/XssoWo5jCkJ+rVEG3nVj7NhKo5aGr8LMKfF/9mcH7Gij3A==
X-Received: by 2002:a1c:9803:: with SMTP id a3mr9018941wme.57.1598126259044;
 Sat, 22 Aug 2020 12:57:39 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id s20sm12932233wmh.21.2020.08.22.12.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 12:57:38 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 0/2] hw/char: Remove TYPE_SERIAL_IO
To: qemu-devel@nongnu.org
References: <20200730165900.7030-1-philmd@redhat.com>
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
Message-ID: <cb90f653-1b00-860f-e1c7-3d835a4e0d4c@redhat.com>
Date: Sat, 22 Aug 2020 21:57:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200730165900.7030-1-philmd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 15:57:54
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 6:58 PM, Philippe Mathieu-Daudé wrote:
> Remove the TYPE_SERIAL_IO which is simply a superset of
> TYPE_SERIAL_MM, as suggested by Paolo and Peter here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg721806.html
> 
> Philippe Mathieu-Daudé (2):
>   hw/mips/mipssim: Use MMIO serial device on fake ISA I/O
>   hw/char/serial: Remove TYPE_SERIAL_IO (superset of TYPE_SERIAL_MM)
> 
>  include/hw/char/serial.h |  9 ---------
>  hw/char/serial.c         | 41 ----------------------------------------
>  hw/mips/mipssim.c        |  4 +++-
>  3 files changed, 3 insertions(+), 51 deletions(-)
> 

ping? ...


