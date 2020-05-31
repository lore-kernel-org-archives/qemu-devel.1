Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB8EC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F5C20776
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H48GstiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F5C20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfLEu-0001Ns-2B
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 06:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfLE7-0000sg-J5
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:29:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51366
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfLE6-0007Rd-LO
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590920997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PhnlCGB2ZF0AKggN/S4V4Xrj4vDDqDsN5QOqIgmV360=;
 b=H48GstiYk8g/wIvoO6xrBYIZVzLCdYvFy71xjf4TXooQEMA17t/k06orXaMtKAfoDZu8xr
 KUG2WyqGcr6dNOqhsgb2fyBP6usoxntcnP0R/skDswPB9wkLLaejXBFTeFEn1lxEZss+kJ
 KmcMI5CUM5VxeA1ablEp5fc4pj3DdTY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139--jiDaQ5oOkmML8RYpsJHJA-1; Sun, 31 May 2020 06:29:54 -0400
X-MC-Unique: -jiDaQ5oOkmML8RYpsJHJA-1
Received: by mail-wm1-f70.google.com with SMTP id j128so1851647wmj.6
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 03:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=PhnlCGB2ZF0AKggN/S4V4Xrj4vDDqDsN5QOqIgmV360=;
 b=pH8kaMjjodPvmlRnye3ZU401hZQ8+AVL+S4Qby90MuDXbzgfnq6Sb3CfAIVzuKJ0b6
 LBDACRPhVTdAVebnzI2iMimM0trul5umu+5/nRdnkLSdrlpHsL3S786tIILNDg0iGNMe
 1zUMTOzR54bYelgLPUlBXE+mE3I9Z8KQPp/QMEnwKCt05Yf2FjysNse9ukEngqiZWy3J
 mfXZyETdx6fPB5TZSL5hf+gkVfA31hawzy5gHHUMQ19wlmwVxmiclIVLm8qaGqPRe16j
 +FalYJ71UmfAU34srw7AIwxZcUfokIh31U+HL0YvHOqRzdDlLAEEEidi1MB0drr8bHT1
 OCmg==
X-Gm-Message-State: AOAM5336grMy5fB0qF0IsFrv0g5GApH3iJumkcBi510lFghIj2XTSv2z
 e1dUok+UwlLmU+zCVC2OmIWKcEmFU4Opx8YB4dONZFu/Ta8AZrtr0c6FLOGOTJ/miB2UpIWa0nV
 kWU2jYr5wiUCVmlM=
X-Received: by 2002:a1c:6606:: with SMTP id a6mr16072605wmc.37.1590920993821; 
 Sun, 31 May 2020 03:29:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1ywKHBm4TXZzgXanZ3T0C1EwaqTOKtuMpScvUt3lXjuiN9oXR05un+SbhLkWWKlcs/QSvFQ==
X-Received: by 2002:a1c:6606:: with SMTP id a6mr16072588wmc.37.1590920993602; 
 Sun, 31 May 2020 03:29:53 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id o10sm14148155wrj.37.2020.05.31.03.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 03:29:53 -0700 (PDT)
Subject: Re: [PATCH v8 01/12] tests/vm: pass args through to BaseVM's __init__
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200529203458.1038-1-robert.foley@linaro.org>
 <20200529203458.1038-2-robert.foley@linaro.org>
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
Message-ID: <4ed793ec-6fb8-aa30-6d0d-d8132b98190f@redhat.com>
Date: Sun, 31 May 2020 12:29:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529203458.1038-2-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 05:57:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 10:34 PM, Robert Foley wrote:
> Adding the args parameter to BaseVM's __init__.
> We will shortly need to pass more parameters to the class
> so let's just pass args rather than growing the parameter list.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/basevm.py | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index a2d4054d72..fbefda0595 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -61,9 +61,9 @@ class BaseVM(object):
>      # 4 is arbitrary, but greater than 2,
>      # since we found we need to wait more than twice as long.
>      tcg_ssh_timeout_multiplier = 4
> -    def __init__(self, debug=False, vcpus=None, genisoimage=None):
> +    def __init__(self, args):
>          self._guest = None
> -        self._genisoimage = genisoimage
> +        self._genisoimage = args.genisoimage
>          self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
>                                                           suffix=".tmp",
>                                                           dir="."))
> @@ -76,7 +76,7 @@ class BaseVM(object):
>          self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
>          open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
>  
> -        self.debug = debug
> +        self.debug = args.debug
>          self._stderr = sys.stderr
>          self._devnull = open(os.devnull, "w")
>          if self.debug:
> @@ -90,8 +90,8 @@ class BaseVM(object):
>                         (",ipv6=no" if not self.ipv6 else ""),
>              "-device", "virtio-net-pci,netdev=vnet",
>              "-vnc", "127.0.0.1:0,to=20"]
> -        if vcpus and vcpus > 1:
> -            self._args += ["-smp", "%d" % vcpus]
> +        if args.jobs and args.jobs > 1:
> +            self._args += ["-smp", "%d" % args.jobs]
>          if kvm_available(self.arch):
>              self._args += ["-enable-kvm"]
>          else:
> @@ -438,8 +438,7 @@ def main(vmcls):
>              return 1
>          logging.basicConfig(level=(logging.DEBUG if args.debug
>                                     else logging.WARN))
> -        vm = vmcls(debug=args.debug, vcpus=args.jobs,
> -                   genisoimage=args.genisoimage)
> +        vm = vmcls(args)
>          if args.build_image:
>              if os.path.exists(args.image) and not args.force:
>                  sys.stderr.writelines(["Image file exists: %s\n" % args.image,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


