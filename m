Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E522C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E32206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7L7AkSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E32206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEM3i-0006LF-DC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jEM34-0005rb-2D
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jEM32-0003NU-Ug
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:55:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jEM32-0003BJ-NR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:55:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id n8so1267277wmc.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CDNFmwP9dHuFqrowISay7pg9ZVhtgdguEeBLfTkRz4s=;
 b=m7L7AkSoIOy2T3szKncHhgvRDaIJ+ul4gKVbQRoJ5M30hhanTHAkg2WDeF3T6JWutj
 Plc4FjSZfP1FIGv6LR4MKyNquNn7uThhosE9uRq3JCwjz6ciYK5t3bG9ulYmYIBa7Sud
 XpJt1h1aF7wrTkVoySmYBW0oM8WS+ZgH4Tb2ji0EM9jHCAKzEppsEqb2+WQjR5JISYy7
 16NOtwWV3CpUa1oJrotMSy17ZES+rMFE4lusK+C/LVAGopTH7PrhvZYDUur5df/3fSHm
 WwiYjsomFOmzHjn/Lni/Z8VtGhDjf+VQYjccTrifRfu0811nCnrIoj2vr7g4QVScfLKk
 OGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CDNFmwP9dHuFqrowISay7pg9ZVhtgdguEeBLfTkRz4s=;
 b=qb6vSn8c4bm9BSpObwiwofk/c0ehvCGqR6qDKTGsxPk4PkyZhsnYZ0ityI5GGjI41H
 gmf6QVcSV5DECxloTVnTddvKrJW7ro1RQccTHKD8YlumHw9iyKZDaNzWR4EbT/7emQiZ
 6KpmblGZ9S/yxu9B2+osd9wY/g4YHfwXxqwBH5CTwhJNni9xavK6uJ8xNdlPm91U9CxV
 c5c1hEqNT3K1fLOnMkDvynxyr9LBvsmvJT/QdVBPD1fFZEwZaqilXEBj9cy4Zo4wGC9E
 6+Ew5TRgyV3Jc3gTNLfsV8Ussmw9I9RnZr2bZJjI5ANSoCniM26uMB6nEs07hjP8NLCV
 /lcQ==
X-Gm-Message-State: ANhLgQ0VpdoLjtbpQdd59oJncrpBMu7MkTOIb+3Jmb30HiuDkYlvgqkw
 0paAZ7E6XgZ4SMck0llBNTP+JJwjT1b9BRQP0Tw=
X-Google-Smtp-Source: ADFU+vs2zIUGvvd9i4MN9Ie0hWY31smICBatpSZGVALcyF4pEehb8YovsKMHLP4Xv0khFRbVFX/ERKQB1wwQS1QjdlM=
X-Received: by 2002:a05:600c:2c4a:: with SMTP id
 r10mr1546569wmg.32.1584489299001; 
 Tue, 17 Mar 2020 16:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200312104142.21259-1-alex.bennee@linaro.org>
 <20200312104913.GB4089516@redhat.com>
 <CAJ+F1CJWy2gEHHjzqyqnvHFf6EP4mEGABLt4aA7xptkXDwPGiw@mail.gmail.com>
 <20200316103331.GC1528804@redhat.com>
 <20200317095414.GC492272@stefanha-x1.localdomain>
 <20200317184704.GG3369@work-vm> <87a74ek1pf.fsf@linaro.org>
In-Reply-To: <87a74ek1pf.fsf@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 18 Mar 2020 00:54:46 +0100
Message-ID: <CAJ+F1C+O18m9F5Y_Thhnr0ZzoQ=yNd=y9u-SCOsV+-wqP0uwDQ@mail.gmail.com>
Subject: Re: [PATCH] tools/virtiofsd: add support for --socket-group
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Mar 18, 2020 at 12:21 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
>
> Dr. David Alan Gilbert <dgilbert@redhat.com> writes:
>
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> >> On Mon, Mar 16, 2020 at 10:33:31AM +0000, Daniel P. Berrang=C3=A9 wrot=
e:
> >> > On Sat, Mar 14, 2020 at 02:33:25PM +0100, Marc-Andr=C3=A9 Lureau wro=
te:
> >> > > Hi
> >> > >
> >> > > On Thu, Mar 12, 2020 at 11:49 AM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
> >> > > >
> >> > > > On Thu, Mar 12, 2020 at 10:41:42AM +0000, Alex Benn=C3=A9e wrote=
:
> >> > > > > If you like running QEMU as a normal user (very common for TCG=
 runs)
> >> > > > > but you have to run virtiofsd as a root user you run into conn=
ection
> >> > > > > problems. Adding support for an optional --socket-group allows=
 the
> >> > > > > users to keep using the command line.
> >> > > >
> >> > > > If we're going to support this, then I think we need to put it i=
n
> >> > > > the vhost-user.rst specification so we standardize across backen=
ds.
> >> > > >
> >> > > >
> >> > >
> >> > > Perhaps. Otoh, I wonder if the backend spec should be more limited=
 to
> >> > > arguments/introspection that are used by programs.
> >> > >
> >> > > In this case, I even consider --socket-path to be unnecessary, as =
a
> >> > > management layer can/should provide a preopened & setup fd directl=
y.
> >> > >
> >> > > What do you think?
> >> >
> >> > I think there's value in standardization even if it is an option tar=
getted
> >> > at human admins, rather than machine usage. You are right though tha=
t
> >> > something like libvirt would never use --socket-group, or --socket-p=
ath.
> >> > Even admins would benefit if all programs followed the same naming f=
or
> >> > these.  We could document such options as "SHOULD" rather than "MUST=
"
> >> > IOW, we don't mandate --socket-group, but if you're going to provide=
 a
> >> > way to control socket group, this option should be used.
> >>
> >> I agree.  It's still useful to have a convention that most vhost-user
> >> backend programs follow.
> >
> > Alex:
> >   Can you add the doc entry that Stefan and Marc-Andr=C3=A9 are asking
> > for;  it's probably good they go together.
>
> Sure - is docs/interop/vhost-user.rst the master spec for vhost-user
> daemons?

So far, yes. But it might make sense to create a standalone
vhost-user-daemons.rst.



--=20
Marc-Andr=C3=A9 Lureau

