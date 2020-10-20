Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB79C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B654E2224B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAeN9Po5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B654E2224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUssz-0003Fp-VX
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kUsqO-0000rw-CJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kUsqJ-0002Fm-LU
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603204944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cyHVh5UNAJnlZVWe1WuMTVBLHHRV+vwMiv5b/10uRLA=;
 b=JAeN9Po5nAoHRs2zmiRm8C3Qji8ZEMAQ+P+24NDQ8hUiceR0u/pFq8uAtg0dCANRdnm7BL
 sCM5F1ULC6RgOIxtMwKowOjkXnb0rEaU8AzbJcFk5JMP6TDlMhATgXJhc9D2f0ARyPWR5I
 a3AwFpmp9b+hZD0EKxGsATgW/zrRDoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-JxUzIVRPNSKkFWPE4ClX5A-1; Tue, 20 Oct 2020 10:42:20 -0400
X-MC-Unique: JxUzIVRPNSKkFWPE4ClX5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 250B561266;
 Tue, 20 Oct 2020 14:42:19 +0000 (UTC)
Received: from localhost (ovpn-114-98.ams2.redhat.com [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C092F5B4C5;
 Tue, 20 Oct 2020 14:42:18 +0000 (UTC)
Date: Tue, 20 Oct 2020 15:42:17 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: Question on Compression for Raw Image
Message-ID: <20201020144217.GT30079@redhat.com>
References: <516589845d6f42d0b00784d16b59b5dc@intel.com>
 <20201020080051.GA4452@merkur.fritz.box>
 <6124d55766e4477299a5796a002276a0@intel.com>
 <ec72d814-109c-4ed9-cb26-32b9d903f8c2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ec72d814-109c-4ed9-cb26-32b9d903f8c2@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 09:32:23AM -0500, Eric Blake wrote:
> On 10/20/20 9:22 AM, Wang, Wei W wrote:
> > On Tuesday, October 20, 2020 4:01 PM, Kevin Wolf wrote:
> >> Am 20.10.2020 um 03:31 hat Wang, Wei W geschrieben:
> >>> Hi,
> >>>
> >>> Does anyone know the reason why raw-format.c doesn't have
> >> compression
> >>> support (but qcow has the supported added)?  For example, raw image
> >>> backup with compression, "qemu-img convert -c -O raw origin.img
> >>> dist.img", doesn't work.
> >>
> >> A raw image is by definition a file that contains the exact same sequence of
> >> bytes as the guest sees, without any additional information or encoding. If
> >> you compress a raw file, the guest will see compressed data on its hard disk
> >> instead of the real data.
> > 
> > Ok, thanks. I'm thinking QEMU could do decompression of the compressed data in raw.img when guest reads data.
> > 
> >>
> >> Anything you could do to add transparent compression to it would mean that
> >> it's not a raw image any more, but a new image format.
> >>
> > Yes, decompression makes it transparent to the guest. Would you think it's good to reuse the raw image implementation, just add the compress/decompress option?
> 
> My recommendation would be implementing a new BDS filter that does
> uncompression.  Then, you could do things like:
> 
> raw -> decompress -> file.xz
> 
> or even
> 
> qcow2 -> decompress -> file.qcow2.xz
> 
> By the way, the notion of filters is already possible in other ways.
> For example, you can point qemu to read from an NBD server, and then use
> nbdkit to do the decompression with its filters:
> 
> nbdkit --filter=xz file file.xz
> raw -> nbd://localhost:10809

nbdkit can already act as a front-end to qemu-nbd, allowing you to use
the rich nbdkit filter ecosystem with qemu block devices.  There are
some examples in the link below, but --filter=xz could also be used
here:

https://libguestfs.org/nbdkit-nbd-plugin.1.html#Use-qemu-nbd-to-open-a-qcow2-file

> Also note that serving a decompressed view of a compressed image tends
> to be a read-only proposition (you really CAN'T write to the image
> without recompressing, but even if recompression has been blocked for
> parallelism, you would end up writing far more of the file after
> recompression than the amount of data written by a guest).

Yup!

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v


