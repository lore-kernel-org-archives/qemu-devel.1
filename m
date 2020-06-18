Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FBFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0A6206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/GUohpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0A6206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwG2-0001x9-SM
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jlwFD-0000kQ-K1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:14:23 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:37987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jlwFB-0002oZ-PK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:14:23 -0400
Received: by mail-il1-x144.google.com with SMTP id b5so6119240iln.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4/1gNELQfCCNGNLFNnXOXrVd+BzTq31Pwjzw+QNFHWI=;
 b=k/GUohpW+yGJ5H/xbpc2JvzCR9J0Wn7qMOrmcATgti+u+aDZiOe99+hwExZJtnnoG/
 0VFaHrAjuvSHJx7UlHA0tPGYuQGD3uDQKXpq528l6DsM9l3Nuz2S9Khq6QX9Q4vn19/n
 bkF3AzQnZIbdcqphRI/eMcipXKaOiw+xYf6IBwOZGaBNdjzX3AaFd3FUHS0WknMGccTP
 G+K/uc5F/TsCRNeGje06vW26PxCGRbnveM3rhCq99tFtnnUA0RJsj9xid3f9F5bKtASz
 mfd+n1/heN+ckJ/VWBlK2ySRxb+wfOaClWLA2/RSG80wTMbHrAOizjCRtRISXchy+Ryt
 wRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4/1gNELQfCCNGNLFNnXOXrVd+BzTq31Pwjzw+QNFHWI=;
 b=MSiSSHNkkJO18skKYIQ1ncXOkpY3W/tjv75Tj1wud1WTyZCVrrTWSrm8x7ZvSBBD9N
 McxNCliMt0SXJmHyE7DVqMLPv6grbhXRthSskoidR+zq3ctmJHmKh4l+5/yxb1AYEJ2R
 L4p9A4Dl4e1mQw79W6KrqCQ4o8WqzqfsXpe4N8lW1Fo6/nkg1X1L5xniAaVMHL6wh4IJ
 KB3HYeAg2HzpE16CndwZVDhVk/PiVfIG/3W1fdxAbAhQwh6TjBwuqJqyi1OzKs0lSzG2
 5gkM3KatcOkqaBkLmjdO9STGxGpzOH5xHxdS9qbeuV30SY7y69K5aM4WafA0fgEmklm9
 9XUg==
X-Gm-Message-State: AOAM530uC/B+jWD7CKuVlcjs7etNSLb1/taHthzmZt2BsydB6T8I014J
 IPDXF3AD1AIpKZUk9xK5D+uJSG6MgThBv7vNP62EHeE0
X-Google-Smtp-Source: ABdhPJzK0CXk6fU6/JPqUfJ8Sn/xG9Unr4S2lHWIdj+FDn7xdHvGUjg8gp2D+KSyW7vn4lOZVqxCr09kB/n63kcXWgM=
X-Received: by 2002:a92:c904:: with SMTP id t4mr4392600ilp.95.1592493260070;
 Thu, 18 Jun 2020 08:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
In-Reply-To: <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 18 Jun 2020 08:14:09 -0700
Message-ID: <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
Subject: Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alexander.duyck@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 5:54 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 13.06.20 22:07, Alexander Duyck wrote:
> > On Tue, May 26, 2020 at 9:14 PM Alexander Duyck
> > <alexander.duyck@gmail.com> wrote:
> >>
> >> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>
> >> In an upcoming patch a feature named Free Page Reporting is about to be
> >> added. In order to avoid any confusion we should drop the use of the word
> >> 'report' when referring to Free Page Hinting. So what this patch does is go
> >> through and replace all instances of 'report' with 'hint" when we are
> >> referring to free page hinting.
> >>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >> ---
> >>  hw/virtio/virtio-balloon.c         |   78 ++++++++++++++++++------------------
> >>  include/hw/virtio/virtio-balloon.h |   20 +++++----
> >>  2 files changed, 49 insertions(+), 49 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >> index 3e2ac1104b5f..dc15409b0bb6 100644
> >> --- a/hw/virtio/virtio-balloon.c
> >> +++ b/hw/virtio/virtio-balloon.c
> >
> > ...
> >
> >> @@ -817,14 +817,14 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
> >>      return 0;
> >>  }
> >>
> >> -static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
> >> +static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
> >>      .name = "virtio-balloon-device/free-page-report",
> >>      .version_id = 1,
> >>      .minimum_version_id = 1,
> >>      .needed = virtio_balloon_free_page_support,
> >>      .fields = (VMStateField[]) {
> >> -        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
> >> -        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
> >> +        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
> >> +        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
> >>          VMSTATE_END_OF_LIST()
> >>      }
> >>  };
> >
> > So I noticed this patch wasn't in the list of patches pulled, but that
> > is probably for the best since I believe the change above might have
> > broken migration as VMSTATE_UINT32 does a stringify on the first
> > parameter.
>
> Indeed, it's the name of the vmstate field. But I don't think it is
> relevant for migration. It's and indicator if a field is valid and it's
> used in traces/error messages.
>
> See git grep "field->name"
>
> I don't think renaming this is problematic. Can you rebase and resent?
> Thanks!

Okay, I will.

> > Any advice on how to address it, or should I just give up on renaming
> > free_page_report_cmd_id and free_page_report_status?
> >
> > Looking at this I wonder why we even need to migrate these values? It
> > seems like if we are completing a migration the cmd_id should always
> > be "DONE" shouldn't it? It isn't as if we are going to migrate the
>
> The *status* should be DONE IIUC. The cmd_id might be relevant, no? It's
> always incremented until it wraps.

The thing is, the cmd_id visible to the driver if the status is DONE
is the cmd_id value for DONE. So as long as the driver acknowledges
the value we could essentially start over the cmd_id without any
negative effect. The driver would have to put down a new descriptor to
start a block of hinting in order to begin reporting again so there
shouldn't be any risk of us falsely hinting pages that were in a
previous epoch.

Ugh, although now looking at it I think we might have a bug in the
QEMU code in that the driver could in theory force its way past a
"STOP" by just replaying the last command_id descriptor and then keep
going. Should be a pretty easy fix though as we should only allow a
transition to S_START if the status is S_REQUESTED/

> > hinting from one host to another. We will have to start over which is
> > essentially the signal that the "DONE" value provides. Same thing for
> > the status. We shouldn't be able to migrate unless both of these are
> > already in the "DONE" state so if anything I wonder if we shouldn't
> > have that as the initial state for the device and just drop the
> > migration info.
>
> We'll have to glue that to a compat machine unfortunately, so we can
> just keep migrating it ... :(

Yeah, I kind of figured that would be the case. However if the name
change is not an issue then it should not be a problem.

Thanks.

- Alex

