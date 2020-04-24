Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F3C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083E420724
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzOZy5OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083E420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRspL-0008Bd-6F
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 03:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRsoa-0007d4-9d
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRsoZ-0006Wy-7U
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:31:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32056
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRsoY-0006Nu-Oi
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587713516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2b3ALT7FBg5h9eKv71TKr2xbansaU8IGxTPxq5D2Z0=;
 b=SzOZy5OJ2P5vkNY0Vtm3gMqmglTCuJjvyfYo87aHv/1VmCL8afhlxoGlPe01KNiwySmZxq
 OqqospIu2+SMWFHYKNFefsSbYjplR6IYnkzRMCoSlMqT8GWX8tCgPQiOJMehce+evzTRPl
 NNcrJainuNg2/xFz+0y8JcatIuI27NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-G4O3gIHiMuC8FYMDl68yvA-1; Fri, 24 Apr 2020 03:31:52 -0400
X-MC-Unique: G4O3gIHiMuC8FYMDl68yvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE01A8014D5;
 Fri, 24 Apr 2020 07:31:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 743005D70C;
 Fri, 24 Apr 2020 07:31:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED81511358BC; Fri, 24 Apr 2020 09:31:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 08/13] qapi: Assert output visitors see only valid enum
 values
References: <20200423160036.7048-1-armbru@redhat.com>
 <20200423160036.7048-9-armbru@redhat.com>
 <75ecc321-7301-3c4c-c3be-741855d13e14@redhat.com>
Date: Fri, 24 Apr 2020 09:31:49 +0200
In-Reply-To: <75ecc321-7301-3c4c-c3be-741855d13e14@redhat.com> (Eric Blake's
 message of "Thu, 23 Apr 2020 12:56:17 -0500")
Message-ID: <87h7x9pcey.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/23/20 11:00 AM, Markus Armbruster wrote:
>> output_type_enum() fails when *obj is not a valid value of the enum
>> type.  Should not happen.  Drop the check, along with its unit tests.
>> qapi_enum_lookup()'s assertion still guards.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/qapi-visit-core.c              |  9 -------
>>   tests/test-qobject-output-visitor.c | 39 -----------------------------
>>   tests/test-string-output-visitor.c  | 19 --------------
>>   3 files changed, 67 deletions(-)
>
> Nice cleanup.
>
> The commit message implies adding an assertion; but in reality, the
> change is deleting dead code (because we already have the assertion in
> place).  Maybe it's worth updating the subject?

I tried to say it in the body: "qapi_enum_lookup()'s assertion still
guards."  I could replace that by "This unmasks qapi_enum_lookup()'s
assertion."  Okay?  Better ideas?

> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> -    /*
>> -     * TODO why is this an error, not an assertion?  If assertion:
>> -     * delete, and rely on qapi_enum_lookup()
>> -     */
>> -    if (value < 0 || value >=3D lookup->size) {
>> -        error_setg(errp, QERR_INVALID_PARAMETER, name ? name : "null");
>> -        return;
>> -    }
>
> The comment being deleted is what points out the assertion that
> already exists.

Thanks!


