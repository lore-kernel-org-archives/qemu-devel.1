Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37F6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFEE207FB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/THGT2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFEE207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfKe-0006E4-Ml
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqfEN-0002me-IE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:05:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25512
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqfEK-0004up-L6
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593619499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=exGaVSNtf3byLDfh4PqMvibGSI3h7BJ109LGnuPkwww=;
 b=O/THGT2cWXkPT+nKWloNoBymfdbcpSijXuconPnuT+x9bB4+N3aK+TkPO4rkkgmK+j8d75
 ut68QjmDpAUbOD8zIy6YBbeDqO/BDxDFu9FFrHDZgRmtsJI7hUw0bYQWldG5vjmgZ+F1Dx
 tFzXd0uZhojeLcFR2KujSctvGUdecWg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-vulZvUf3MimbuLV1CJbwRw-1; Wed, 01 Jul 2020 12:04:58 -0400
X-MC-Unique: vulZvUf3MimbuLV1CJbwRw-1
Received: by mail-ed1-f72.google.com with SMTP id y92so17012070eda.12
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 09:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=exGaVSNtf3byLDfh4PqMvibGSI3h7BJ109LGnuPkwww=;
 b=G1jQUu728A7ku5ImwOoCcMkDr7/fkushUX/LgXFgOk/LXMqJz0b3h1EDpgK/4T52bP
 POKaPQlHiQlcT2MqKfZjKNkSsOd9t0GfYZQmdQqNNor0eJ770zQFXwZI3x8CYpzpak+b
 kKvMCSisHRRNjzLzWoJfk7znD3fwIQny4NgxlI1sQayMdgBm0exGw4DpHVQyVMk+x1BG
 IYNj+2IIFSStA3978GVPJslsDa1ZreUOy9ZVIIL4aVcq3PeQfQJia5B33ViEVqj5dSEL
 KoBEGb0MnklpvaoUwWmEKkdbKjwKL7zy3Wr1kyo5fxuVwVesmAt5xxWD+YQCMW2hjO6a
 KVPA==
X-Gm-Message-State: AOAM532nfNtEcUicDRSF+1hTHhZVd/5gGNTYz4u0JlElAvis/5JcVXqn
 NucfIVAknChDmhzhfV2EVp0HL0luc+svzjuMgtNTdNdFHmMrWkphyBX/po5U4LFZKwk/3AgpK4f
 YbbJ8mpxCHkgzLbY=
X-Received: by 2002:a17:907:7244:: with SMTP id
 ds4mr13770550ejc.509.1593619496628; 
 Wed, 01 Jul 2020 09:04:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj2LzL7/Mu/M1gRKZVMaECkjCjbYX47EgpGu/D5TwHmeeroiA41KeV4rZv1cAWLjbYq2H/8A==
X-Received: by 2002:a17:907:7244:: with SMTP id
 ds4mr13770520ejc.509.1593619496330; 
 Wed, 01 Jul 2020 09:04:56 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id ce15sm4812470ejc.86.2020.07.01.09.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 09:04:55 -0700 (PDT)
Subject: Re: [PATC 7/9] Skipping drm build, unsupported
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>
References: <CA+XhMqzjjrfxXeSENBQuHzTe4TRMWV5GOdqPkD3bo17T3ufR1A@mail.gmail.com>
 <1058ccbd-b4bb-9413-abc5-ae89076a58e1@redhat.com>
 <20200630082301.6vybzwmg4pviuwob@sirius.home.kraxel.org>
 <CAFEAcA8jkzf8+d5AyAVH2HJ544TyHsM4xP5tpWsKiJbJtWMjKw@mail.gmail.com>
 <20200630165356.2ka2ltwmrfjb5msn@sirius.home.kraxel.org>
 <3eb3c266-1a83-9f40-4760-1ab2578ae5d6@redhat.com>
 <20200701151524.wogl4ihbdevgf4bt@sirius.home.kraxel.org>
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
Message-ID: <561e33c0-507b-ecc6-39ab-50b858eae315@redhat.com>
Date: Wed, 1 Jul 2020 18:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701151524.wogl4ihbdevgf4bt@sirius.home.kraxel.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, David CARLIER <devnexen@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 7/1/20 5:15 PM, Gerd Hoffmann wrote:
>>> Ah, that is the problem.  Yes, DT_CHR is an non-posix optimization which
>>> allows to get the file type directly, without another round-trip to the
>>> kernel.  If that isn't available you can stat() the file and check
>>> ((st_mode & S_IFMT) == S_IFCHR) instead.
>>
>> Even when d_type and DT_CHR is available, there are filesystems where the
>> Linux kernel reports d_type of DT_UNKNOWN, and where you are best having
>> that code also falling back to an fstat().
> 
> Given this isn't perforance critical at all it is probably simplest to
> avoid non-portable d_type altogether and just to the fstat
> unconditionally.
> 
> David, does that work for haiku?
> 
> take care,
>   Gerd
> 
> diff --git a/util/drm.c b/util/drm.c
> index a23ff2453826..a1d3520d00f2 100644
> --- a/util/drm.c
> +++ b/util/drm.c
> @@ -24,6 +24,7 @@ int qemu_drm_rendernode_open(const char *rendernode)
>  {
>      DIR *dir;
>      struct dirent *e;
> +    struct stat st;
>      int r, fd;
>      char *p;
>  
> @@ -38,10 +39,6 @@ int qemu_drm_rendernode_open(const char *rendernode)
>  
>      fd = -1;
>      while ((e = readdir(dir))) {
> -        if (e->d_type != DT_CHR) {
> -            continue;
> -        }
> -
>          if (strncmp(e->d_name, "renderD", 7)) {
>              continue;
>          }
> @@ -53,6 +50,12 @@ int qemu_drm_rendernode_open(const char *rendernode)
>              g_free(p);
>              continue;
>          }
> +        fstat(r, &st);

While preparing the formal patch, can you add a comment here explaining
we deliberately use this way for portability (not checking DT_CHR /
DT_UNKNOWN ...)?

Thanks!

> +        if ((st.st_mode & S_IFMT) != S_IFCHR) {
> +            close(r);
> +            g_free(p);
> +            continue;
> +        }
>          fd = r;
>          g_free(p);
>          break;
> 


