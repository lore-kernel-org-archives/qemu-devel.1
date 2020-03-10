Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCBFC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB3B24692
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gf1TM4PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB3B24692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBczn-0000ek-6z
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBcxt-0007Fw-1Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBcxr-0008Lb-V6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:22:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBcxr-0008IA-Qi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583839342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orKRIICRl/X/2gpnuqBGANKUENakTw/SkK+fEhxMH5I=;
 b=gf1TM4PRBr/jOZdantb5PpVt279w1X3JEoH00Ytja1gNlB7pDlPBf433Viqybq1WKEBjNB
 JQbui6s2GRKkUVq6suQO7GgUhr80o676o0H2DKPOvzKr51V3aoKvdS3b4lyAoBjKP8Dnx5
 8STd6jsX7iGZV9Kzzk6Er8zv66jemsg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-JJu_SSp0NxCwg6jmtI7qDw-1; Tue, 10 Mar 2020 07:22:20 -0400
X-MC-Unique: JJu_SSp0NxCwg6jmtI7qDw-1
Received: by mail-qv1-f71.google.com with SMTP id dr18so8838839qvb.14
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JgVJ2/81Ny8qYpmSIfmD4NToQk2NflPvnkhVl6Xhch4=;
 b=uKGvJee7bgyeLGJDs3ludhEh8znwbtSmoKcIwrB/lymtn3V0RlPbhP0e/Lr9OE4sFS
 7w5HbX8gW9weCqbSSdL2HruIPZNvHNKvkjj5dv+ULEwZfDD7SJ9u2FLLZj0xbSvRATpK
 awTymqKSe4UQXfB7YdsqMwcjAfMwUWJASq/N03BHDcBZGkgjq3JweFQccb9yWwkw7UDw
 p7rSpIG4TNqKvg24cSijrbdMQnyoy7RrBSVSpYEsndJVCw5udY3+MEQfcG7VAwOxW+da
 u4J6QGyrFo1u/Ryxc1zrJNIGGXgT15oLDW1NklXn0rigVbal1ctcVzNgHPjMBT6xCB0b
 SBnA==
X-Gm-Message-State: ANhLgQ0cD+OLfAeCd9NCDwh5Mwxhx0EenyCqXeex6f3xdyzq4VE0fFAh
 4kOt53/xx9PnQFvV/YFoszng27tl9U4N/P4F8vcbXq2+2FJdtpCPqJib1mZe5ppFvzAOSma0npY
 6PcMA13jBVJPfK5c=
X-Received: by 2002:a37:2794:: with SMTP id n142mr8892492qkn.336.1583839340019; 
 Tue, 10 Mar 2020 04:22:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvBOOfIQYZ8/3795jdH8cwUyhwD1mGPiyN7OjFyFB3X2IGBTVvAKs7AwlQ5llD69HmodZRAdg==
X-Received: by 2002:a37:2794:: with SMTP id n142mr8892476qkn.336.1583839339785; 
 Tue, 10 Mar 2020 04:22:19 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id u123sm5262541qkc.16.2020.03.10.04.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:22:18 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:22:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
Message-ID: <20200310071934-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-8-liran.alon@oracle.com>
 <20200310053305-mutt-send-email-mst@kernel.org>
 <9213671d-75e9-b4d6-6e3d-c9221c2b7cc4@oracle.com>
MIME-Version: 1.0
In-Reply-To: <9213671d-75e9-b4d6-6e3d-c9221c2b7cc4@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 01:13:21PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 11:34, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:54:04AM +0200, Liran Alon wrote:
> > > This is VMware documented functionallity that some guests rely on.
> > > Returns the BIOS UUID of the current virtual machine.
> > >=20
> > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > So this at least seems guest-visible.
> >=20
> > So I suspect you need to add properties to
> > disable this for old machine types, to avoid
> > breaking compatibility with live-migration.
>=20
> It is indeed guest visible.
> In theory, you are right that for every guest-visible change, we should m=
ake
> sure to expose it to only new machine-types.
>=20
> However, in this case, I feel it just unnecessary over-complicates the co=
de.
> I don't see how a guest which previously failed to use this command, will
> fail because after Live-Migration it could succeed.

The reverse can happen, start guest on a new qemu, command seems to
work, then we migrate and it fails.

And I guess this applies to the version right?

> If you insist, I will add such functionality. In that case, do you think =
a
> single flag will suffice for the addition of all new commands
> (i.e. "commands-version" that it's number specifies set of commands to
> expose), or you want to have a per-command flag?
>=20
> -Liran

Can be a single flag but I'd just do it a boolean that enables a group
of commands. E.g. "commands-v2".

--=20
MST


