Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB58C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92642073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+hnB2pH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92642073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVatT-0004Co-TA
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVasl-0003YT-Aa
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:11:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVash-0005e7-VS
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588597894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7JgEI7TR3OEFegI0dxTvConAJ/P1XGEgG/FbppwLT8=;
 b=a+hnB2pHjKr5zHw0F8yoiFeNnKHhy35qEC4Kdwavy+iswILKQ85d39jqMrf47A+QVaOzKL
 oPanRBoJsSkIp+ImdNE7q4t0AI7b/kRfjubibjFzc7p10bCWyZG6OyC/EwZR2274N7uD3p
 3bY+XLpMVw7gXq21hKbZhboYpr0nYz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-Y-VphjTUMI-wv8NILuVolg-1; Mon, 04 May 2020 09:11:33 -0400
X-MC-Unique: Y-VphjTUMI-wv8NILuVolg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A829A0C13;
 Mon,  4 May 2020 13:11:32 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 641A45C1BD;
 Mon,  4 May 2020 13:11:30 +0000 (UTC)
Message-ID: <3f97d41b50f923c068880f717effdf4e25d58a92.camel@redhat.com>
Subject: Re: [PATCH] Fix iotest 153
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 04 May 2020 16:11:29 +0300
In-Reply-To: <d4bb0d5e-615c-eac9-d0cd-5e8ad1e1d07a@redhat.com>
References: <20200503164943.27215-1-mlevitsk@redhat.com>
 <ae56957e-090c-0d8d-0499-4e1b97e615e0@redhat.com>
 <93921c24cdb5f70b3d836500bf0d3836c8a9fbb1.camel@redhat.com>
 <d4bb0d5e-615c-eac9-d0cd-5e8ad1e1d07a@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-05-04 at 15:08 +0200, Max Reitz wrote:
> On 04.05.20 11:41, Maxim Levitsky wrote:
> > On Mon, 2020-05-04 at 11:22 +0200, Max Reitz wrote:
> > > On 03.05.20 18:49, Maxim Levitsky wrote:
> > > > Commit f62514b3def5fb2acbef64d0e053c0c31fa45aff made qemu-img rejec=
t -o "" but this test uses it
> > > >=20
> > > > Since this test only tries to do a dry-run run of qemu-img amend, r=
eplace the -o "" with
> > > > dummy -o "size=3D0" since due to the nature of the test, it is not =
going
> > > > to reach the actual amend operation anyway
> > > >=20
> > > > Fixes: f62514b3def5fb2acbef64d0e053c0c31fa45aff
> > > >=20
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  tests/qemu-iotests/153     |  2 +-
> > > >  tests/qemu-iotests/153.out | 12 ++++++------
> > > >  2 files changed, 7 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> > > > index 2b13111768..3f5029dd8f 100755
> > > > --- a/tests/qemu-iotests/153
> > > > +++ b/tests/qemu-iotests/153
> > > > @@ -122,7 +122,7 @@ for opts1 in "" "read-only=3Don" "read-only=3Do=
n,force-share=3Don"; do
> > > >          _run_cmd $QEMU_IMG check       $L "${TEST_IMG}"
> > > >          _run_cmd $QEMU_IMG compare     $L "${TEST_IMG}" "${TEST_IM=
G}"
> > > >          _run_cmd $QEMU_IMG map         $L "${TEST_IMG}"
> > > > -        _run_cmd $QEMU_IMG amend -o "" $L "${TEST_IMG}"
> > > > +        _run_cmd $QEMU_IMG amend -o "size=3D0" $L "${TEST_IMG}"
> > >=20
> > > AFAIU we don=E2=80=99t want this command to actually change the image=
 (hence the
> > > empty options list, which would result in nothing being changed), so
> > > maybe "size=3D$size" would be more in the spirit of the test?
> >=20
> > This is a good idea! Should I resend the patch or you can add this chan=
ge locally?
>=20
> Fixing it up locally should actually rather be the exception than the
> rule.  It makes sense for larger series where resending it just for one
> little thing generates too much noise, but in this case I don=E2=80=99t t=
hink
> sending a v2 would hurt.
>=20
> Max
>=20
V2 is on the way then!

Best regards,
=09Maxim Levitsky


