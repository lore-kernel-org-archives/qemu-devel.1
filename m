Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF1DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E8C2245C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtOkFP8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E8C2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5pkh-0007fn-4h
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 08:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5pjX-00072h-By
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:19:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5pjV-0002cD-4s
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597234792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=989288FbIlvacuy6N/3Yg9uqNHxm/HXXkikvRLzl2jc=;
 b=LtOkFP8Y6qvNnca1a70jbtfL/SYmFtD2RmVwXLWc8m9vtoWLvOsxZAUI2iCVRDh4maZFE+
 mOxWKHz1JOMtpy/k4BiHYKyM7/ovZi3gbenVIrOu9xfWs6HiFNnSpqxCFF1qzYRy7jA1HZ
 noI3e3l+J8cTksKsm2XZVRXMMmCRT/k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-qtEv3BWwMcOF1vHMA5wkSA-1; Wed, 12 Aug 2020 08:19:49 -0400
X-MC-Unique: qtEv3BWwMcOF1vHMA5wkSA-1
Received: by mail-wm1-f72.google.com with SMTP id t26so829974wmn.4
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 05:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=989288FbIlvacuy6N/3Yg9uqNHxm/HXXkikvRLzl2jc=;
 b=HAknvlHEU4zn2JwpNpXm1CZCCip91zr45kjK12zF2WOx5tISYmEp5ajWSSO7f8Mq4o
 ZgppNJWXC9evKqhbwlg42t2os8/xv0Nso879oNhHXAagkfisQn6PBtMOuqe4KMhAbC1F
 SaDEKUgOpC7DDXow6/SztdifB1qo9c+ogRSfTaCOkkVdE8j34JoSkvOpnTfakhoHtRoL
 5lxKXCOsa5wp5At+1xTbzKK32zGvMfYzkavgd7yPijuN8MN+shosZiQN9J2J1O/FLr+m
 rTnwupWV0k4vjMjnV/5EsASyx+ST1ociqVzcGz8JxQn9IBbhmTwzoGFahacWm/FZP5CR
 mhpQ==
X-Gm-Message-State: AOAM5336IMfK1mZvpth2swjO0zx2M37KPRMtUad0iYtjiUiGvhVLLkUD
 +KVp3DOtHFtYSNMOBZC6XQ0R8oPSXQ4+mQgLAOR69UNfbN+AclEmH9k4XSXeC4drdu4hDYv7msN
 A1Ic4xY0FVis4u2w=
X-Received: by 2002:a1c:6707:: with SMTP id b7mr8010376wmc.97.1597234786854;
 Wed, 12 Aug 2020 05:19:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKbs0YYWdtSNS9WbhJgC1z+l+Bh096nXcsRCYlbDIFDC+la5vOq1WV2hYsWipcGhx+nvILBw==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr8010350wmc.97.1597234786568;
 Wed, 12 Aug 2020 05:19:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id u204sm3800016wmg.9.2020.08.12.05.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 05:19:45 -0700 (PDT)
Subject: Re: Acceptance Test BootLinuxAarch64.test_virt_tcg execution times
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200806193553.GA1463846@localhost.localdomain>
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
Message-ID: <e1eab172-5f29-dd54-c78a-fc76216fe97c@redhat.com>
Date: Wed, 12 Aug 2020 14:19:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200806193553.GA1463846@localhost.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 9:35 PM, Cleber Rosa wrote:
> TL;DR: This is a followup from an IRC chat about the
> tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg test
> taking many orders of magnitute longer than other acceptance (and even
> similar boot) tests.  I could not find an easy way for this specific
> test (aarch64+tcg) to have a significant execution time improvement.
> The best solution may be to filter out tests that are known to be
> slow, and create a specific "test job" that includes them.
> 
> Fisrt, if it's not clear, this specific test runs QEMU with TCG and
> boots a Fedora 31 "cloud image" and waits until the cloud-init agent
> notifies the test that the boot is over.
> 
> Out of the four archtiectures tested with the same approach under
> "tests/acceptance/boot_linux.py", aarch64 was special, in the sense
> that many Linux "cloud images" got stuck very late in the boot
> process.  What seemed to be a disk activity within the guest that
> seemed to make the kernel drain its random number sources if my memory
> serves me right.  Giving the machine a RNG device fixed it.  This can
> still be verified Today if you comment the virtio-rng lines in the
> aarch64 test.
> 
> So, even with the RNG device and the boot process not getting stuck, a
> lot of the test time is spent with QEMU actively using CPU time
> produced by the guest boot process.  This may or may not be the cause
> for the slowness.

I believe this is related to the issue Richard recently addressed:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg729216.html

> 
> One approach to have a shorter test time, would be to reduce the
> things that happen during the guest boot process.  Choosing a minimal
> guest, such as CirrOS, would be an example of such a solution, but:
> 
> * With less things happening during the guest boot, less things
>   get tested within QEMU;
> 
> * CirrOS can not make use of the same boot cloud-init configuration
>   and boot verification the test currently uses;
> 
> So that leaves other non-minimal Linux "cloud images" as options.  But
> still, the following things are required or nice to have:
> 
> * Support for cloud-init;
> 
> * Support for as many as possible architectures;
> 
> * Wide user base;
> 
> * Be thoroughly tested with this "boot_linux.py" test
> 
> So in the end, I picked Fedora 31, which was available and behaved
> well for four different architectures with and without KVM. Today, I
> verified if switching distros would provide an "easy fix", but the
> results were negative.  Any ideas on how to improve the test execution
> times are appreciated.
> 
> For the record, one of the ways we're trying to improve the overall
> test experience is to allow tests to run in parallel (expected to be
> fully supported on the upcoming version 81.0).
> 
> For those interested, these are the numbers I got, and how I tested
> with other distros.  I'm using QEMU e1d322c405 with a vanilla
> configure under a x86_64 Fedora 32 host.
> 
> Fedora 31 (baseline):
> ====================
> 
>   $ make check-venv
>   $ ./tests/venv/bin/avocado run -t arch:aarch64,accel:tcg --keep-tmp on -- tests/acceptance/boot_linux.py{,,,,}
>   JOB ID     : 14802f9d5016a44d2937ed7b1fec63b2eaa06e89
>   JOB LOG    : /home/cleber/avocado/job-results/job-2020-08-06T13.19-14802f9/job.log
>    (1/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (153.12 s)
>    (2/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (149.57 s)
>    (3/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (154.45 s)
>    (4/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (148.97 s)
>    (5/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (150.70 s)
>   RESULTS    : PASS 5 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>   JOB TIME   : 757.50 s
> 
> Fedora 32:
> ==========
> 
> 1. Tweak version and image hash:
> 
> ---
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
> index 0055dc7cee..44c62bd4a2 100644
> --- a/tests/acceptance/boot_linux.py
> +++ b/tests/acceptance/boot_linux.py
> @@ -48,7 +48,7 @@ class BootLinuxBase(Test):
>              image_arch = 'ppc64le'
>          try:
>              boot = vmimage.get(
> -                'fedora', arch=image_arch, version='31',
> +                'fedora', arch=image_arch, version='32',
>                  checksum=self.chksum,
>                  algorithm='sha256',
>                  cache_dir=self.cache_dirs[0],
> @@ -160,7 +160,7 @@ class BootLinuxAarch64(BootLinux):
>      :avocado: tags=machine:gic-version=2
>      """
>  
> -    chksum = '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf16fe49'
> +    chksum = 'b367755c664a2d7a26955bbfff985855adfa2ca15e908baf15b4b176d68d3967'
>  
>      def add_common_args(self):
>          self.vm.add_args('-bios',
> ---
> 
> 2. Download the image before the test:
> 
>   $ ./tests/venv/bin/avocado vmimage get --distro=fedora --arch aarch64 --distro-version=32
>   The image was downloaded:
>   Provider Version Architecture File
>   fedora   32      aarch64      /tmp/data/cache/by_location/7049001631a4b2eabf5766cc110e66d486e09821/Fedora-Cloud-Base-32-1.6.aarch64.qcow2
> 
> 3. Run the tests:
> 
>   $ ./tests/venv/bin/avocado run -t arch:aarch64,accel:tcg --keep-tmp on -- tests/acceptance/boot_linux.py{,,,,}
> JOB ID     : 09e740a41dc400f9fcbb9253f613734597fe0efc
> JOB LOG    : /home/cleber/avocado/job-results/job-2020-08-06T13.53-09e740a/job.log
>  (1/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (162.06 s)
>  (2/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (167.78 s)
>  (3/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (166.98 s)
>  (4/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (171.13 s)
>  (5/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (167.43 s)
> RESULTS    : PASS 5 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
> JOB TIME   : 836.05 s
> 
> Ubuntu 20.04:
> =============
> 
> 1. Tweak version and image hash:
> 
> ---
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
> index 0055dc7cee..03c0e1bee9 100644
> --- a/tests/acceptance/boot_linux.py
> +++ b/tests/acceptance/boot_linux.py
> @@ -48,7 +48,7 @@ class BootLinuxBase(Test):
>              image_arch = 'ppc64le'
>          try:
>              boot = vmimage.get(
> -                'fedora', arch=image_arch, version='31',
> +                'ubuntu', arch=image_arch, version='20.04',
>                  checksum=self.chksum,
>                  algorithm='sha256',
>                  cache_dir=self.cache_dirs[0],
> @@ -160,7 +160,7 @@ class BootLinuxAarch64(BootLinux):
>      :avocado: tags=machine:gic-version=2
>      """
>  
> -    chksum = '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf16fe49'
> +    chksum = '1d9e50f3381145835b11911adf611f455d674a570814086b7d6581ecc0718770'
>  
>      def add_common_args(self):
>          self.vm.add_args('-bios',
> ---
> 
> 2. Download the image before the test:
> 
>   $ ./tests/venv/bin/avocado vmimage get --distro=ubuntu --arch aarch64 --distro-version=20.04
>   The image was downloaded:
>   Provider Version Architecture File
>   ubuntu   20.04   arm64        /tmp/data/cache/by_location/19db8c6d910a3f2660c4109ffb85d73d43e5cdf2/ubuntu-20.04-server-cloudimg-arm64.img
> 
> 3. Run the tests:
> 
>   $ ./tests/venv/bin/avocado run -t arch:aarch64,accel:tcg --keep-tmp on -- tests/acceptance/boot_linux.py{,,,,}
>   JOB ID     : 92a1bdbb5e933e6dff8b882808a191f1de3c2600
>   JOB LOG    : /home/cleber/avocado/job-results/job-2020-08-06T12.13-92a1bdb/job.log
>    (1/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (341.40 s)
>    (2/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (345.82 s)
>    (3/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (335.91 s)
>    (4/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (320.32 s)
>    (5/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS (319.79 s)
>   RESULTS    : PASS 5 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>   JOB TIME   : 1663.92 s
> 


