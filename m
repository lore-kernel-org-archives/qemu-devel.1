Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C59BCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 13:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448FD20856
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 13:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Us3Mb6IM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448FD20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPRL2-00040c-Gl
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 09:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iPRJD-0002Br-Uj
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 09:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iPR5c-0004vx-Jt
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:59:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35207
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iPR5c-0004vf-EH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572353951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IT1aPRF+1g7Z8aX2+tr2mCf+DyouEE6m2YdtgYq10r8=;
 b=Us3Mb6IMDEHWFHNmcku+W8XiinnhDozcv7Jmhvs1xE5zw/MKeX3eWXUpVCwAUUEBnVf1o6
 4CGifMMhm4oLnUyqavK3QsCvL4u3KZdTRh2GbrKNdFGxnf07ylQf3+yZXmWXR1VPv6H5d7
 55ZClEWEFDUmaiLTkQa6AOYyTbC28y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-dqC57J3BPn2GAqJAOpd1-g-1; Tue, 29 Oct 2019 08:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C459C801E64;
 Tue, 29 Oct 2019 12:59:08 +0000 (UTC)
Received: from work-vm (ovpn-116-79.ams2.redhat.com [10.36.116.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38AF260863;
 Tue, 29 Oct 2019 12:56:49 +0000 (UTC)
Date: Tue, 29 Oct 2019 12:56:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] fw_cfg: Allow reboot-timeout=-1 again
Message-ID: <20191029125641.GC16329@work-vm>
References: <20191025165706.177653-1-dgilbert@redhat.com>
 <87a79o4jjb.fsf@dusky.pond.sub.org> <20191028134700.GB2961@work-vm>
 <87lft3sqhf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lft3sqhf.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: dqC57J3BPn2GAqJAOpd1-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: philmd@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, lersek@redhat.com, hhan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>=20
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> >>=20
> >> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> >
> >> > Commit ee5d0f89de3e53cdb0dc added range checking on reboot-timeout
> >> > to only allow the range 0..65535; however both qemu and libvirt docu=
ment
> >> > the special value -1  to mean don't reboot.
> >> > Allow it again.
> >> >
> >> > Fixes: ee5d0f89de3e53cdb0dc ("fw_cfg: Fix -boot reboot-timeout error=
 checking")
> >> > RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1765443
> >> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> > ---
> >> >  hw/nvram/fw_cfg.c | 5 +++--
> >> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> >> > index 7dc3ac378e..1a9ec44232 100644
> >> > --- a/hw/nvram/fw_cfg.c
> >> > +++ b/hw/nvram/fw_cfg.c
> >> > @@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgState *s)
> >> > =20
> >> >      if (reboot_timeout) {
> >> >          rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", -1);
> >> > +
> >> >          /* validate the input */
> >> > -        if (rt_val < 0 || rt_val > 0xffff) {
> >> > +        if (rt_val < -1 || rt_val > 0xffff) {
> >> >              error_report("reboot timeout is invalid,"
> >> > -                         "it should be a value between 0 and 65535"=
);
> >> > +                         "it should be a value between -1 and 65535=
");
> >> >              exit(1);
> >> >          }
> >> >      }
> >>=20
> >> Semantic conflict with "PATCH] qemu-options.hx: Update for
> >> reboot-timeout parameter", Message-Id:
> >> <20191015151451.727323-1-hhan@redhat.com>.
> >
> > Thanks for spotting that.
> > I think Han and also submitted patches to review it from libvirt
> > and it wasn't obvious what to do.  (Cc'd Han in).
> >
> >> I'm too tired right now to risk an opinion on which one we want.
> >
> > As is everyone else !  The problem here is that its documented
> > as a valid thing to do, and libvirt does it, and you might have=20
> > a current XML file that did it.  Now I think you could change libvirt
> > to omit the reboot-timeout parameter if it was called with -1.
> >
> > So given its a documented thing in both qemu and libvirt xml
> > if we want to remove it then it sohuld be deprecated properly - but it'=
s
> > already broken.
>=20
> Since commit ee5d0f89d, v4.0.0.
>=20
> If that commit had not made it into a release, we'd certainly treat the
> loss of "-1 means don't reboot" as regression.
>=20
> But it has.  We can treat it as a regression anyway.  We can also
> declare "ship has sailed".
>=20
> I'm leaning towads the former.
>=20
> If we restore "-1 means don't reboot", then I don't see a need to
> deprecate it.  Just keep it.
>=20
> What do you think?

That's also my view; especially since the problem seems to be an easy
fix.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


