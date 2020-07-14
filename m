Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE443C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946E921897
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxqiXIyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946E921897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHwB-0003zb-Rn
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHvd-0003aa-2b
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:12:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHvZ-0006lh-VN
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594721565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3NDJ26CRwcBIlpXwKpJeAbyH26hgqpFkbjqh5Muu40=;
 b=XxqiXIyhz3Laeo7Gy1xFbTj7WDclq2zhWOXOucEF1R+so9gDkb+vHO0YoVxDurKKz00AUD
 EvYWEMgvDOVwfHzYbRqMO/WBVrPBixB5eilED4585QGtPBHrTPKtX4GBbbxMzMhPhBI9ju
 u+8oMDyjBoGVPy5CW2DT1CIB8nCFI40=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-t_lfzAGJPvm4gtUTOcBCSg-1; Tue, 14 Jul 2020 06:12:30 -0400
X-MC-Unique: t_lfzAGJPvm4gtUTOcBCSg-1
Received: by mail-wr1-f71.google.com with SMTP id j3so21079111wrq.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 03:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7yZJm+UT8ltwiU2pT9pbGx42NWqyw69avuT6S0wQNf8=;
 b=K1KfhJrW5k2hjsPrxlf4IT4AlOzkCF3zoVC+ExGIfqjghqB5+wfbC1AHlpZVVQy0Kk
 5BezcJdVIj8dehCCTPEN8tNn4USTCoLyO5PFVbstIXf3IMsJdrAf8QKE2+UpqnL6lJkM
 ActfFbB9eItEcb/wvbTkB6BQAXyfK8ltuZChmm3oFE57lggHc0+lhelT4j3NVA7maw/l
 J6jwr2nZYTUPxBAzrfR9GYOEKMBc2NYDPLR3flNiG6qSJZukacIX3UAtO+s+07Vt7wbJ
 OBq9np9xW7sieGU0wLmYcmVX80VHum5KtnliZtzFqWJ8sDzHTE2/L8RYwfm8Gz1WRaY5
 l8IA==
X-Gm-Message-State: AOAM531GZRnGVMIsPdX/mfpwxJxbQHQ+ypm/Oyp5sTPZ2IWkScd7hFU+
 Y/zXQmh/iVnPEmFMJLvWeGNxBFXCd5bZTg2qeUda42fnVFl5ghv2fgpszEsi5B/Jj8sNuFyhOqL
 zT6M+5dgw3PAVzq8=
X-Received: by 2002:a5d:610a:: with SMTP id v10mr4251221wrt.108.1594721549024; 
 Tue, 14 Jul 2020 03:12:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfwOonW74muHvN13rPaLEkspH+EK4gM3+VK8zTAoGCFKBeQOunnQLR0KXHe+ZKDhQdsqNU2Q==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr4251191wrt.108.1594721548753; 
 Tue, 14 Jul 2020 03:12:28 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id b184sm3911714wmc.20.2020.07.14.03.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 03:12:28 -0700 (PDT)
Date: Tue, 14 Jul 2020 06:12:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200714060916-mutt-send-email-mst@kernel.org>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
 <20200714095233.GC25187@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200714095233.GC25187@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, P J P <ppandit@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 10:52:33AM +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 14, 2020 at 10:42:55AM +0100, Peter Maydell wrote:
> > On Tue, 14 Jul 2020 at 09:40, P J P <ppandit@redhat.com> wrote:
> > >
> > > From: Prasad J Pandit <pjp@fedoraproject.org>
> > >
> > > QEMU supports numerous virtualisation and emulation use cases.
> > > It also offers many features to support guest's function(s).
> > >
> > > All of these use cases and features are not always security relevant.
> > > Because some maybe used in trusted environments only. Some may still
> > > be in experimental stage. While other could be very old and not
> > > used or maintained actively.
> > >
> > > For security bug analysis we generally consider use cases wherein
> > > QEMU is used in conjunction with the KVM hypervisor, which enables
> > > guest to use hardware processor's virtualisation features.
> > >
> > > The CVE (or Security or Trust) Quotient field tries to capture this
> > > sensitivity pertaining to a feature or section of the code.
> > >
> > > It indicates whether a potential issue should be treated as a security
> > > one OR it could be fixed as a regular non-security bug.
> > 
> > How does this interact with the way we already document our
> > level of security support in docs/system/security.rst ?
> > 
> > > +       C: CVE/Security/Trust Quotient
> > > +          H:High - Feature (or code) is meant to be safe and used by untrusted
> > > +                   guests. So any potential security issue must be processed with
> > > +                   due care and be considered as a CVE issue.
> > > +          L:Low  - Feature (or code) is not meant to be safe OR is experimental
> > > +                   OR is used in trusted environments only OR is not well
> > > +                   maintained. So any potential security issue can be processed
> > > +                   and fixed as regular non-security bug. No need for a CVE.
> > 
> > The difficulty with this is that MAINTAINERS is not set up
> > with a split between "security issues" and "non-security
> > issues". For instance this stanza:
> > 
> > > @@ -149,6 +161,7 @@ ARM TCG CPUs
> > >  M: Peter Maydell <peter.maydell@linaro.org>
> > >  L: qemu-arm@nongnu.org
> > >  S: Maintained
> > > +C: Low
> > >  F: target/arm/
> > >  F: tests/tcg/arm/
> > >  F: tests/tcg/aarch64/
> > 
> > you have marked "Low", but the files it covers include
> > both ones used by TCG (not security-critical) and ones
> > used by KVM (security-critical).
> > 
> > Also, MAINTAINERS is not user-facing. If we want to say
> > that vvfat or 9pfs are not suitable for use on a security
> > boundary and that we do not consider bugs in them to
> > be security issues, we should do that in the user-facing
> > documentation.
> > 
> > Broadly speaking, it feels like you're trying to come up
> > with an automatic way to say "does this patch touch a
> > security-relevant part of the code", and I'm not sure
> > that that's possible.
> 
> I agree that it isn't possible in the MAINTAINERS file, as the level
> of granularity is a very poor match for what we want to express.
> 
> My high level thought would be that we should ultimately be able to
> have a build flag to request only security-critical code is built
> into the binaries.

And for people who want to build QEMU with lots of functionality (like
Fedora does), I think a -security flag would be a useful addition.
We can then tell security researchers "only a high security issue
if it reproduces with -security=high, only a security issue
if it reproduces with -security=low".


> This is probably a bit too much of a stretch goal right now, but it
> at least points towards maintaining the information on a per-file
> level of granularity. There might be some individual files which
> currently contain a mix security-critical/not-security critical
> code. Either they can be split eventually, or we can simply declare
> that the entire file is none the less security critical.
> 
> We could perhaps have a magic comment at the top of each file that
> is security critical. eg
> 
>  /* @security: maintained */
> 
> we don't need any comment in files we consider non-maintained from
> a security POV.  Eventually we could do some (insert hand waving)
> magic in meson to pull out this list of comments and use it to
> exclude build of files that are not security critical. Maybe we
> find out that using a magic comment isn't the best option, but
> at least if we start now by keeping a per-file comment, we can
> probably do an automated transformation to any other data storage
> later.
> 
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


