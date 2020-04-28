Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13030C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1490206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLB4rr1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1490206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQlc-0008JU-S0
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQgh-0006Ke-Nl
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQch-0000Sb-Vs
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:54:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTQch-0000SJ-IW
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588081806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HERtMhpYr7NF+S7e4pmK6DIPXXMjl1K1GtnqrJdzG0=;
 b=XLB4rr1c/IAJ+lF0iOo7xMhSMwXsQlvokn1w0J6W1FGMY5qbRsLnIw8cbX3d1W59uzv4FI
 NGYEl38Bw/nEW3ut5Fx92qLkff++31dKjxvabwHDTEuAI9eNAQPn0pB5ODoOmj/mBE08xz
 ZV7WOGX1pvq68F9Go3MmqpwRF/6C3Rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131--zPPIK3kPCOIGIxDlqZ21A-1; Tue, 28 Apr 2020 09:50:02 -0400
X-MC-Unique: -zPPIK3kPCOIGIxDlqZ21A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CE42A0BDC;
 Tue, 28 Apr 2020 13:50:01 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37F715D9E5;
 Tue, 28 Apr 2020 13:49:59 +0000 (UTC)
Subject: Re: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200428132629.796753-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c8235407-a2cf-abe3-e5d9-f16170f9b4b4@redhat.com>
Date: Tue, 28 Apr 2020 08:49:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428132629.796753-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 8:26 AM, Max Reitz wrote:
> Branch: https://github.com/XanClic/qemu.git fix-bdrv_make_empty-v1
> Branch: https://git.xanclic.moe/XanClic/qemu.git fix-bdrv_make_empty-v1
>=20
> Hi,
>=20
> Right now, there is no centralized bdrv_make_empty() function.  Not only
> is it bad style to call BlockDriver methods directly, it is also wrong,
> unless the caller has a BdrvChild with BLK_PERM_WRITE taken.

I'm also in the middle of writing a patch series that adds a=20
corresponding .bdrv_make_empty driver callback.  I'll rebase that work=20
on top of this, as part of my efforts at fixing more code to rely on=20
bdrv_make_empty rather than directly querying bdrv_has_zero_init[_truncate]=
.

>=20
> This series fixes that.
>=20
> Note that as far as I=E2=80=99m aware this series shouldn=E2=80=99t visib=
ly fix anything
> at this point; but =E2=80=9Cblock: Introduce real BdrvChildRole=E2=80=9D
> (https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00737.html)
> makes the iotest break when run with -o data_file=3D$SOMETHING, without
> this series applied beforehand.  (That is because without that series,
> external data files are treated much like metadata children, so the
> format driver always takes the WRITE permission if the file is writable;
> but after that series, it only does so when it itself has a parent
> requestion the WRITE permission.)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


