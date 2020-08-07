Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8229FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D18620855
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLHBeFFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D18620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yYU-0002U5-Ii
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3yXj-0001lY-VQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3yXi-0001Y6-4r
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596792001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dR7tT+k79o16BwejfpYZPSHttSNmvHIOfu/iKvfiIq8=;
 b=OLHBeFFejf2uTNvj3P29uWzlID3JD1smL0X2zSrdWsZ42LdxJziUzts1hqSx5xb4NE0cxy
 SMB0pF6A8JydyXaLQmkJgMCmsIHGvOUukk2if76y0omBwYp1Z/lbuzU3GC+41ROdnG2Y5P
 lMTTyYtNi0bl0FnrurxubVWYPlK+Chg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-gjqq0b8FPOKrN0TbrnseTw-1; Fri, 07 Aug 2020 05:19:59 -0400
X-MC-Unique: gjqq0b8FPOKrN0TbrnseTw-1
Received: by mail-wr1-f71.google.com with SMTP id b18so510397wrn.6
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dR7tT+k79o16BwejfpYZPSHttSNmvHIOfu/iKvfiIq8=;
 b=A1ntBcI1sjMaye4gacOJnN/Xo2fe8mY8yJOuhWenKba5BMqGL1pF9V1NqULxJ41/32
 aqdtuvfxcemqp+rPN8ROIsqEWo8jXAOko790Fnb6wEnvPDdByWJwYzfHPtre/xUb6cvo
 sMWshLyMzq5xmMIz548aSlT2AB57A/QQ0GMobrcWRaWUJo3HPApEWKATnBbqr1tmmVv8
 k+ByM/LtBaJSp+Cpfa28R+MiMM/69Se6Oqj3JTR36hJUoR6mLayHnH0RY/MPD65zuUf1
 6Kx4AksafGHyJnTmyZj3GDoQ42/KbZtH50UVHg3Zp4qBZV4aprnIzwuvTjz87CFdzIC9
 P6eg==
X-Gm-Message-State: AOAM533UjIxtK4FqYrEAJTelriheNoHZKXJ5SQ+c3BMsojz7GP9UgtV1
 ucL2xJGBIjtv+YrvZzbTLNsxlloH5QUC1qDJw5OQ+z5t4aYzBqYma5fg2Fg8oGY7yt6nltUh4OK
 Vw70y8HJ9xUneTcQ=
X-Received: by 2002:adf:ffc1:: with SMTP id x1mr11608426wrs.54.1596791998373; 
 Fri, 07 Aug 2020 02:19:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIQHOd0rua9R6DKf3t0kwt2fTQmSkU447X4IEn5XpTeVtQ60CmMhD/tImDiCGQHxb3/WHSvQ==
X-Received: by 2002:adf:ffc1:: with SMTP id x1mr11608407wrs.54.1596791998148; 
 Fri, 07 Aug 2020 02:19:58 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z66sm9609392wme.16.2020.08.07.02.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 02:19:57 -0700 (PDT)
Subject: Re: [Bug 1030807] Re: PCI host bridge should ignore 1- and 2-byte I/O
 accesses
To: Bug 1030807 <1030807@bugs.launchpad.net>, qemu-devel@nongnu.org,
 Julia Suvorova <jusual@redhat.com>
References: <20120730102531.13148.51710.malonedeb@wampee.canonical.com>
 <159678769319.10780.14963118191647047477.malone@chaenomeles.canonical.com>
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
Message-ID: <4e854df9-b3e2-ecf0-0c24-0c4d8031bd93@redhat.com>
Date: Fri, 7 Aug 2020 11:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159678769319.10780.14963118191647047477.malone@chaenomeles.canonical.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:20:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Julia (can't find her on Launchpad) because this looks
similar to a bug she has been tracking.

On 8/7/20 10:08 AM, Thomas Huth wrote:
> Looking through old bug tickets... is this still an issue with the
> latest version of QEMU? Or could we close this ticket nowadays?
> 
> 
> ** Changed in: qemu
>        Status: New => Incomplete
> 


