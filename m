Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1382EC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF1320706
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mb6+u4Wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF1320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRzAn-0006L0-VU
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRz9y-0004vg-E3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRz9x-0000m9-SE
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:18:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47103
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRz9x-0000m0-FK
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587737908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLhRAndf9YLpp5jic3Luzt5LA5Br7Rg/BKG3rMftihY=;
 b=Mb6+u4WkM+NOpgnBI1OFpFXmFxU9kIY1lZ4Gtkr/z2ma4jQpZn2IlFw5n2YTJLXS4D4POK
 iUS70x8I7abTrByqQxgT15Tbe7mqs35WzBU46YpBrz2EbTujxqhbasse1nPWzSgT2tKW56
 gQh35czPwdKCoyVkZQc8RLIAGTWQYsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-T4uZdClAMvG3yPPNMY5-jA-1; Fri, 24 Apr 2020 10:18:27 -0400
X-MC-Unique: T4uZdClAMvG3yPPNMY5-jA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ECAA1009440;
 Fri, 24 Apr 2020 14:18:25 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D49360605;
 Fri, 24 Apr 2020 14:18:20 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] block: Add blk_new_with_bs() helper
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200423221707.477404-1-eblake@redhat.com>
 <20200423221707.477404-2-eblake@redhat.com>
 <307f7619-5e4a-10c1-7d49-8ee6bb8d650c@redhat.com>
 <f3808938-8b27-3af0-c2da-996459a5c921@redhat.com>
 <b8d91b29-67ea-3a50-864c-03ae907e092e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9d1d05f0-2e28-7912-b00b-93d2654d8373@redhat.com>
Date: Fri, 24 Apr 2020 09:18:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b8d91b29-67ea-3a50-864c-03ae907e092e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 5:02 AM, Max Reitz wrote:

>> (With the Patchew warning fixed, of course (i.e., we should set ret to
>> -EPERM or something in qcow.c))
>=20
> Er, well, maybe I should have looked into more places.  The compiler
> only warns about that single one because it=E2=80=99s the only place wher=
e @ret
> is really uninitialized, but there are many more where we need to set
> it: crypto.c, parallels.c, qcow.c, qcow2.c (both hunks), qed.c,
> sheepdog.c, vdi.c, vhdx.c, and vpc.c.
>=20
> (So basically everywhere but vmdk.c, blockdev.c, and blockjob.c.)

Urgh - so it's even less of a win in terms of reduced lines of code.=20
Still, I'll fix it and post v3.

>=20
> And now I=E2=80=99m going to get another coffee...
>=20
> Max
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


