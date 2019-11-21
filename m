Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30A3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD34820658
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaT4Nnxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD34820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXq6p-0003RJ-Dx
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iXq5b-0002YI-IO
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iXq5X-0005XW-Na
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:17:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33240
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iXq5T-0005Ua-Ro
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574356666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tfkc1ykSzBrR1TEkaAf6yfWT7gnlSyJ+Peb9RQ6oyMc=;
 b=FaT4NnxchIL+WCqk7eHulverEmnH+3dDxZcOrI/Lm1BrQ+FSsPDJmT9A3DjiEmwHrhmnOx
 9qCL6jOqt1LVAdwrweGGvjO3tk+EDQSbVi/voudQcIMHJ/lZ/ekQQkODWASRlwNPaVhI+1
 fAw+3bigL8sFbshJ23saJHrlfrO5Qs8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-7ZvXGBMVPxWdZeaixMDzug-1; Thu, 21 Nov 2019 12:17:37 -0500
Received: by mail-qk1-f198.google.com with SMTP id d18so2409577qkl.5
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jVoZgtdA6KpEzUybLpuIbYHi2sG5q97+IeMi5CvK+/M=;
 b=m1H+dCe4yQpObisdAux4MzsxUW/2QQ2eX04VgtZYdmfxDvTMVOljLg2ZjHyHkjAo//
 PTVpqMvAEWt5hxQZlcuZ9mKg3huXcv9k7qqGfnaN5SonNM35T+F4kHOh3sLRt8K4mkUf
 RUWQsEMMt0ZUEhDX4/GXj8S76nVRCWEc9vhL7IFiOZJ+bwgE/JXaKMY7lglR7zk++lfd
 LF1Fw7eelXbQYqaz2Y1WuUazxLOgYvD5aaSZSQy7eTuELTBXfLSeF4pgtdBmyePEtm5F
 0ysqnPlKTQB/SVUVjBdVWfBMUIbOLjglofljbMM400e1Mp9fCDw22+geckYRTgFKP04m
 MdLg==
X-Gm-Message-State: APjAAAUs2xe7FZNSc62a2ViUkTEkJzbFNdywUpmoJ38JCZ2Kzctrm4+x
 Fh0/pa3GJ81UUoyLsqz3DOGUGWHiuDNFWwUyaS9ZkpD3jDyGhW159JA7/bBi2/aKMEv2s5jLWEr
 tcU7BgZX/I7l5N10=
X-Received: by 2002:a05:620a:208d:: with SMTP id
 e13mr8806759qka.287.1574356657469; 
 Thu, 21 Nov 2019 09:17:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/yiXggTOzHs8fuFx8SKTCNOKBqd2pkZIrGVApxXZplS7zSUa984UOpJax9sUQTEkW8fntyQ==
X-Received: by 2002:a05:620a:208d:: with SMTP id
 e13mr8806736qka.287.1574356657235; 
 Thu, 21 Nov 2019 09:17:37 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id a4sm1641828qkk.113.2019.11.21.09.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 09:17:36 -0800 (PST)
Date: Thu, 21 Nov 2019 12:17:35 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] kvm: Reallocate dirty_bmap when we change a slot
Message-ID: <20191121171735.GE26741@xz-x1>
References: <20191121165645.33483-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191121165645.33483-1-dgilbert@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: 7ZvXGBMVPxWdZeaixMDzug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 04:56:45PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> kvm_set_phys_mem can be called to reallocate a slot by something the
> guest does (e.g. writing to PAM and other chipset registers).
> This can happen in the middle of a migration, and if we're unlucky
> it can now happen between the split 'sync' and 'clear'; the clear
> asserts if there's no bmap to clear.   Recreate the bmap whenever
> we change the slot, keeping the clear path happy.
>=20
> Typically this is triggered by the guest rebooting during a migrate.
>=20
> Corresponds to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1772774
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1771032
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

--=20
Peter Xu


