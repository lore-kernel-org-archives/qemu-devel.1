Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD98C4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26928206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvEifdUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26928206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sJi-0007CR-C4
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6sIv-0006dy-Me
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6sIu-0001gk-Kr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:44:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6sIu-0001fr-HS
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582706668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vQNp8eqUbd3oSwY1ezPXCX9BKBX5nJ3UlO7fF0GtCM=;
 b=CvEifdUEHOdIuUaCZyBQu6Mm84c4tAQIzMw4VPC0crF+pKIhF4/5DUmFjlq9TznCOzGfWG
 l2naFC5wD4Nr/bE/o8cnIL3vb+LPUY7wmIG3YuBR3+rs7Lp9pgY9K7CBFUDWX6qS8TaZHx
 iI4r6KGnZJvTzP6AVCOEukliBFi87vg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Regw7dBSPaq9xiPDkmuXcA-1; Wed, 26 Feb 2020 03:44:22 -0500
X-MC-Unique: Regw7dBSPaq9xiPDkmuXcA-1
Received: by mail-wr1-f70.google.com with SMTP id o9so1156645wrw.14
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 00:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9vQNp8eqUbd3oSwY1ezPXCX9BKBX5nJ3UlO7fF0GtCM=;
 b=g1dHLrVioCVNcOjSNtdsHtWAYkFJnB95oHLPc6XO5GB+muEQWW7DX+UTCqkQC0ERaM
 NzszUbrC1PUd8CtAThMk6UT6gGr0xQfj50B1Aw5Sqh82z6W3eJ2oq/4ZNEFeZFpwNzrK
 6eIrcmxPbTYDlPfA/lGACSTXhXg5SpypjDuOmBZPRc39UrnGGAWhZlZNEvbnNJw/IZEI
 7k2EjBxz6zzLxxyrVXGAQt1rfGf8yml7oVqAd2EY2OEyFpXB0CuSLrZzjn9AAQ6F+8pB
 kCqnsreTfJlUlYirHS9XnzGn0ELIQeuVLPOf5+kiDXvthe2r9ogcn/PP8fv5WvM2qrYK
 T57A==
X-Gm-Message-State: APjAAAVmkeRifKvu8fUNtiTriLyE4CdNrwoFtX0ksTwK3muyudD+8xuL
 TS309ma01yFKuu7WdJAZ/DNbn95RRSdRx/EmI9HJqLJT6TxHnhpD+WSngKV0Ht9by1+GqUwy2/Q
 OkUFhTGjKY/mFg5o=
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr4353103wmf.105.1582706661593; 
 Wed, 26 Feb 2020 00:44:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiuZrDzYmOcsoA49D2wtmzQ6uzQ+p9JOgT/ZrxW1V5GkhRMcibFNrYNpk7NOBZMW1xIHEVwg==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr4353082wmf.105.1582706661322; 
 Wed, 26 Feb 2020 00:44:21 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id h13sm2058742wml.45.2020.02.26.00.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 00:44:20 -0800 (PST)
Subject: Re: Sudden slowdown of ARM emulation in master
To: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
 <CAFEAcA_azGqyzbxegpK8ch_bums6Wtd=U7cNxvM=bAJ-Ld2DDA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ffa87cab-e85c-c381-289a-fdf1ef07b45a@redhat.com>
Date: Wed, 26 Feb 2020 09:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_azGqyzbxegpK8ch_bums6Wtd=U7cNxvM=bAJ-Ld2DDA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 9:41 AM, Peter Maydell wrote:
> On Tue, 25 Feb 2020 at 23:08, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
> 
>> Just now I was working on some small fixes for the cubieboard machine and rebasing my Allwinner H3 branches.
>> While doing some testing, I noticed that suddenly the machines were much slower than before.
>> I only see this happening when I rebase to this commit:
>>     ca6155c0f2bd39b4b4162533be401c98bd960820 ("Merge tag 'patchew/20200219160953.13771-1-imammedo@redhat.com' of https://github.com/patchew-project/qemu into HEAD")
> 
> Yeah, I noticed a slowdown yesterday as well, but haven't tracked it down
> as yet. The first thing would be to do a git bisect to try to narrow
> down what commit caused it.

My guess: biggest chunk of memory is the DRAM, registered as "fast RAM" 
by QEMU, but the SoCs provide SRAM which is supposed to be faster. Not 
anymore with QEMU. And Linux try to use the SRAM when possible.


