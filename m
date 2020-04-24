Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90704C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 22:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588F820781
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 22:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihTPBy32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588F820781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS6NG-0006ds-6I
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 18:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS6Gs-0002XT-LB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS6Gq-0001Hh-BB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:54:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS6Gp-0001Er-Qt
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587765241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v6OdSNvNHw2fW4KzCxX3OpHPBgYJpgFnmdwj8NCsYYY=;
 b=ihTPBy32E9OOng4gHHcyXvS0Gp2cT2RrPT351VngO3D6fociLOxSJMxSghwTzHyLqB2W2k
 DjUydxpTkKC56BsqRIRHcZLddiLg7QmKklWkqNohzr0SUm+EkGyUfLtzlzdkdxgKQGh1A2
 NeK3CrJ+AOwzyxWnPRSmMWKdNdOHBIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-CNKWIzBNOjqF4LaqYYNuCA-1; Fri, 24 Apr 2020 17:53:56 -0400
X-MC-Unique: CNKWIzBNOjqF4LaqYYNuCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFE36107ACCA;
 Fri, 24 Apr 2020 21:53:55 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDA4A5D70C;
 Fri, 24 Apr 2020 21:53:54 +0000 (UTC)
Subject: Re: [PATCH] linux-user: Drop unnecessary check in dup3 syscall
To: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200424205755.GA26282@ls3530.fritz.box>
 <56bb3ce2-9b70-7470-d4f4-563b617849d2@redhat.com>
 <86df80e9-c747-1854-d210-5856b71e2f7b@gmx.de>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bb774102-33a9-8d78-a0a5-779ef7eb815b@redhat.com>
Date: Fri, 24 Apr 2020 16:53:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <86df80e9-c747-1854-d210-5856b71e2f7b@gmx.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 4:47 PM, Helge Deller wrote:

>>> -=A0=A0=A0=A0=A0=A0=A0 host_flags =3D target_to_host_bitmask(arg3, fcnt=
l_flags_tbl);
>>> +=A0=A0=A0=A0=A0=A0=A0 int host_flags =3D target_to_host_bitmask(arg3, =
fcntl_flags_tbl);
>>
>> I don't think this is quite correct.  target_to_host_bitmask()
>> silently ignores unknown bits, and a user that was relying on bit
>> 0x40000000 to cause an EINVAL will not fail with this change (unless
>> bit 0x40000000 happens to be one of the bits translated by
>> fcntl_flags_tbl).
>=20
> True.
>=20
>> The open() syscall is notorious for ignoring unknown bits rather than
>> failing with EINVAL, and it is has come back to haunt kernel
>> developers; newer syscalls like dup3() learned from the mistake, and
>> we really do want to catch unsupported bits up to make it easier for
>> future kernels to define meanings to those bits without them being
>> silently swallowed when run on older systems that did not know what
>> those bits meant.
> Ok, I wasn't aware that it's a design goal to manually find such
> cases of wrong userspace applications. But in this case, you're right
> that my patch shouldn't be applied.

This, and several similar ones that you also posted.

Maybe you could add a new int target_to_host_bitmask_strict(int src,=20
translate_tbl, int *dst), which returns 0 when *dst is bit-for-bit=20
translated from src, and returns -1 if src had bits not specified by=20
translate_tbl.  In that case, the caller can then translate all usual=20
bits and rely on the syscall() failure (as you tried here), but you can=20
also flag -TARGET_EINVAL up front for bits not covered by the table.

>=20
> While looking at the code I just noticed another bug too, which needs
> fixing then:
>>> -        if ((arg3 & ~TARGET_O_CLOEXEC) !=3D 0) {
>>> -            return -EINVAL;
> this needs to be:
>>> -            return -TARGET_EINVAL;

Indeed.  Good catch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


