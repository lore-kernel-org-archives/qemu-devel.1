Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D409C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46951215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azGUCYUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46951215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacma-0005yo-GK
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iaccl-0007iP-Px
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iacca-0007Wn-97
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:31:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iacca-0007JU-4L
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575019885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyqEiNh42ADdCGLIEgaYnyEdLpPA9oFGI9R14Nm/zkE=;
 b=azGUCYUDwRX2rWZiSif4mbQtGKoFVSrTDLrp8N65nRyVmSYffRczJtMcwFngAHeAieZpJD
 vBqHMK6kKjp2AKoQfhngrACojd+ZUZe7BfANbXe6RXg2DZLpfLX3lfAjocW3K3qSm0jS8F
 Ehju5Sd0ZEn75xzHUk+CyaHOeICJQfk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Lm3RJWvBPVmHw7fb9C-WOQ-1; Fri, 29 Nov 2019 04:31:24 -0500
Received: by mail-oi1-f197.google.com with SMTP id 10so14027544ois.18
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 01:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vyqEiNh42ADdCGLIEgaYnyEdLpPA9oFGI9R14Nm/zkE=;
 b=s6meSKE4QcoQSz9YIXbSLIyn2bX5JhIZIc2PaYmowt1kS8+4tB9VAVWAvAgoDNx6ZK
 eCZdKZC08Cq6XwljExBByChQ/Ixpd+Jpc3MVdoBXB6ykUn1uFeCzC2Se3nyJhfDPXFlA
 fwYaMbnWZed2mQI/FK8roGgm/v/cpxxD4lk1NamgEjiuNrx3kdK0ISYNgf/Uqaynt9IB
 DBDachk+S4wbae0W3dK/YzrWMju9bw7FwH2lyqulRMwY3W+imI+y9opbhRF3VIYWO0jA
 zYNiJrMCmHBYN4aSZ19JEU+iwqdr3x5L/ELmmUqYL/Ci0PhaKCscEI3nbCFB48Xa2YSD
 JWNw==
X-Gm-Message-State: APjAAAXqU57lQH9ru/Ve03/ItQkkefeYqYvBrv/dSa2lzRNkp4MFwVN+
 eh0GKqiEVM74eBMRZFuqDQvGg25E3eCTXL5nS6K5eNtQXarPyEABRud/s+EL1iKqO6pZKlnE34E
 +ksnX8j1KsmUcUKIj7F5vBLa5gfLK9Ug=
X-Received: by 2002:aca:52c4:: with SMTP id g187mr8696992oib.76.1575019883093; 
 Fri, 29 Nov 2019 01:31:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3KN7OXdySLTCv2Pkij6CCU/aLcRwEcQikO5rD4AWuKH1ShGhfZFwdZkwPEiwJFfXu3pCt+HyXj9RYEQIYi/A=
X-Received: by 2002:aca:52c4:: with SMTP id g187mr8696978oib.76.1575019882870; 
 Fri, 29 Nov 2019 01:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
 <20191129092713.GA2260471@redhat.com>
In-Reply-To: <20191129092713.GA2260471@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 29 Nov 2019 13:31:11 +0400
Message-ID: <CAMxuvaw=o9xP4G1GD95xVUb2as9R_pUB_85muRUVP8p3pEeqxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-MC-Unique: Lm3RJWvBPVmHw7fb9C-WOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Nov 29, 2019 at 1:27 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Fri, Nov 29, 2019 at 11:30:51AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Nov 29, 2019 at 11:03 AM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> > >
> > > On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi,
> > > >
> > > > Setting up shared memory for vhost-user is a bit complicated from
> > > > command line, as it requires NUMA setup such as: m 4G -object
> > > > memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3D=
on -numa
> > > > node,memdev=3Dmem.
> > > >
> > > > Instead, I suggest to add a -mem-shared option for non-numa setups,
> > > > that will make the -mem-path or anonymouse memory shareable.
> > >
> > > Is it an option to just use memfd by default (if available)?
> >
> > Yes, with a fallback path currently using a temporary file under /tmp
> > (we may want to use shm_open() instead, or a different location such
> > as XDG_RUNTIME_DIR? - and use O_TMPFILE)
>
> We can't assume either /tmp or XDG_RUNTIME_DIR is on tmpfs as that is no
> where near standard across all OS distros, and even if on tmpfs these
> dirs can be size limited to a significant subset of available RAM. IOW
> we can't safely use them unless explicitly told to.

Is shm_open() acceptable instead?

Imho, -mem-shared should do a best effort by default, but can fail.


