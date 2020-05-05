Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9468DC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFCF206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdrkYEQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFCF206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVtkO-000388-GM
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVtjp-0002cH-5p
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:19:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVtjo-0004fv-HU
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588670379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4vhjQF4ENmA/SSW0P31nwlQjBbQBmUz5xTfSxmUKKc=;
 b=cdrkYEQORbtI8ja3FPVQvbaXm81fSjOuyhaGTX6a5omMFR5Cj2mDV+KduIlhJW8LNCeksK
 oc39HTxbE5q52ZrRTmHonRTaYWBScRG1R+fh8oMtlt20FjdvE/kYz0RjaoMPaT6vZ4ppG0
 59FmbvczQk7SS/4Oi6uhhrICgAVMApc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-MU8S34XjO0mpPn9434En9g-1; Tue, 05 May 2020 05:19:36 -0400
X-MC-Unique: MU8S34XjO0mpPn9434En9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AF081054F92;
 Tue,  5 May 2020 09:19:35 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1589D5C1B2;
 Tue,  5 May 2020 09:19:33 +0000 (UTC)
Date: Tue, 5 May 2020 11:19:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH v3] qcow2: Avoid integer wraparound in qcow2_co_truncate()
Message-ID: <20200505091927.GF5759@linux.fritz.box>
References: <20200504155217.10325-1-berto@igalia.com>
 <6fefd4af-3687-7f38-3933-aa67f2f221e8@redhat.com>
 <w51368fiq7k.fsf@maestria.local.igalia.com>
 <20200505085412.GD5759@linux.fritz.box>
 <w514ksuvj0n.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w514ksuvj0n.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Am 05.05.2020 um 11:16 hat Alberto Garcia geschrieben:
> On Tue 05 May 2020 10:54:12 AM CEST, Kevin Wolf wrote:
> > But I think there is a more important problem with the test: It seems
> > to pass even with old binaries that don't have the fix. Is this only
> > on my system or do you get the same?
>=20
> With old binaries when qcow2_cluster_zeroize() is called it receives
> bytes =3D (UINT64_MAX - 9216), however that number is then used to
> calculate the number of affected clusters, so it's rounded up, wraps
> around again and back to zero. There's no visible sign of the error, it
> just happens to work fine.
>=20
> If there was a raw data file then we would try to write UINT64_MAX-9216
> bytes to it, but in this case there's no backing file allowed and
> therefore the image is not zeroed, so qcow2_cluster_zeroize() never
> happens.
>=20
> Why the test case then? There was a mistake with my first patch and
> there it crashed (due to an assertion), that's why Eric thought it would
> be a good idea to add a test case anyway, in case we have to change that
> code in the future and we screw up.

Thanks for the explanation, this makes sense. I'll apply the patch now.

Kevin


