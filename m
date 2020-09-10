Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E69C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4892120809
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7miHAHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4892120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGF43-0003kE-C8
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 01:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGF3Q-0003Ja-4N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 01:23:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGF3O-0007IY-Gd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 01:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599715405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CPjhM69v5jE9+HjPWqevVz5tUEZmCG5dbpoWrJIQT+8=;
 b=N7miHAHQ1bApRorxj7SiTWYNwwo+3//QLta8xUNByz5kAtwC+GyOOfDQTJ4BM4KijLpw2N
 SlG/zb5dre/yr7M/rGPF+271R66r6DoC4NUTu6r1nyS26PDDxZhUaehdhtl5Nn33EntGgr
 nui1XsFoXWn+ZV4C6H2yBetyJ0Rw0ck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-UtoGi_ANNmOd6SSNwb_0UA-1; Thu, 10 Sep 2020 01:23:22 -0400
X-MC-Unique: UtoGi_ANNmOd6SSNwb_0UA-1
Received: by mail-wr1-f71.google.com with SMTP id o6so1793940wrp.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 22:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=CPjhM69v5jE9+HjPWqevVz5tUEZmCG5dbpoWrJIQT+8=;
 b=jxtBhUcxV82fZpQCUSEmEfqeARxwckhqGkYj+B978oQ0FEX1dDXDxuEGS94Kek2zQ6
 7UI4c6W2fwA1wDBuMz5mf8RLG1kWjK0GxbJPQh/SUsuBE5tl+P/r74Y4ioDSJvh8ikSN
 aRvg2UiEqytPcmSY7CBGOi8FdeIlVovpKEcPt62fwH/PksX9HpaLjUE4jVepgBO0aE1K
 Ii4P7I1vBP0vL+FMTDpUedhOQmJefxEgEi0uu9tcxOJXYO+USBef3hzK0OnFwXf5fIIj
 dmRLO1tp1Aqf8nOxKcyoldTkr2Xh4k9wpK9Bcc3lulgnj6JIfSWXCKs1mHmBYZOb76Jb
 nU6w==
X-Gm-Message-State: AOAM533RHPIvUKhfQXjAqvkbnwas0DRzATCW1u52yvTYtCW27ocu7X9k
 7WIjwzSai9V7gPNADUcC4Ee1LUMfwb/cPrG4/ZzxvIQ+55fdW50MsbDRVhPXuJN46EBjTWbUJTb
 MpsIT1VMnVklEpEE=
X-Received: by 2002:a1c:3985:: with SMTP id g127mr6984840wma.32.1599715400861; 
 Wed, 09 Sep 2020 22:23:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAMYVWzmDJpFeNF2EazQir9vY17KYFZQdibPEe16Zw3B8JdqtvK+BuZYMXFBCPDoiZ6lmqDA==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr6984835wma.32.1599715400651; 
 Wed, 09 Sep 2020 22:23:20 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z19sm1791194wmi.3.2020.09.09.22.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 22:23:20 -0700 (PDT)
Subject: Re: [PATCH 7/8] tests/acceptance/boot_linux: Accept SSH pubkey
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200909184028.262297-1-mreitz@redhat.com>
 <20200909184028.262297-8-mreitz@redhat.com>
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
Message-ID: <7dacc660-4a4d-43a3-c264-11bbae223b31@redhat.com>
Date: Thu, 10 Sep 2020 07:23:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909184028.262297-8-mreitz@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 8:40 PM, Max Reitz wrote:
> Let download_cloudinit() take an optional pubkey, which subclasses of
> BootLinux can pass through setUp().
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/acceptance/boot_linux.py | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
> index 0055dc7cee..ad997c3f2e 100644
> --- a/tests/acceptance/boot_linux.py
> +++ b/tests/acceptance/boot_linux.py
> @@ -57,7 +57,7 @@ class BootLinuxBase(Test):
>              self.cancel('Failed to download/prepare boot image')
>          return boot.path
>  
> -    def download_cloudinit(self):
> +    def download_cloudinit(self, ssh_pubkey=None):
>          self.log.info('Preparing cloudinit image')
>          try:
>              cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
> @@ -67,7 +67,8 @@ class BootLinuxBase(Test):
>                            password='password',
>                            # QEMU's hard coded usermode router address
>                            phone_home_host='10.0.2.2',
> -                          phone_home_port=self.phone_home_port)
> +                          phone_home_port=self.phone_home_port,
> +                          authorized_key=ssh_pubkey)
>          except Exception:
>              self.cancel('Failed to prepared cloudinit image')
>          return cloudinit_iso
> @@ -80,19 +81,19 @@ class BootLinux(BootLinuxBase):
>      timeout = 900
>      chksum = None
>  
> -    def setUp(self):
> +    def setUp(self, ssh_pubkey=None):
>          super(BootLinux, self).setUp()
>          self.vm.add_args('-smp', '2')
>          self.vm.add_args('-m', '1024')
>          self.prepare_boot()
> -        self.prepare_cloudinit()
> +        self.prepare_cloudinit(ssh_pubkey)
>  
>      def prepare_boot(self):
>          path = self.download_boot()
>          self.vm.add_args('-drive', 'file=%s' % path)
>  
> -    def prepare_cloudinit(self):
> -        cloudinit_iso = self.download_cloudinit()
> +    def prepare_cloudinit(self, ssh_pubkey=None):
> +        cloudinit_iso = self.download_cloudinit(ssh_pubkey)
>          self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
>  
>      def launch_and_wait(self):
> 


