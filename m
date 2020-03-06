Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB4FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2E521D56
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vyrs+A/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2E521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACV2-0003U5-3g
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jACU7-0002vO-SY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jACU6-0003uL-RD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:53:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53780
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jACU6-0003qU-M2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583499225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHBqnY5BA6JYzaFAPYEl+m0ZIW6C7prezsJU9x9zSao=;
 b=Vyrs+A/7S6kQ4YNWv3nAtQl3ybltYUVbheoPRidftDNI4/fifGcbYZ16pYBt5JCoszhGOG
 Qv4hE2DiqB06/2/u/QPMSpyl7vQeVuglOqACTlqBU/FKtCp+6cta11X58BcWGCYKyEnczL
 xcUbNuyLlp7JQKu7B+LMOP/jhdRDOX8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-7Z6HkfDBMIytBcc5w7T69g-1; Fri, 06 Mar 2020 07:53:40 -0500
X-MC-Unique: 7Z6HkfDBMIytBcc5w7T69g-1
Received: by mail-wm1-f72.google.com with SMTP id y18so3746275wmi.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 04:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KHBqnY5BA6JYzaFAPYEl+m0ZIW6C7prezsJU9x9zSao=;
 b=bb4b7drvxiIVE++gkNaDzqct4BypE5uN8HqjmhCR4V2KYLquNkQQamzktItFEjZ358
 cK192ZYZuPrmoiFSyYWuEK/JlBW66c58yUetXeA85+KA+If5IhOnv+QB1ZYl8Gmgr0b0
 JbxnsGO28l8pPSb3DOCtQuqmC2Yx0O1Xx0DsvMItfzIowrey8ry1XGWhZRewe6rImqk/
 ibgORgOYPm+ujmnF20gC8dLk1MAV4eNOetxVHY0IkjS57huh2QYi+gygwfIFMfKYygU/
 MqKmyIyjUWbJGC94b1Es6bt9rlAIvRzrnxENos6rZ7pMcS2WFCL2yDPIuQwPdnJH7ZJA
 O5Rg==
X-Gm-Message-State: ANhLgQ2jmrAooSjQVw1oVg6E7k/pKlbi42iqWI2MuthKyLaekGb6QUAt
 ggRM2b67hC18M8b8E/eq0wr6ypK/1OT7MnIlMjeSg03QUD8BCYWwumNqiOwXYkdsR8n6sUZw0Te
 +yMtXQbpfFzxxOL6KObNpPMfLDhrTU5s=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr3992126wmd.39.1583499219415; 
 Fri, 06 Mar 2020 04:53:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsNdCBgqTbREGyk32+vJCX2tu5eZ35oZ4BtJKcVg1aTPaAU/RZZdTY5GWV9HEfoHTAbNwMQAdquXqbu3//gVJA=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr3992116wmd.39.1583499219173; 
 Fri, 06 Mar 2020 04:53:39 -0800 (PST)
MIME-Version: 1.0
References: <b4440411-cc60-cd7e-988e-458baf0c8b6d@xcancerberox.com.ar>
 <CAAdtpL4Fg3rjxOXxGA=sSLpsXrT1E0Ko1kjt1YugvRCtKPi-hw@mail.gmail.com>
 <20200306125155.GJ1335569@stefanha-x1.localdomain>
In-Reply-To: <20200306125155.GJ1335569@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 6 Mar 2020 13:53:28 +0100
Message-ID: <CAP+75-UUUPgYcC0FCyw-PTf92n3sNtEJj97-PYAhvBS9Qoq1JA@mail.gmail.com>
Subject: Re: Wiki user request
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 6, 2020 at 1:52 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Wed, Mar 04, 2020 at 12:57:14PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Ping?
>
> Joaquin's account has been created.
>
> Any QEMU wiki user can create accounts for other people!  Log in and go
> to https://wiki.qemu.org/Special:SpecialPages and click the create
> account link.

I didn't know, thanks :)

>
> Stefan


