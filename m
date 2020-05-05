Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B833C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420B820675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Me4pycfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420B820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVtM0-0007WF-5h
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 04:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVtLJ-0006pO-7h
 for qemu-devel@nongnu.org; Tue, 05 May 2020 04:54:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVtLH-00019y-Px
 for qemu-devel@nongnu.org; Tue, 05 May 2020 04:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588668858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/j66NZvXAMTEPSFzNKuwaXQbl2r/RZOwr/qF2DHVVVw=;
 b=Me4pycfHBgnGB275gqcCM9x1R5w9R8C9gQ2WIRQW7uT7ijPKr1cbHQzngy73HiEIGndtPy
 4VuBq5UhDk1Knw8Ny+USO/xUJWb1gHx4i7c8L6tycS4t0uiigsO/T86Qk52GSLM6F/bmkr
 +pljc54SRmd1tGbwXYkY+Zjbft8CIp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-xUx78zWjPL-U57ZY4JY1yw-1; Tue, 05 May 2020 04:54:16 -0400
X-MC-Unique: xUx78zWjPL-U57ZY4JY1yw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75002468;
 Tue,  5 May 2020 08:54:15 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C5615C1B2;
 Tue,  5 May 2020 08:54:13 +0000 (UTC)
Date: Tue, 5 May 2020 10:54:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH v3] qcow2: Avoid integer wraparound in qcow2_co_truncate()
Message-ID: <20200505085412.GD5759@linux.fritz.box>
References: <20200504155217.10325-1-berto@igalia.com>
 <6fefd4af-3687-7f38-3933-aa67f2f221e8@redhat.com>
 <w51368fiq7k.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w51368fiq7k.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.05.2020 um 19:07 hat Alberto Garcia geschrieben:
> On Mon 04 May 2020 06:01:19 PM CEST, Eric Blake wrote:
> >> +_supported_fmt qcow2
> >> +_supported_proto file
> >
> > Do we have to limit it to qcow2 and file?  Yes, it's testing a bugfix
> > for qcow2, but are there other formats that it doesn't hurt to have
> > the extra testing?
>=20
> It doesn't work with any other format at the moment (meaning: reading
> the tail of the image after growing it returns the data from the backing
> file).
>=20
> Also, it seems that qemu-img's -F does not work with other formats
> either.
>=20
> > Also, I don't see anything preventing this from working with non-file
> > protocol.
>=20
> Right, that can be updated I guess (whoever commits this, feel free to
> do it).

I don't know for which protocols it works. I know that qcow2 over nbd
doesn't work.

But I think there is a more important problem with the test: It seems to
pass even with old binaries that don't have the fix. Is this only on my
system or do you get the same?

Kevin


