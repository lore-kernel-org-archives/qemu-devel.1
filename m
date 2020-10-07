Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15F0C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 05:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D62208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 05:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVxrxbqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D62208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1uO-0005L5-Vg
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 01:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ1so-0004dA-RH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 01:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ1sm-0005MS-5J
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 01:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602048054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=155nRlOUgpB7tpMso1AZ5Bdijv2DuGHaQ0Nx1JxhHvc=;
 b=KVxrxbqBhU3CWFWDcluCfz6r0Bz3VBr4yyylE5sN7Kq6vPgTAqCNHHt7XkxHVlt4F5M1uB
 KpmNHOFEWK7epZWqSz+F1AicaSUHntshAB0E/xqZwRr/GjqvETNVvGbyQkI1fYHpGbPe52
 G5VyQTVPt5Ke8J+Bqnjx3jthAxxCP1U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-GdOCxBTDOKSTJbqJu7sFlg-1; Wed, 07 Oct 2020 01:20:53 -0400
X-MC-Unique: GdOCxBTDOKSTJbqJu7sFlg-1
Received: by mail-wm1-f71.google.com with SMTP id s12so1695373wmj.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 22:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=155nRlOUgpB7tpMso1AZ5Bdijv2DuGHaQ0Nx1JxhHvc=;
 b=ldDdMsro14h8tHSCoHTj14fdRpyWs7+2zb+Wj4xNBEroLmkWUi/hjmbzz08Civ1QXW
 rNrcQPFukFnkFEs7LiZUfIRsRy6pYkDiJ1ntsl9a8Zrxhrm1oMJvegulqhopCXo2G3bv
 CDYUFNSyb1t9OqQOIygN22x62Zy3vAEVy9Eup9dp5Vx9ZaYynmlISpMAQxaIfDRCrRTn
 dRYcJ4Bheh1lO3Pqq4tfdOMhZz3jZqDs9hKv4bgHNHoUwbPirf1KZf2JvED6q+sPtcyk
 TGeoPYFkTAWAJYKy/iW74UIIN5ueTjcCYucseMic0Vvh7vOl3dwyYAKtK/ecpCOLZ5M8
 6Ifw==
X-Gm-Message-State: AOAM530w76YgJiM4wOVAjDTACcaMtm7BorUIiBLy244x+/PtzG/s1OeS
 iS2PcZOisq7gA+0IIU54vNX3J6lIzAwyDhQEL+Rm+RRXuwzgbjV1dn2yDVLQEqotARL9Wn5JAsm
 oZa48yqHl5ZE4p3Q=
X-Received: by 2002:a1c:e082:: with SMTP id x124mr1237158wmg.60.1602048051956; 
 Tue, 06 Oct 2020 22:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfu8iHo05Q8qvHd2j1mwTBmZ1k++IkaBVgyGqDGkjw4wZUe0SQrbKpVqS8fJW9b/gh6fCk6g==
X-Received: by 2002:a1c:e082:: with SMTP id x124mr1237142wmg.60.1602048051725; 
 Tue, 06 Oct 2020 22:20:51 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c4sm1036836wme.27.2020.10.06.22.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 22:20:51 -0700 (PDT)
Subject: Re: acceptance-system-fedora failures
To: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
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
Message-ID: <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
Date: Wed, 7 Oct 2020 07:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 1:07 AM, John Snow wrote:
> I'm seeing this gitlab test fail quite often in my Python work; I don't
> *think* this has anything to do with my patches, but maybe I need to try
> and bisect this more aggressively.
> 
> The very first hint of an error I see is on line 154:
> 
> https://gitlab.com/jsnow/qemu/-/jobs/776334918#L154
> 
> 22:05:36 ERROR|
> 22:05:36 ERROR| Reproduced traceback from:
> /builds/jsnow/qemu/build/tests/venv/lib64/python3.8/site-packages/avocado/core/test.py:753
> 
> 22:05:36 ERROR| Traceback (most recent call last):
> 22:05:36 ERROR|   File
> "/builds/jsnow/qemu/build/tests/acceptance/avocado_qemu/__init__.py",
> line 171, in setUp
> 22:05:36 ERROR|     self.cancel("No QEMU binary defined or found in the
> build tree")

Last year the Avocado developers said we could have a clearer
log error report, but meanwhile this verbose output is better
that not having anything ¯\_(ツ)_/¯

> 
> Is this a known problem?

"No QEMU binary defined or found in the build tree" is not a
problem, it means a test is skipped because the qemu-system-$ARCH
binary is not found. In your case this is because your job
(acceptance-system-fedora) is based on build-system-fedora
which only build the following targets:

    TARGETS: tricore-softmmu microblaze-softmmu mips-softmmu
      xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu
      sparc64-softmmu

Now I don't understand what binary the EmptyCPUModel/Migration tests
are expecting. Maybe these tests only work when a single target is
built? IOW not expecting that the python code searching for a binary
return multiple ones? -> Eduardo/Cleber.

w.r.t. the error in your build, I told Thomas about the
test_ppc_mac99/day15/invaders.elf timeouting but he said this is
not his area. Richard has been looking yesterday to see if it is
a TCG regression, and said the test either finished/crashed raising
SIGCHLD, but Avocado parent is still waiting for a timeout, so the
children become zombie and the test hang.

Not sure that helps :)

Regards,

Phil.


