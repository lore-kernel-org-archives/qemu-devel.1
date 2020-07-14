Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E45C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227E721BE5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rv0lQqv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227E721BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGOm-0005FF-DU
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 04:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jvGO8-0004iI-Gp
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:34:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jvGO3-0001fG-M6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594715642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zlxy0rQ6/K4t0Q1OYaZSDiz/duInP9Xvimvz2MHQ4Xk=;
 b=Rv0lQqv38I/TT8Mdn2kOriojc+IMtJP2RHtj0XvFPLojTQpwPJOdOtH4/EfhJKSx8xAhFR
 YdHuGn3OhkFxxV21fzGeOz//cDmGm3T3Xn4MItqsJkE/WR1LVicn/pBeapw8BInNMkasqO
 01HJ2hRIcPkNqHzPg/eSGoUD+L7OnOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-Bmr10CMbPGiS9OYxBXsaMA-1; Tue, 14 Jul 2020 04:34:00 -0400
X-MC-Unique: Bmr10CMbPGiS9OYxBXsaMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EF91106B242;
 Tue, 14 Jul 2020 08:33:59 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-8.ams2.redhat.com [10.36.114.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 367CC1D9;
 Tue, 14 Jul 2020 08:33:58 +0000 (UTC)
Date: Tue, 14 Jul 2020 10:33:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.1] qemu-img resize: Require --shrink for shrinking
 all image formats
Message-ID: <20200714083356.GA5120@linux.fritz.box>
References: <20200710121717.28339-1-kwolf@redhat.com>
 <CAFEAcA-QXayeXzrAv5=5mJvRy-qC5FD3Z7AEw3ZW_UDAZ6V8-w@mail.gmail.com>
 <20200710124132.GF6641@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200710124132.GF6641@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:06:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.07.2020 um 14:41 hat Kevin Wolf geschrieben:
> Am 10.07.2020 um 14:33 hat Peter Maydell geschrieben:
> > On Fri, 10 Jul 2020 at 13:17, Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > QEMU 2.11 introduced the --shrink option for qemu-img resize to avoid
> > > accidentally shrinking images (commit 4ffca8904a3). However, for
> > > compatibility reasons, it was not enforced for raw images yet, but only
> > > a deprecation warning was printed. This warning has existed for long
> > > enough that we can now finally require --shrink for raw images, too, and
> > > error out if it's not given.
> > >
> > > Documentation already describes the state as it is after this patch.
> > >
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  qemu-img.c | 17 +++--------------
> > >  1 file changed, 3 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/qemu-img.c b/qemu-img.c
> > > index e3b2ec3e78..f6a2703039 100644
> > > --- a/qemu-img.c
> > > +++ b/qemu-img.c
> > > @@ -4011,20 +4011,9 @@ static int img_resize(int argc, char **argv)
> > >      }
> > >
> > >      if (total_size < current_size && !shrink) {
> > > -        warn_report("Shrinking an image will delete all data beyond the "
> > > -                    "shrunken image's end. Before performing such an "
> > > -                    "operation, make sure there is no important data there.");
> > > -
> > > -        if (g_strcmp0(bdrv_get_format_name(blk_bs(blk)), "raw") != 0) {
> > > -            error_report(
> > > -              "Use the --shrink option to perform a shrink operation.");
> > > -            ret = -1;
> > > -            goto out;
> > > -        } else {
> > > -            warn_report("Using the --shrink option will suppress this message. "
> > > -                        "Note that future versions of qemu-img may refuse to "
> > > -                        "shrink images without this option.");
> > > -        }
> > > +        error_report("Use the --shrink option to perform a shrink operation.");
> > 
> > I think it would be nice to retain this bit of text:
> > 
> > > -        warn_report("Shrinking an image will delete all data beyond the "
> > > -                    "shrunken image's end. Before performing such an "
> > > -                    "operation, make sure there is no important data there.");
> > 
> > ie, make the raw-shrink case be the same as the non-raw-shrink
> > case currently does.
> 
> I had this at first, but then the whole thing looked like a warning and
> I wasn't sure that it would still be understood as an error. (Which is
> of course a preexisting problem for non-raw.)
> 
> Maybe it becomes clearer if I just swap the order and print the error
> first and only then the warning?

I made this change and applied the patch to the block branch.

Kevin


