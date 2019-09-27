Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821E8C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538BD207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538BD207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtwU-0004nW-0x
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iDs8g-0003kV-E8
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iDs8f-0004OW-6o
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:26:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iDs8b-0004La-1U; Fri, 27 Sep 2019 11:26:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FA5B10C0954;
 Fri, 27 Sep 2019 15:26:28 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE7931001B08;
 Fri, 27 Sep 2019 15:26:27 +0000 (UTC)
Subject: Re: [PATCH] tests: fix I/O test for hosts defaulting to LUKSv2
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20190927101155.25896-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <666c1338-e5c4-3cba-cb89-651755baa065@redhat.com>
Date: Fri, 27 Sep 2019 10:26:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927101155.25896-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 27 Sep 2019 15:26:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 5:11 AM, Daniel P. Berrang=C3=A9 wrote:
> Some distros are now defaulting to LUKS version 2 which QEMU cannot
> process. For our I/O test that validates interoperability between the
> kernel/cryptsetup and QEMU, we need to explicitly ask for version 1
> of the LUKS format.
>=20

Ultimately, it would be nice to get LUKS 2 support in qemu too, but=20
that's a much bigger job.  This is fine for now.

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/qemu-iotests/149     |  2 +-
>   tests/qemu-iotests/149.out | 44 +++++++++++++++++++------------------=
-
>   2 files changed, 23 insertions(+), 23 deletions(-)

>=20
> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> index 4f363f295f..8ab42e94c6 100755
> --- a/tests/qemu-iotests/149
> +++ b/tests/qemu-iotests/149
> @@ -153,7 +153,7 @@ def cryptsetup_format(config):
>  =20
>       (password, slot) =3D config.first_password()
>  =20
> -    args =3D ["luksFormat"]
> +    args =3D ["luksFormat", "--type", "luks1"]

On Fedora 29, 'cryptsetup --help | grep -A1 type' shows:
   -M, --type=3DSTRING               Type of device metadata: luks, plain=
,
                                   loopaes, tcrypt

but that is just 'luks', not 'luks1'.

On CentOS 6 (yeah, I know, not relevenant to qemu any more), --type is=20
unsupported.  But I didn't check our other range of supported systems.=20
My point, however, is whether this patch needs to be conditionalized=20
based on what cryptsetup actually supports.

I could not quickly determine if there is some sort of safe no-op=20
'cryptsetup --type=3DFOO action /safe/device' that can be used to tell if=
=20
--type=3DFOO is recognized.

Otherwise, this makes sense to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

