Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F033C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5D52073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtjR7HGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5D52073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZY7l-0008AF-02
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZXsT-0005R4-RT
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZXiG-00017p-Sz
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:04:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZXiG-00017J-Pj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574762690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcgV5nUGY6qSF67eIFoj07CtVtZBZFfJ2ofaNZP5R50=;
 b=MtjR7HGevod5tLJ1r2TM67BThG5dCnQ2lvyqMeXujzqdSXA2zcF3BpoNsNFxqC9/Foir6S
 tkk9mhAErFw03I0fSxFLht27GXJCGwANv24t11mUdFEOlbsotxCLWL+jeqCMp81Ysu/Nsj
 3eJZyq5PFUrObXlP4HK3AEVtlWddfKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-zkxcDclZP96i1Kp5huwFsw-1; Tue, 26 Nov 2019 05:04:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38139184CAA2;
 Tue, 26 Nov 2019 10:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 418211001DC0;
 Tue, 26 Nov 2019 10:04:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C056F1138606; Tue, 26 Nov 2019 11:04:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v17 03/14] util/cutils: refactor do_strtosz() to support
 suffixes list
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-4-tao3.xu@intel.com>
 <87pnhgjubs.fsf@dusky.pond.sub.org>
 <20191125121531.GD4438@habkost.net>
Date: Tue, 26 Nov 2019 11:04:41 +0100
In-Reply-To: <20191125121531.GD4438@habkost.net> (Eduardo Habkost's message of
 "Mon, 25 Nov 2019 09:15:31 -0300")
Message-ID: <87y2w37y2u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: zkxcDclZP96i1Kp5huwFsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, sw@weilnetz.de,
 Tao Xu <tao3.xu@intel.com>, fan.du@intel.com, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, imammedo@redhat.com,
 jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Nov 25, 2019 at 08:20:23AM +0100, Markus Armbruster wrote:
>> Tao Xu <tao3.xu@intel.com> writes:
>>=20
>> > Add do_strtomul() to convert string according to different suffixes.
>> >
>> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> > Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>=20
>> What's the actual change here?  "Refactor" suggests the interfaces stay
>> the same, only their implementation changes.  "Support suffixes list"
>> suggests some interface supports something new.
>
> 1) Parameters added to suffix_mul() (suffix table);
> 2) do_strtomul() is being extracted from do_strtosz().
>
> do_strtomul() interface and behavior stays the same.

Alright, it's two related changes squashed together (which tends to
complicate writing good commit messages).  2) is really a refactoring.
1) is not: it makes suffix_mul() more flexible.  Summarizing 1) and 2)
as "refactor do_strtosz() to support suffixes list" is confusing,
because it's about 1), while the interesting part is actually 2).

Moreover, the commit message should state why these two changes are
useful.  It tries, but "to support suffixes list" merely kicks the can
down the road, because the reader is left to wonder why supporting
suffix lists is useful.  It's actually for use by the next patch.  So
say that.

I'll review the actual patch now.


