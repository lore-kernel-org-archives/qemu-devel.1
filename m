Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7632520663
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP0Cg/7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7632520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoOr-0000c4-OW
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoNu-0007a7-LP
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:50:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoNs-0005n3-Rh
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591271407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=884kRQQjH7w6M0i8yh6lX1SNT9HgXZgi3Ib4W0Yu5S0=;
 b=MP0Cg/7wOM7hJuDuuX5KAN8WfuXg6ZomEA8Stt2DP2aS+FLN67YEeqkR17ReFcDcf909+D
 xYTMOjYMJRXViUvOeLaYpKL2sKbbqkQ6TJ413dRrK8cAy+6E+IZQ1Dad+c/wrKKS+dhLyh
 NtrAVPOO3esnFh/dawWuc0o2dp5Eijo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-zFMmv-OYOji6_1KJYwEESA-1; Thu, 04 Jun 2020 07:50:04 -0400
X-MC-Unique: zFMmv-OYOji6_1KJYwEESA-1
Received: by mail-wr1-f71.google.com with SMTP id c14so2322722wrm.15
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=884kRQQjH7w6M0i8yh6lX1SNT9HgXZgi3Ib4W0Yu5S0=;
 b=ZCj+gWagf8amibn0IvIlmAuBLnNnc5R3JTPdpX1pIkQG70qFsRbEqFwZZkFSn46kT9
 TiqrS2xVWvozSf4c63qcBjWLsT5PQcWq/iLpSzQMXjYDLvoF51/H02Af5WSuE2ABrH11
 ZDbpJz+4d7U/vXEmWYW7Cs64869W54SfeIU3Wf9oPR/TpGRf+lsJXw7CEY+fQSb89gqb
 HG1G5bmL2ggyJMSgr4Sn8VnV6VLjgLfiwRnvYbYCnxguAgAJ/k9OKLy462weIWQBgZL6
 ut9M6IjPBzIjAB4Iyhek5vmGSe2GnoFM/g/nLCs7HWiKofW3ZXdvsbpW4NlHyYT3/bXW
 kKeA==
X-Gm-Message-State: AOAM53030OPUTI7lIbsGbdcuQSAkCtU/pfh8mLVxokWrUzTOvQ1E+MgL
 F5AXcSNX1w2svWr63grrIboQXsuXYAeMie+cI65zBCla0HoSlXHOtJuxMJLGF/kRIwxknydvf1O
 XXygmxr1HSKPV0/Y=
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr4029760wrj.227.1591271401608; 
 Thu, 04 Jun 2020 04:50:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA2dyg9hzhjDccfwTkiscYZGAkvzOxVccRSviRq0z6ve9+B3NAJwt1QvQ2B24DwwAXXuGF6w==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr4029739wrj.227.1591271401392; 
 Thu, 04 Jun 2020 04:50:01 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id v24sm6804658wmh.45.2020.06.04.04.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:50:00 -0700 (PDT)
Date: Thu, 4 Jun 2020 07:49:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v3] ati-vga: check address before reading configuration
 bytes (CVE-2020-13791)
Message-ID: <20200604074539-mutt-send-email-mst@kernel.org>
References: <20200604105524.46158-1-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200604105524.46158-1-ppandit@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>, pbonzini@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 04:25:24PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While reading PCI configuration bytes, a guest may send an
> address towards the end of the configuration space. It may lead
> to an OOB access issue. Add check to ensure 'address + size' is
> within PCI configuration space.
> 
> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Yi Ren <c4tren@gmail.com>
> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

BTW, this only happens on unaligned accesses.
And the IO memory region in question does not set valid.unaligned
or .impl.unaligned.

And the documentation says:

- .valid.unaligned specifies that the *device being modelled* supports
  unaligned accesses; if false, unaligned accesses will invoke the
  appropriate bus or CPU specific behaviour.

and

- .impl.unaligned specifies that the *implementation* supports unaligned
  accesses; if false, unaligned accesses will be emulated by two aligned
  accesses.

Is this then another case of a memory core bug which should have either
failed the access or split it?

> ---
>  hw/display/ati.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Update v3: avoid modifying 'addr' variable
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00834.html
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 67604e68de..b4d0fd88b7 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -387,7 +387,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>          val = s->regs.crtc_pitch;
>          break;
>      case 0xf00 ... 0xfff:
> -        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
> +        if ((addr - 0xf00) + size <= pci_config_size(&s->dev)) {
> +            val = pci_default_read_config(&s->dev, addr - 0xf00, size);
> +        }
>          break;
>      case CUR_OFFSET:
>          val = s->regs.cur_offset;
> -- 
> 2.26.2


