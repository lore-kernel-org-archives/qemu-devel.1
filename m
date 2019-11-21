Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FCEC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E096B20674
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmCfrCPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E096B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXo4n-0002St-1Y
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXo3k-0001Yy-QD
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXo3i-0007QD-Pe
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:07:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXo3i-0007PM-Lz
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574348869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjIMR8kAUCZNQt0MnGI8WLQ5h5+Z52ER0l1AL7AjP9E=;
 b=LmCfrCPMkJGA4FGWXuIUrerfdzw44pF4OAjZxVm4/5QMJsHoYEmxVZklMaaw7+36YwGWqx
 5FRM197QLmqCOErLKUI4Yyd6EGLYOnUXYw8PYVuYFOoydd0C2aG3ntFv45ngIhZyNenNVi
 6+5vhdazYfY40Z9Ao5KAbKIZ+XcnNnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-qGzsot_0NqqzYixgyDLuBw-1; Thu, 21 Nov 2019 10:07:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23483DB76;
 Thu, 21 Nov 2019 15:07:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E320F537B8;
 Thu, 21 Nov 2019 15:07:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63D051138606; Thu, 21 Nov 2019 16:07:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/14] qapi: Introduce default values for
 struct members
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-4-mreitz@redhat.com>
Date: Thu, 21 Nov 2019 16:07:45 +0100
In-Reply-To: <20190624173935.25747-4-mreitz@redhat.com> (Max Reitz's message
 of "Mon, 24 Jun 2019 19:39:23 +0200")
Message-ID: <87eey1b73y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: qGzsot_0NqqzYixgyDLuBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> With this change, it is possible to give default values for struct
> members, as follows:
>
>   What you had to do so far:
>
>     # @member: Some description, defaults to 42.
>     { 'struct': 'Foo',
>       'data': { '*member': 'int' } }
>
>   What you can do now:
>
>     { 'struct': 'Foo',
>       'data': { '*member': { 'type': 'int', 'default': 42 } }

The '*' is redundant in this form.

Can anyone think of reasons for keeping it anyway?  Against?

> On the C side, this change would remove Foo.has_member, because
> Foo.member is always valid now.  The input visitor deals with setting
> it.  (Naturally, this means that such defaults are useful only for input
> parameters.)
>
> At least three things are left unimplemented:
>
> First, support for alternate data types.  This is because supporting
> them would mean having to allocate the object in the input visitor, and
> then potentially going through multiple levels of nested types.  In any
> case, it would have been difficult and I do not think there is need for
> such support at this point.
>
> Second, support for null.  The most important reason for this is that
> introspection already uses "'default': null" for "no default, but this
> field is optional".  The second reason is that without support for
> alternate data types, there is not really a point in supporting null.
>
> Third, full support for default lists.  This has a similar reason to the
> lack of support for alternate data types: Allocating a default list is
> not trivial -- unless the list is empty, which is exactly what we have
> support for.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>


