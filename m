Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA731C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854CC2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4H11u68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854CC2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH4sA-00006b-O7
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jH4rS-0007po-Qv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jH4rR-0005Ic-Kc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:10:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26373)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jH4rR-0005I6-Gc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585138217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAFT12LcBV/9KYAz9C3tZQI412uZoIA0KBN9ngpMVbY=;
 b=B4H11u68aS3nErn0Eay6hUKQ0i/o6PjgLFGUVunEB8CAKbZxRtRGiQuUuLF32CGuVM9QFL
 6v09yaXO7kFnIeH5vJDIHiYTeGTkvcHsqU6ZKgNBfQF/tDDwEnhquFMWePXd30sxjMGCwx
 ttSbJnDAoavBdDAt6lSPaN/FY3mc6WQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-_MM7suqhOYu1c-LEhNeITw-1; Wed, 25 Mar 2020 08:10:15 -0400
X-MC-Unique: _MM7suqhOYu1c-LEhNeITw-1
Received: by mail-ed1-f71.google.com with SMTP id k7so1975632edn.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 05:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rH/mouCnbQNZBBtTZ5Nqgt7CSjQsIdjQv20f5KQCrrg=;
 b=qzLRYbTkulYRQaE08ZVqNAUH+frk+CLN2e6ZwjZMEt3D/7a3REWbGVmtsISs7iVg91
 SFv20R1fIfauxDGRdDnk6vgzPQAG/7da++Csu9lnhzPDax7xnJZwaOLLJWQ6d8clYFl6
 F8EuDE7D1MjrtCP49lQQldu79GeaYjkjusSPbT4+cE5kQbXd+Y0opkgsf1yl/I/VSwtq
 xtMKu6KF9FZbEQY7zdq6aMG39rZj8EQUV1lHhmi+uph/YFi58viFv8rYRPWe28OH7OHZ
 TIRKJ7aXy9x4mPsBe4WIs+1qfk5yHizqdRQ06IyBsom5OAoZDn6WPxjKq6DpndbxlBzE
 fOig==
X-Gm-Message-State: ANhLgQ3Dd9uC9XV3FSITrXv5PTJ0aLww563n+5M7ghodijRgysmimE+F
 BkzK1eupaK5jiIB3bvchWRbVVYuBDmbHjiTPUEbOFVnQHNq/6g6GLgJdM0fPAeDIoGIsGOYN0SX
 b6KvqVde9xsUKHPc=
X-Received: by 2002:a17:906:4c2:: with SMTP id
 g2mr2766713eja.295.1585138214057; 
 Wed, 25 Mar 2020 05:10:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsM7UHzaPCUBBjgVhtnWYsfKwP6lRATsMQiJK0NWVbkySOXrNZw+N9VrbEKOpZXioPUJFcF6Q==
X-Received: by 2002:a17:906:4c2:: with SMTP id
 g2mr2766684eja.295.1585138213707; 
 Wed, 25 Mar 2020 05:10:13 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id oq12sm624456ejb.85.2020.03.25.05.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 05:10:12 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] qga-posix: Avoid crashing process when failing to
 allocate memory
To: Dietmar Maurer <dietmar@proxmox.com>, qemu-devel@nongnu.org
References: <20200324194836.21539-1-philmd@redhat.com>
 <1242083041.1.1585117162620@webmail.proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6be54d1f-e5fc-5b34-ba4d-fa050029f26b@redhat.com>
Date: Wed, 25 Mar 2020 13:10:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1242083041.1.1585117162620@webmail.proxmox.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-trivial@nongnu.org, Sameeh Jubran <sjubran@redhat.com>,
 qemu-stable@nongnu.org, Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 7:19 AM, Dietmar Maurer wrote:
> but error_setg() also calls malloc, so this does not help at all?

IIUC the problem, you can send a QMP command to ask to read let's say=20
3GB of a file, and QEMU crashes. But this doesn't mean there the .heap=20
is empty, there is probably few bytes still available, enough to respond=20
with an error message.

>=20
>> On March 24, 2020 8:48 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>>
>>  =20
>> Similarly to commit 807e2b6fce0 for Windows, kindly return a
>> QMP error message instead of crashing the whole process.
>>
>> Cc: qemu-stable@nongnu.org
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
>> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   qga/commands-posix.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 93474ff770..8f127788e6 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -493,7 +493,13 @@ struct GuestFileRead *qmp_guest_file_read(int64_t h=
andle, bool has_count,
>>           gfh->state =3D RW_STATE_NEW;
>>       }
>>  =20
>> -    buf =3D g_malloc0(count+1);
>> +    buf =3D g_try_malloc0(count + 1);
>> +    if (!buf) {
>> +        error_setg(errp,
>> +                   "failed to allocate sufficient memory "
>> +                   "to complete the requested service");
>> +        return NULL;
>> +    }
>>       read_count =3D fread(buf, 1, count, fh);
>>       if (ferror(fh)) {
>>           error_setg_errno(errp, errno, "failed to read file");
>> --=20
>> 2.21.1
>=20


