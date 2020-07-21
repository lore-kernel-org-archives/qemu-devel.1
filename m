Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F4CC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833CC206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmyKlOWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833CC206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsfa-0002Ga-Kn
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxsel-0001gW-BH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:50:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38751
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxsej-0006lq-0P
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595339403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XlAZVJANpsQV4X2EMdYtbXN/w9Xgc7IuSuUj5cUcH/M=;
 b=GmyKlOWl6/Po6bhnI7A/i9dGALIR0o33CNbJ7mHcSudE+kbVX5CAAtpM/zdq8svmEJzLcR
 gbwelCGxU7fCYAYqBUj/CXHsjVJ9HUwr3UnnctMX8YnGoJ8UOvGYp9YYfk9GWIlBkVEShs
 vAwjBQQnnM+ULqGaA7xSIDgkZFbN6dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-yX__RCx1PI6X1N5rNwkt5Q-1; Tue, 21 Jul 2020 09:50:01 -0400
X-MC-Unique: yX__RCx1PI6X1N5rNwkt5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 855DE805B03;
 Tue, 21 Jul 2020 13:50:00 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90C8D5D9D3;
 Tue, 21 Jul 2020 13:49:59 +0000 (UTC)
Date: Tue, 21 Jul 2020 15:49:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH for-5.1 2/2] iotests: Test sparseness for qemu-img
 convert -n
Message-ID: <20200721134958.GB18481@linux.fritz.box>
References: <20200720131810.177978-1-kwolf@redhat.com>
 <20200720131810.177978-3-kwolf@redhat.com>
 <CAMRbyyswk69PWmpAB3isGDrsbBuVwchhsFGNhiPx2PD3eezPOA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMRbyyswk69PWmpAB3isGDrsbBuVwchhsFGNhiPx2PD3eezPOA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.07.2020 um 16:47 hat Nir Soffer geschrieben:
> On Mon, Jul 20, 2020 at 4:18 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/122     | 34 ++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/122.out | 17 +++++++++++++++++
> >  2 files changed, 51 insertions(+)
> >
> > diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
> > index dfd1cd05d6..1112fc0730 100755
> > --- a/tests/qemu-iotests/122
> > +++ b/tests/qemu-iotests/122
> > @@ -281,6 +281,40 @@ $QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> >
> >  $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
> >
> > +echo
> > +echo '=== -n to an empty image ==='
> > +echo
> > +
> > +_make_test_img 64M
> 
> Why make a test image here? We create it again below twice

This is a different image because the invocations below change the
TEST_IMG variable.

> > +
> > +# Convert with -n, which should not result in a fully allocated image, not even
> > +# with compat=0.10 (because the target doesn't have a backing file)
> > +TEST_IMG="$TEST_IMG".orig _make_test_img -o compat=1.1 64M
> > +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> > +$QEMU_IMG map --output=json "$TEST_IMG".orig
> 
> This looks reversed - "$TEST_IMG".orig is the original image, and
> "$TEST_IMG" is the target image. So maybe use "$TEST_IMG".target?

I'll use .orig for the source and without a suffix for the target (which
are filenames that _cleanup_test_img covers automatically).

> > +
> > +TEST_IMG="$TEST_IMG".orig _make_test_img -o compat=0.10 64M
> > +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> > +$QEMU_IMG map --output=json "$TEST_IMG".orig
> 
> Since the only difference is the compat, why not use a loop?
> 
> for compat in 0.10 1.1; do
> ...

Makes sense.

> > +
> > +echo
> > +echo '=== -n to an empty image with a backing file ==='
> > +echo
> > +
> > +_make_test_img 64M
> > +TEST_IMG="$TEST_IMG".base _make_test_img 64M
> > +
> > +# Convert with -n, which should still not result in a fully allocated image for
> > +# compat=1.1 (because it can use zero clusters), but it should be fully
> > +# allocated with compat=0.10
> > +TEST_IMG="$TEST_IMG".orig _make_test_img -b "$TEST_IMG".base -F $IMGFMT -o compat=1.1 64M
> > +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> > +$QEMU_IMG map --output=json "$TEST_IMG".orig
> 
> Do we have a real use case for this convert? Doesn't this hide all the
> data in the backing file by data from source?

There is probably no real use case for this. But it has a defined
behaviour and it's always good to cover corner cases with tests so that
unintentional changes can be found (which may potentially affect more
relevant cases, too).

Kevin


