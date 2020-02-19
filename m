Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588E0C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F2D207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fI4d12tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F2D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QoT-00045T-AQ
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j4QnK-0002Sc-26
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j4QnI-0005dS-Lu
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:57:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j4QnI-0005d4-Hl
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582124264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5i0bYGI2Qqaxgl8TlI49IXiVSpNYG6jcrYN0KNd3fI=;
 b=fI4d12tt4ITtZYNJJJCERV7KC7rF3wqa43TSO61btna4TbQSOgXfyKHEWvwMy8Tk2jzvAI
 IbohHxIEMJUKf1wm9pzB/b2MD3lRFnr2ez6yabrFrd0GhsKv6YnGOnWLElLtcLR0cgZ3XL
 EoUMWnpUtyZa2YMtf03cZPftHJmqyEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-E8lLcxGFOWmGydQI2BzVmg-1; Wed, 19 Feb 2020 09:57:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92C7F1034B20;
 Wed, 19 Feb 2020 14:57:37 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A9C886CCC;
 Wed, 19 Feb 2020 14:57:36 +0000 (UTC)
Date: Wed, 19 Feb 2020 15:57:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Subject: Re: [PATCH v5 2/4] vl: Initialise main loop earlier
Message-ID: <20200219145734.GB6464@linux.fritz.box>
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-3-kwolf@redhat.com>
 <20200219140739.tfn7p5xsbxofoajq@olga.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <20200219140739.tfn7p5xsbxofoajq@olga.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: E8lLcxGFOWmGydQI2BzVmg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.02.2020 um 15:07 hat Wolfgang Bumiller geschrieben:
> On Tue, Feb 18, 2020 at 04:40:34PM +0100, Kevin Wolf wrote:
> > We want to be able to use qemu_aio_context in the monitor
> > initialisation.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  vl.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/vl.c b/vl.c
> > index 794f2e5733..98bc51e089 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2894,6 +2894,11 @@ int main(int argc, char **argv, char **envp)
> >      runstate_init();
> >      precopy_infrastructure_init();
> >      postcopy_infrastructure_init();
> > +
> > +    if (qemu_init_main_loop(&main_loop_err)) {
> > +        error_report_err(main_loop_err);
> > +        exit(1);
> > +    }
> >      monitor_init_globals();
>=20
> This is a tiny bit scary, as we now have around 1kloc of code between
> here and os_daemonize() where in the future we may accidentally cause
> the aio context's on-demand thread pool to spawn before fork()ing
> (silently losing the threads again - we did have such an issue right
> there in monitor_init_globals() in the past)

I don't think it's that bad, because while it is many lines, it's just
boring option parsing code. I certainly don't think it's likely to start
using a thread pool anywhere.

However, I also wonder now if this patch is actually necessary. Maybe
some intermediate version of the series actually used qemu_aio_context
in monitor_init_globals_core(), but none of the versions actually sent
to the list do. They all use iohandler_get_aio_context(), which should
be safe before the main loop is initialised. To make sure that I didn't
miss anything, 'make check' passes without the patch.

So maybe we can just drop this patch after all.

Kevin


