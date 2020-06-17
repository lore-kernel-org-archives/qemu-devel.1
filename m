Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96E7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B29208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6qUI/EM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B29208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlbfx-0008Sm-0J
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 13:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlbfE-0007kC-Nl
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:15:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31451
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlbfD-00028O-3U
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592414150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Tuddeaq+IeCsL0MvGEaibHwOLVKI+fbQ6Sghs+xlEoA=;
 b=J6qUI/EMb9LB8q71n8c2vwXVsbYVCC/r1pzSMl6lX4EZFbdi1EzkvHPA4ittka/FU1NfLJ
 MPPn4yywgv9LThhmiNWDDkMUfEB8hO0yYk+TTlrf45SY7B9msfHMDwduhTe0cG650wkMax
 68vPOV34TIddwJ7HSz0/2WyOmfdDyp0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-gfwVYKmqOgGWrBCecxuFBQ-1; Wed, 17 Jun 2020 13:15:48 -0400
X-MC-Unique: gfwVYKmqOgGWrBCecxuFBQ-1
Received: by mail-ed1-f71.google.com with SMTP id y4so1210439edo.16
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Tuddeaq+IeCsL0MvGEaibHwOLVKI+fbQ6Sghs+xlEoA=;
 b=JSxSm+fc6y13UTDDdTC/Lr8XegBw0ZMGWU8jssy+t6KUiAp7peBGHLKHlj5uGGkFR7
 FYj27chH9JFrM8xwVLIPEJIJXnsm/+V+2NoOMrZIdJFymoKqgznExuMA4p5kt74hnGt8
 XbAsd7jI4vtZgCKJJ3n3Q6n69kjle1rWl8QHrx6oL11VJ0GvMT/3MReMaUdkvliAOfbq
 DX+wNyHkHSNQI2BcZpEjXEe+9Ici/GquebzjdQja3UwmFzhn4d4hp8jKH4xb1nAKMTQH
 16DDqR5bsnp8/9Iy38Gx+PPr8FVua2ijL9+m5NlR3OOWkIh/Xkl/HTsHMRBP/55zxYLe
 jWmQ==
X-Gm-Message-State: AOAM533yDdOj+Abnevzd5XzHfFtESkzdy1JY5+rafKovUvrnw5Lw1k3c
 VinTGgdW1K3zFgPoan9jOMeIWNs0WRuY5+xeXJtRcxe9Vx78OvKfYcT4SbyQSnyoadUaCybCVbI
 EYP/Ans6mA0SX35I=
X-Received: by 2002:aa7:d283:: with SMTP id w3mr206316edq.262.1592414146633;
 Wed, 17 Jun 2020 10:15:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7gy+RXw38OFIB499HQaAS3Ieot0RCvSB70CTLtLLbgUSKoKtft0eFWymTUAoUQg45b49FKg==
X-Received: by 2002:aa7:d283:: with SMTP id w3mr206300edq.262.1592414146432;
 Wed, 17 Jun 2020 10:15:46 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id o16sm398723ejg.106.2020.06.17.10.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 10:15:45 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] python/machine.py: refactor shutdown
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200604195252.20739-1-jsnow@redhat.com>
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
Message-ID: <3af15942-4097-e47d-9ba0-24059a205228@redhat.com>
Date: Wed, 17 Jun 2020 19:15:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200604195252.20739-1-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 9:52 PM, John Snow wrote:
> v3:
>  - Split _post_shutdown refactor into own patch (now 1/3)
>  - Re-add sigkill warning squelch (now 3/3)
> 
> NOTE: I re-added the squelch in its own patch for review purposes, but
> for the purposes of avoiding temporary breakage, a maintainer may wish
> to squash patches 2 and 3 if they are accepted.
> 
> v2: Philippe took patches 1, 3 and 4.
> 
> This is a re-write of what was:
> [PATCH RFC 03/32] python//machine.py: remove bare except
> [PATCH 2/4] python/machine.py: remove bare except
> 
> It's a bit heavier handed, but it should address some of kwolf's
> feedback from the RFC version.
> 
> Applies straight to origin/master, ought to pass pylint and flake8:
> 
>> cd ~/src/qemu/python/qemu
>> pylint *.py
>> flake8 *.py
> 
> John Snow (3):
>   python/machine.py: consolidate _post_shutdown()
>   python/machine.py: refactor shutdown
>   python/machine.py: re-add sigkill warning suppression
> 
>  python/qemu/machine.py | 100 +++++++++++++++++++++++++++++------------
>  1 file changed, 71 insertions(+), 29 deletions(-)
> 

I had prepared:

Thanks, applied to my python-next tree (including your
diff in python/qemu/machine.py):
https://gitlab.com/philmd/qemu/commits/python-next

But I just noticed Cleber review comment asking for more testing,
so I'm keeping this applied, but will delay the pull request
since I have to re-run the testing.

Phil.


