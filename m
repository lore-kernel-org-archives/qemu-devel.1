Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F814C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE7E20651
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK4kUqS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE7E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmwyC-0002Kd-Px
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46906)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hmwy3-0001wB-IO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hmwy1-00048y-Fw
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:08:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hmwy1-00045z-4k
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:08:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id p17so16170789wrf.11
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=pjSycxBHV/sHf0oPYBVquy4PLbbpkadHCa0zK8ld/VI=;
 b=HK4kUqS4QaxefWK//isqSZvmsdyG/bcL+jnu+d8G7+UfSI9v1ayV1CbzYGdKSZAi1g
 xFq1GZloHe3MK/efEjNlAuMcQ0x2byEb8gu29VaVplWhAUUoO3mYwxTvyzBGh7VPx4q9
 nQAf8EBqZ6uf0MQuuwCpB59JBTO3qGwsjrdjea2nNIeIIzfUDsplPEs3uWeABOBM8P/A
 IrwHhQx+Tb4K9nE0oiRdHX/lRp54dnGPdICz+UlCVnLe4NOhWdoFpcUwPFM8j0JLrU0e
 14aLqLm3BrQY/IxFXf/ybnb0jXykmXDjySHXhWzwR48a196Op+7IV41FS38SjRtS/3Yd
 UrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=pjSycxBHV/sHf0oPYBVquy4PLbbpkadHCa0zK8ld/VI=;
 b=oYRVl8CiKylPWRAt6ItB38IqcXO+cM1FVyjKO3P1RaTb3yxK0A32IYYYt8sIN+9PVX
 E66qAI9t7fP4NVJlKQTbYySWh8qYfFXIFv9Zko9bAItssEiR4A0guhTkCnAWjPcw4L5T
 2zfLPCC0ty1w0So5VoXlwNOQO9bm61J5slGAz5Q4mUsEIIQioTqu4t7NQHHYk20j5rzD
 qKVziXxc0FgYPUfR995Zkz2PTRWpBDcoDao5rTpRNqOH7mSmWa8pcjYKOXCeX4Oh34nj
 pGpE2ttDPXLRgC896GyPPxYb333e5aQTBMgHYMyuf50w1BoliTtEBt1jxQCRaF4xxGG3
 Cugg==
X-Gm-Message-State: APjAAAUxWrAyFB9qNUmPK3E0kpDN8S/CUK94qcHI25++HXr0bOVX0oMk
 GkLtUT7FWG2a+kVzyFvSisQ=
X-Google-Smtp-Source: APXvYqzls0i3bhbZyYHUYkxI8NjLR49YT785t9e+eVJaOtVzhA5dVJahZ+jsmN0vJDlUqoaoTub3hw==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr28513084wrq.29.1563181693658; 
 Mon, 15 Jul 2019 02:08:13 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p6sm14727101wrq.97.2019.07.15.02.08.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 02:08:13 -0700 (PDT)
Date: Mon, 15 Jul 2019 10:08:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190715090812.GD19807@stefanha-x1.localdomain>
References: <20190708211936.8037-1-julio.montes@intel.com>
 <1eb3f75e-01b0-990b-44c2-1770982da5b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eb3f75e-01b0-990b-44c2-1770982da5b5@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RFC] memory-backend-file/nvdimm: support
 read-only files as memory-backends
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
Cc: Julio Montes <julio.montes@intel.com>, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 09, 2019 at 12:53:45PM +0200, Philippe Mathieu-Daudé wrote:
> Cc'ing Igor & Xiao.
> 
> On 7/8/19 11:19 PM, Julio Montes wrote:
> > Currently is not possible to use a file that is part of a read-only
> > filesystem as memory backend for nvdimm devices, even if this is not modified
> > in the guest. In order to improve the security of Virtual Machines that share
> > and do not modify the memory-backend-file, QEMU should support
> > read-only memory-backeds.
> > 
> > Use case:
> > * Kata Containers use a memory-backed-file as read-only rootfs, and this
> >   file is used to start all the virtual machines in the node.
> >   It would be really bad if somehow a malicious container modified it.
> > 
> > Signed-off-by: Julio Montes <julio.montes@intel.com>
> > ---
> >  exec.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/exec.c b/exec.c
> > index 50ea9c5aaa..1eb170b55a 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1852,6 +1852,12 @@ static int file_ram_open(const char *path,
> >                  break;
> >              }
> >              g_free(filename);
> > +        } else if (errno == EROFS) {
> > +            fd = open(path, O_RDONLY);
> 
> While I can understand your use case, I'm not sure we want this silenced
> as default. I'd expect an explicit command line option for that backend,
> but I don't know well this area so let's wait for other to review.

I also wonder whether read-only should be exposed to the guest (e.g.
ACPI NFIT SPA EFI_MEMORY_WP Address Range Memory Mapping Attribute or
ACPI NFIT NVDIMM Region Mapping Structure NVDIMM State Flags Bit 3).

Stefan

