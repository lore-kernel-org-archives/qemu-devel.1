Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD22C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D6320661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTgNnQ0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D6320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCxQ-0002Pf-9T
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ixCwI-0001Dy-Cr
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ixCwG-0003P8-Kw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:45:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ixCwG-0003LT-2i
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580402706;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvffK6wvGez8mmfLGV3KAt0KsmfMEUdujHgjRO4RNG8=;
 b=fTgNnQ0/X/XOCEem31wU8wXwwTRasIdlHX2wMnEgTQRq7S2pAkvf0D38RpatTTYFSxQQLg
 G+VBFxq0Cl4saGjW9TFNDkeyypQfAkiBOs0acIXULXD72YYePGttQ/9Jn2PF9G+sm14D/e
 1GH7F1GiDK3veeFnQyVBzjOni8B11ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-P8C5FnN9NC-NsJBsseztZg-1; Thu, 30 Jan 2020 11:45:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4ECB190B2A0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:45:02 +0000 (UTC)
Received: from redhat.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A65460BE1;
 Thu, 30 Jan 2020 16:45:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2] git: Make submodule check only needed modules
In-Reply-To: <20200130163120.GR1891831@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 30 Jan 2020 16:31:20 +0000")
References: <20200130162810.14503-1-quintela@redhat.com>
 <20200130163120.GR1891831@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 30 Jan 2020 17:44:59 +0100
Message-ID: <87pnf0c2r8.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: P8C5FnN9NC-NsJBsseztZg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Jan 30, 2020 at 05:28:10PM +0100, Juan Quintela wrote:
>> If one is compiling more than one tree from the same source, it is
>> possible that they need different submodules.  Change the check to see
>> that all modules that we are interested in are updated, discarding the
>> ones that we don't care about.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>=20
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Should I send the pull request?

Later, Juan.


