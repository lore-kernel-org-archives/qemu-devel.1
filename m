Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F49BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D801C2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQf+mPLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D801C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1javmP-00055L-2p
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 02:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javlO-0004Nt-Un
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:30:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javlO-0005Az-7C
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589869805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9t18dkKFWJdIgG4szm6GzzLAbBoLaJ+oIrpZ6t0c+0s=;
 b=GQf+mPLcn2QWiw5HqvIFgsIrczVpGy4SRjYkZzzKZq2cgyWPQBWTvluQjIwS1ZgvlsR1Es
 AftgcNg77D/uN2RzXIrRh/tL5NmCNtJWFUz3U/D0NuS0TcrYvoF+OiW0/XLYVMRPnt9J4a
 mCmTWExHF6OyeEpLGvwT96oiwz8w5YU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-TTGkTpvwNDCxLsKrraC6Kg-1; Tue, 19 May 2020 02:30:03 -0400
X-MC-Unique: TTGkTpvwNDCxLsKrraC6Kg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78D0C835B41;
 Tue, 19 May 2020 06:30:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4568D60C05;
 Tue, 19 May 2020 06:30:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF54E11358BC; Tue, 19 May 2020 08:30:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 17/24] pnv/psi: Correct the pnv-psi* devices not to be
 sysbus devices
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-18-armbru@redhat.com>
 <648a3207-b842-6dd3-0f00-a26acb3d48be@kaod.org>
Date: Tue, 19 May 2020 08:30:00 +0200
In-Reply-To: <648a3207-b842-6dd3-0f00-a26acb3d48be@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Mon, 18 May 2020 18:27:04 +0200")
Message-ID: <87367w5tef.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 5/18/20 7:04 AM, Markus Armbruster wrote:
>> pnv_chip_power8_instance_init() creates a "pnv-psi-POWER8" sysbus
>> device in a way that leaves it unplugged.
>> pnv_chip_power9_instance_init() and pnv_chip_power10_instance_init()
>> do the same for "pnv-psi-POWER9" and "pnv-psi-POWER10", respectively.
>>=20
>> These devices aren't actually sysbus devices.  Correct that.
>
> I might have done things wrong regarding sysbus in the PowerNV machine.
>
> For some devices (PHBs), I have added :
>
> =09qdev_set_parent_bus(DEVICE(...), sysbus_get_default());

It's not wrong.

My next series will rework how devices get plugged into their buses.

> Should we do the same for the PSI device ?

No, because the PSI device is not a sysbus device.


