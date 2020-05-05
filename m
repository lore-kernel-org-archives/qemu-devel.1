Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193F7C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A6B20721
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBcB9T+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A6B20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVsMn-0006eI-2C
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 03:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVsM0-00066C-Nh
 for qemu-devel@nongnu.org; Tue, 05 May 2020 03:51:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVsLz-0007T4-BI
 for qemu-devel@nongnu.org; Tue, 05 May 2020 03:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588665058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYke/vIF0cYduZtP8zeR8AwYerfCyukkWfmBsg5UdEI=;
 b=bBcB9T+bkcqwVcUhSi4UDKm/9zzWw36yk3yNLg7ghtno9xfYyLsTAanTXLDZ/qOQ9V6R9A
 +btj78hgSlKQ7iwdzESlfz/UKQctvWW2bjRPHTZEFdrfPKQmOAFnPf42q8qZWHYwit1LNW
 DCRQsCxebGNqWPXigr0HSJHzrUKyMOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-rNlRLC6aPC26H1p129_SRQ-1; Tue, 05 May 2020 03:50:56 -0400
X-MC-Unique: rNlRLC6aPC26H1p129_SRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A34A439340;
 Tue,  5 May 2020 07:50:55 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A49F60CD1;
 Tue,  5 May 2020 07:50:51 +0000 (UTC)
Date: Tue, 5 May 2020 09:50:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 4/7] qcow2: Deprecate use of qemu-img amend to change
 backing file
Message-ID: <20200505075050.GB5759@linux.fritz.box>
References: <20200403175859.863248-1-eblake@redhat.com>
 <20200403175859.863248-5-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200403175859.863248-5-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.04.2020 um 19:58 hat Eric Blake geschrieben:
> The use of 'qemu-img amend' to change qcow2 backing files is not
> tested very well.  In particular, our implementation has a bug where
> if a new backing file is provided without a format, then the prior
> format is blindly reused, even if this results in data corruption, but
> this is not caught by iotests.
>=20
> There are also situations where amending other options needs access to
> the original backing file (for example, on a downgrade to a v2 image,
> knowing whether a v3 zero cluster must be allocated or may be left
> unallocated depends on knowing whether the backing file already reads
> as zero), but the command line does not have a nice way to tell us
> both the backing file to use for opening the image as well as the
> backing file to install after the operation is complete.
>=20
> Even if we do allow changing the backing file, it is redundant with
> the existing ability to change backing files via 'qemu-img rebase -u'.
> It is time to deprecate this support (leaving the existing behavior
> intact, even if it is buggy), and at a point in the future, require
> the use of only 'qemu-img rebase' for adjusting backing chain
> relations, saving 'qemu-img amend' for changes unrelated to the
> backing chain.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

I think the original idea was that in BlockDriver, special interfaces
like the ones used by qemu-img rebase could eventually go away if we
have a single consistent interface to change image options, which is
amend. So ideally, bdrv_change_backing_file() should become a wrapper
around amend.

I'm not even sure if the behaviour you mention should be considered a
bug because amend is a low-level interface. But even if that's the case,
it would be a matter of simply adding a check.

Kevin


