Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B918C2D0EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA97D2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jv84lc2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA97D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwzD-0006FA-0s
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jIwxs-0004Tp-G5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jIwxq-00032h-LH
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:08:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jIwxq-00032G-Gb
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585584518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhkhTcy4qzrCoHLcXT9dI7qqKtnV+QGOJ2gWOZbClPc=;
 b=Jv84lc2/7B71qeplrOIonhmLGhBIPfPQWB8dvMEXBJ4ygYBx4zFy8BS2q9LsVPh7fTLMkZ
 8tmW4W+FaJcXh6VhvTlkHKTK2g4kcDO+HcSBf/ZE9Qjftn0cbOCzFXMm51o5K7JZxP2ZTv
 /nDrPEfjibCifrGGJ3Vlzq2Hi4uDfAs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-dFijSgdPNgeqM3_91V7SHw-1; Mon, 30 Mar 2020 12:08:35 -0400
X-MC-Unique: dFijSgdPNgeqM3_91V7SHw-1
Received: by mail-wr1-f69.google.com with SMTP id i18so11467564wrx.17
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 09:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X+7TDFCHmUZvDZWPMbYpAkyP3dimyIWbo9ovfDsvyq4=;
 b=nSgQmBfyFX/GqWCtSbeb2tyO4vUuXvkL8fZOorysw3QTeI8hKV4pKjA0/rw2MTnxam
 Q62c4JEcbP1P2H9PZ6GqHsq/QyK7IQ0xjkPhBUCCXhqYaDME2kozRh+Fl8gAGYAvv+bZ
 RklmwYxqPnhg1yKGTT7R+zWnVulSt+n6HXHYzImvQvam7VifPu4vM82qsq6m7XzhX8Zr
 u0gTDxwu21+sJFKMVIfyuqqDqxELgBGDwje0W7XAfU0jruROmh/04etw16sOjwr9lcfI
 uCc//UFITY4KI4pRMRCpjkmq+CwyV9UlBdses/CbRwrtiKN4SMq2ssAcEyhzQXAb7hi5
 hl+w==
X-Gm-Message-State: ANhLgQ2cUA0yipUoG12J6bitw2rtvEnl1yxVfHqJDzdTdsIUqkbjnQyY
 05SfT9rQe8sY10oBYjHUUY9DcLk1xfOJ6nCTOA6taJw5kwVRUx6InexJcFrnAJ3/oLZdya60A4w
 sS+RiW5nA3MIvlRM=
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr14343wmb.81.1585584514072;
 Mon, 30 Mar 2020 09:08:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vssUTjWXiwssCiVu/QIn1gpEQS1B418myWSrfxJzvPVret0dxs4K7Rs6M5Tx/5q3KI6sOw6eQ==
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr14313wmb.81.1585584513813;
 Mon, 30 Mar 2020 09:08:33 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v7sm20406318wrs.96.2020.03.30.09.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 09:08:33 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] qga-posix: Avoid crashing process when failing to
 allocate memory
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20200324194836.21539-1-philmd@redhat.com>
 <1242083041.1.1585117162620@webmail.proxmox.com>
 <6be54d1f-e5fc-5b34-ba4d-fa050029f26b@redhat.com>
 <87mu7yue35.fsf@dusky.pond.sub.org>
 <81317f7f-7de9-f616-27dc-c389f06792c3@redhat.com>
Message-ID: <7f67ab75-5f7c-e0b8-2dd3-4e573a8d3f68@redhat.com>
Date: Mon, 30 Mar 2020 18:08:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <81317f7f-7de9-f616-27dc-c389f06792c3@redhat.com>
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org,
 qemu-stable@nongnu.org, Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 Dietmar Maurer <dietmar@proxmox.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 6:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Cc'ing the ppl who responded the thread you quoted.
>=20
> On 3/30/20 4:11 PM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>  > ---
>  >=C2=A0=C2=A0 qga/commands-posix.c | 8 +++++++-
>  >=C2=A0=C2=A0 1 file changed, 7 insertions(+), 1 deletion(-)
>  >
>  > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>  > index 93474ff770..8f127788e6 100644
>  > --- a/qga/commands-posix.c
>  > +++ b/qga/commands-posix.c
>  > @@ -493,7 +493,13 @@ struct GuestFileRead=20
> *qmp_guest_file_read(int64_t handle, bool has_count,
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfh->state=
 =3D RW_STATE_NEW;
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  >
>  > -=C2=A0=C2=A0=C2=A0 buf =3D g_malloc0(count+1);
>  > +=C2=A0=C2=A0=C2=A0 buf =3D g_try_malloc0(count + 1);
>  > +=C2=A0=C2=A0=C2=A0 if (!buf) {
>  > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
>  > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to allocate sufficient memo=
ry "
>  > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "to complete the requested service"=
);
>  > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>  > +=C2=A0=C2=A0=C2=A0 }
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_count =3D fread(buf, 1, count=
, fh);
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ferror(fh)) {
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg=
_errno(errp, errno, "failed to read file");
>  >
>=20
>>> On 3/25/20 7:19 AM, Dietmar Maurer wrote:
>>>> but error_setg() also calls malloc, so this does not help at all?
>>>
>>> IIUC the problem, you can send a QMP command to ask to read let's say
>>> 3GB of a file, and QEMU crashes. But this doesn't mean there the .heap
>>> is empty, there is probably few bytes still available, enough to
>>> respond with an error message.
>>
>> We've discussed how to handle out-of-memory conditions many times.
>> Here's one instance:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Subject: When it's okay to treat OOM as fatal?
>> =C2=A0=C2=A0=C2=A0=C2=A0 Message-ID: <87efcqniza.fsf@dusky.pond.sub.org>
>>     =20
>> https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03212.html
>>
>> No improvement since then; there's no guidance on when to check for OOM.
>> Actual code tends to check only "large" allocations (for subjective
>> values of "large").
>>
>> I reiterate my opinion that whatever OOM handling we have is too
>> unreliable to be worth much, since it can only help when (1) allocations
>> actually fail (they generally don't[*]), and (2) the allocation that
>> fails is actually handled (they generally aren't), and (3) the handling
>> actually works (we don't test OOM, so it generally doesn't).
>>
>>
>> [*] Linux overcommits memory, which means malloc() pretty much always
>> succeeds, but when you try to use "too much" of the memory you
>> supposedly allocated, a lethal signal is coming your way.=C2=A0 Reasd th=
e
>> thread I quoted for examples.
>=20
> So this patch takes Stefan reasoning:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03525.html
>=20
>  =C2=A0 My thinking has been to use g_new() for small QEMU-internal struc=
tures
>  =C2=A0 and g_try_new() for large amounts of memory allocated in response=
 to
>  =C2=A0 untrusted inputs.=C2=A0 (Untrusted inputs must never be used for =
unbounded
>  =C2=A0 allocation sizes but those bounded sizes can still be large.)
>=20
> In any cases (malloc/malloc_try) we have a denial of service=20
> (https://www.openwall.com/lists/oss-security/2018/10/17/4) and the=20
> service is restarted.
>=20
> Daniel suggests such behavior should be catched by external firewall=20
> guard (either on the process or on the network). This seems out of scope=
=20
> of QEMU and hard to fix.
>=20
> So, can we improve something? Or should we let this code as it?

But if we don't want to modify this code, we should document somewhere=20
that maintstream QEMU doesn't care about DoS and it is the=20
responsibility to protect it with something else...


