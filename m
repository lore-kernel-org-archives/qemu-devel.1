Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D9AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCA120823
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGZ2+k9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCA120823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ8ib-000363-RZ
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 02:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZ8fn-00015e-EH
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 02:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZ8fk-0003FA-67
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 02:20:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59946
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZ8fj-0003Eq-T9
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 02:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574666434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slCFMBqnKk9gBZVCjpRi4Queq/Fk8X1Qm4c5A9G6Pv0=;
 b=hGZ2+k9b5ziKRhXORCPFr38RkeE0Ms4FCFXobmTj1zM6IVTUJ2DkHlTy64ORMv5N0p+BcA
 XDcXiRKh/irSrrUeKceQW2hr6S4yiWPgY4sM7O01X24+JQiUGB1ywv7tQYBj6MMKj6JTo5
 NZunh1zxn9rCsF4riBVuWBItyNAcIBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-WEMeQlgqOE2h6yfoWtu1iA-1; Mon, 25 Nov 2019 02:20:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F4236801E5A;
 Mon, 25 Nov 2019 07:20:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6611D60863;
 Mon, 25 Nov 2019 07:20:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCDF91138606; Mon, 25 Nov 2019 08:20:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 03/14] util/cutils: refactor do_strtosz() to support
 suffixes list
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-4-tao3.xu@intel.com>
Date: Mon, 25 Nov 2019 08:20:23 +0100
In-Reply-To: <20191122074826.1373-4-tao3.xu@intel.com> (Tao Xu's message of
 "Fri, 22 Nov 2019 15:48:15 +0800")
Message-ID: <87pnhgjubs.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WEMeQlgqOE2h6yfoWtu1iA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> Add do_strtomul() to convert string according to different suffixes.
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

What's the actual change here?  "Refactor" suggests the interfaces stay
the same, only their implementation changes.  "Support suffixes list"
suggests some interface supports something new.


