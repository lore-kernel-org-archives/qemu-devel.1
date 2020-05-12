Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD91BC2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52ADD20740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Knm0hh2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52ADD20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYbdy-0000cu-BZ
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 16:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jYbd6-00006G-Th
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:35:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54216
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jYbd5-00014t-II
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589315754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ToeW7XloOLGcmuo/1uvD1dXWilmjj+uukSbMpVsXYQs=;
 b=Knm0hh2w9gk4ysTat6tsaWZrrxCTwCwkTzRI/zoLQVUjU1G2d1odQ06s+LsCV+Ocwdj11M
 Wmr3C11RMVhqfTWPUGdMSAIppLcmjJk7RQ61F7kjAf+wsEVNN+3l1r+afB5rFq7gIURXGs
 Xt4rm/s6ofNw4hoQZzgeTRlsaw4sxHM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-FRdrefXDP62Tyyc_GFFWAA-1; Tue, 12 May 2020 16:35:49 -0400
X-MC-Unique: FRdrefXDP62Tyyc_GFFWAA-1
Received: by mail-ot1-f69.google.com with SMTP id r16so6719590otn.21
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 13:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ToeW7XloOLGcmuo/1uvD1dXWilmjj+uukSbMpVsXYQs=;
 b=E88sZCdO4vJVbVrOJl56m4r0H41viZT7MHxupdnDdXqJlswRfxpWjdqmnDMsnVxdx2
 mKkkojmRy73OE+smh9UA4fG1efthj8b1gBWFkWpYazPdzKlPVXyfpe+kFlgwA1AQ0iNi
 yNXAdTFvDK+rQE+stid5HIShzxkIX98DjGXua+FNarCej+6xFBTc2PNCWD337aK85a3A
 v+08f132DNMhR9KuL3yf8jd8jxx/gj5/a+QLxgxRUCkKgFlc3PPRh73qZsfxN7nR9PW5
 h6BhaWh4KAcDDxo9uZszvwkKAN70BfDF2lF9LK+vqATZfhy3yqYkrrakP8qOcHXRVjZp
 131Q==
X-Gm-Message-State: AGi0PuaMQgOFl1Pls6a5ZRbEcZuA+J4TUFtJ6dwDBxjZf1jBLf6u6h73
 pPSvPsdI01VDZpAxxi7uoqdlzqnoAXsptqI+LvpMPxJ1z8K+xed2HaVxWJWi2QXPddyMspwSb/v
 gbCqfqqUpwvwMT4McN9Hj74zZHhU3Jro=
X-Received: by 2002:a9d:3785:: with SMTP id x5mr18080223otb.81.1589315748479; 
 Tue, 12 May 2020 13:35:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYeoSqJSokkTbnjWha2vmoaYqizouRlWeQpj0mKNXg8/MGymTl0MOPoQGFwLrY5ydByc1/QdgFO4lpRayBAd8=
X-Received: by 2002:a9d:3785:: with SMTP id x5mr18080192otb.81.1589315747958; 
 Tue, 12 May 2020 13:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-8-eblake@redhat.com>
 <CAMRbyytP9LvMVJ1R1EEnjHJGKOXtOYg_=ywqn-yVDLBeqFff4g@mail.gmail.com>
 <d0c62eef-acf6-0996-4928-1836940e2901@redhat.com>
 <1a9f1d01-5b9a-ac35-334e-1fe090682621@redhat.com>
In-Reply-To: <1a9f1d01-5b9a-ac35-334e-1fe090682621@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 12 May 2020 23:35:30 +0300
Message-ID: <CAMRbyyu=Q-EZoQcY8_JUQQOvMQ+K7W22wRf+BX+tGbShWweNYA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] qcow2: Expose bitmaps' size during measure
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 10:39 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 5/12/20 6:10 AM, Max Reitz wrote:
>
>
> >> This does not break old code since previously we always reported only
> >> guest visible content
> >> here, but it changes the semantics, and now you cannot allocate
> >> "required" size, you need
> >> to allocate "required" size with "bitmaps" size.
> >
> > Only if you copy the bitmaps, though, which requires using the --bitmap=
s
> > switch for convert.
>
> First, a usage question: would you rather that 'qemu-img convert
> --bitmaps' silently succeeds even when the image being converted has no
> bitmaps, or would you rather that it fails loudly when there are no
> bitmaps to be copied over?

I think the meaning of --bitmaps should be "copy also bitmaps".

This request makes sense only for qcow2 images, since other images do
not have bitmaps, so failing loudly when the source format does not support
bitmaps seems right.

Same for the target format does not support bitmaps, this is invalid reques=
t
and it should fail loudly.

If the source and target are qcow2, and there are no bitmaps in source, I d=
on't
see any reason to fail. We don't want to check if an image has bitmaps befo=
re
we copy the image, it does not help us.

> As implemented in this patch series, patch 8
> currently silently succeeds.

Sounds good for qcow2 format.

> But in order to make patch 7 and 8
> consistent with one another, I need to know which behavior is easier to
> use: failing convert if the source lacks bitmaps (and thus measure would
> suppress the bitmaps:0 output), or treating lack of bitmaps as nothing
> additional to copy and thereby succeeding (and thus measure should
> output bitmaps:0 to show that no additional space is needed because
> nothing else will be copied, successfully).

I don't think showing "bitmaps: 0" in measure is related to how --bitmaps
behave in convert. If we will have --bitmaps in measure, we don't need to
show "bitmaps" at all since "required" will include it.

If we want to show bitmaps in measure, I think using the same logic is fine=
:
- if format does not support bitmaps - fail
- if format suppots bitmaps, show what we have - zero is valid result when
  image does not have any bitmap.

> >> If we add a new
> >> extension all users will have to
> >> change the calculation again.
> >
> > It was my impression that existing users won=E2=80=99t have to do that,=
 because
> > they don=E2=80=99t use --bitmaps yet.
> >
> > In contrast, if we included the bitmap size in @required or
> > @fully-allocated, then previous users that didn=E2=80=99t copy bitmaps =
to the
> > destination (which they couldn=E2=80=99t) would allocate too much space=
.
> >
> > ...revisiting this after reading more of your mail: With a --bitmaps
> > switch, existing users wouldn=E2=80=99t suffer from such compatibility =
problems.
> >   However, then users (that now want to copy bitmaps) will have to pass
> > the new --bitmaps flag in the command line, and I don=E2=80=99t see how=
 that=E2=80=99s
> > less complicated than just adding @bitmaps to @required.
>
> More concretely, suppose down the road that we add the ability to copy
> internal snapshots (not that you want to mix internal and external
> snapshots, but that such information already exists and therefore can be
> used as an example).  Which is easier:
>
> $ qemu-img measure -f qcow2 image.qcow2
> required size: 8716288
> fully allocated size: 8716288
> bitmaps size: 1024
> internal snapshot size: 2048
>
> where you now have to add three numbers prior to creating dest.qcow2 and
> calling:
>
> $ qemu-img convert image.qcow2 -f dest.qcow2 --bitmaps --snapshots
>
> or using:
>
> $ qemu-img measure --bitmaps --snapshots -f qcow2 image.qcow2
> required size: 8719360
> fully allocated size: 8719360
>
> where you then call:
>
> $ qemu-img convert image.qcow2 -f dest.qcow2 --bitmaps --snapshots
>
> with a single size that matches the same arguments you pass to qemu-img
> convert?

Yes, the second form is a good example of using --bitmaps consistently.

>  What about failure cases?  What happens when qemu-img doesn't
> understand --snapshots but does understand --bitmaps?  Do you have to
> try a series of up to three calls to find how much information is support=
ed:
>
> $ qemu-img measure -f qcow2 image.qcow2 --bitmaps --snapshots
> error: unknown argument
> $ qemu-img measure -f qcow2 image.qcow2 --bitmaps
> error: unknown argument
> $ qemu-img measure -f qcow2 image.qcow2
> data given, now you know that neither --bitmaps nor --snapshots will work

Assuming that I cannot require a version that support both features, which =
is
usually the case when we have to support different platforms with
different versions
of qemu-img, I will check the capabilities using qemu-img --help and cache
the result. For vdsm case we control the host so qemu-img should not be upg=
raded
behind vdsm back.

Then I will use the supported features. If both are missing, this
convert will drop the
the bitmaps and the snaphosts, and the next incremetnal backup will
fail or fallback to
full backup.

> or is it nicer to issue just one measure without options, getting
> separate output lines, and seeing which output lines exist to know which
> convert options are supported, at the minor expense of having to add
> values yourself?

It is a little nicer since we don't need to check the capabilities,
but we need to
check them anyway for qemu-img convert, so this does not help much.

But it introduces other issues:

- we need to calculate the required size using required + bitmap or
required + bitmaps + snapshots

- what if measuring a snapshot is expensive - let's say take 20
seconds. This is still fast enough
  if the entire copy takes several minutes, so having a way to measure
is useful. But users that do not
  care about the snapshot have to pay for this one every call. So we
would end with a --snapshot flag
  to avoid this, and inconsistent API.

> And then back to my question: should 'measure --bitmaps' fail if there
> are no bitmaps to be measured, or silently succeed and not change the
> output size?

For raw file yes (invalid request), for qcow2 file no, it should just
add 0 since this is the actual
size required for bitmaps in this image.

> >> With the current way, to measure an image we need to do:
> >>
> >> qemu-img info --output json ...
> >> check if image contains bitmaps
> >> qemu-img measure --output json ...
> >> check if bitmaps are reported.
>
> Why do you have to check 'qemu-img info' first?  If measure reports
> bitmaps, then you know bitmaps can be copied;

This works only if qemu-img measure will report "bitmaps": 0 when there
are no bitmaps. Otherwise I don't know if this version does not report bitm=
aps
because it does not understand them, or because there are no bitmaps.

Using qemu-img info I can tell the difference if measure does not report 0.

> if it doesn't, then you
> can check info as a fallback path to compute size yourself - but
> computing the size yourself doesn't help unless you also have fallbacks
> to copy the bitmaps via QMP commands, because that qemu-img will also
> lack 'qemu-img convert --bitmaps' or 'qemu-img bitmaps' to do it via
> qemu-img.

When we started to work on this it was not clear that we will have a
way to measure
bitmaps. If we are going to have support both in convert and measure,
we can check
capability only in convert or only in measure.

> >> If image has bitmaps and bitmaps are not reported, we know that we hav=
e an old
> >> version of qemu-img that does not know how to measure bitmaps.
> >
> > Well, but you=E2=80=99ll also see that convert --bitmaps will fail.  Bu=
t I can
> > see that you probably want to know about that before you create the
> > target image.
> >
> >> If bitmaps are reported in both commands we will use the value when cr=
eating
> >> block devices.
> >
> > And otherwise?  Do you error out, or do you just omit --bitmaps from
> > convert?
> >
> >> If we always report bitmaps even when they are zero, we don't need to
> >> run "qemu-img info".
> >>
> >> But  my preferred interface is:
> >>
> >>     qemu-img measure --bitmaps ...
> >>
> >> And report bitmaps only if the user asked to get the value. In this
> >> case the required and
> >> fully-allocated values will include bitmaps.
> >
> > Well, it would be consistent with the convert interface.  If you specif=
y
> > it for one, you specify it for the other.
> >
> > OTOH, this would mean having to pass around the @bitmaps bool in the
> > block layer, which is a bit more difficult than just adding a new field
> > in BlockMeasureInfo.  It would also mean to add a new bool every time w=
e
> > add a new extension (which you hinted at above that it might happen).
>
> Or, that could be a CLI-only feature: the QMP interface _always_ reports
> bitmaps separately, but if 'qemu-img measure --bitmaps' is used, the CLI
> then adds that value in on your behalf after the QMP command but before
> printing to the end user.
>
> >
> > (We could also let img_measure() in qemu-img add @bitmaps to @required
> > if --bitmaps was given, so we wouldn=E2=80=99t have to pass the bool ar=
ound; but
> > I think letting qemu-img fix up a QAPI object filled by the block drive=
r
> > sounds wrong.  (Because that means the block driver didn=E2=80=99t fill=
 it
> > correctly.))
>
> If we only touch it up in the CLI, then we would have two forms of CLI
> output:
>
> $ qemu-img measure -f qcow2 image.qcow2
> required size: 8716288
> fully allocated size: 8716288
> bitmaps size: 1024
> $ qemu-img measure -f qcow2 image.qcow2 --bitmaps
> required size: 8717312
> fully allocated size: 8717312

I hope we will not have 2 forms. qemu-img is complicated enough ;-)

> > And I don=E2=80=99t see how the interface proposed here by Eric (or rat=
her, what
> > I think we had agreed on for the next version) poses any problems for
> > users.  If you want to copy bitmaps, you just use @required + @bitmaps.
> >   (If @bitmaps isn=E2=80=99t present, you can=E2=80=99t copy bitmaps, s=
o that should be
> > an error.)  If you don=E2=80=99t want to copy bitmaps, you just use @re=
quired.
> >
> > (And if you want to copy bitmaps if present, you use @required +
> > @bitmaps, and treat @bitmaps as 0 if not present.)
> >
> >> To learn if qemu-img measure understand bitmaps we can check --help
> >> output, like we did
> >> in the past until we can require the version on all platforms.
> >>
> >> An advantage is not having to change old tests.
> > I personally don=E2=80=99t really consider that a significant advantage=
...  (On
> > the contrary, seeing the field in all old tests means the code path is
> > exercised more often, even though it=E2=80=99s supposed to always just =
report 0.)
> >
> > So all in all the main benefit I see in your proposal, i.e. having
> > @bitmaps be included in @required with --bitmaps given, is that it woul=
d
> > give a symmetrical interface between measure and convert: For simple
> > cases, you can just replace the =E2=80=9Cconvert=E2=80=9D in your comma=
nd line by
> > =E2=80=9Cmeasure=E2=80=9D, retrieve @required/@fully-allocated, create =
the target image
> > based on that, and then re-run the same command line, but with =E2=80=
=9Cconvert=E2=80=9D
> > this time.
> >
> > But I=E2=80=99m not sure whether that=E2=80=99s really an advantage in =
practice or more
> > of a gimmick.  With Eric=E2=80=99s proposal, if you want to convert wit=
h
> > bitmaps, just add @bitmaps to the target size.  If you don=E2=80=99t, d=
on=E2=80=99t.  If
> > you=E2=80=99d prefer to but don=E2=80=99t really care, add =E2=80=9C@bi=
tmaps ?: 0=E2=80=9D.
> >
> > The benefit of Eric=E2=80=99s proposal (not including @bitmaps in @requ=
ired or
> > @fully-allocated) is that it doesn=E2=80=99t require passing an additio=
nal
> > parameter to the block driver.  It also makes the definition of
> > BlockMeasureInfo simpler.  With your proposal, it would need to be
> > parameterized.  (As in, @required sometimes includes the bitmaps,
> > sometimes it doesn=E2=80=99t, depending on the parameter used to retrie=
ve
> > BlockMeasureInfo.)  I=E2=80=99m not sure whether that even makes sense =
in the
> > QAPI definition.
>
> I'm leaning towards making v4 try a CLI-only 'measure --bitmaps', to see
> if I can speed the discussion along with concrete patches for comparison.

Thanks, that would be useful.

Nir


