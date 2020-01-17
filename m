Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99717C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669632072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTUjTaV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669632072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isOk7-0005T6-Jh
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1isOjS-00051P-GH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mszeredi@redhat.com>) id 1isOjO-0006ed-4f
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:20:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mszeredi@redhat.com>) id 1isOjN-0006dO-U4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579256396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHCE37nFJLmVidUAZB6boOVKuBXUfksbG87JYOGeO+8=;
 b=RTUjTaV5bmsaL8uu1DXl1q2JMwV6BonC24OrFPz1z0O6mgvGQcqDMHCJFkwRhjrCzPPEoC
 zXnvSoJkSErkej+rik3N1loMaDSWefmsoqjl+OwQCDbzMSV8GitV9Kn+XG8YmH3XT6obsi
 rhJ5Ojn4rl0vAkUNAbq1YRnpZlht2jM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-gikY7e-hOdC_PLUctYQTBQ-1; Fri, 17 Jan 2020 05:19:55 -0500
Received: by mail-io1-f71.google.com with SMTP id d10so14845698iod.19
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 02:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WjhOne+MEOOT/CkKKaKV+EI+4cHrZ5ufoDIXkZDsqNI=;
 b=aqtEyVcRVRRDxpLY4ISUdF/GspSpWlNJ8/ai14cyJdXQnGVW+SFQu5cHG53sSLxXlX
 dY5iNebyr0ZsUPCCAKH+eMgbBRYJKBH+qYVmniQrZQMt/d6qGMJEUBeW2bQOr+lm7/V0
 NcquqtnwZ178k3pqb5pIJ9Nw3UDBSoOaIavEU02Vq1pgFx8gOrTU5RJjKxizhVLKddpa
 6oLy71EOHmYDVB28jTahpYX6OGOX8G0p4OKmpLr+WkAA4+kYloHBZPVP7TQb+gT5ucik
 mUOPOIdEfstTkamv3iCjaACTWbWRksGUGXl5kIMfdq8bSyviCd3fnUl7QUentOiimxNg
 gDPQ==
X-Gm-Message-State: APjAAAWGsueJrg3BbG8yxVKA5/YKbbygmwN+4U1Qu2kh9YeQiDNA7T3P
 hhlDA4ZuNYs5OxuOvspKjlgIhg8IADLvfb5+EBJVOhukDSzjqHXXUZ+XQ+lnm285bff6zFTUBuI
 ZNjIRtNvokifsRboQ9ktV37UlIlfxT/I=
X-Received: by 2002:a92:9c04:: with SMTP id h4mr2523839ili.6.1579256395193;
 Fri, 17 Jan 2020 02:19:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwY4raw0OA2mIDE5tPBgp1K75idkOIdIHy0hQw9+Ob/WmSWDXwCd90bGmcUEUGYv448lx4bQi+Mmc5DQsPo3dg=
X-Received: by 2002:a92:9c04:: with SMTP id h4mr2523830ili.6.1579256394969;
 Fri, 17 Jan 2020 02:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20191212163904.159893-73-dgilbert@redhat.com>
 <20200116115603.5415-1-misono.tomohiro@jp.fujitsu.com>
 <20200116164511.GJ3108@work-vm>
In-Reply-To: <20200116164511.GJ3108@work-vm>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Fri, 17 Jan 2020 11:19:43 +0100
Message-ID: <CAOssrKfO1PZkR-Fonxae_b2oAOQMgx0=vU8A2UvCNKsgthKMbg@mail.gmail.com>
Subject: Re: [PATCH 072/104] virtiofsd: passthrough_ll: fix refcounting on
 remove/rename
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-MC-Unique: gikY7e-hOdC_PLUctYQTBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Vivek Goyal <vgoyal@redhat.com>,
 Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 5:45 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > > From: Miklos Szeredi <mszeredi@redhat.com>
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> >
> > I'm not familiar with qemu convention but shouldn't we put
> > at least one line of description like linux kernel?
>
> Miklos: would you like to suggest a better commit message?

Hmm, the patch doesn't really make sense, since the looked up inode is not =
used.

Not sure what happened here, this seems to be for supporting shared
versions, and these changes are part of commit 06f78a397f00
("virtiofsd: add initial support for shared versions") in our gitlab
qemu tree.  Was this intentionally split out?

Thanks,
Miklos


