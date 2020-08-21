Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A8EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFAD206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJiXqHhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFAD206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99tE-0004st-IU
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k99r6-00029w-Si
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:25:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60618
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k99r4-0006Ho-89
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598027125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WCRMozm3Lkxhk3Wzj43wTDSxHtQLaRWPWVleKpbfHg=;
 b=RJiXqHhnTnFtzWYhUiI5QDlahuySY/YPdLOv3QkDDRnRGDu2KUUC/Y54YrumvtYvute00m
 rKsipB/WKBrgsgEdReMdYlhOIB6/ChRRJ/oPut6XZPWh15uY+EgP3+2Nf+kpBcDmfE/hft
 XaHw6x96We7yPvh5JIC86ANCQNfjugE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-foNNxGxaNc2FmSAIfrpPGw-1; Fri, 21 Aug 2020 12:25:23 -0400
X-MC-Unique: foNNxGxaNc2FmSAIfrpPGw-1
Received: by mail-wm1-f69.google.com with SMTP id k204so1179002wmb.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=TMMvwQz4TzoMeXxDD9hGX5Nqr4z8RlAuaftPRpSPoE0=;
 b=N6jfyqPEwjhDO1Qzm2uusg7a7YR9tuwztQTe1/1Xb73aue7iBzXIUxuGRI7yq4PKGj
 stIGd64huiCjHWmQygpXunzekPKmVrHBd3VnkblFIvb2w6fz1BrY4izstkuQQnmBfG9y
 PNycLAaQ7oWPQJDSnR5f/tsPptIP0QDuYgJ3t8LpNFXUSbnqo10UQzBxPNWgIoxQCa3C
 JCJh69/eNovvrk0kWQqm1FGP1Pq3M1RNFTa2oz02Sxcq7K5ps7iL1XC43zfF+ZrWDT3/
 YsJ3TvqDOh2x1YhVrxvPjSB14i9lY6B0zv+jXloeFGglV3BWkyeyPN+Tf1EQfiDyr7VL
 cJGg==
X-Gm-Message-State: AOAM533h8GddObFGKcVocnUxf+gVNhWwsmUSe5Hg6wLZgy3Ek1jnDf53
 EZsjUzayXrH5wX64un4oMeNFc2VXsjlfvmDRrDqQzlW596qeT1YqMgxJCHwo3dVao6E5tsxfH/8
 /IZppsku1GGNqjxM=
X-Received: by 2002:a7b:c011:: with SMTP id c17mr4502257wmb.63.1598027121442; 
 Fri, 21 Aug 2020 09:25:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQ0MNKJyoBwsGIA79hlLrq2FRoe2We5MNGwDPgRi6dqUnI3ACxDs7gdr3eVSy2oCTAoLME9A==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr4502241wmb.63.1598027121202; 
 Fri, 21 Aug 2020 09:25:21 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id x14sm6057839wmc.5.2020.08.21.09.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:25:20 -0700 (PDT)
Date: Fri, 21 Aug 2020 18:25:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] configure: silence 'shift' error message in version_ge()
Message-ID: <20200821162518.qr2jq72maxpnwst5@steredhat>
References: <20200821150014.42461-1-sgarzare@redhat.com>
 <CAFEAcA9zUDeig8TB4JDd_48v2AXcr7HGyjGq6r7KVx=sQyrjXA@mail.gmail.com>
 <20200821152627.trreokf3ly24thrs@steredhat>
 <7ac1a133-8b60-226d-4358-231f4b6b29a1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7ac1a133-8b60-226d-4358-231f4b6b29a1@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 06:14:25PM +0200, Philippe Mathieu-Daudé wrote:
> On 8/21/20 5:26 PM, Stefano Garzarella wrote:
> > On Fri, Aug 21, 2020 at 04:21:10PM +0100, Peter Maydell wrote:
> >> On Fri, 21 Aug 2020 at 16:00, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>>
> >>> If there are less than 2 arguments in version_ge(), the second shift
> >>> prints this error:
> >>>     ../configure: line 232: shift: shift count out of range
> >>>
> >>> Let's shut it up, since we're expecting this situation.
> 
> Maybe s/shut up/silence/?

Yeah, less aggressive ;-)

> 
> >>>
> >>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>> ---
> >>>  configure | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/configure b/configure
> >>> index 4e5fe33211..de4bd0df36 100755
> >>> --- a/configure
> >>> +++ b/configure
> >>> @@ -229,7 +229,7 @@ version_ge () {
> >>>          set x $local_ver1
> >>>          local_first=${2-0}
> >>>          # shift 2 does nothing if there are less than 2 arguments
> >>> -        shift; shift
> >>> +        shift; shift 2>/dev/null
> >>
> >> POSIX says
> >> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#shift
> >>
> >> "If the n operand is invalid or is greater than "$#", this may be
> >> considered a syntax error and a non-interactive shell may exit"
> >>
> >> so I think that we need to actually avoid the excess shift,
> > 
> > Maybe something like this:
> > 
> > diff --git a/configure b/configure
> > index de4bd0df36..5f5f370e2c 100755
> > --- a/configure
> > +++ b/configure
> > @@ -229,7 +229,7 @@ version_ge () {
> >          set x $local_ver1
> >          local_first=${2-0}
> >          # shift 2 does nothing if there are less than 2 arguments
> > -        shift; shift
> > +        shift; test $# -gt 0 && shift
> 
> This looks better that mine indeed.

Okay, I'll send a v2 with this change.

Thanks,
Stefano

> 
> >          local_ver1=$*
> >          set x $local_ver2
> >          # the second argument finished, the first must be greater or equal
> > 
> >> not just suppress any warning it might print. (I'm not sure
> >> Philippe's "shift || shift" patch can work for that, though,
> >> as the exit status doesn't distinguish "valid shift but don't
> >> do it again" from "valid shift and more args to come".)
> > 
> > I tried and also if I have meson 0.55.0, with the Philippe's patch
> > applied it tries to download our internal meson, so maybe it is not
> > working as expected.
> 
> =)
> 
> > 
> > Thanks,
> > Stefano
> > 
> 


