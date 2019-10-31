Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217BDCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 13:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD15920862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 13:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xaosgiuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD15920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQAe4-0005tq-QZ
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 09:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iQAcb-0003eD-GV
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iQAcY-0007Aa-Gc
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:36:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24590
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iQAcW-00078n-RN
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572528971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HofgZqCvk6WiGZ+EOChwGzwxCdve88vIW2QvyZeY1OM=;
 b=XaosgiuysnENkdhgXzXeAC/zYgok4HfXZ3nADFTPnlSa18F5zl/PR0a5etOiMyu2Hu4AXf
 NSGWBAJBRDlRr69u2c8OV+Fl7PR6Bv5Uo5Q7zLYDmiijzKGv9NaWomAiwFhe5H1t3bOXOd
 zj3K8dN8f+Pzg21uQpOYs4l9rcvGg88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-UODJJHsmOBW1HFBQVcho7A-1; Thu, 31 Oct 2019 09:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31D8D107ACC0;
 Thu, 31 Oct 2019 13:36:07 +0000 (UTC)
Received: from work-vm (ovpn-116-247.ams2.redhat.com [10.36.116.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EFBA19C7F;
 Thu, 31 Oct 2019 13:35:52 +0000 (UTC)
Date: Thu, 31 Oct 2019 13:35:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Han Han <hhan@redhat.com>
Subject: Re: [PATCH] fw_cfg: Allow reboot-timeout=-1 again
Message-ID: <20191031133549.GC3128@work-vm>
References: <20191025165706.177653-1-dgilbert@redhat.com>
 <87a79o4jjb.fsf@dusky.pond.sub.org> <20191028134700.GB2961@work-vm>
 <87lft3sqhf.fsf@dusky.pond.sub.org>
 <20191029125641.GC16329@work-vm>
 <CAHjf+S_KfDQeC_k997_PKSgP6v8LQgNh1HYt9JPRM-Ds+POADg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHjf+S_KfDQeC_k997_PKSgP6v8LQgNh1HYt9JPRM-Ds+POADg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: UODJJHsmOBW1HFBQVcho7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Karen Noel <knoel@redhat.com>, Jaroslav Suchanek <jsuchane@redhat.com>,
 philmd@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, kraxel@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Han Han (hhan@redhat.com) wrote:
> However, another important question is: how can we avoid such undocumente=
d
> incompatibility appears again?

The reboot-timeout one was accidental - it was a documented qemu
feature; just no one noticed it when the input check was added.
Officially if we actually want to deprecate a feature we should actually
follow qemu's deprecation guidelines.

> I can show another case caused by such incompatibile change:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1745868#c0
>=20
> For the qemu devices, attributes, values, qmp cmds, qmp cmds arguments us=
ed
> by libvirt, could we get a way to inform libvirt
> that an incompatibile qemu change is coming, please update libvirt code
> ASAP to adjust to that change?
> Or another way that is more gently:  popping up the warning of depreciati=
on
> instead of  dropping it, and then drop it in the version
> after next version.

Yes that should happen;  with deprecated devices it's easier than more
subtle features like command line things;  I'm not sure how that gets
introspected.  I thought libvirt already asked qemu for a list of
devices, so I'm confused why libvirt didn't spot it before starting the
VM in 1745868.

Dave

>=20
> On Tue, Oct 29, 2019 at 1:59 PM Dr. David Alan Gilbert <dgilbert@redhat.c=
om>
> wrote:
>=20
> > * Markus Armbruster (armbru@redhat.com) wrote:
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> > >
> > > > * Markus Armbruster (armbru@redhat.com) wrote:
> > > >> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> > > >>
> > > >> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > >> >
> > > >> > Commit ee5d0f89de3e53cdb0dc added range checking on reboot-timeo=
ut
> > > >> > to only allow the range 0..65535; however both qemu and libvirt
> > document
> > > >> > the special value -1  to mean don't reboot.
> > > >> > Allow it again.
> > > >> >
> > > >> > Fixes: ee5d0f89de3e53cdb0dc ("fw_cfg: Fix -boot reboot-timeout
> > error checking")
> > > >> > RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1765443
> > > >> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > >> > ---
> > > >> >  hw/nvram/fw_cfg.c | 5 +++--
> > > >> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >> >
> > > >> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > > >> > index 7dc3ac378e..1a9ec44232 100644
> > > >> > --- a/hw/nvram/fw_cfg.c
> > > >> > +++ b/hw/nvram/fw_cfg.c
> > > >> > @@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgState *s)
> > > >> >
> > > >> >      if (reboot_timeout) {
> > > >> >          rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", =
-1);
> > > >> > +
> > > >> >          /* validate the input */
> > > >> > -        if (rt_val < 0 || rt_val > 0xffff) {
> > > >> > +        if (rt_val < -1 || rt_val > 0xffff) {
> > > >> >              error_report("reboot timeout is invalid,"
> > > >> > -                         "it should be a value between 0 and
> > 65535");
> > > >> > +                         "it should be a value between -1 and
> > 65535");
> > > >> >              exit(1);
> > > >> >          }
> > > >> >      }
> > > >>
> > > >> Semantic conflict with "PATCH] qemu-options.hx: Update for
> > > >> reboot-timeout parameter", Message-Id:
> > > >> <20191015151451.727323-1-hhan@redhat.com>.
> > > >
> > > > Thanks for spotting that.
> > > > I think Han and also submitted patches to review it from libvirt
> > > > and it wasn't obvious what to do.  (Cc'd Han in).
> > > >
> > > >> I'm too tired right now to risk an opinion on which one we want.
> > > >
> > > > As is everyone else !  The problem here is that its documented
> > > > as a valid thing to do, and libvirt does it, and you might have
> > > > a current XML file that did it.  Now I think you could change libvi=
rt
> > > > to omit the reboot-timeout parameter if it was called with -1.
> > > >
> > > > So given its a documented thing in both qemu and libvirt xml
> > > > if we want to remove it then it sohuld be deprecated properly - but
> > it's
> > > > already broken.
> > >
> > > Since commit ee5d0f89d, v4.0.0.
> > >
> > > If that commit had not made it into a release, we'd certainly treat t=
he
> > > loss of "-1 means don't reboot" as regression.
> > >
> > > But it has.  We can treat it as a regression anyway.  We can also
> > > declare "ship has sailed".
> > >
> > > I'm leaning towads the former.
> > >
> > > If we restore "-1 means don't reboot", then I don't see a need to
> > > deprecate it.  Just keep it.
> > >
> > > What do you think?
> >
> > That's also my view; especially since the problem seems to be an easy
> > fix.
> >
> > Dave
> >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
>=20
>=20
> --=20
> Best regards,
> -----------------------------------
> Han Han
> Quality Engineer
> Redhat.
>=20
> Email: hhan@redhat.com
> Phone: +861065339333
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


