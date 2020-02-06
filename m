Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A258C352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6984420838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEvVhuPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6984420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjeE-0000bk-KI
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1izjcr-0007dt-BE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1izjcl-0002jf-Rw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:03:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1izjcl-0002i0-Mq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581005006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDAoFlPyiGqmdei+TNBQxWsF7N3qj8RdgZqupcz0EXU=;
 b=aEvVhuPUrdc8C3j5KGYChBIxRIw0IsCHmq23UIcpa/tTnsMAGHQiq9TB7Kev15Jjiw/bI2
 7/0pIklBVyMX3Dp9PsJlRDJz95hlEao+0sbQAk07tgrX3nmzLv0skVnyBgTxIbAR/o97SR
 83DbUULgApr8FLxjpySTi0oiLaXs9rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-2voJA1sWOfe-YOYBkf1UsA-1; Thu, 06 Feb 2020 11:03:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8718C8010F8;
 Thu,  6 Feb 2020 16:03:09 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 316A5790D8;
 Thu,  6 Feb 2020 16:03:09 +0000 (UTC)
Date: Thu, 6 Feb 2020 11:03:08 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Message-ID: <20200206160308.GB25446@habkost.net>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <20191218151144.GN498046@habkost.net>
 <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
 <20200205223731.GY25446@habkost.net>
 <CY4PR12MB157489B70F2AD26C97779E40951D0@CY4PR12MB1574.namprd12.prod.outlook.com>
 <FD52354F-2038-4829-A7D8-7513D601A2FF@nutanix.com>
 <60B21C9A-30BE-4DC0-8A1B-0BC7757BA9D7@nutanix.com>
 <78f5dad9-5433-3f7c-69cb-db496b1c37a7@amd.com>
MIME-Version: 1.0
In-Reply-To: <78f5dad9-5433-3f7c-69cb-db496b1c37a7@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2voJA1sWOfe-YOYBkf1UsA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani.sinha@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 09:30:11AM -0600, Babu Moger wrote:
>=20
>=20
> On 2/5/20 11:53 PM, Ani Sinha wrote:
> >=20
> >=20
> >> On Feb 6, 2020, at 11:16 AM, Ani Sinha <ani.sinha@nutanix.com> wrote:
> >>
> >>
> >>
> >>> On Feb 6, 2020, at 5:30 AM, Moger, Babu <Babu.Moger@amd.com> wrote:
> >>>
> >>> Ani, I am already working on it.
> >>
> >> Wow, I see a whole new AMD-Rome CPU model with it=E2=80=99s own cache =
info data :=20
> >>
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo=
re.kernel.org%2Fqemu-devel%2F157314966312.23828.17684821666338093910.stgit%=
40naples-babu.amd.com%2F&amp;data=3D02%7C01%7CBabu.Moger%40amd.com%7Cc566dc=
5cf3cc407b5ee608d7aac8d9bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637=
165651955089264&amp;sdata=3DtlafWD6m5%2BZ12cqd4vqJcWh0%2FIgly%2FPVMgAbjxK5M=
og%3D&amp;reserved=3D0
> >=20
> > Do you think the ROME specific guest cpu cache data will have significa=
nt impact on performance?
>=20
> I have not done performance benchmarks myself. Yes. Rome is expected to
> perform better than its previous generations.

Note that virtual cache information on CPUID doesn't affect host
software or hardware behavior in any way.  In the exceptional
cases it affects performance, it's solely because guest software
behavior changed depending on the cache information it sees.

--=20
Eduardo


