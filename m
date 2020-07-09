Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDA0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A29206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhxW4ud/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A29206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtVc3-0005tO-2j
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 08:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtVbL-0005A8-FH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:24:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53875
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtVbJ-0002PK-O2
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594297468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QHq2YupySf3qk97aOozFoF2Q1CTFMMAbnlns0VrKCwU=;
 b=dhxW4ud/4aHE4K9sPFaR2h1dZ6yXo5MBq/a3tfuObkma51C1zuPX2ziTyYZYMwuhPJWf8K
 LyertkHr+VodEoPhxrHrWDfcOOUX+u5Po64h4loU4X3UKQkwAzy6UJQISYbBM9jEvFBU2b
 NwqflfcOrtY+O9C4pBOtp8VERToP0jQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-xHzebYYnOM2NZJGs2EwfOw-1; Thu, 09 Jul 2020 08:24:23 -0400
X-MC-Unique: xHzebYYnOM2NZJGs2EwfOw-1
Received: by mail-wm1-f70.google.com with SMTP id g138so1956872wme.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 05:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QHq2YupySf3qk97aOozFoF2Q1CTFMMAbnlns0VrKCwU=;
 b=exspVqoHmA4PudAHAgLAisR2U9c8fyyvK0w4Np7LqPZa8wtbJ+kCISuxUWNvo0zY7y
 a1L8iMrUXhJoB4mEnnrHX1H79lQxBd8eTx+jjjKhv3dAdkQtZhney6322NQVZ7qEYGCU
 zE2GEMp4wxkGTjcQZKu/kgySplliP5VDJse1ijCh2LvIsVvlrbZNi5dj5yhiVMRb/OWT
 LFsRR4bly7rRsvAOjfxjtfE53UXl+P2xF0PZkHxQY6LbHBvD6KxBSuGtmDkCoe+SpNrn
 EbbxpZ+wGCTrMeaaf32sSLtEjmPeeKaLuJsVU3mOVK/E8caCM6oGlEnsT2bKs9kjzQ3a
 4BIw==
X-Gm-Message-State: AOAM533n+TkRdUxWndMtHaJv/zRRQAvwW/UAEMqxp+QYZJF4+/IIN7Bv
 N4ak2mgs3RSgjAMya01jtPJjuyx3CDNCowhzVWGndUoHciFeWeyjM6zm7aGkY+O3LldwPfs93vs
 dyhQiscOC2urNCtE=
X-Received: by 2002:adf:80c7:: with SMTP id 65mr34939354wrl.246.1594297461932; 
 Thu, 09 Jul 2020 05:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoWScjw3QtfQvVWLt96VWqf+mLmSs5V9zmAsiO2edVgZ5CTJ6uVhLYJihVnnNFSCUeXEuV5Q==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr34939332wrl.246.1594297461702; 
 Thu, 09 Jul 2020 05:24:21 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id z16sm5172775wrr.35.2020.07.09.05.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 05:24:21 -0700 (PDT)
Subject: Re: [PULL 00/41] testing updates (vm, gitlab, misc build fixes)
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
 <CAFEAcA80gPAFRsJcFyO8ogNbSa_ex6fSaxnBYU6awU=Ug+Y7wg@mail.gmail.com>
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
Message-ID: <70a8b609-a84d-1390-7f85-bbade83a980e@redhat.com>
Date: Thu, 9 Jul 2020 14:24:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80gPAFRsJcFyO8ogNbSa_ex6fSaxnBYU6awU=Ug+Y7wg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 1:31 PM, Peter Maydell wrote:
> On Tue, 7 Jul 2020 at 08:09, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> There will be some docker failures until the official repository has
>> seeded but local builds should continue to work.
>>
>> ----
>>
>> The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:
>>
>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200703' into staging (2020-07-04 16:08:41 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-070720-1
>>
>> for you to fetch changes up to 6a726e8ca0286e3ed69945abd447099f6f6a903c:
>>
>>   tests/qht-bench: Adjust threshold computation (2020-07-07 07:57:41 +0100)
>>
>> ----------------------------------------------------------------
>> Testing and build updates:
>>
>>   - tests/vm support for aarch64 VMs
>>   - tests/tcg better cross-compiler detection
>>   - update docker tooling to support registries
>>   - gitlab build docker images and store in registry
>>   - gitlab use docker images for builds
>>   - a number of skipIf updates to support move
>>   - linux-user MAP_FIXED_NOREPLACE fix
>>   - qht-bench compiler tweaks
>>   - configure fix for secret keyring
>>   - tsan fiber annotation clean-up
[...]
> Also a compile failure on s390x, but since this isn't related
> to changes you made afaict I wonder if it's the result of
> a change in the build environment:
> /home/ubuntu/qemu/block/ssh.c: In function ‘check_host_key_knownhosts’:
> /home/ubuntu/qemu/block/ssh.c:281:28: error: storage size of ‘state’ isn’t known
>      enum ssh_known_hosts_e state;
>                             ^~~~~
> /home/ubuntu/qemu/block/ssh.c:289:13: error: implicit declaration of
> function ‘ssh_session_is_known_server’ [-Werror=implicit-funct
> ion-declaration]
>      state = ssh_session_is_known_server(s->session);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> [and other errors]

libssh is bugged on Ubuntu 18.04.
https://bugs.launchpad.net/qemu/+bug/1838763

We need to use 'configure --disable-libssh' there.


