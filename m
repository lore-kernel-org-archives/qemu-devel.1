Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D62AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E3E206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHxWsdhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E3E206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPpH-0001TL-HD
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iiPhk-0001wo-Nh
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iiPhj-0002Pl-Jr
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:21:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iiPhj-0002Ne-Fk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576876859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjkOEuDdfsWZPslFU3vpH/pBaVVMOsqHvTAPF7Cp0b4=;
 b=YHxWsdhl1dlgIhkjuU5LBw0ILSoqhM6YiKFZogVLXuR4JcXuNrdaYfD5zezh50btG0I09g
 Lyk6lJhth4RM7ioEb0QFwg2qxtvVza5g7jggy5a7pzdJGNcQOHuruEfEjCwlR7A7hNJTuf
 DeiX0VXgKcsHMKFV8AqXpv4MDwyMOUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-BpeZzKcHMhSYr_ah-KP3Fw-1; Fri, 20 Dec 2019 16:20:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B005A64A7E;
 Fri, 20 Dec 2019 21:20:54 +0000 (UTC)
Received: from [10.3.116.246] (ovpn-116-246.phx2.redhat.com [10.3.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A5775EE0F;
 Fri, 20 Dec 2019 21:20:54 +0000 (UTC)
Subject: Re: [PATCH 00/18] block: Allow exporting BDSs via FUSE
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191220100846.GC1635864@stefanha-x1.localdomain>
 <a372e742-182a-ec98-d297-ed8d43e10734@redhat.com>
 <20191220125017.GF4019@dhcp-200-226.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f4c290d1-7ef2-2bbe-5d6e-5f08896a84cb@redhat.com>
Date: Fri, 20 Dec 2019 15:20:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220125017.GF4019@dhcp-200-226.str.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: BpeZzKcHMhSYr_ah-KP3Fw-1
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 6:50 AM, Kevin Wolf wrote:
> Am 20.12.2019 um 11:30 hat Max Reitz geschrieben:
>> I placed it into block/ because that just seemed like the least bad
>> place to me (apart from creating a new top-level directory like nbd has)
>> =E2=80=93 and also because we already have quite some few non-driver fil=
es in
>> block/ (io.c, the jobs (where some got drivers only rather recently),
>> accounting.c, ...).
>=20
> We could consider block/exports/ and eventually also move the NBD server
> there.

We already had another thread considering the motion of qemu-nbd.c to=20
tools/, and I don't mind moving top-level nbd/ into block/exports/ if=20
that makes things easier to reason about.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


