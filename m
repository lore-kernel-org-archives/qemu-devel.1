Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F777C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0994E2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bh+xGmNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0994E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwwP-0000b0-3U
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jIwuW-00067L-AC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jIwuU-0008N4-Dp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:05:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jIwuU-0008Ll-AI
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585584308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xb+aPsiv2uaWbWXaN12OZGlbPQ4K+SmUQv6l5jUfU90=;
 b=bh+xGmNC0s8eSZgMY51BqBjxWchgc6pJfVjRKuiUwgeAKg7pRUpdqYmMqlJ8PHUUw4RHDg
 mbucYfkP/BEFEjQn0DNRIeT5AwMFtnqatCVzzK0R+9T22s7fEPSrUKeAzxherpQY5lWCW1
 HscgiH01dcelL3gqTVBAa6vfLo6nxX4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-UT4L_97vM1KmT72flKySGg-1; Mon, 30 Mar 2020 12:04:53 -0400
X-MC-Unique: UT4L_97vM1KmT72flKySGg-1
Received: by mail-wr1-f72.google.com with SMTP id j12so11484696wrr.18
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 09:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eL3QibjcvLjwB2MqyrJIvS7OIKsHSFRia/T4h9f/mGM=;
 b=IfYFg8ahsv9rKbbXGFOiM53C0M5JDx9q1XnbqV7GeMDbBZXE7Qc26SXz8AXL/j0kam
 mzPk89V3vMRX+4D2B1bmbQmmmY6kBYY2rf3wrh0A4B4/LfiCfcExZo3HLT6KcpPb30E3
 YzIxJ9awXl8hBWT1lO3gi+G6rNA+buQ1JFZNObswihxhGwV5E8GXskofieCIETkeh74k
 1GX3KKraci0vpq6dcrvzh9n+CIWSxCIZOh14qBVomIxiGZ/QmLmK2YtUE70xN+xKioXS
 2WUSsZtuK8aTDwmjh68YKB44ylFw4FBHwWt7fu5AaXB8/zZTX+4eqcEMZl87FK7YJudQ
 oOIA==
X-Gm-Message-State: ANhLgQ1Qwf4NNshOOAP+Eyfo8VLlU2rhr/GUfSCTWjvm1GrubePRFts9
 jfvS8a+fgTpsIO98llvctaEpjkQChxFvDgwHBSydnDj94dCGbMOhjRx8TKwYZZAfO8q5G+kjUmE
 R+vIBWpCXUJIWNu8=
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr14798027wrw.243.1585584292189; 
 Mon, 30 Mar 2020 09:04:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuC3wS/vwwMxbzG5VcGI9s6qkxVIyadz2J/+fNSAOaU1mTdjsdsn68BQJ5QZBn5zuQRPcFPFQ==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr14798007wrw.243.1585584291877; 
 Mon, 30 Mar 2020 09:04:51 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b82sm21589523wmb.46.2020.03.30.09.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 09:04:51 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] qga-posix: Avoid crashing process when failing to
 allocate memory
To: Markus Armbruster <armbru@redhat.com>
References: <20200324194836.21539-1-philmd@redhat.com>
 <1242083041.1.1585117162620@webmail.proxmox.com>
 <6be54d1f-e5fc-5b34-ba4d-fa050029f26b@redhat.com>
 <87mu7yue35.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81317f7f-7de9-f616-27dc-c389f06792c3@redhat.com>
Date: Mon, 30 Mar 2020 18:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87mu7yue35.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

Cc'ing the ppl who responded the thread you quoted.

On 3/30/20 4:11 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
 > ---
 >   qga/commands-posix.c | 8 +++++++-
 >   1 file changed, 7 insertions(+), 1 deletion(-)
 >
 > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
 > index 93474ff770..8f127788e6 100644
 > --- a/qga/commands-posix.c
 > +++ b/qga/commands-posix.c
 > @@ -493,7 +493,13 @@ struct GuestFileRead=20
*qmp_guest_file_read(int64_t handle, bool has_count,
 >           gfh->state =3D RW_STATE_NEW;
 >       }
 >
 > -    buf =3D g_malloc0(count+1);
 > +    buf =3D g_try_malloc0(count + 1);
 > +    if (!buf) {
 > +        error_setg(errp,
 > +                   "failed to allocate sufficient memory "
 > +                   "to complete the requested service");
 > +        return NULL;
 > +    }
 >       read_count =3D fread(buf, 1, count, fh);
 >       if (ferror(fh)) {
 >           error_setg_errno(errp, errno, "failed to read file");
 >

>> On 3/25/20 7:19 AM, Dietmar Maurer wrote:
>>> but error_setg() also calls malloc, so this does not help at all?
>>
>> IIUC the problem, you can send a QMP command to ask to read let's say
>> 3GB of a file, and QEMU crashes. But this doesn't mean there the .heap
>> is empty, there is probably few bytes still available, enough to
>> respond with an error message.
>=20
> We've discussed how to handle out-of-memory conditions many times.
> Here's one instance:
>=20
>      Subject: When it's okay to treat OOM as fatal?
>      Message-ID: <87efcqniza.fsf@dusky.pond.sub.org>
>      https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03212.ht=
ml
>=20
> No improvement since then; there's no guidance on when to check for OOM.
> Actual code tends to check only "large" allocations (for subjective
> values of "large").
>=20
> I reiterate my opinion that whatever OOM handling we have is too
> unreliable to be worth much, since it can only help when (1) allocations
> actually fail (they generally don't[*]), and (2) the allocation that
> fails is actually handled (they generally aren't), and (3) the handling
> actually works (we don't test OOM, so it generally doesn't).
>=20
>=20
> [*] Linux overcommits memory, which means malloc() pretty much always
> succeeds, but when you try to use "too much" of the memory you
> supposedly allocated, a lethal signal is coming your way.  Reasd the
> thread I quoted for examples.

So this patch takes Stefan reasoning:
https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03525.html

   My thinking has been to use g_new() for small QEMU-internal structures
   and g_try_new() for large amounts of memory allocated in response to
   untrusted inputs.  (Untrusted inputs must never be used for unbounded
   allocation sizes but those bounded sizes can still be large.)

In any cases (malloc/malloc_try) we have a denial of service=20
(https://www.openwall.com/lists/oss-security/2018/10/17/4) and the=20
service is restarted.

Daniel suggests such behavior should be catched by external firewall=20
guard (either on the process or on the network). This seems out of scope=20
of QEMU and hard to fix.

So, can we improve something? Or should we let this code as it?


