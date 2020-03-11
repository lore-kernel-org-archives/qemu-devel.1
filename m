Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382C0C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DA020735
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd/VthLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DA020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC5D5-0008Hh-9Z
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jC5CG-0007mF-Lo
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jC5CA-0002Pb-GK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:31:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jC5CA-0002PL-D0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583947862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7/3y1pyU64v8C7S1fpt7aQ/iZ/bva1vEVR3oKK3KIs=;
 b=fd/VthLg2XefeRlI2/14ff1M/nXaTEDJEAzLwbt0lhbtDXmMzEKHBG0P+ZXO7lQJcsBxYb
 AVmUR7AKj7eXLtd3Qo6DgyUwuTkh9dwxdUOyBcaX/sQCl+l/r69Jz4CCYlRST8Xq9C4A0l
 C1pTTKGnV042FUvrZggv/mmQpVfPE/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-n03VVTVIMdOZZglR_3R0fQ-1; Wed, 11 Mar 2020 13:30:47 -0400
X-MC-Unique: n03VVTVIMdOZZglR_3R0fQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 628E4805758;
 Wed, 11 Mar 2020 17:30:46 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE90F9CA3;
 Wed, 11 Mar 2020 17:30:45 +0000 (UTC)
Subject: Re: [PATCH v5 0/5] qcow2: Implement zstd cluster compression method
To: Max Reitz <mreitz@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200304133538.9159-1-dplotnikov@virtuozzo.com>
 <bbb15291-ffb5-80f1-ed27-583ac3cb98bb@virtuozzo.com>
 <55afec29-1726-c36a-6d80-3dbd1839f0a6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d65fcc11-c35d-fbd1-fa77-c36616125813@redhat.com>
Date: Wed, 11 Mar 2020 12:30:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <55afec29-1726-c36a-6d80-3dbd1839f0a6@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/11/20 11:28 AM, Max Reitz wrote:
> On 11.03.20 08:31, Denis Plotnikov wrote:
>> ping!
>>
>> Is there any other comments/concerns/objections/suggestions according to
>> the series except the minor ones from Alberto and Vladimir?
>> If not, please, let me know, so I can resend the series with the minor
>> changes for applying to the corresponding branch.
>=20
> Sounds good to me.
>=20
> I=E2=80=99d like to note that most iotests that seem to do something with
> compression (i.e., where grep finds a 'compress' somewhere; 013, 014,
> 023, 042, 046, 053, 055, ...) pass with -o compression_type=3Dzstd, too.
> 060 hangs somewhere.  112 complains about v2 incompatibility; and 214
> relies on intricacies of zlib, I think.  So that looks good, too.
>=20
> Well, one thing I did have to fix for this to work is to quote
> everything in common.pattern that tries to echo something with brackets
> (e.g. =E2=80=9CClusters to be compressed [1]=E2=80=9D).  I don=E2=80=99t =
quite know why the
> brackets suddenly disappear when I run the tests with -o
> compression_type, who knows.

That sounds like you have a file named '1' in the directory where the=20
echo was run.  Unquoted [1] is a shell glob that expands to '1' if that=20
file exists, otherwise remains unexpanded as '[1]'.

>  But putting quotes around the echo
> arguments fixes it, so...

Yes.  Figuring out why a file named '1' is being created is also a=20
useful exercise, but quoting any time you have [ that you want output is=20
already a good idea.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


