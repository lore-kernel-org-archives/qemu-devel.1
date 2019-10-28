Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB90CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C2020862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/O5K245"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C2020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP5P1-0001rn-LU
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iP5Mv-0007ZV-8v
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iP5Ms-0004eE-5e
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:47:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iP5Mq-0004ai-84
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572270450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04ak9+iAXKXlIPHe5jOdH/Bnj/T7KxGCZP9hE3yrvN8=;
 b=d/O5K245iB9gn+1J8NgPRUa883yTO8aETS0lai+6bm4tDAT2FvA0sQ1zqRjIUXyn+eEKYJ
 XVtrUYa1bgrg/HcylD/Tr42K9YCgjQRMfRegkyJBqFnoLKzLrHb+q/jOS2yJH/1Fp0pR/G
 yOakTCFgGDEnjVzQAH9/QyVhjK1DQlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-gP3mlhGmNmGUMqnPzKP3sw-1; Mon, 28 Oct 2019 09:47:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B95DC180496F;
 Mon, 28 Oct 2019 13:47:25 +0000 (UTC)
Received: from work-vm (ovpn-116-216.ams2.redhat.com [10.36.116.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E654600D5;
 Mon, 28 Oct 2019 13:47:11 +0000 (UTC)
Date: Mon, 28 Oct 2019 13:47:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, hhan@redhat.com
Subject: Re: [PATCH] fw_cfg: Allow reboot-timeout=-1 again
Message-ID: <20191028134700.GB2961@work-vm>
References: <20191025165706.177653-1-dgilbert@redhat.com>
 <87a79o4jjb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87a79o4jjb.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: gP3mlhGmNmGUMqnPzKP3sw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: lersek@redhat.com, liq3ea@gmail.com, philmd@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
>=20
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Commit ee5d0f89de3e53cdb0dc added range checking on reboot-timeout
> > to only allow the range 0..65535; however both qemu and libvirt documen=
t
> > the special value -1  to mean don't reboot.
> > Allow it again.
> >
> > Fixes: ee5d0f89de3e53cdb0dc ("fw_cfg: Fix -boot reboot-timeout error ch=
ecking")
> > RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1765443
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/nvram/fw_cfg.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > index 7dc3ac378e..1a9ec44232 100644
> > --- a/hw/nvram/fw_cfg.c
> > +++ b/hw/nvram/fw_cfg.c
> > @@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgState *s)
> > =20
> >      if (reboot_timeout) {
> >          rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", -1);
> > +
> >          /* validate the input */
> > -        if (rt_val < 0 || rt_val > 0xffff) {
> > +        if (rt_val < -1 || rt_val > 0xffff) {
> >              error_report("reboot timeout is invalid,"
> > -                         "it should be a value between 0 and 65535");
> > +                         "it should be a value between -1 and 65535");
> >              exit(1);
> >          }
> >      }
>=20
> Semantic conflict with "PATCH] qemu-options.hx: Update for
> reboot-timeout parameter", Message-Id:
> <20191015151451.727323-1-hhan@redhat.com>.

Thanks for spotting that.
I think Han and also submitted patches to review it from libvirt
and it wasn't obvious what to do.  (Cc'd Han in).

> I'm too tired right now to risk an opinion on which one we want.

As is everyone else !  The problem here is that its documented
as a valid thing to do, and libvirt does it, and you might have=20
a current XML file that did it.  Now I think you could change libvirt
to omit the reboot-timeout parameter if it was called with -1.

So given its a documented thing in both qemu and libvirt xml
if we want to remove it then it sohuld be deprecated properly - but it's
already broken.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


