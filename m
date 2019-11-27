Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD8C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8330215F2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmuIvQID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8330215F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia5wK-0003fp-SB
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 17:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ia5uW-0002Zo-R9
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ia5uQ-00053N-Uu
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:35:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21019
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ia5uN-0004yk-5B
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574894136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcw8nfM1ZEt43RN7zAPTvWbJgAZi0GvJrv7ta04I5Hg=;
 b=PmuIvQIDjRHkXsf3f834BL4FxZFKhDF/IkyZNwfPNVUazGrnNhgz3bVfDBh/v3uKghBDmX
 hOhzxpGODK9nOyWhqyu2pFDT5JIVQAgHGPcYDdjthjThP3TfW35xoWERZpbNEj26RMoFnm
 88hQmuoiwb+JZtjmMEvJTDhdfTxXg5E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-BoK1PWqyOTCqzF1ExbA9cA-1; Wed, 27 Nov 2019 17:35:33 -0500
Received: by mail-wr1-f69.google.com with SMTP id u14so12814121wrq.19
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 14:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LRqhTGvE3ajg0ZBW1Fv2tk4IOl1PLc6FYv9VcOjVs1c=;
 b=HK/R4Eoqc+3bruBXAMLACcY4e6N+5Mi4Ozfwaj9HOyc7m6rDdObswHl1Sa6rJL3yu2
 h6L9QQDNt2ebFFKTt8pNwCdr4z2Qbo+2IZCcaHkq7c138jRakKTpbyON3Cp0nsB2wb7C
 2Km8qhkrIlmFJI4cOp15DHO8LJUbBUJgd+JbjPBxkOrvuR88JxI2itX4dUoMqOzIuaN+
 K66h4UOgKUxQMmNizmTfDo9CaWUQtsOe0qsqjo3TBUmjepIY52JVSjnqUlBs7rwwgiXh
 kAEEw+nTspu822DMnAvT47iSJX5DZnn7sFvU1Mv6HmlGXB+2iiCR+SeEAfSOFaAY0Byu
 kvmg==
X-Gm-Message-State: APjAAAVJOlVnHeAxjnTdG5vxUC35xkaQkq4JB7sbq9CFphbrnHJwIkLw
 iGB3l2j0aCi4hAgP4xiXhDVD1kSzU29mRkr5j4B8Bob7fr7brfwcXlmye7mgH8+8qpffu6Hb1pg
 p9JeRD615+RTabvY=
X-Received: by 2002:a05:600c:28c:: with SMTP id
 12mr6396399wmk.25.1574894132531; 
 Wed, 27 Nov 2019 14:35:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzlUcE5NC2JQBkDdVxh31AW7i0eUz6ODimhHkthQ3WWImVar3SCXImQj2gnOqK8VO0TltbAIg==
X-Received: by 2002:a05:600c:28c:: with SMTP id
 12mr6396379wmk.25.1574894132332; 
 Wed, 27 Nov 2019 14:35:32 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id r6sm7112174wrq.92.2019.11.27.14.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 14:35:31 -0800 (PST)
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=gJxBRvkiPzdAKOqVLEc7mmLpJRrprv5Rjcd8p2jD+_Hg@mail.gmail.com>
 <8fa0f275-797a-6a3c-4fac-43f4f7a8b975@redhat.com>
 <CAL1e-=i8vTPSPPCWBZfwd4c7cVD7cQPZSeJX7w7iWitAMYJuog@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <74083e72-ac20-d8c5-bd03-546f79b9227c@redhat.com>
Date: Wed, 27 Nov 2019 23:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i8vTPSPPCWBZfwd4c7cVD7cQPZSeJX7w7iWitAMYJuog@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: BoK1PWqyOTCqzF1ExbA9cA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 10:31 PM, Aleksandar Markovic wrote:
> On Wed, Nov 27, 2019 at 10:17 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Hi Aleksandar,
>>
>> On 11/27/19 7:47 PM, Aleksandar Markovic wrote:
>>> On Mon, Nov 25, 2019 at 11:41 AM Philippe Mathieu-Daud=C3=A9
>>> <philmd@redhat.com> wrote:
>>>>
>>>> The r4k machine was introduced in 2005 (6af0bf9c7) and its last
>>>> logical change was in 2005 (9542611a6). After we can count 164
>>>> maintenance commits (QEMU API changes) with the exception of
>>>> 1 fix in 2015 (memory leak, commit 3ad9fd5a).
>>>>
>>>> This machine was introduced as a proof of concept to run a MIPS
>>>> CPU. 2 years later, the Malta machine was add (commit 5856de80)
>>>> modeling a real platform.
>>>>
>>
>> Since you queued this patch, do you mind adding Aurelien comment to the
>> patch description, as it appears important information:
>>
>> '''
>> The Linux kernel support for this machine has been dropped more
>> than 10 years ago in this commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D302922e5f6901eb6f29c58539631f71b3d9746b8
>> '''
>>
>> I was not sure when sending the patch, but as an improvement, we can
>> also remove Aurelien and Aleksandar Rikalo from the MAINTAINERS section.
>>
>> And I assume we can also add (which was explicit in your previous patch)=
:
>> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
>>
>> If you want I can resend this patch with all that amended.
>>
>=20
> No need to resend, I'll fix the things while applying.

Thank you very much, very appreciated!


