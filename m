Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B09C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C8320720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh6NevlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C8320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jquRJ-00089w-BH
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 04:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jquQR-000706-3b
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:18:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jquQP-0000iM-4j
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593677908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ChXie8hCd5baVF+nONSSmMmzXvpcAd7hRN47DVrFAKU=;
 b=Sh6NevlEsblJHDjvgAAWhEooieqQqMhjHA2+4SUhM9yn3DoTBlYW90Dc09n4/N+BLml3QE
 wTo+yNqu9Jwyi+B9aCbLo87xaacgJiGuVt3hEImfrVsexkdZVWl0EL1NGt8rIEJcM7xXsh
 LQFHqFPI/+AaFjixzu225lm24Ay77pE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-N-HDvEMHPnGcb42ixxl7xg-1; Thu, 02 Jul 2020 04:18:26 -0400
X-MC-Unique: N-HDvEMHPnGcb42ixxl7xg-1
Received: by mail-ed1-f69.google.com with SMTP id 64so25675299edf.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 01:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ChXie8hCd5baVF+nONSSmMmzXvpcAd7hRN47DVrFAKU=;
 b=jKf/3QDujYjfZ48i6aMOArrRqLuDqaBjjRsMGk2q7TlNSA98prZV3Tw3vtRKc9ZxbK
 lrO9xaYv7Z/Y7uePKGWe5GQtvyxioQH1iweVwJImf2vo7UjuPS2sZCUkFkGgnmPf8LlM
 3fDgtlCV6gUWxTDvoISPEsZ/HhZocoZCE4dMyN7ZXrNDDJ9w2NCso9U8p8z3aTdc1dVt
 onxR/lr0TprDeG55Bc2/e4aFEQXBaM6O4YQDz69KxUZQPwLgKKPiuY/WbazaI6RjNB39
 nWC/bO0ZxLNoMhMBaliemW/j+HRund2jgxCUuSDylpNPmrZkXzn0jtkEi1lTOoR43ffP
 pxdg==
X-Gm-Message-State: AOAM533evD27cG2OAGsTwwYPJLuxwff7LDnpIsOqyIiJ7ouQauUxhhE1
 uBhhjxR6d0WfRbf0HvYm09GQAeOnWDJLOF3nqUfa3iFHPJdWIZgRJC7M4ZOI1FCqvz+IP+h+m8v
 WogfPi4GBtUm8rW8=
X-Received: by 2002:a17:906:2ccf:: with SMTP id
 r15mr27426751ejr.277.1593677905518; 
 Thu, 02 Jul 2020 01:18:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy36KslbQBm5FkKcQJF9h8e24KfqMMo0etEPxPSFlIUE2m9YtLx7HPXRyuOmFXTPhl0mmY6VA==
X-Received: by 2002:a17:906:2ccf:: with SMTP id
 r15mr27426726ejr.277.1593677905222; 
 Thu, 02 Jul 2020 01:18:25 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y2sm9336498eda.85.2020.07.02.01.18.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 01:18:24 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] net: tap: check if the file descriptor is valid
 before using it
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200701193951.36248-1-lvivier@redhat.com>
 <20200701193951.36248-2-lvivier@redhat.com>
 <48ef599b-20b8-0cfa-4c73-548f1f9bebee@redhat.com>
 <339093a1-6937-85d0-7313-5cd9f55ac779@redhat.com>
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
Message-ID: <31892cf3-b19c-9911-8fed-1dd5dcbec2c0@redhat.com>
Date: Thu, 2 Jul 2020 10:18:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <339093a1-6937-85d0-7313-5cd9f55ac779@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 10:17 AM, Laurent Vivier wrote:
> On 02/07/2020 10:00, Philippe Mathieu-Daudé wrote:
>> On 7/1/20 9:39 PM, Laurent Vivier wrote:
>>> qemu_set_nonblock() checks that the file descriptor can be used and, if
>>> not, crashes QEMU. An assert() is used for that. The use of assert() is
>>> used to detect programming error and the coredump will allow to debug
>>> the problem.
>>>
>>> But in the case of the tap device, this assert() can be triggered by
>>> a misconfiguration by the user. At startup, it's not a real problem, but it
>>> can also happen during the hot-plug of a new device, and here it's a
>>> problem because we can crash a perfectly healthy system.
>>>
>>> For instance:
>>>  # ip link add link virbr0 name macvtap0 type macvtap mode bridge
>>>  # ip link set macvtap0 up
>>>  # TAP=/dev/tap$(ip -o link show macvtap0 | cut -d: -f1)
>>>  # qemu-system-x86_64 -machine q35 -device pcie-root-port,id=pcie-root-port-0 -monitor stdio 9<> $TAP
>>>  (qemu) netdev_add type=tap,id=hostnet0,vhost=on,fd=9
>>>  (qemu) device_add driver=virtio-net-pci,netdev=hostnet0,id=net0,bus=pcie-root-port-0
>>>  (qemu) device_del net0
>>>  (qemu) netdev_del hostnet0
>>>  (qemu) netdev_add type=tap,id=hostnet1,vhost=on,fd=9
>>>  qemu-system-x86_64: .../util/oslib-posix.c:247: qemu_set_nonblock: Assertion `f != -1' failed.
>>>  Aborted (core dumped)
>>>
>>> To avoid that, add a function, qemu_try_set_nonblock(), that allows to report the
>>> problem without crashing.
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>  include/qemu/sockets.h |  1 +
>>>  net/tap.c              | 16 +++++++++---
>>>  util/oslib-posix.c     | 26 +++++++++++++------
>>>  util/oslib-win32.c     | 57 ++++++++++++++++++++++++------------------
>>>  4 files changed, 64 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
>>> index 57cd049d6edd..7d1f8135767d 100644
>>> --- a/include/qemu/sockets.h
>>> +++ b/include/qemu/sockets.h
>>> @@ -18,6 +18,7 @@ int qemu_accept(int s, struct sockaddr *addr, socklen_t *addrlen);
>>>  int socket_set_cork(int fd, int v);
>>>  int socket_set_nodelay(int fd);
>>>  void qemu_set_block(int fd);
>>> +int qemu_try_set_nonblock(int fd);
>>>  void qemu_set_nonblock(int fd);
>>>  int socket_set_fast_reuse(int fd);
>>>  
>>> diff --git a/net/tap.c b/net/tap.c
>>> index 6207f61f84ab..fb04c9044ce2 100644
>>> --- a/net/tap.c
>>> +++ b/net/tap.c
>>> @@ -766,6 +766,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>>>      Error *err = NULL;
>>>      const char *vhostfdname;
>>>      char ifname[128];
>>> +    int ret = 0;
>>
>> No need to zero-initialize.
>>
>> Otherwise:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
> 
> I would agree with you but gcc doesn't:
> 
> net/tap.c:769:9: error: ‘ret’ may be used uninitialized in this function
> [-Werror=maybe-uninitialized]
>   769 |     int ret;
>       |         ^~~

I tried to outsmart GCC by manual review :/

> 
> if nfds == 0, we don't enter in the loop and ret is never set.
> 
> Thanks,
> Laurent
> 


