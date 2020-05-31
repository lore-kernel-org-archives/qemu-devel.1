Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F143C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 12:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E816F206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 12:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtNrnCH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E816F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfMid-0000jI-4L
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 08:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfMhu-0000Gw-7l
 for qemu-devel@nongnu.org; Sun, 31 May 2020 08:04:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfMhs-0002Xu-Gg
 for qemu-devel@nongnu.org; Sun, 31 May 2020 08:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590926687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bUvyrTbxCH3YrTBF7HEwzDh9Va4hOGW+HVOjvQeK85c=;
 b=PtNrnCH1Wi61sNwPhL3ptGVzlUGp7HiL10FGlL+pk/TThoqs10Lf7qaA3EaDXAXAcSapth
 AFw9wEZmF2S5dc//Y4VRPekbw9UcLxlJiE/2STFgD9l/fMhstIFkB+rZBI6FAA83WwS7hq
 POFn+9f59skI15MeFljw8BHAgfCvwpU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-HNcdNUqfMeqlAosLRiW09g-1; Sun, 31 May 2020 08:04:44 -0400
X-MC-Unique: HNcdNUqfMeqlAosLRiW09g-1
Received: by mail-wr1-f70.google.com with SMTP id h6so3425238wrx.4
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 05:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bUvyrTbxCH3YrTBF7HEwzDh9Va4hOGW+HVOjvQeK85c=;
 b=XVwWOWlRPtFjsrF0dEx07yocCpAs9245XtlpcCYplOiuz/WFXJZcyVMKYlPvjm3ZV6
 IcLr+sR/OKu1w+x9rv3+QhwI5IJGI3KI8YaJHA7aP2arKp5HF9v5ZZorK/0n3qDJGlRE
 W7tsCI3pQVTI9zwHd0h5GLAw89QV+8I0V6TaU9ulJFhhzm+wckkhTRwz0R/vbvaMIlNS
 zdm2pc8wEfaNqCBzj6gLhc+kQLIWcRzlzalo07mpdI5Aes+sLdqVzEN5sTGzw2SDbWJ2
 7WDKGu+royrZ1PeOtNWdCbJ+7c/e+cDqFD6/EUAMFo6/yfK4DiOmbYRz/OEn8sx9aLiV
 3xgg==
X-Gm-Message-State: AOAM530Txe6ZfkErt+AIJ1NN11dBFmZVvzT23nfsttu4PP6NH2VquVQx
 fIAE/HQRmflXVgpE2CYkAZlhprA0kay9mo4f5bMlGdDNKXjgNCjqpvS/4b2rwkxxBb+P4mjSeMp
 0l83OAXL9IjrfoZM=
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr16601041wrp.378.1590926683901; 
 Sun, 31 May 2020 05:04:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6DLjv2RyM+bX3SLF6QQGqMd3IquA9reJEtcWmD0JdYIqfj8WQyagLEFpIScTn/VV86QIC3g==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr16601022wrp.378.1590926683650; 
 Sun, 31 May 2020 05:04:43 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id g3sm2014986wrb.46.2020.05.31.05.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 05:04:43 -0700 (PDT)
Subject: Re: [PATCH v3 10/11] tests/acceptance: refactor boot_linux to allow
 code reuse
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159073587336.20809.5404476664125786279.stgit@pasha-ThinkPad-X280>
 <159073593167.20809.17582679291556188984.stgit@pasha-ThinkPad-X280>
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
Message-ID: <235f4ab0-6f2a-e63c-0960-524f4d045a5c@redhat.com>
Date: Sun, 31 May 2020 14:04:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159073593167.20809.17582679291556188984.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 05:58:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
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
Cc: wrampazz@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 9:05 AM, Pavel Dovgalyuk wrote:
> This patch moves image downloading functions to the separate class to allow
> reusing them from record/replay tests.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  0 files changed
> 
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
> index 075a386300..3aa57e88b0 100644
> --- a/tests/acceptance/boot_linux.py
> +++ b/tests/acceptance/boot_linux.py
> @@ -26,22 +26,8 @@ KVM_NOT_AVAILABLE = ACCEL_NOT_AVAILABLE_FMT % "KVM"
>  TCG_NOT_AVAILABLE = ACCEL_NOT_AVAILABLE_FMT % "TCG"
>  
>  
> -class BootLinux(Test):
> -    """
> -    Boots a Linux system, checking for a successful initialization
> -    """
> -
> -    timeout = 900
> -    chksum = None
> -
> -    def setUp(self):
> -        super(BootLinux, self).setUp()
> -        self.vm.add_args('-smp', '2')
> -        self.vm.add_args('-m', '1024')
> -        self.prepare_boot()
> -        self.prepare_cloudinit()
> -
> -    def prepare_boot(self):
> +class BootLinuxBase(Test):
> +    def download_boot(self):
>          self.log.debug('Looking for and selecting a qemu-img binary to be '
>                         'used to create the bootable snapshot image')
>          # If qemu-img has been built, use it, otherwise the system wide one
> @@ -60,17 +46,17 @@ class BootLinux(Test):
>          if image_arch == 'ppc64':
>              image_arch = 'ppc64le'
>          try:
> -            self.boot = vmimage.get(
> +            boot = vmimage.get(
>                  'fedora', arch=image_arch, version='31',
>                  checksum=self.chksum,
>                  algorithm='sha256',
>                  cache_dir=self.cache_dirs[0],
>                  snapshot_dir=self.workdir)
> -            self.vm.add_args('-drive', 'file=%s' % self.boot.path)
>          except:
>              self.cancel('Failed to download/prepare boot image')
> +        return boot.path
>  
> -    def prepare_cloudinit(self):
> +    def download_cloudinit(self):
>          self.log.info('Preparing cloudinit image')
>          try:
>              cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
> @@ -81,9 +67,32 @@ class BootLinux(Test):
>                            # QEMU's hard coded usermode router address
>                            phone_home_host='10.0.2.2',
>                            phone_home_port=self.phone_home_port)
> -            self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
>          except Exception:
>              self.cancel('Failed to prepared cloudinit image')
> +        return cloudinit_iso
> +
> +class BootLinux(BootLinuxBase):
> +    """
> +    Boots a Linux system, checking for a successful initialization
> +    """
> +
> +    timeout = 900
> +    chksum = None
> +
> +    def setUp(self):
> +        super(BootLinux, self).setUp()
> +        self.vm.add_args('-smp', '2')
> +        self.vm.add_args('-m', '1024')
> +        self.prepare_boot()
> +        self.prepare_cloudinit()
> +
> +    def prepare_boot(self):
> +        path = self.download_boot()
> +        self.vm.add_args('-drive', 'file=%s' % path)
> +
> +    def prepare_cloudinit(self):
> +        cloudinit_iso = self.download_cloudinit()
> +        self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
>  
>      def launch_and_wait(self):
>          self.vm.set_console()
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


