Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B09C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 22:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D617320717
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 22:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCsIBIYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D617320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9zSt-0006kE-2T
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 17:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j9zSH-00068j-Ou
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 17:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j9zSG-0001aB-30
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 17:59:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52698
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j9zSF-0001Yd-Og
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 17:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583449138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ir8fK1z4Awa/0+qpzm2z1n4xhrIOA0DBh373QTnhAI=;
 b=WCsIBIYFWTJJOtPtNvanSQ+GcCuiPnhY0GPVMWBCJTUIt84PP+Vr5PnM5efHV8yB0IzB2/
 4rMAdZGt/L7Nw37svSR2GhAq5B+z8Dn/PFZcRFy9ZYO/FStuiU6Wq1rtUFLmuGvSp63i51
 VeTZZLPGyp6fnW3ChQ6fT0o8HbSNBL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-qKxN-R3hO2GccoDrsSM5aQ-1; Thu, 05 Mar 2020 17:58:54 -0500
X-MC-Unique: qKxN-R3hO2GccoDrsSM5aQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B28CD107ACC4;
 Thu,  5 Mar 2020 22:58:53 +0000 (UTC)
Received: from [10.3.117.177] (ovpn-117-177.phx2.redhat.com [10.3.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E9403A5;
 Thu,  5 Mar 2020 22:58:50 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] iotests: Specify explicit backing format where
 sensible
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
References: <20200227023928.1021959-1-eblake@redhat.com>
 <20200227023928.1021959-2-eblake@redhat.com> <20200227091955.GD2262365@lpt>
 <acef142b-4554-488b-10a7-75209a91b919@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f0ac3890-9a3d-8adc-afeb-e6ac404c698b@redhat.com>
Date: Thu, 5 Mar 2020 16:58:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <acef142b-4554-488b-10a7-75209a91b919@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 7:08 AM, Eric Blake wrote:

>>> The change in libvirt to reject images without explicit backing format
>>> has pointed out that a number of tools have been far too reliant on
>>> probing in the past.=A0 It's time to set a better example in our own
>>> iotests of properly setting this parameter.
>>>
>>> iotest calls to create, rebase, convert, and amend are all impacted to
>>> some degree.=A0 It's a bit annoying that we are inconsistent on command
>>> line - while all of those accept -o backing_file=3D...,backing_fmt=3D..=
.,
>>> the shortcuts are different: create and rebase have -b and -F, convert
>>> has -B but no -F, and amend has no shortcuts.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>
>> [...]
>>
>> Test #225 still uses -b without a format:
>>
>> ./check -vmdk 225
>=20
> Oh, good catch (I only ran ./check -qcow2, -nbd, and -raw).

Urgh - running './check -vmdk' shows failures in:

017 018 019 020 034 037 069 110 126 216 225 279

all similar to:

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576=20
backing_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+qemu-img: TEST_DIR/t.IMGFMT: Backing file format not supported for file=20
format 'IMGFMT'

with knock-on effects.  I guess I first have to fix outlier formats like=20
vmdk to ignore a backing file format where it does not hurt.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


