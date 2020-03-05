Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03955C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 05:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2414208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 05:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkpbEUoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2414208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9jVA-0007Ww-RY
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 00:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9jUW-00075q-FG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 00:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9jUV-0001yx-DZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 00:56:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9jUV-0001yq-AB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 00:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583387774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pYFmiutsh3vI940txW/lAeviITO2r+2vTCUET3q5WE=;
 b=TkpbEUoZ5Y+A12Y69K+JNPooYos6+/UqgzYM8y63tOhDEddgW8EhD/xvNMe6ulA5DZErU7
 mq42nfQz4Fy7cflM/A3CnVX3gpAn3O05JVzqcgbZNKU8h0UJpEUvnbeL9d5rvRm9P/vGfw
 E2MH5NVD6FpYuau3SthD758qs4qOFFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-Lco-N_75Oou2H9D6IKEVpA-1; Thu, 05 Mar 2020 00:56:12 -0500
X-MC-Unique: Lco-N_75Oou2H9D6IKEVpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE22EDB60;
 Thu,  5 Mar 2020 05:56:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49F5146;
 Thu,  5 Mar 2020 05:56:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC93111386A6; Thu,  5 Mar 2020 06:56:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 4/4] qapi: Brush off some (py)lint
References: <20200304155932.20452-1-armbru@redhat.com>
 <20200304155932.20452-5-armbru@redhat.com>
 <896c42b1-eaeb-51bd-1dc3-ba5508431149@redhat.com>
Date: Thu, 05 Mar 2020 06:56:09 +0100
In-Reply-To: <896c42b1-eaeb-51bd-1dc3-ba5508431149@redhat.com> (John Snow's
 message of "Wed, 4 Mar 2020 15:33:48 -0500")
Message-ID: <87blpb1h1i.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: crosa@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 3/4/20 10:59 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/commands.py   |  2 +-
>>  scripts/qapi/expr.py       |  3 +--
>>  scripts/qapi/gen.py        |  9 ++++++---
>>  scripts/qapi/introspect.py |  2 --
>>  scripts/qapi/parser.py     |  6 ++----
>>  scripts/qapi/schema.py     | 11 +++++------
>>  6 files changed, 15 insertions(+), 18 deletions(-)
>>=20
>
> Looks okay. (I don't care as much about no-else-return being there or
> not, and this module is your baby.)

I admit I personally prefer to elide the else there.  But my main
argument is consistent style.  Picking the one pylint wants makes
consistency easier.

> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!


