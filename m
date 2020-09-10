Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C043C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B572078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3sotSSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B572078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJkz-00012b-3Q
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGJkA-0000I9-8n
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:23:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGJk7-0001af-0C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599733429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ig4LH8LzlUaqIslvyhADh/0eTC/9LmgVGaAWDhESs/0=;
 b=T3sotSSYqoENSHTdqUBS3PaS0waPRavMr+80jfn6qhSu6hrEWwzVoZtdOo2gX+9En0lL5/
 Fbhyki1AXf8tcZgpif3z8pDWRsFIOuSc9MimzvYwbeOscU/mMgx+wm4WIiRaIhR2J4IsYL
 g5T8jdr5Yc0aDNyJsN6AGeTioqdzqVg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-ydrDzUJzNCi-ZqqaU6nE0A-1; Thu, 10 Sep 2020 06:23:46 -0400
X-MC-Unique: ydrDzUJzNCi-ZqqaU6nE0A-1
Received: by mail-wr1-f71.google.com with SMTP id g6so2098644wrv.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 03:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ig4LH8LzlUaqIslvyhADh/0eTC/9LmgVGaAWDhESs/0=;
 b=Evf5BJ8V7AHfgsXxcGXsU+SC2JYqRu1jADLcBQd7fAbiZkSDyUToHCoSdbu+Ku407B
 wb/pi/tNYPG6o8X1xS4YxoaOy/H74fn6IX41vvzrESDgclcXTGG9AVmVIileYYf4oDna
 CzarhCsftpJMCZCjfiAeEkkwShcRD2SmGvz27jEilILROyFnWkpZzUtCzhpm4U961x8j
 BtPq+3VDTs5BrXyKnkyji6+XTsUxnJP5ivXMsJJtvdghtgps9BBXqapd8oO2lT0Fgvq3
 0d7C1rcTuQxnfQPIWV2fjdulMwWSr77O+VgIZnuyVZl852pf/waPbEnk0aoQYnnNG4IR
 esMA==
X-Gm-Message-State: AOAM530mIw9BMxT5ktlYuGInuCWQUSUCAPp6ogxk1lSp/H9tZkVLv8uI
 zsBgyrsP0w8DPFTKoZobXPv3ka9+ISiTkkqg4z9hJceE1xWTZd/HpKvqcI47OOFnCubtJNqY3Rn
 L90UWxNDAfuqBv5I=
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr8206048wmj.134.1599733424851; 
 Thu, 10 Sep 2020 03:23:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAqhKar///xH31HZqNOuilroiZUuTzhGYVh6bRvyGjzp44WBHcDSWgkzBLRxQ1wqWlONojFg==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr8206030wmj.134.1599733424567; 
 Thu, 10 Sep 2020 03:23:44 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v7sm2926552wmj.28.2020.09.10.03.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 03:23:44 -0700 (PDT)
Subject: Re: [PATCH RESEND] manual: escape backslashes in "parsed-literal"
 blocks
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20200908172111.19072-1-lersek@redhat.com>
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
Message-ID: <0bcfea31-36eb-08ba-c450-a7d01910d837@redhat.com>
Date: Thu, 10 Sep 2020 12:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908172111.19072-1-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 03:02:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@

On 9/8/20 7:21 PM, Laszlo Ersek wrote:
> According to
> <https://docutils.sourceforge.io/docs/ref/rst/directives.html#parsed-literal>,
> "inline markup is recognized and there is no protection from parsing.
> Backslash-escapes may be necessary to prevent unintended parsing".
> 
> The qemu(1) manual page (formatted with Sphinx 2.2.2) has several overlong
> lines on my system. A stand-alone backslash at EOL serves as line
> continuation in a "parsed-literal" block. Therefore, escape the
> backslashes that we want to appear as such in the formatted documentation.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
> 
> Notes:
>     Resending with Peter's email address in the Cc: tag fixed. Sorry!
> 
>  docs/system/device-url-syntax.rst.inc |   8 +-
>  qemu-options.hx                       | 108 ++++++++++----------
>  2 files changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
> index 88d7a372a748..6f6ec8366b7a 100644
> --- a/docs/system/device-url-syntax.rst.inc
> +++ b/docs/system/device-url-syntax.rst.inc
> @@ -25,8 +25,8 @@ These are specified using a special URL syntax.
>  
>     .. parsed-literal::
>  
> -      |qemu_system| -iscsi initiator-name=iqn.2001-04.com.example:my-initiator \
> -                       -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \
> +      |qemu_system| -iscsi initiator-name=iqn.2001-04.com.example:my-initiator \\
> +                       -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \\
>                         -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
>  
>     Example (CHAP username/password via URL):
> @@ -39,8 +39,8 @@ These are specified using a special URL syntax.
>  
>     .. parsed-literal::
>  
> -      LIBISCSI_CHAP_USERNAME="user" \
> -      LIBISCSI_CHAP_PASSWORD="password" \
> +      LIBISCSI_CHAP_USERNAME="user" \\
> +      LIBISCSI_CHAP_PASSWORD="password" \\
>        |qemu_system| -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
>  
>  ``NBD``
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b0f020594eab..47f64be0c041 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -373,9 +373,9 @@ SRST
>  
>      .. parsed-literal::
>  
> -        |qemu_system| \
> -         -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \
> -         -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \
> +        |qemu_system| \\
> +         -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \\
> +         -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \\
>           -drive file=/dev/fdset/2,index=0,media=disk
>  ERST
>  
> @@ -1338,9 +1338,9 @@ SRST
>  
>      .. parsed-literal::
>  
> -        |qemu_system| \
> -         -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \
> -         -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \
> +        |qemu_system| \\
> +         -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \\
> +         -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \\
>           -drive file=/dev/fdset/2,index=0,media=disk
>  
>      You can connect a CDROM to the slave of ide0:
> @@ -2593,7 +2593,7 @@ SRST
>  
>          .. parsed-literal::
>  
> -            |qemu_system| -hda linux.img -boot n -device e1000,netdev=n1 \
> +            |qemu_system| -hda linux.img -boot n -device e1000,netdev=n1 \\
>                  -netdev user,id=n1,tftp=/path/to/tftp/files,bootfile=/pxelinux.0
>  
>      ``smb=dir[,smbserver=addr]``
> @@ -2703,15 +2703,15 @@ SRST
>  
>          #launch a QEMU instance with two NICs, each one connected
>          #to a TAP device
> -        |qemu_system| linux.img \
> -                -netdev tap,id=nd0,ifname=tap0 -device e1000,netdev=nd0 \
> +        |qemu_system| linux.img \\
> +                -netdev tap,id=nd0,ifname=tap0 -device e1000,netdev=nd0 \\
>                  -netdev tap,id=nd1,ifname=tap1 -device rtl8139,netdev=nd1
>  
>      .. parsed-literal::
>  
>          #launch a QEMU instance with the default network helper to
>          #connect a TAP device to bridge br0
> -        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \
> +        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
>                  -netdev tap,id=n1,"helper=/path/to/qemu-bridge-helper"
>  
>  ``-netdev bridge,id=id[,br=bridge][,helper=helper]``
> @@ -2749,12 +2749,12 @@ SRST
>      .. parsed-literal::
>  
>          # launch a first QEMU instance
> -        |qemu_system| linux.img \
> -                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
> +        |qemu_system| linux.img \\
> +                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
>                           -netdev socket,id=n1,listen=:1234
>          # connect the network of this instance to the network of the first instance
> -        |qemu_system| linux.img \
> -                         -device e1000,netdev=n2,mac=52:54:00:12:34:57 \
> +        |qemu_system| linux.img \\
> +                         -device e1000,netdev=n2,mac=52:54:00:12:34:57 \\
>                           -netdev socket,id=n2,connect=127.0.0.1:1234
>  
>  ``-netdev socket,id=id[,fd=h][,mcast=maddr:port[,localaddr=addr]]``
> @@ -2776,16 +2776,16 @@ SRST
>      .. parsed-literal::
>  
>          # launch one QEMU instance
> -        |qemu_system| linux.img \
> -                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
> +        |qemu_system| linux.img \\
> +                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
>                           -netdev socket,id=n1,mcast=230.0.0.1:1234
>          # launch another QEMU instance on same "bus"
> -        |qemu_system| linux.img \
> -                         -device e1000,netdev=n2,mac=52:54:00:12:34:57 \
> +        |qemu_system| linux.img \\
> +                         -device e1000,netdev=n2,mac=52:54:00:12:34:57 \\
>                           -netdev socket,id=n2,mcast=230.0.0.1:1234
>          # launch yet another QEMU instance on same "bus"
> -        |qemu_system| linux.img \
> -                         -device e1000,netdev=n3,mac=52:54:00:12:34:58 \
> +        |qemu_system| linux.img \\
> +                         -device e1000,netdev=n3,mac=52:54:00:12:34:58 \\
>                           -netdev socket,id=n3,mcast=230.0.0.1:1234
>  
>      Example (User Mode Linux compat.):
> @@ -2793,8 +2793,8 @@ SRST
>      .. parsed-literal::
>  
>          # launch QEMU instance (note mcast address selected is UML's default)
> -        |qemu_system| linux.img \
> -                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
> +        |qemu_system| linux.img \\
> +                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
>                           -netdev socket,id=n1,mcast=239.192.168.1:1102
>          # launch UML
>          /path/to/linux ubd0=/path/to/root_fs eth0=mcast
> @@ -2803,8 +2803,8 @@ SRST
>  
>      .. parsed-literal::
>  
> -        |qemu_system| linux.img \
> -                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
> +        |qemu_system| linux.img \\
> +                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
>                           -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
>  
>  ``-netdev l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]``
> @@ -2860,9 +2860,9 @@ SRST
>  
>          # Setup tunnel on linux host using raw ip as encapsulation
>          # on 1.2.3.4
> -        ip l2tp add tunnel remote 4.3.2.1 local 1.2.3.4 tunnel_id 1 peer_tunnel_id 1 \
> +        ip l2tp add tunnel remote 4.3.2.1 local 1.2.3.4 tunnel_id 1 peer_tunnel_id 1 \\
>              encap udp udp_sport 16384 udp_dport 16384
> -        ip l2tp add session tunnel_id 1 name vmtunnel0 session_id \
> +        ip l2tp add session tunnel_id 1 name vmtunnel0 session_id \\
>              0xFFFFFFFF peer_session_id 0xFFFFFFFF
>          ifconfig vmtunnel0 mtu 1500
>          ifconfig vmtunnel0 up
> @@ -2872,7 +2872,7 @@ SRST
>          # on 4.3.2.1
>          # launch QEMU instance - if your network has reorder or is very lossy add ,pincounter
>  
> -        |qemu_system| linux.img -device e1000,netdev=n1 \
> +        |qemu_system| linux.img -device e1000,netdev=n1 \\
>              -netdev l2tpv3,id=n1,src=4.2.3.1,dst=1.2.3.4,udp,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter
>  
>  ``-netdev vde,id=id[,sock=socketpath][,port=n][,group=groupname][,mode=octalmode]``
> @@ -4627,8 +4627,8 @@ SRST
>  
>          .. parsed-literal::
>  
> -             # |qemu_system| \
> -                 -object tls-cipher-suites,id=mysuite0,priority=@SYSTEM \
> +             # |qemu_system| \\
> +                 -object tls-cipher-suites,id=mysuite0,priority=@SYSTEM \\
>                   -fw_cfg name=etc/edk2/https/ciphers,gen_id=mysuite0
>  
>      ``-object filter-buffer,id=id,netdev=netdevid,interval=t[,queue=all|rx|tx][,status=on|off][,position=head|tail|id=<id>][,insert=behind|before]``
> @@ -4791,10 +4791,10 @@ SRST
>  
>          .. parsed-literal::
>  
> -             # |qemu_system| \
> -               [...] \
> -                   -object cryptodev-backend-builtin,id=cryptodev0 \
> -                   -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
> +             # |qemu_system| \\
> +               [...] \\
> +                   -object cryptodev-backend-builtin,id=cryptodev0 \\
> +                   -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \\
>                 [...]
>  
>      ``-object cryptodev-vhost-user,id=id,chardev=chardevid[,queues=queues]``
> @@ -4810,11 +4810,11 @@ SRST
>  
>          .. parsed-literal::
>  
> -             # |qemu_system| \
> -               [...] \
> -                   -chardev socket,id=chardev0,path=/path/to/socket \
> -                   -object cryptodev-vhost-user,id=cryptodev0,chardev=chardev0 \
> -                   -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
> +             # |qemu_system| \\
> +               [...] \\
> +                   -chardev socket,id=chardev0,path=/path/to/socket \\
> +                   -object cryptodev-vhost-user,id=cryptodev0,chardev=chardev0 \\
> +                   -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \\
>                 [...]
>  
>      ``-object secret,id=id,data=string,format=raw|base64[,keyid=secretid,iv=string]``
> @@ -4892,9 +4892,9 @@ SRST
>  
>          .. parsed-literal::
>  
> -             # |qemu_system| \
> -                 -object secret,id=secmaster0,format=base64,file=key.b64 \
> -                 -object secret,id=sec0,keyid=secmaster0,format=base64,\
> +             # |qemu_system| \\
> +                 -object secret,id=secmaster0,format=base64,file=key.b64 \\
> +                 -object secret,id=sec0,keyid=secmaster0,format=base64,\\
>                       data=$SECRET,iv=$(<iv.b64)
>  
>      ``-object sev-guest,id=id,cbitpos=cbitpos,reduced-phys-bits=val,[sev-device=string,policy=policy,handle=handle,dh-cert-file=file,session-file=file]``
> @@ -4941,10 +4941,10 @@ SRST
>  
>          .. parsed-literal::
>  
> -             # |qemu_system_x86| \
> -                 ......
> -                 -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=5 \
> -                 -machine ...,memory-encryption=sev0
> +             # |qemu_system_x86| \\
> +                 ...... \\
> +                 -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=5 \\
> +                 -machine ...,memory-encryption=sev0 \\
>                   .....
>  
>      ``-object authz-simple,id=id,identity=string``
> @@ -4962,9 +4962,9 @@ SRST
>  
>          .. parsed-literal::
>  
> -             # |qemu_system| \
> -                 ...
> -                 -object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,O=Example Org,,L=London,,ST=London,,C=GB' \
> +             # |qemu_system| \\
> +                 ... \\
> +                 -object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,O=Example Org,,L=London,,ST=London,,C=GB' \\
>                   ...
>  
>          Note the use of quotes due to the x509 distinguished name
> @@ -5013,9 +5013,9 @@ SRST
>  
>          .. parsed-literal::
>  
> -             # |qemu_system| \
> -                 ...
> -                 -object authz-simple,id=auth0,filename=/etc/qemu/vnc-sasl.acl,refresh=yes
> +             # |qemu_system| \\
> +                 ... \\
> +                 -object authz-simple,id=auth0,filename=/etc/qemu/vnc-sasl.acl,refresh=yes \\
>                   ...
>  
>      ``-object authz-pam,id=id,service=string``
> @@ -5032,9 +5032,9 @@ SRST
>  
>          .. parsed-literal::
>  
> -             # |qemu_system| \
> -                 ...
> -                 -object authz-pam,id=auth0,service=qemu-vnc
> +             # |qemu_system| \\
> +                 ... \\
> +                 -object authz-pam,id=auth0,service=qemu-vnc \\
>                   ...
>  
>          There would then be a corresponding config file for PAM at
> 


