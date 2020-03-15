Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD83C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 16:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BBD206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRsvFDdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BBD206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDWai-0000sf-A4
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 12:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDWVm-0008KN-7K
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 12:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDWVh-0006OI-Sm
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 12:53:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDWVg-0006Fr-6F
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 12:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584291186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s96EE224y9m3WdpcXcecWW3EvUzTXxmkBvhgbQF+m3w=;
 b=dRsvFDdR1X6xdIopn3cQteKI/THlUg/IyW0G28tZ1Rc/W0tK3m6ToYX11JSZr91NNmg7KF
 axZs+knxthXErVYJz9lMvB/Ajh9mhc5JLs/12HSkRRxC6kvJl6hzU1ZU02AQ4xwjsm82n+
 3MwHGLngrfwL+GIV3a5GTLH5IBSJdXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-_lIprHn_N1C4V-HuF6i5mQ-1; Sun, 15 Mar 2020 12:53:04 -0400
X-MC-Unique: _lIprHn_N1C4V-HuF6i5mQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E6B13F5;
 Sun, 15 Mar 2020 16:53:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C3241001B34;
 Sun, 15 Mar 2020 16:53:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B20601138404; Sun, 15 Mar 2020 17:53:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 25/34] qapi: New special feature flag "deprecated"
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-26-armbru@redhat.com>
 <6af79067-2631-c12d-5643-fbc78bfb1bcf@redhat.com>
Date: Sun, 15 Mar 2020 17:53:01 +0100
In-Reply-To: <6af79067-2631-c12d-5643-fbc78bfb1bcf@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun, 15 Mar 2020 16:49:37
 +0100")
Message-ID: <87o8sx4l1u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 3/15/20 3:46 PM, Markus Armbruster wrote:
>> Unlike regular feature flags, the new special feature flag
>> "deprecated" is recognized by the QAPI generator.  For now, it's only
>> permitted with commands, events, and struct members.  It will be put
>> to use shortly.
>
> What about using a '@DeprecatedSince' tag?
> Ah, that would apply to the whole structure and not a particular member..=
.
>
> I am wondering because sometimes we deprecate something for 2 releases
> but then once the deadline passed we forgot to remove it. Having the
> release version deadline along with deprecation would help automating
> removal checks.
> Maybe we can use a tag with release version, such 'deprecated_since:5.0'?

Intended consumer for "since <version>" information?

So far, it's been just developers.  Searching the QAPI schema for
deprecated stuff past its grace period hasn't been the problem;
remembering to search for it has been.


