Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D14C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFC5207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBTi0Vjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFC5207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbM1e-0006wf-L2
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbLz6-0003Co-ST
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:30:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45079
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbLz6-0000h3-7H
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589970599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scMCYpJEYGJpIew3DLaLj+/Ro13I7keT6LWOdd2p23A=;
 b=fBTi0VjpPQXCXuOqgrlrcZ0ol7wgqYJ/EmKE9R97cB//NDUanGsvvMZGha1+w5OItvYDLb
 j7r2vYaNy57LRXgE7jy87qjcCm047o7VsPwUezp3io3bOA99DjQ6dCe0n9q6qdD3Fw+RzB
 qJky+DpNrD51dwEa7kg6uw2yBe/V+Rs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-5VBWivJ1NkKOb179Tv0Z3Q-1; Wed, 20 May 2020 06:29:55 -0400
X-MC-Unique: 5VBWivJ1NkKOb179Tv0Z3Q-1
Received: by mail-wm1-f69.google.com with SMTP id u11so740925wmc.7
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=CjXsPArqeVZUxZnM75Qph7ij8o3SdnpfjxPXON+ZmFI=;
 b=LgNjlyRx40fnbpH4P76yMDR5xIBZpFm86OPK29W+vm1l91CIwJ4n50eCZ630Gfk9Jt
 cNz2TMMSiIRpqMgNcmmwMitmuqJiqsf1LK1Ukvfmv9kAi7OqNjwHO3JvSaXdu/HR2Rc8
 1Yc5xYf0j84WQeeLhzmFdqXpQVNuJsPKi+u7wth08ltuq+l/Dbre29MbZ54kSq0U8uzb
 VT2ZsCxeMV+EyI3/pUCFXqt4GyqQDmbVI+Q8HyxLt7Keo2J29iDf44P8xT4vIn9Ki2fr
 3hH8fB23GHSY5UQ1TF8NKsXqS5xgw5k0I+QLOv4ttDfaBbshz7YcijEx9SMVrwycGT4E
 JG0w==
X-Gm-Message-State: AOAM530vtVcGDv4OewGdXkPYRppBk98fFv/JCLFnwV+RT/m2snVARVnJ
 VWAtciEQWyKHfi0qAQFzrstHtQn9JMFWPehJdR6sMGSHrHhZi1826WK03/TLWwLa2kwGcZD2mXY
 +gksaR/F0+sdXmq4=
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr4082241wme.160.1589970594864; 
 Wed, 20 May 2020 03:29:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpmix3MGNpMCWRxtZNqx5egMV1bYq67KOuJuZcHntZvehg1R3eIdWo9mSup2MabP92gdDp4w==
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr4082218wme.160.1589970594653; 
 Wed, 20 May 2020 03:29:54 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 b14sm2770933wmb.18.2020.05.20.03.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 03:29:54 -0700 (PDT)
Date: Wed, 20 May 2020 06:29:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 10/16] floppy: move cmos_get_fd_drive_type() from pc
Message-ID: <20200520062944-mutt-send-email-mst@kernel.org>
References: <20200515150421.25479-1-kraxel@redhat.com>
 <20200515150421.25479-11-kraxel@redhat.com>
 <0c3d5c81-fc38-e1c1-b83a-3c3d8f781dd8@redhat.com>
 <20200520084303.z4srklygrskx7kbr@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200520084303.z4srklygrskx7kbr@sirius.home.kraxel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 10:43:03AM +0200, Gerd Hoffmann wrote:
> On Tue, May 19, 2020 at 04:51:44PM +0200, Philippe Mathieu-Daudé wrote:
> > Missing "Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>",
> > otherwise:
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> mst, can you pick that up or should I respin?
> 
> thanks,
>   Gerd

Not a problem.


