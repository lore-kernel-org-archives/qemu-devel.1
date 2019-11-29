Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFF0C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C252176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UL79x4qQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C252176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacyn-0005lh-Qn
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iacqF-0000g9-QG
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iacqA-0003MZ-Of
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:45:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iacq7-0003Ia-No
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575020726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ye2aTxTIPGkyOiCJQcRakJoRxytgzjLIMI3tVbksxpg=;
 b=UL79x4qQRtsa/1Dbh/bgbqw5O06zcsa4QRIDL92y6OKbbtRWVrrUcY2StoLE6qUnNpXbGC
 vYTCjA2d0tXqTwJWKbD0n+vb4sKhu1U4sj3Sipqtr5p6xZlhjorqunpu0IDZv4MnWfwiZo
 tk0r0rJRMPAYOpaiA8YZs36N1DZbgro=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-sXgAAF0nOsKHmS5GeWDqDg-1; Fri, 29 Nov 2019 04:45:23 -0500
Received: by mail-oi1-f199.google.com with SMTP id k15so1493779oik.11
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 01:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ye2aTxTIPGkyOiCJQcRakJoRxytgzjLIMI3tVbksxpg=;
 b=fFIt3kd1+LU9tLIMAKesTNaYYdjECIhDcI3t/hNfghk26+NYnPfnyhziUqhJbpTUV9
 Tv5Eqqh6ce3Q9yqB4rnuaoofdbOnfHYa2ezeh4NQ9QsGTAqb+iQ9roBXh3RZLbaT9KRB
 vGAI2NjxQc9/0p6r7+uPNXEibddVbNoopJfUyqVAkzugiLMf7niaLiZ6wuMnfor5jjXt
 tVAXPEdu3nHbK3l7cvf9xCwjnmAV+K33zLpl+oGXoIhGnnoljhlI9N/SQ8hur4rQ/4qz
 WMphbgDDQUDMs2Exes/ztlnkLCwqhLVFtbYxzC8MKuUb28+aM9Hj0BBkYKV5rKwD9lS5
 ls/Q==
X-Gm-Message-State: APjAAAVbYo0N/Ol3ioGZF4ERk3sSaD6z9yINc0fpJumIrZovUoge9uFY
 4ChzNC3SqrMiMsa3xNV4BMe+YoxXkEzyNJ+VIWJzqziOQ0TRu9aPRGtFAXJscolqjy0bQTU3bJl
 3N1HSSNCYD5eS6cwDtzsgUYu/lSt/MOs=
X-Received: by 2002:aca:52c4:: with SMTP id g187mr8734814oib.76.1575020722871; 
 Fri, 29 Nov 2019 01:45:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbXis50IuxthAYcApbk0rerbJyKVbF3OTbHhiesJGVyXswIsVYMLGr2UE7SYUC4WckeA4huq1tpHitrmL06A4=
X-Received: by 2002:aca:52c4:: with SMTP id g187mr8734798oib.76.1575020722613; 
 Fri, 29 Nov 2019 01:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
 <20191129092713.GA2260471@redhat.com>
 <CAMxuvaw=o9xP4G1GD95xVUb2as9R_pUB_85muRUVP8p3pEeqxw@mail.gmail.com>
 <20191129094230.GE2260471@redhat.com>
In-Reply-To: <20191129094230.GE2260471@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 29 Nov 2019 13:45:11 +0400
Message-ID: <CAMxuvayDmXcFSvjyBC+e=40tO6N15rbBETDsP_kYoHOU1xKrpg@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-MC-Unique: sXgAAF0nOsKHmS5GeWDqDg-1
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

On Fri, Nov 29, 2019 at 1:42 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Fri, Nov 29, 2019 at 01:31:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Nov 29, 2019 at 1:27 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > >
> > > On Fri, Nov 29, 2019 at 11:30:51AM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > On Fri, Nov 29, 2019 at 11:03 AM Gerd Hoffmann <kraxel@redhat.com> =
wrote:
> > > > >
> > > > > On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=C3=A9 Lureau =
wrote:
> > > > > > Hi,
> > > > > >
> > > > > > Setting up shared memory for vhost-user is a bit complicated fr=
om
> > > > > > command line, as it requires NUMA setup such as: m 4G -object
> > > > > > memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,shar=
e=3Don -numa
> > > > > > node,memdev=3Dmem.
> > > > > >
> > > > > > Instead, I suggest to add a -mem-shared option for non-numa set=
ups,
> > > > > > that will make the -mem-path or anonymouse memory shareable.
> > > > >
> > > > > Is it an option to just use memfd by default (if available)?
> > > >
> > > > Yes, with a fallback path currently using a temporary file under /t=
mp
> > > > (we may want to use shm_open() instead, or a different location suc=
h
> > > > as XDG_RUNTIME_DIR? - and use O_TMPFILE)
> > >
> > > We can't assume either /tmp or XDG_RUNTIME_DIR is on tmpfs as that is=
 no
> > > where near standard across all OS distros, and even if on tmpfs these
> > > dirs can be size limited to a significant subset of available RAM. IO=
W
> > > we can't safely use them unless explicitly told to.
> >
> > Is shm_open() acceptable instead?
> >
> > Imho, -mem-shared should do a best effort by default, but can fail.
>
> Possibly, but if we're relying on shm_open choosing the path, then
> its harder for users to know what files to clean up when QEMU crashes
> or otherwise exits wthout a shm_unlink

True, although I think you can call shm_unlink() right after
shm_open() that should limit the risk of those forgotten files.


