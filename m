Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178FAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFE2207C4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6nbDxWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFE2207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajzj-0002HZ-5Y
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jajz9-0001pr-3l
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:55:31 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:35834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jajz7-0001m3-Ee
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:55:30 -0400
Received: by mail-il1-x144.google.com with SMTP id a14so5391393ilk.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wI+HdTBnUe3uknFemOmE9KXXz9v4wmjJWDeptio41qg=;
 b=B6nbDxWmxwJHXlljIN8q3TDtET/7A4gWg4syVbPDbzsXSYeFXR00jGETCzjA5beS+G
 iUNfQ2DUWXmXqRlD7ShwwUg2SxxTMTqNmT8Whsq4CtA0lRlFe0njlatlAE7iAb75wvC9
 4TaSrfxIBK+147VxSVYxY3H41xOPteWbDrWcUFGXa1qr7mEjmngsFNc9cOYpbVvHrTuZ
 vEn6rgPAfdkeXFbSSD09NgtgzwpEE3PHCJ+LO75lcCoGPyLmOgNt0whiPuCVZsgoFMAu
 4vrSuqsNdI04ll+Cg+xBesSJga+RteH/GMaAbXPjvbWXV2VHRT9l5+6Pj2MBd2kD2DMt
 ralw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wI+HdTBnUe3uknFemOmE9KXXz9v4wmjJWDeptio41qg=;
 b=mhiiQ3M00pxRCpIYnMFBIRR6JGIqb2T4oohKYAGE2lvbmWXgRpf+h2gmmDQwmLNLwS
 e7os3qZpqQ7F82D5ktBXO4CbwN0yn52D1/L3Yv4OcTOltRXDD/nsyh6uAa2OL47lHtoY
 QQPACy/1KaPM9dgthiRKuTHjTvdf1GSnNXrPPCHAN2Zz6iUrAThFyE4J1r17ZryuwiDW
 S1h+6sdcNR2m6ARtPDTM+zYhBcymdYJfwyBMH6I5wTydxFjg+YmjO6H6u7yW3LrnUGbm
 DwQzc/gnUhFTj8ZOmhvAIcxQJWIh/FrP2DCCqEp4x1/4bVS16JUHxxVAWYpUJCWnHRI3
 N+zw==
X-Gm-Message-State: AOAM530WcS5wcSPdLWKcnb7tkkJlzBRt/vj+Tnv1XZX7QJj39McYEqx+
 fCcqGOGdn1LAKZf3OKnwllUIK2HTvOtBnZN7frc=
X-Google-Smtp-Source: ABdhPJw+gNONjHCDDpyTqOn9bvqY5KZjUJ24qkhpqJDrMnXXMiVKW87KltY44thH0JoMI7TvVJ5a8tH1MCB+dcgt+lE=
X-Received: by 2002:a92:d40f:: with SMTP id q15mr15922521ilm.97.1589824527986; 
 Mon, 18 May 2020 10:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200518083704.52646-1-david@redhat.com>
 <20200518083704.52646-4-david@redhat.com>
 <CAKgT0UfNdU9quX75MrV0EQk-v0EP4w8g6UVFj2k2qRO=VUvRCQ@mail.gmail.com>
 <299d4475-bfd4-34b7-749f-ed11076d23c3@redhat.com>
In-Reply-To: <299d4475-bfd4-34b7-749f-ed11076d23c3@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 18 May 2020 10:55:16 -0700
Message-ID: <CAKgT0Ue68LYPFpOSM3sycOXBui+DiJXesxrkQaCYU3cw7WLgGw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: unref the iothread when unrealizing
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alexander.duyck@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Wei Wang <wei.w.wang@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 8:42 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 18.05.20 17:35, Alexander Duyck wrote:
> > On Mon, May 18, 2020 at 1:37 AM David Hildenbrand <david@redhat.com> wr=
ote:
> >>
> >> We took a reference when realizing, so let's drop that reference when
> >> unrealizing.
> >>
> >> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"=
)
> >> Cc: Wei Wang <wei.w.wang@intel.com>
> >> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/virtio/virtio-balloon.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >> index a4fcf2d777..3f8fc50be0 100644
> >> --- a/hw/virtio/virtio-balloon.c
> >> +++ b/hw/virtio/virtio-balloon.c
> >> @@ -820,6 +820,7 @@ static void virtio_balloon_device_unrealize(Device=
State *dev)
> >>
> >>      if (s->free_page_bh) {
> >>          qemu_bh_delete(s->free_page_bh);
> >> +        object_unref(OBJECT(s->iothread));
> >>          virtio_balloon_free_page_stop(s);
> >>          precopy_remove_notifier(&s->free_page_report_notify);
> >>      }
> >
> > I'm not entirely sure about this order of operations. It seems like it
> > would make more sense to remove the notifier, stop the hinting, delete
> > the bh, and then release the IO thread.
>
> This is the reverse order of the steps in
> virtio_balloon_device_realize(). And I guess it should be fine. The
> notifier cannot really be active/trigger while we are removing devices
> (cannot happen with concurrent migration). After qemu_bh_delete(), the
> iothread is effectively unused.
>
> I am unsure about many things regarding free page hinting (e.g., if the
> virtio_balloon_free_page_stop() is of any use while we are ripping out
> the device and it will be gone in a second).

Agreed. This is probably fine as is.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

