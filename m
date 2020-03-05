Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA02DC3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C882073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHntM68B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C882073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46561 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nkW-0002yx-OR
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j9njo-0001q0-1n
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j9njm-0000Fo-VU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:28:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51262
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j9njm-0000FD-RH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583404098;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LY1n84qMZKG+VSL8Tik1BoPD7zkduViQx0aw6vxO5XQ=;
 b=IHntM68BuZdOlY5maRHW2drMusrseQFR0Xp6mdSjRVjiDdW6BFv4lsge2HELh4X6oiFilg
 o1+Ivxvt++d/VXtyxohJo+TvtIPLhHtRn0qxNgBCrVQx/cQ69+R6j6XvNi0YH9Y8a9/tRA
 WkZiNMPEBQ6uDXU6FJznLPVP02wNch8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-7eu024GcM4q33RS_AznFtA-1; Thu, 05 Mar 2020 05:28:16 -0500
X-MC-Unique: 7eu024GcM4q33RS_AznFtA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75692101FC60;
 Thu,  5 Mar 2020 10:28:15 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0407891D71;
 Thu,  5 Mar 2020 10:28:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 07/10] configure: fix check for libzstd
In-Reply-To: <87o8tb5d0v.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Thu, 05 Mar 2020 10:09:20 +0000")
References: <20200302181907.32110-1-alex.bennee@linaro.org>
 <20200302181907.32110-8-alex.bennee@linaro.org>
 <874kv68lg9.fsf@linaro.org> <87v9njf87n.fsf@secure.laptop>
 <87o8tb5d0v.fsf@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 05 Mar 2020 11:28:11 +0100
Message-ID: <87r1y7f64k.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>>

>>
>> Can you told me what architecture/distro/os are you using.
>
> It broke on the CI setup - it could be another issue with the ageing
> Travis images (Ubuntu 16.04).
>
>>> Dropping this patch as it breaks the build even more!
>>>
>>>   CC      migration/block.o
>>>
>>> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:24:5: error: u=
nknown type name =E2=80=98ZSTD_CStream=E2=80=99
>>>
>>>      ZSTD_CStream *zcs;
>>>
>>>      ^
>>
>> This is really weird.  if you arrive here, that means:
>> - you have zstd devel installed (whatever is that called for your
>>   os/distro/whatever).
>
> Well it detected it:
>
>   zstd support      yes
>
>>
>> - pkg-config has found zstd devel packages and configured them (that
>>   file depends on CONFiG_ZSTD beoing defined)
>>
>> - gcc has found <zstd.h> (i.e. it don't give one error about that
>>   include file not found).
>>
>> And zstd don't have ZSTD_CStream defined?  What is going on here?
>> Can you post/show what is on your zstd.h file?
>> What zstd library version do you have?
>>
>> I thought that zstd was a new library, and that we didn't need to check
>> for versions.  It appears that I was wrong.  And no, the include file
>> don't show what features are new/old.
>
> Obviously not that new but has changed since it first got introduced.

I put my archeology hat, and went digging.

Streaming API was introduced on this commit:

commit 5a0c8e24395079f8e8cdc90aa1659cd5ab1b7427
Author: Yann Collet <yann.collet.73@gmail.com>
Date:   Fri Aug 12 01:20:36 2016 +0200

    new streaming API (compression)

And it first appears on v0.8.1 version.

Posting a better fix on toplevel.  If you want to try, I have changed it
to:

diff --git a/configure b/configure
index 7b373bc0bb..1bf48df1ef 100755
--- a/configure
+++ b/configure
@@ -2464,7 +2464,8 @@ fi
 # zstd check
=20
 if test "$zstd" !=3D "no" ; then
-    if $pkg_config --exist libzstd ; then
+    libzstd_minver=3D"0.8.1"
+    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then
         zstd_cflags=3D"$($pkg_config --cflags libzstd)"
         zstd_libs=3D"$($pkg_config --libs libzstd)"
         LIBS=3D"$zstd_libs $LIBS"


If you can check that this works for you, thanks.


