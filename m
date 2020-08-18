Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480C3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13AE3207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAvqAcnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AE3207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83iR-000730-8X
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k83XA-00047A-Rw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:28:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31617
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k83X8-0001VP-61
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597764496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Og5bGG/dbkltpFkenJ+NjzM234zwinPeSK6kx6Slucw=;
 b=YAvqAcnn5DqV9EsDOvkLbonscBVGXALZpjAfGxN5JG+Z7IcHfhtzgpUqqG23e5hAQu8kxf
 fELtxTFwWiNmZxwoCwygmw/5/r2nY7L1zOKnLodEKKUuqF9anjZyXUqQpslPEeyEvQ+G+2
 O5aU8TDf6Q8mPBU2PLZ3q6Ly+nG4ZT8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-zYa8eNWjMxWX2kUAxL9zVw-1; Tue, 18 Aug 2020 11:28:14 -0400
X-MC-Unique: zYa8eNWjMxWX2kUAxL9zVw-1
Received: by mail-wr1-f72.google.com with SMTP id k11so8369759wrv.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 08:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Og5bGG/dbkltpFkenJ+NjzM234zwinPeSK6kx6Slucw=;
 b=kuL4ofekDiaNwgwPK7+bv5kgZR8EQShVyuVbNR1BtVOOGDkJPm4FqKXIYSrsz1pTHC
 t80XiTL3z5N/O4BrbhfLqjTnN/bYQZvce++kMhs5yoWR1DQSfgIO9K8QRBUzAaPR6l9i
 bhZhTEj30oR2OnFzIBSiX9/h2V39z0Woskh3BmR8kBjOqZZ2G+fiiE6U4BtOcJYyi8tE
 Ve91untNOXDG+jI9dasn9i5qFsGNc2Vt8QcV0Ec9lnesivvgS9p7vrSYZ2gtUNmyLKnx
 jH7Y2RYSAA3H4TJ/eyv70xz7ztvCNMLl63lwQ1Kbb5Cn77bonyASQT+qIbmQY1WcJnKU
 DaiA==
X-Gm-Message-State: AOAM531xLlv6xHj6ox86+OSO1FqYtcSXY1PS8iCFww/IafQkClmuK/1b
 sOoVPO12crgwWrH6vA+eekJa/lnAqhEersXRxy4d97hjk6rAkH24vcNBrmgBEp2kDarLGsBpyCa
 5q6mYE+pPLtsQ34c=
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr22664225wrj.347.1597764493199; 
 Tue, 18 Aug 2020 08:28:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5UINidixatJGGvhKXABnSTKrCZlHl4s5Z+JTWLl+GqP+EfSmFoA2XVh8/kTm5yII6So+A+A==
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr22664207wrj.347.1597764492885; 
 Tue, 18 Aug 2020 08:28:12 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id 130sm393749wme.26.2020.08.18.08.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 08:28:12 -0700 (PDT)
Date: Tue, 18 Aug 2020 17:28:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <20200818152807.oig6p3ajve5ju32b@steredhat>
References: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
 <20200813112820.62ffd63e.cohuck@redhat.com>
 <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
 <20200813123737.25ba11d2.cohuck@redhat.com>
 <20200813120415.s5we6mihe6fywm4a@steredhat.lan>
 <20200817122746.0b786372.cohuck@redhat.com>
 <20200817131128.lgxn3pyzuzly4edp@steredhat>
 <20200818144450.0701d68c.cohuck@redhat.com>
 <20200818140120.c46fsf6cia2ol53v@steredhat>
 <20200818163101.72abd288.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200818163101.72abd288.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Qinghua Cheng <qcheng@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 04:31:01PM +0200, Cornelia Huck wrote:
> On Tue, 18 Aug 2020 16:01:20 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > On Tue, Aug 18, 2020 at 02:44:50PM +0200, Cornelia Huck wrote:
> 
> > > It seems to me that the status before this was "works by accident, but
> > > only if we're not negotiating to legacy, or the guest/host are both
> > > little endian". IOW, no visible breakage for most people (or we'd
> > > probably have heard of it already). Now we have a setup that's correct,
> > > but forces users to adapt their QEMU command lines. Option 1 would
> > > eliminate the need to do that, but would cause possibly
> > > not-really-fixable migration issues (you can probably deal with that
> > > manually, detaching and re-attaching the device as a last resort.)
> > > 
> > > So, force modern, probably also remove the -transitional device type,
> > > and put a prominent explanation into the change log?
> > >   
> > 
> > I completely agree with your analysis and solution.
> > 
> > So, for now we need to patch vhost-vsock-pci and vhost-user-vsock-pci,
> > and queue the patches in stable.
> 
> I think we should also change -ccw; even though users won't get an
> error when starting QEMU, they might still run into the legacy problems
> in theory.

Okay.

> 
> Not sure how fast we'll have a stable release, though.
> 
> > 
> > Do you prefer to send them? Otherwise I can do that.
> 
> If you already have something on your disk, please go ahead :)

Yes, I have something for pci, and I'll follow your suggestion for ccw!

If you have time, can you share with me some tips on how to install
s390x guest on my laptop?

> 
> > 
> > Thanks again for the help and the test with s390x guest!
> 
> np; especially as it was my patch which started this in the first place
> :/
> 

I'm not sure that was a bad thing, since we found out that virtio-vsock is
modern only :-)

Thanks,
Stefano


