Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D54DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490D624688
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chtv1cTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490D624688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eLT-0003oH-HC
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j7e9f-0004hA-Kz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j7e9e-000257-KZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:50:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j7e9e-00024t-FE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tDCxU8QPH9uLNwR6t99jNdSH2Qd3DCmeMHffX9VG6U=;
 b=chtv1cTyPiYa/CMHBmv2MKkyKIsxnF0930VlabJmOOJHta4gELkj0jwnI8j5rTJ4gUD6lf
 B8fHVh6jzXUBCvQnHxBRHK3m+dSvRMr7j/MmFnR9WhZL9wTSThRELszLRquHAjhgRwAdG3
 xEgufH1rMZYL+fNf0L5cQHaoCYja9ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-5gFfmSw5PH2Wqc_md-zRqA-1; Fri, 28 Feb 2020 06:50:04 -0500
X-MC-Unique: 5gFfmSw5PH2Wqc_md-zRqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA5F100550E;
 Fri, 28 Feb 2020 11:50:03 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-243.ams2.redhat.com
 [10.36.116.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02B345D9CD;
 Fri, 28 Feb 2020 11:50:00 +0000 (UTC)
Subject: Re: [edk2-devel] A problem with live migration of UEFI virtual
 machines
From: Laszlo Ersek <lersek@redhat.com>
To: Andrew Fish <afish@apple.com>, devel@edk2.groups.io
References: <tencent_BC7FD00363690990994E90F8@qq.com>
 <87sgjhxbtc.fsf@zen.linaroharston> <20200224152810.GX635661@redhat.com>
 <8b0ec286-9322-ee00-3729-6ec7ee8260a6@redhat.com>
 <3E8BB07B-8730-4AB8-BCB6-EA183FB589C5@apple.com>
 <465a5a84-cac4-de39-8956-e38771807450@redhat.com>
 <8F42F6F1-A65D-490D-9F2F-E12746870B29@apple.com>
 <6666a886-720d-1ead-8f7e-13e65dcaaeb4@redhat.com>
 <284BFC25-8534-4147-8616-DE7C410DB681@apple.com>
 <2e3771cf-089c-aecd-49a7-3034a30fc443@redhat.com>
Message-ID: <05c16f06-7576-f643-5bf8-8adbd41d139c@redhat.com>
Date: Fri, 28 Feb 2020 12:50:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2e3771cf-089c-aecd-49a7-3034a30fc443@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 zhoujianjay <zhoujianjay@gmail.com>, discuss <discuss@edk2.groups.io>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 wuchenye1995 <wuchenye1995@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/28/20 12:47, Laszlo Ersek wrote:
> On 02/28/20 05:04, Andrew Fish wrote:

>> Given the above it seems like the 2 options are:
>> 1) Pad OVMF_CODE.fd to be very large so there is room to grow.
> 
> There's already room to grow, *inside* OVMF_CODE.fd. As I've shown
> elsewhere in this thread, even the 2MB build has approx. 457 KB free in
> the DXEFV volume, even without link-time optimization and without
> DEBUG/ASSERT stripping, if you don't enable additional features.

Typo; I meant FVMAIN_COMPACT, not DXEFV.

Laszlo


