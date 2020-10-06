Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C7AC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B9C20789
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VciRwD0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B9C20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPi3E-0003tx-2p
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPhby-0003Bv-S7
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPhbx-0002xw-0p
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601970131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgId7LstDm7tdDrDOesKhRCBO+RL7ifS3kYl+H00O8g=;
 b=VciRwD0XJWKmYO3DJOkREAHnV85VXQskBCmjCYaAz2S5HkkIxpbBxODXkFuQasMvinQ8sY
 46x50UQfxzaCuK7cpMjfYNvppN7Mc14ysAlKyKdHU/till8rWaCv2V2yDZnO8Jw0Yt6dE3
 E/odgqcCQe0vmaRk3Y0lbSRyhuJ2v38=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-Tj_jdBSmNp6Tf5YPq1zMWA-1; Tue, 06 Oct 2020 03:42:08 -0400
X-MC-Unique: Tj_jdBSmNp6Tf5YPq1zMWA-1
Received: by mail-wr1-f70.google.com with SMTP id r16so4991887wrm.18
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BgId7LstDm7tdDrDOesKhRCBO+RL7ifS3kYl+H00O8g=;
 b=CQbSJcNkAQJQwqpoBaaIQDgfLxvYxCWrVyONQLbHjroGpZQF/mGaRCJyKdi88W7GFj
 RnZx57VFhvI/1Vi/Nw59OYJbghODTdl2ThcCXw5P2Vg9W4yMa6KkyFIKl21k8/sQSOi9
 2fJWEEsusRDvckdPdJBL55x6lonaNcdNh2YcgCrPinSddpV/ZhCjX60uvCCLvZmUVNRF
 q2iWSM9Vv1TL/dYU/svBIgFqNlHO1sQgaFbOTCjUJZO7yjax0vPNEiKMI7CVv31SoH4V
 KKuDd3rTbF7fY/MPuJC3t5QsVtBw39IBHIpv93Sy8BKQNANGntPLsw1qFZHQLNqdFcAN
 VV4w==
X-Gm-Message-State: AOAM531KRJe5qsgBMJlkQfisdc5aYxiQ8VjSunlRz8DxJrv2uHixlACG
 glvzh7Yux817+u+avSPL0bLtrQWjFnc1Zk4FXEEha66zwvlb3MTlxorSazkkXKyon+dX2ZI5hd9
 xCptUdPel6VlRQPA=
X-Received: by 2002:a1c:a593:: with SMTP id o141mr3352646wme.88.1601970126747; 
 Tue, 06 Oct 2020 00:42:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHM1zfXwthC7OTHyqntKgn8EiG/SZjcN514t2ZqVLFf3YTtTgs4CjaCN71VEkIEw/Dt/9e+w==
X-Received: by 2002:a1c:a593:: with SMTP id o141mr3352616wme.88.1601970126489; 
 Tue, 06 Oct 2020 00:42:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id h76sm2818079wme.10.2020.10.06.00.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 00:42:05 -0700 (PDT)
Subject: Re: [PATCH v2] scripts: Convert qemu-version.sh to qemu-version.py
To: Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20201005172109.416-1-luoyonggang@gmail.com>
 <CAFEAcA95r2FZibphrO0N_rckWOKigM_d80Qi0grtpWWzN3d19A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f6f412b-03f8-b8f3-9708-0080277999a6@redhat.com>
Date: Tue, 6 Oct 2020 09:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95r2FZibphrO0N_rckWOKigM_d80Qi0grtpWWzN3d19A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 21:22, Peter Maydell wrote:
>> +def main(args):
>> +    if len(args) <= 3:
>> +        sys.exit(0)
>> +
>> +    dir = args[1]
>> +    pkgversion = args[2]
>> +    version = args[3]

In addition to what Peter pointed out, all these lines can be changed to

    def main(dir, pkgversion, version, *unused):

and below

    if __name__ == "__main__":
        main(*sys.argv)

>> +    pc = subprocess.run(['git', 'describe', '--match', "'v*'", '--dirty', '--always'],
>> +        stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, cwd=dir)
>> +    if pc.returncode == 0:
>> +        pkgversion = pc.stdout.decode('utf8').strip()
>> +    fullversion = version
>> +    if len(pkgversion) > 0:

Just "if pkgversion:" please.

>> +        fullversion = "{} ({})".format(version, pkgversion)
>> +
>> +    version_header = '''#define QEMU_PKGVERSION "{}"
>> +#define QEMU_FULL_VERSION "{}"'''.format(pkgversion, fullversion)
>> +    sys.stdout.buffer.write(version_header.encode('utf8'))

No need to use buffer and encode, just

    print('#define QEMU_PKGVERSION "%s"' % pkgversion)
    print('#define QEMU_FULLVERSION "%s"' % fullversion)

It is still a bit more clunky than a shell script, but at least not as much.

Paolo


