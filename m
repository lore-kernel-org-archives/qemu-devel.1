Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199AAC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90D020748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X89Ia6qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90D020748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4G3-0007td-Ko
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1is4F9-0006yu-Df
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1is4F7-0002ix-AF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:27:23 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:33529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1is4F6-0002a7-Mh; Thu, 16 Jan 2020 07:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=CjqjOavh+h6FbIAOkCvSwZh5K5ofDT1pkDWoFvkw13w=; 
 b=X89Ia6qsyUFgt0cpLi+0VIkqLJWXo0Q2BWDqEHNJRn1mJaTFCA+D+ATcE+J3kZaMDYeloWqq29Dib3UkpikfJma0ZhmwPGYqrN4xHkRn6goUHBteyfzPMrItSVWcEezBvUc5CxtzImJppsd5JIVW2YuP+ZHRD0/bzy3bwSpquNPfDGm2M45IqiQR9nMINHvbrBOFXD2reR7iZPOT9Dv5tSqkd1uI09wHQWF4E+sdM3Ov1mP5kGEhBIm8w6CwEKVLzYyFwZvfn3C0TXCjkuFohTS3JrAfeB/cXJdR4XhFk5vP+PnTbfshTOx58GizqKCauGqtslIcoEri2zuElbmPww==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1is4F2-0003Qt-77; Thu, 16 Jan 2020 13:27:16 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1is4F1-0006Xz-Ts; Thu, 16 Jan 2020 13:27:15 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] qcow2: Use a GString in report_unsupported_feature()
In-Reply-To: <7dc5a8bf-bb1d-aeec-ef3e-6e60597bbcb8@redhat.com>
References: <20200115135626.19442-1-berto@igalia.com>
 <7dc5a8bf-bb1d-aeec-ef3e-6e60597bbcb8@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 16 Jan 2020 13:27:15 +0100
Message-ID: <w51d0bjfuxo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Alex =?utf-8?Q?Benn?= =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 16 Jan 2020 01:19:34 PM CET, Max Reitz wrote:
> On 15.01.20 14:56, Alberto Garcia wrote:
>> This is a bit more efficient than having to allocate and free memory
>> for each item.
>>=20
>> The default size (60) is enough for all the existing incompatible
>> features or the "Unknown incompatible feature" message.
>
> That doesn=E2=80=99t make sense to me.  The existing incompatible feature=
s are
> known to qemu, and as such will never be printed here.

I know, it's sort of an arbitrary number, I just chose a default size
that is big enough for the strings we have.

> ((I=E2=80=99d just have created an empty string.  Considering this is par=
t of
> the explanation for a fatal error, nobody cares whether this function
> takes a couple of microseconds more.  Or maybe a length of 47, so it
> can definitely hold exactly one incompatible feature name.))

That would be fine with me as well, I don't think it matters so much
either way. Feel free to change the default size or remove the
explanation from the commit message if you want.

Berto

