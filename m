Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357F0C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D949D2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyjmou/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D949D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOHK1-00086q-3p
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 04:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOHJJ-0007bc-5z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOHJH-0004LP-Hm
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:52:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOHJH-0004L8-FL
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586854366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnNjWZdkEghzEhy64W/pYsmXM2XzC7zWCqcBu24bNYs=;
 b=gyjmou/2lreaxGeKh3YPLRZelydi7aAeDpIsGEljNLodwnQ8bMNCflhW/JGBKHNXH22s6i
 6YpJfrxLsTsnU1I46HGNlmOSJYx67vF4dua3Yb+C4e9LoJ8J1WLYmXHRpIa4Ntst0y3X7G
 aaUX63Ja5apcWWZKm02tJaQ9g75i86Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-mScQM550PbuhwQEt7-TseA-1; Tue, 14 Apr 2020 04:52:41 -0400
X-MC-Unique: mScQM550PbuhwQEt7-TseA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D422E107ACC9;
 Tue, 14 Apr 2020 08:52:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A037218A8E;
 Tue, 14 Apr 2020 08:52:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 296A611385C8; Tue, 14 Apr 2020 10:52:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.1 0/8] qemu-option: Fix corner cases and clean up
References: <158645218790.18042.4891276831001916938@39012742ff91>
 <61902667-8412-3d94-c298-ac89963d4f7f@redhat.com>
Date: Tue, 14 Apr 2020 10:52:39 +0200
In-Reply-To: <61902667-8412-3d94-c298-ac89963d4f7f@redhat.com> (Eric Blake's
 message of "Thu, 9 Apr 2020 12:44:26 -0500")
Message-ID: <87ftd6xxd4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/9/20 12:09 PM, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20200409153041.17576-1-armbru@redh=
at.com/
>>
>>
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below f=
or
>> more information:
>>
>
>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>> 1/8 Checking commit 2e003109273b (tests-qemu-opts: Cover has_help_option=
(), qemu_opt_has_help_opt())
>> WARNING: Block comments use a leading /* on a separate line
>> #37: FILE: tests/test-qemu-opts.c:747:
>> +        { "a,b,,help", false /* BUG */, true, true },
>
> Annoying, but I don't mind ignoring it (especially since we fix the
> bug later in the series).
>
>>
>> total: 0 errors, 1 warnings, 50 lines checked
>>
>> Patch 1/8 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>> 2/8 Checking commit 8bb805dd3730 (qemu-options: Factor out get_opt_name_=
value() helper)
>> 3/8 Checking commit b3630a346906 (qemu-option: Fix sloppy recognition of=
 "id=3D..." after ", , ")
>> 4/8 Checking commit 5c1b2db0b7ad (qemu-option: Avoid has_help_option() i=
n qemu_opts_parse_noisily())
>> 5/8 Checking commit 6845c29bee11 (qemu-option: Fix has_help_option()'s s=
loppy parsing)
>> 6/8 Checking commit b7fcaaeeeb6f (test-qemu-opts: Simplify test_has_help=
_option() after bug fix)
>> 7/8 Checking commit b164930d4c8d (qemu-img: Factor out accumulate_option=
s() helper)
>> 8/8 Checking commit 505f5f389855 (qemu-option: Move is_valid_option_list=
() to qemu-img.c and rewrite)
>> ERROR: suspect code indent for conditional statements (4, 4)
>> #61: FILE: qemu-img.c:243:
>> +    for (i =3D len; i > 0 && optarg[i - 1] =3D=3D ','; i--) {
>> +    }
>
> False positive. Maybe you can shut up the checker by:
>     for (...) {
>         /* nothing further to do */
>     }

I don't like to add code to work around checkpatch bugs.  Rare
checkpatch bugs can be ignored, non-rare ones should be fixed.


