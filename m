Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C84C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA0D2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a99tlB/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA0D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZj4t-00040L-Lo
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iZj3U-000303-Da
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iZj3T-0003eN-2j
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:11:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iZj3S-0003ao-VD
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574806288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=011651snvfsBps6SDdRWvgoe4+4YX6VQtzLkCZvkwT8=;
 b=a99tlB/RT/4M2Up9pK/bFHt1uU3VcFt16oY+42b6n2GIzHqNbMFqT7o8rIN2lvH0YDYZwu
 5eawIi75VI1kmFNdBRmzvKyOZN/A2uE9y4MX0VaRmNpSVVfGLHv9VV6junm9MAkfqO2+kW
 VwUYN1rSczUwttGwGBRMNPzrGG7/7+4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-OUrvaRn9ON2Q3yB247fYUw-1; Tue, 26 Nov 2019 17:11:23 -0500
Received: by mail-wm1-f70.google.com with SMTP id n18so1194394wmi.8
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 14:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=011651snvfsBps6SDdRWvgoe4+4YX6VQtzLkCZvkwT8=;
 b=hvsBRCdkjGyygXyt8VCtasPyZqKS1nP+R6gU++YPZoLqbaMn6hGsr93pXIvFf9oz7b
 2jbLertMjywacVe+WieAMyR85Ez9oAKBzNyxeeaL5jCgWRjOsHBXSYqSYmwn7zH6aZ3o
 D4qLDeZZc24gkkjx+YhyE4l3o0WzeXexcJQOZcrSqRd+z8dgcpIefVEbyI/3gjaS5/gV
 BuXmJOVbMrrm1tWngTb4iTV0c/b2Xiy0t71S0WDufsa4StS3JmlZnKqPjroR3/0LU+44
 0KgDWc2GY+GHZPj5+G7Zy8mVu+pYgZNLnPdbQtueWj5P3ejHe5POzdB/Rc71hZFsIz02
 BJaA==
X-Gm-Message-State: APjAAAWJvPg15juA0reCwfN8FAd7LxH3zFRVI1Zc7k+AqTVyYyGnlF12
 5mp+JYr5apdWMH0rH4RNMYZveDZKyfIfimrf6dc4iOx1SZRZtFVVh+ubQEqy/Ct+QUqbaV7Y9YW
 kQQeL3srGNUVJOd5Mjrw9410dVuSqiuc=
X-Received: by 2002:a05:6000:1602:: with SMTP id
 u2mr41651526wrb.249.1574806282797; 
 Tue, 26 Nov 2019 14:11:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyv0bAGewiaseq6hOorZNzvVqWpVqBjElubgxqF/WqKRTrHU6jyQVf3UBcZgjBIEzZUiB3hEHNFsbp6VNm4AkU=
X-Received: by 2002:a05:6000:1602:: with SMTP id
 u2mr41651505wrb.249.1574806282585; 
 Tue, 26 Nov 2019 14:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=h69CVmS6Rpm_CNet836BLSxTPQsXmP1Ur4tVL-0uryOw@mail.gmail.com>
 <744f91e0-858b-3752-942d-f3d552691fd5@redhat.com>
 <CAL1e-=gNRfu0kSBdZuw4kAjBYZ3rr9fnins_T6XPb_Hg11KE-g@mail.gmail.com>
In-Reply-To: <CAL1e-=gNRfu0kSBdZuw4kAjBYZ3rr9fnins_T6XPb_Hg11KE-g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 26 Nov 2019 23:11:11 +0100
Message-ID: <CAP+75-UY++CJEj9r87dfPsJY1S_yJd9Ovy6DxfVY6wezYkojsw@mail.gmail.com>
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
X-MC-Unique: OUrvaRn9ON2Q3yB247fYUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Thomas Huth <thuth@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 11:03 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> On Tuesday, November 26, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>
>> Hi Aleksandar,
>>
>> On 11/26/19 9:46 PM, Aleksandar Markovic wrote:
>>>
>>> On Mon, Nov 25, 2019 at 11:41 AM Philippe Mathieu-Daud=C3=A9
>>> <philmd@redhat.com> wrote:
>>>>
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
>>>> Note also this machine has no specification except 5 lines in
>>>> the header of this file:
>>>>
>>>>   * emulates a simple machine with ISA-like bus.
>>>>   * ISA IO space mapped to the 0x14000000 (PHYS) and
>>>>   * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
>>>>   * All peripherial devices are attached to this "bus" with
>>>>   * the standard PC ISA addresses.
>>>>
>>>> It is time to deprecate this obsolete machine. Users are
>>>> recommended to use the Malta board, which hardware is well
>>>> documented.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>
>>>
>>> Philippe,
>>>
>>> I see you added "libvir-list" in "cc". Was it a mistake, or there was
>>> some purpose?
>>
>>
>> I don't pick the series recipient manually, I send my series with git-pu=
blish. Here it used the default QEMU profile.
>>
>> All profiles call git-sendmail with the cc-cmd set to the get_maintainer=
.pl script:
>>
>> $ cat .gitpublish
>> #
>> # Common git-publish profiles that can be used to send patches to QEMU u=
pstream.
>> #
>> # See https://github.com/stefanha/git-publish for more information
>> #
>> [gitpublishprofile "default"]
>> base =3D master
>> to =3D qemu-devel@nongnu.org
>> cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
>>
>> Having a closer look, libvir-list list was Cc'ed because it is listed as=
 reviewer of the qemu-deprecated.texi file, which was modified.
>>
>> ./scripts/get_maintainer.pl -f qemu-deprecated.texi
>> libvir-list@redhat.com (reviewer:Incompatible changes)
>> qemu-devel@nongnu.org (open list:All patches CC here)
>>
>
> OK. No problem. It just looked strange.
>
> As far as consuktations, I am just waiting for some responses within comp=
any to establish if somebody is perhaps using this machine with some ancien=
t kernel. I got some opinions that are in favor of R4000 machine deprecatin=
g, but I need to wait for all relevant departments to confirm.
>
> What happened to TileGX?

Peter Maydell suggested to postpone deprecations for after 4.2, since
we are already at rc3 (and deprecating a target involves modifying the
./configure script).

[...]


