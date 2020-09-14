Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D14AC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E454420770
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNq/VEfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E454420770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHiJg-0002Dm-Rn
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 02:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHiJ3-0001jB-Sx
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:49:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHiJ2-00075r-FY
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600066179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AXr2YVv7nTjX2uziOVV9d7+k4y5qWP7/Si6eneJ/vig=;
 b=NNq/VEfs7u+kzm0+788hKoCLBdZpaIa178g5BRWUcMdMWEhj1dErMqk2qp6fCevQMf00yp
 qRelo78h8oiJy0tCBxmZ6mo1aKmHA1/r9nbUm8WYFrIAlFWD7kUyntzJisOZB4tP9KUGKj
 vU5l4naYEgvcXx2zV6M3s9slJRZ+ySg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-JmRlVwgYMNqJJDUFYUsfWQ-1; Mon, 14 Sep 2020 02:49:35 -0400
X-MC-Unique: JmRlVwgYMNqJJDUFYUsfWQ-1
Received: by mail-wr1-f72.google.com with SMTP id l9so6459081wrq.20
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 23:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=AXr2YVv7nTjX2uziOVV9d7+k4y5qWP7/Si6eneJ/vig=;
 b=B1zBkiBeqnufwuHMQfz2IkufyVGgn3S+UG9KsxcEaglxQCCxmWCZgWBM4+EYTPKYPi
 09daAbu4AWPJh4+VMzWs60R4TOl1UXkWMCBuxdGeIIP52gyUkzXCe0zrHjKrQvBaAU4I
 YLgO/D7Y1IxJ6NQj0OEKCVlyIHHAG6wo8eJTAsXN8jCg1G1eRO6yILW91ubaoF5LN314
 mBRhjBQqB+na6EarM+d6JE88EpGQXMKydvIPMaKwYj6ac1N4EW6cHedf+0OGNpRwZWxs
 LcfQGrFX2SfRtU/5L/Het7/vEfQlfJUxh8rO49pthIA4ahL4CoQ4aq3XoIWixVFB/jpc
 +a4w==
X-Gm-Message-State: AOAM531xzN63J1APmIShnw8Md85bmydfTOcOCM6Q6p8fnGlKV54S6UNz
 ST+Gz0g8Ia3+3XsQIM9GjAHxDaZy9tMPN9qFTjGvBSVdoXsf2jZqJ3cNPrMfBTGeOgJijw+vqq+
 yz4CE7gSsDARl5R4=
X-Received: by 2002:a1c:7911:: with SMTP id l17mr13292987wme.179.1600066174606; 
 Sun, 13 Sep 2020 23:49:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE445BM3knpeFRF9eX/eIv6SLpQOJC2PDBBM/ziMeblWpQkOYByHefQXVzBBEEzHMP9KPvsg==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr13292966wme.179.1600066174437; 
 Sun, 13 Sep 2020 23:49:34 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b187sm17505265wmb.8.2020.09.13.23.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 23:49:33 -0700 (PDT)
Subject: Re: [PATCH v8 00/27] W32, W64 msys2/mingw patches
To: luoyonggang@gmail.com, Thomas Huth <thuth@redhat.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <276a137d-d863-2465-1fe2-599e5772a1a8@redhat.com>
 <CAE2XoE8WrE1_e1VR1VSG7vWWX9nsbp2iRwZvOur1ouGrbC+Rqw@mail.gmail.com>
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
Message-ID: <2d7d28dc-49ac-3265-15b0-2cdda83d49f3@redhat.com>
Date: Mon, 14 Sep 2020 08:49:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8WrE1_e1VR1VSG7vWWX9nsbp2iRwZvOur1ouGrbC+Rqw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 8:27 AM, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Mon, Sep 14, 2020 at 2:10 PM Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
> 
>     On 13/09/2020 00.44, Yonggang Luo wrote:
>     > It first introduce msys2 CI on cirrus by fixes nfs, capstone,
>     curses and
>     > disable partial test-char tests.
>     > And then fixes all unit tests failure on msys2/mingw
>     > This fixes the reviews suggested in the mailling list
>     > All cirrus CI are passed
> 
>      Hi,
> 
>     since you're very often sending new versions of your patch series, could
>     you please add a history to the cover letter to say what you changed in
>     each version? Otherwise, your work is very hard to follow.
>     I'd also suggest to really slow down the sending a little bit. Let your
>     patches mature in your tests first, then send out a new series only if
>     you feel that they are really ready. Nobody has the bandwith to review a
>     patch series with 27 patches each day...
> 
> Thanks, I am learning how to submit patches properly, in old days,  when
> I am using pull request on github have no such problems. easy to follow up 

GitHub pull-request have the same problem, you can update its patches
and re-reviewing on top is very difficult. Some old review comments
even get deleted. At least having email archive allow us to look
back for older versions/comments.

Regards,

Phil.


