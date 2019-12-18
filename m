Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F76C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0882176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwOpIh6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0882176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhE4-0007QJ-Hn
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ihhCT-000635-GN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:49:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ihhCQ-000264-U1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:49:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ihhCQ-00021s-GS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576705780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4LLQEEaHKWC7dIhIlwqqKtf4yL6SGhTK7vyFmfwb58=;
 b=GwOpIh6VuQB4YuGoP16Sn0lKsuddvsxyRkae9eC3Jyor1vQDyir4WuGBqTPXtbwp//hk0C
 rrNNDyB9WxSp2vJ1quzl/r2FenZf/rgJzojPt9E3VjC3k2SMATSASPsW0inmO7tGN4bJO6
 XcqXdkHgbpPrbp5HO8EgNYj84FfwAnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-usSB4n3bMIWEG98yHqfFoQ-1; Wed, 18 Dec 2019 16:49:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3D08107ACC4;
 Wed, 18 Dec 2019 21:49:35 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 423B7620BC;
 Wed, 18 Dec 2019 21:49:35 +0000 (UTC)
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
To: Tao Xu <tao3.xu@intel.com>, Markus Armbruster <armbru@redhat.com>
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
 <b7c442e3-cc7e-155e-5370-db9a371928a6@intel.com>
 <87y2vbgsf0.fsf@dusky.pond.sub.org>
 <e731445a-4461-3212-c08d-05dc7ad2b742@intel.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c19efe27-5a61-100f-7b9b-bbac50209f94@redhat.com>
Date: Wed, 18 Dec 2019 15:49:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e731445a-4461-3212-c08d-05dc7ad2b742@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: usSB4n3bMIWEG98yHqfFoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 7:33 PM, Tao Xu wrote:

>> Also fun: for "0123", we use uint64_t 83, not double 123.0.=C2=A0 But fo=
r
>> "0123.", we use 123.0, not 83.
>>
>> Do we really want to accept octal and hexadecimal integers?
>>
>=20
> Thank you for reminding me. Octal and hexadecimal may bring more=20
> confusion. I will use qemu_strtou64(nptr, &suffixu, 10, &valu) and add=20
> test for input like "0123".

Note that JSON does not permit octal numbers, but ALSO does not permit=20
'0123' as a valid JSON number.  Of course, this parser is intended for=20
human users rather than a JSON parser, so silently accepting it as=20
decimal 123 is probably okay, but it is worth remembering that decisions=20
are not trivial here.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


