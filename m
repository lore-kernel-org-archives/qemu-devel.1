Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCA02074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFe7OXGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCA02074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jebW9-00058F-Ro
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 05:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jebVR-0004d1-Tg
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:40:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jebVQ-0000ps-Dq
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590745247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UPtCI1ILff4fIxcDolPO4f3yzUVTY12YYe6DiQxSHEY=;
 b=dFe7OXGQq+0r/7wcmEN7bBmQUF4vLKzkjuKCQc3O6e9i38CqMBqehGnvJLtYBiAaxTRBN7
 NDHYyYUN3hbCUCwwbH8GEPVMhIGJq/Yjm5L2kouzC4IunJwkek+ovTbYw9CB0+VMTJD+w6
 S8bxOh22Hz90Y3EUNgWgQTWCmGqVUas=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-OGelHLYDMA2J8qipqquSWw-1; Fri, 29 May 2020 05:40:45 -0400
X-MC-Unique: OGelHLYDMA2J8qipqquSWw-1
Received: by mail-wr1-f70.google.com with SMTP id c14so809859wrw.11
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 02:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UPtCI1ILff4fIxcDolPO4f3yzUVTY12YYe6DiQxSHEY=;
 b=k0rVZXa5Rj6jiPYLTOKJ9joqQUZAlgN3Y5j0bYYKOE9q26qBCjUa9jjIxN2Vtuvsdn
 Fo2+gyiE5DqcCA92E3dXrMPYGfpbnHZvqIzUGz/Lx4EU3lPvdRh77gt15MU3St15fYbJ
 kTpvyhFNrK3uB/d/MsbWOqBAxkVyP40mQJ3wpp9768NcFZDBYfCU2UD6/VSBOmdqZHkr
 evXz1Q4ANVv5zSB/Ee3gonz3CH6mEWovgE8x8jLrgGWn3LVZYKTINBGySjUiCXvCQxDg
 EnjgdIk3y2GQWcSS0sq43F/T3+sYx402qSmrVyISSxbRQQvps93rmViQoKH7uUQOLTUW
 cYrQ==
X-Gm-Message-State: AOAM531XjPCwVp4bSB0CVaqx6I7JwXCTDH1zez5E4c4sv7iczAYat94+
 70a6RbRH1nWMWw4bptpdxOacXefoAzdb9xPmnmMTVQRMESn+RduYDVgSsJIssDIaITD8gk6Mskc
 Rgkx65iEuT8lgJVY=
X-Received: by 2002:a7b:c764:: with SMTP id x4mr1596756wmk.94.1590745244166;
 Fri, 29 May 2020 02:40:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLftavAO6RwLptM12fhh21OFc2vujYUyeYMuOsOsbu1L9MnawKG1jHOXUziAu3mFuPCB5H2Q==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr1596729wmk.94.1590745243909;
 Fri, 29 May 2020 02:40:43 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id q128sm9560245wma.38.2020.05.29.02.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 02:40:43 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] scripts: More Python fixes
To: qemu-devel@nongnu.org
References: <20200512103238.7078-1-philmd@redhat.com>
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
Message-ID: <dfbf5d8b-c02f-2ac9-80cd-c1190728eb74@redhat.com>
Date: Fri, 29 May 2020 11:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512103238.7078-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, kvm@vger.kernel.org, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 12:32 PM, Philippe Mathieu-Daudé wrote:
> Trivial Python3 fixes, again...
> 
> Since v3:
> - Fixed missing scripts/qemugdb/timers.py (kwolf)
> - Cover more scripts
> - Check for __main__ in few scripts
> 
> Since v2:
> - Remove patch updating MAINTAINERS
> 
> Since v1:
> - Added Alex Bennée A-b tags
> - Addressed John Snow review comments
>   - Use /usr/bin/env
>   - Do not modify os.path (dropped last patch)
> 
> Philippe Mathieu-Daudé (6):
>   scripts/qemugdb: Remove shebang header
>   scripts/qemu-gdb: Use Python 3 interpreter
>   scripts/qmp: Use Python 3 interpreter
>   scripts/kvm/vmxcap: Use Python 3 interpreter and add pseudo-main()
>   scripts/modules/module_block: Use Python 3 interpreter & add
>     pseudo-main
>   tests/migration/guestperf: Use Python 3 interpreter
> 
>  scripts/kvm/vmxcap                 |  7 ++++---
>  scripts/modules/module_block.py    | 31 +++++++++++++++---------------
>  scripts/qemu-gdb.py                |  4 ++--
>  scripts/qemugdb/__init__.py        |  3 +--
>  scripts/qemugdb/aio.py             |  3 +--
>  scripts/qemugdb/coroutine.py       |  3 +--
>  scripts/qemugdb/mtree.py           |  4 +---
>  scripts/qemugdb/tcg.py             |  1 -
>  scripts/qemugdb/timers.py          |  1 -
>  scripts/qmp/qom-get                |  2 +-
>  scripts/qmp/qom-list               |  2 +-
>  scripts/qmp/qom-set                |  2 +-
>  scripts/qmp/qom-tree               |  2 +-
>  tests/migration/guestperf-batch.py |  2 +-
>  tests/migration/guestperf-plot.py  |  2 +-
>  tests/migration/guestperf.py       |  2 +-
>  16 files changed, 33 insertions(+), 38 deletions(-)

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


