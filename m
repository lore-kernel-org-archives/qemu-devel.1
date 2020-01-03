Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEC1C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD862053B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fik6lQea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD862053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inK6D-000466-Sc
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 05:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inK5O-0003bR-AS
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:21:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inK5L-0005os-Nl
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:21:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60317
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inK5L-0005gx-6d
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578046897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9RYSR/sn6+d2eH5ftwfeq3X9jGWnkhZKbL5UfeNNRA=;
 b=fik6lQea8htHWcmy4TcO6H27z5uL+02xZDxVYBWM/hU6TqhkDnxCmSTCUHIWVmhNqNJihj
 rlIpMdttbT+F7wTQA5zd6+0FQ8JclOx8Sc+SkzuarefD1KAMpJayYIpnAtYA0iksgs7b9D
 ckTPVzR7Kv4LfYkqf5Nh6waKRVBybqE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-0aRSGO6GPHipRJyJlHQmxQ-1; Fri, 03 Jan 2020 05:21:35 -0500
Received: by mail-wm1-f72.google.com with SMTP id f25so1269922wmb.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 02:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ucYFAtUt2tty/jSrqFoeg0oVHaTa3wl53B4MyKD14sU=;
 b=VTGck2g+FCMBHJyBJh+ikoh9zkZFXmmVWuWn2xbcx34IQqrGuM4airIT9FEExqrI0l
 wLmyNd/U1IQ0HxUmKnND1IOR+EJpy8XjeWOUKl27zY3BAMUrNs12Os6ghm9KScYTa5xg
 VYbwaK6kPlCQPVUBSxt8U5glpXn1ZjjDiDIW5V7tvBTuxEr6R1E093gYpvTWyPBaS0aw
 9N5w+UU1LrEAojGHVPdJymLKftLJ7fV2TbNhSu00Vl4HivfzqVeZ7yjfw/2ZZyAJjQhm
 wThwXiVoFQ9d+ZybVbTMh5r0S2SKPte4UP0gYiHOfU5hxvc2V1qth2FH2W6Ex/WJvjmf
 OyTA==
X-Gm-Message-State: APjAAAWXJDwQFwNIrc0rb8yIcXmzJfQhZ2rNaeKD7bwDlfTgS7VxOhNK
 f0P30mm3o6+PAPh/JzxxCBCBbqKXbYTnnjkTh9lJXqkid/a9Vp4X5utGBlWUbbHd2uo9ekLcLcu
 v8NSD2BD3oCZ7zO0=
X-Received: by 2002:adf:ce87:: with SMTP id r7mr84148538wrn.245.1578046894415; 
 Fri, 03 Jan 2020 02:21:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9xw5FgFhgIszRKsYJ2ledwmo+8RCh/QkE5iSUTRC/FvZY3f5uviG2FWRFO9KQuFStXgWDyg==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr84148498wrn.245.1578046894118; 
 Fri, 03 Jan 2020 02:21:34 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id p17sm11690892wmk.30.2020.01.03.02.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 02:21:33 -0800 (PST)
Subject: Re: [PATCH v2 1/3] misc: use QEMU_IS_ALIGNED
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-2-marcandre.lureau@redhat.com>
 <2668c259-8ee9-06eb-9d7e-c09ca12aace4@redhat.com>
 <CAMxuvaw8m4gM5PUTYQR6NhbdL5xiBS+Tnqo=vhWJTycmQBSV2w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d85779f5-4888-c736-a948-b3bb8a1f21b9@redhat.com>
Date: Fri, 3 Jan 2020 11:21:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMxuvaw8m4gM5PUTYQR6NhbdL5xiBS+Tnqo=vhWJTycmQBSV2w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 0aRSGO6GPHipRJyJlHQmxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 8:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> On Fri, Jan 3, 2020 at 11:43 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 1/3/20 8:39 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    exec.c    | 4 ++--
>>>    roms/SLOF | 2 +-
>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/exec.c b/exec.c
>>> index d4b769d0d4..1feda49ca1 100644
>>> --- a/exec.c
>>> +++ b/exec.c
>>> @@ -3895,7 +3895,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_=
t start, size_t length)
>>>
>>>        uint8_t *host_startaddr =3D rb->host + start;
>>>
>>> -    if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
>>> +    if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_size)) {
>>>            error_report("ram_block_discard_range: Unaligned start addre=
ss: %p",
>>>                         host_startaddr);
>>>            goto err;
>>> @@ -3903,7 +3903,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_=
t start, size_t length)
>>>
>>>        if ((start + length) <=3D rb->used_length) {
>>>            bool need_madvise, need_fallocate;
>>> -        if (length & (rb->page_size - 1)) {
>>> +        if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
>>>                error_report("ram_block_discard_range: Unaligned length:=
 %zx",
>>>                             length);
>>>                goto err;
>>> diff --git a/roms/SLOF b/roms/SLOF
>>> index 9546892a80..8ebf2f55e1 160000
>>> --- a/roms/SLOF
>>> +++ b/roms/SLOF
>>> @@ -1 +1 @@
>>> -Subproject commit 9546892a80d5a4c73deea6719de46372f007f4a6
>>> +Subproject commit 8ebf2f55e1ba1492b942ba4b682160e644fc0f98
>>
>> Without the SLOF submodule update:
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> oops, I think I should submit a git config proposal, for git commit -a
> to exclude submodules, or warn loudly...
>=20
> Or perhaps I should stop using -a.

Once someone told me "never use 'git add -a' it is dangerous", but as I=20
was learning git the same person told me "never use git-rebase it is=20
dangerous" so I dunno :)

I have so many unstagged files in my repo that I can not use '-a'.
When doing mechanical changes, I dumbly use 'yes | git add -p'.
This worked fine so far...


