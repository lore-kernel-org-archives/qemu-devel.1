Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BEB2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkMK2hwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BEB2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZa7A-0007oB-3k
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZa6F-0007Hd-BP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZa6C-0004QO-41
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:37:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31566
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZa6B-0004PM-KT
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574771862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6M5mHkaCJeJ0Dx+5Y6PuUGWB3DKVftI182pbuMmu9Ic=;
 b=RkMK2hwLwB9YG7b6C0zcE4WGVSKrSblz/zhVZjyd+/ILDDk8XPV5Sa9HC5EvCtFpXDaOce
 jkJX4YhIO9GFvVUkTo9tfLcLTkFIH2hzhHp9vVY/GkXmz/2LFSwV0j6cwj5tUCzXrv7aSH
 YQQxZ5vfuIbA5gOXjb6h9AHcaUP2IkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-2nW5sgMuPtWv_k7rqrrcHQ-1; Tue, 26 Nov 2019 07:37:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 587D01099DB2;
 Tue, 26 Nov 2019 12:37:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 827475C1D8;
 Tue, 26 Nov 2019 12:37:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0DEC31138606; Tue, 26 Nov 2019 13:37:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v17 03/14] util/cutils: refactor do_strtosz() to support
 suffixes list
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-4-tao3.xu@intel.com>
 <87pnhgjubs.fsf@dusky.pond.sub.org>
 <20191125121531.GD4438@habkost.net>
 <87y2w37y2u.fsf@dusky.pond.sub.org>
 <20191126103315.GI556568@redhat.com>
Date: Tue, 26 Nov 2019 13:37:33 +0100
In-Reply-To: <20191126103315.GI556568@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Tue, 26 Nov 2019 10:33:15 +0000")
Message-ID: <87pnhe6cfm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 2nW5sgMuPtWv_k7rqrrcHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: lvivier@redhat.com, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 mst@redhat.com, sw@weilnetz.de, Tao Xu <tao3.xu@intel.com>, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 imammedo@redhat.com, jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Nov 26, 2019 at 11:04:41AM +0100, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>=20
>> > On Mon, Nov 25, 2019 at 08:20:23AM +0100, Markus Armbruster wrote:
>> >> Tao Xu <tao3.xu@intel.com> writes:
>> >>=20
>> >> > Add do_strtomul() to convert string according to different suffixes=
.
>> >> >
>> >> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> >> > Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> >>=20
>> >> What's the actual change here?  "Refactor" suggests the interfaces st=
ay
>> >> the same, only their implementation changes.  "Support suffixes list"
>> >> suggests some interface supports something new.
>> >
>> > 1) Parameters added to suffix_mul() (suffix table);
>> > 2) do_strtomul() is being extracted from do_strtosz().
>> >
>> > do_strtomul() interface and behavior stays the same.
>>=20
>> Alright, it's two related changes squashed together (which tends to
>> complicate writing good commit messages).  2) is really a refactoring.
>> 1) is not: it makes suffix_mul() more flexible.  Summarizing 1) and 2)
>> as "refactor do_strtosz() to support suffixes list" is confusing,
>> because it's about 1), while the interesting part is actually 2).
>>=20
>> Moreover, the commit message should state why these two changes are
>> useful.  It tries, but "to support suffixes list" merely kicks the can
>> down the road, because the reader is left to wonder why supporting
>> suffix lists is useful.  It's actually for use by the next patch.  So
>> say that.
>
> Test case additions to test-cutils.c would go a long way to illustrating
> what is added & that its working correctly.

Since this patch only prepares for new features, it doesn't need test
updates.  The next patch adds features, and it does update the tests.


