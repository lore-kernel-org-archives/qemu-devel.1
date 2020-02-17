Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED83C761A1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790792070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVj48yWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790792070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cqM-0007q7-L1
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3cpL-0006WW-QA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3cpK-0006DK-NQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:36:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38611
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3cpK-0006CD-JA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581932189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZi/DjLez6TDm2dgSixwb0Zd5B0VmtevtckyJ3+zbdI=;
 b=BVj48yWgLYHO0WJ32upTyyxYAXu85/mxlGmQEQT9bEHazUQXPlqBLgBiC665qvfGfH6/N6
 8ifTBn0zHqew+CBpeuXIAuvkKt3JFdh6Cob/k3Y92x2Z0oGr+qKYQzjHVWwgLUY4WZWkpu
 3mrXkSikp/PRXze3DOCB+g2C2cpQR48=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-TR3j9C8gM_GDY5UNzPIuRA-1; Mon, 17 Feb 2020 04:36:24 -0500
Received: by mail-wr1-f72.google.com with SMTP id w17so8681439wrr.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EekdzBwfRxuigwFrRujNicpzo0HFAmDDj8UAkV660GA=;
 b=ZHvtfAxkYIkuxcbptc1E0dcq/a+vKvd0SfO95GCS2TwhKLYtL+7fS10BiTKJjiB0sy
 8Qs0GCjrv+etosy3QBGJLK8OBjz43jcMtQXrjm0q96BFyma0JYFKjg34gw0VAvh+FWnA
 VkwMbjfuH+tqkYJOyS/+GuAdjXHenzVw4vF56SiHSZUda0rsZXJCwldWFGkLqMQ7HZk3
 B4Kz89nxtB3/6/AI7sq3ELbsY3pm5tp9gPoeY0WnoFcofzDrA486kdZMxxuQ8aeEnnLI
 G26UL86ws0slmncxXBBiTrB52pz2D0WOfB7ZcHGhuxDMThV0wgx/mKvwl/zUFMb5fnFM
 vWkg==
X-Gm-Message-State: APjAAAVgBKUjBeo5A14o2GAVginnUkEyKaTLYu97w6aKruetoSq7LUYh
 g6XED30NEoimMEIvd5HcwwBv/okrRv99Qt6ZbNzT3UEAAvk1p5OpfsLE93/SGBUSHSItzJHp9Pu
 HXM9h0U+X3GHxyFE=
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr22227000wru.220.1581932183156; 
 Mon, 17 Feb 2020 01:36:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWGAgL9zQOxKUqplWz5mtJRfh75V71wgCeBiXBf6Kib5G3XT0pwNeH76bFFz8pyvMGwt88cA==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr22226966wru.220.1581932182907; 
 Mon, 17 Feb 2020 01:36:22 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h2sm112154wrt.45.2020.02.17.01.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 01:36:21 -0800 (PST)
Subject: Re: [PATCH 2/3] tools/virtiofsd/passthrough_ll: Remove unneeded
 variable assignment
To: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
References: <20200215160716.1262-1-philmd@redhat.com>
 <20200215160716.1262-3-philmd@redhat.com> <20200216212349.GC745061@lpt>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0bc872e5-8dbc-1d8b-d599-83bc85f730c1@redhat.com>
Date: Mon, 17 Feb 2020 10:36:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200216212349.GC745061@lpt>
Content-Language: en-US
X-MC-Unique: TR3j9C8gM_GDY5UNzPIuRA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/16/20 10:23 PM, J=E1n Tomko wrote:
> On Sat, Feb 15, 2020 at 05:07:15PM +0100, Philippe Mathieu-Daud=E9 wrote:
>> Fix warning reported by Clang static code analyzer:
>>
>> =A0=A0 CC=A0=A0=A0=A0=A0 tools/virtiofsd/passthrough_ll.o
>> =A0tools/virtiofsd/passthrough_ll.c:925:9: warning: Value stored to=20
>> 'newfd' is never read
>> =A0=A0=A0=A0=A0=A0=A0=A0 newfd =3D -1;
>> =A0=A0=A0=A0=A0=A0=A0=A0 ^=A0=A0=A0=A0=A0=A0 ~~
>> =A0tools/virtiofsd/passthrough_ll.c:942:9: warning: Value stored to=20
>> 'newfd' is never read
>> =A0=A0=A0=A0=A0=A0=A0=A0 newfd =3D -1;
>> =A0=A0=A0=A0=A0=A0=A0=A0 ^=A0=A0=A0=A0=A0=A0 ~~
>>
>> Fixes: 7c6b66027
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> ---
>> tools/virtiofsd/passthrough_ll.c | 4 +---
>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tools/virtiofsd/passthrough_ll.c=20
>> b/tools/virtiofsd/passthrough_ll.c
>> index e9e71d5fc2..b38e0e4d84 100644
>> --- a/tools/virtiofsd/passthrough_ll.c
>> +++ b/tools/virtiofsd/passthrough_ll.c
>> @@ -922,7 +922,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t=
=20
>> parent, const char *name,
>> =A0=A0=A0 inode =3D lo_find(lo, &e->attr);
>> =A0=A0=A0 if (inode) {
>> =A0=A0=A0=A0=A0=A0=A0 close(newfd);
>> -=A0=A0=A0=A0=A0=A0=A0 newfd =3D -1;
>> =A0=A0=A0 } else {
>> =A0=A0=A0=A0=A0=A0=A0 inode =3D calloc(1, sizeof(struct lo_inode));
>> =A0=A0=A0=A0=A0=A0=A0 if (!inode) {
>> @@ -938,8 +937,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t=
=20
>> parent, const char *name,
>> =A0=A0=A0=A0=A0=A0=A0 g_atomic_int_set(&inode->refcount, 2);
>>
>> =A0=A0=A0=A0=A0=A0=A0 inode->nlookup =3D 1;
>> -=A0=A0=A0=A0=A0=A0=A0 inode->fd =3D newfd;
>> -=A0=A0=A0=A0=A0=A0=A0 newfd =3D -1;
>> +=A0=A0=A0=A0=A0=A0=A0 inode->fd =3D -1;
>=20
> The functional equivalent is:
>  =A0=A0=A0 inode->fd =3D newfd;
>=20
> newfd cannot contain -1 here, as checked a few lines above:
>  =A0=A0=A0=A0 newfd =3D openat(dir->fd, name, O_PATH | O_NOFOLLOW);
>  =A0=A0=A0=A0 if (newfd =3D=3D -1) {
>  =A0=A0=A0=A0=A0=A0=A0=A0 goto out_err;
>  =A0=A0=A0=A0 }

Correct. I'll respin, thanks for the review!

> Jano
>=20
>> =A0=A0=A0=A0=A0=A0=A0 inode->key.ino =3D e->attr.st_ino;
>> =A0=A0=A0=A0=A0=A0=A0 inode->key.dev =3D e->attr.st_dev;
>> =A0=A0=A0=A0=A0=A0=A0 pthread_mutex_init(&inode->plock_mutex, NULL);
>> --=20
>> 2.21.1
>>
>>


