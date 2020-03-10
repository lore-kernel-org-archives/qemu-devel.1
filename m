Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66689C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101BC21927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHQoj/GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101BC21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBnwY-0008IJ-91
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 19:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jBnvq-0007mu-4Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jBnvo-0007oE-1K
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:05:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49316
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jBnvn-0007nG-QL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583881498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1q0bjXuJxkjzFeH/WMLemMy+2HsDOjel1zYGYmqbKI=;
 b=fHQoj/GCEZYszIwyvoMokBtGO8wRDtTg5lZw33Zl0a6RqqaoHVnCjIby7AfiL2fADn4ChL
 wgsSAxHJ1NET5Z06VJ+nOuWaSviPr3uNkjJeW4ky8oMLfHbZ2lBA4jI/hzPA8oPr/dFqAb
 UI/s2GDo1WFfqJIkFtQpQdhnDbKjyow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-6-7grAvlMrOnv_vZbW-WHg-1; Tue, 10 Mar 2020 19:04:55 -0400
X-MC-Unique: 6-7grAvlMrOnv_vZbW-WHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A47E107ACC7;
 Tue, 10 Mar 2020 23:04:54 +0000 (UTC)
Received: from localhost (ovpn-122-18.rdu2.redhat.com [10.10.122.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEE9A60BF4;
 Tue, 10 Mar 2020 23:04:50 +0000 (UTC)
Date: Tue, 10 Mar 2020 19:04:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 02/16] hw/i386: Introduce X86CPUTopoInfo to contain
 topology info
Message-ID: <20200310230448.GJ1187748@habkost.net>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326542572.40452.15331466265190906874.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <158326542572.40452.15331466265190906874.stgit@naples-babu.amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 03, 2020 at 01:57:05PM -0600, Babu Moger wrote:
> This is an effort to re-arrange few data structure for better readability=
.
>=20
> 1. Add X86CPUTopoInfo which will have all the topology informations
>    required to build the cpu topology. There is no functional changes.
> 2. Introduce init_topo_info to initialize X86CPUTopoInfo members from
>    X86MachineState.
>=20
> There is no functional changes.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>

I was queueing this one, but I had to dequeue.  You forgot to
tests/test-x86-cpuid.c to use the new X86CPUTopoInfo argument.

--=20
Eduardo


