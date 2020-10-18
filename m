Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171CFC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 15:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA5A21D7F
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 15:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBetzPrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA5A21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUB2D-0007EW-6q
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 11:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luto@kernel.org>) id 1kUB1L-0006lD-Om
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 11:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luto@kernel.org>) id 1kUB1I-0003cx-Bt
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 11:54:55 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB34122201
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603036491;
 bh=Ij8hCcQO2WHfMKXqZ9b6mcj8QwkRUY/6wK0sNA0dh5k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=uBetzPrS68y8aDFcxVbITPIt7cbLg3eTcT1j1dzz5xLultMfRuj1Je6Sl5Debetpz
 iPfcfj8sdam5FA9VTZTAl3d2BLJwwtycOofdPqfnyebtP4geLDoCb2KlMjV2LPD7X7
 3AMtEhJoxgvF5zMKDHiUYMqGJkYjn2gCcjlrYkJ4=
Received: by mail-wm1-f51.google.com with SMTP id z22so4135731wmi.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 08:54:50 -0700 (PDT)
X-Gm-Message-State: AOAM532LngyenQD9fTJlOAAkt3uXxI+gPX9/w40Sc9OWNXNlZaMBMz84
 P/nbqblFDLEh+MGkLkhW9mM8TSfr7RFYFNQ509ExbQ==
X-Google-Smtp-Source: ABdhPJzOzWCZEG9azNTIf9qwP5griKMHkVzCTru01xShRnsJyxl7Sq+uw//hwIlw3LWqPCYWr/akWwABt07P/Tsxr5M=
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr13689655wmm.138.1603036488608; 
 Sun, 18 Oct 2020 08:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <20201018114625-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201018114625-mutt-send-email-mst@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 18 Oct 2020 08:54:36 -0700
X-Gmail-Original-Message-ID: <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
Message-ID: <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=198.145.29.99; envelope-from=luto@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 11:54:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 "Singh, Balbir" <sblbir@amazon.com>, bonzini@gnu.org, "Graf \(AWS\),
 Alexander" <graf@amazon.de>, Michal Hocko <mhocko@kernel.org>,
 Jann Horn <jannh@google.com>, oridgar@gmail.com, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 Colm MacCarthaigh <colmmacc@amazon.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, Willy Tarreau <w@1wt.eu>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 18, 2020 at 8:52 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Oct 17, 2020 at 03:24:08PM +0200, Jason A. Donenfeld wrote:
> > 4c. The guest kernel maintains an array of physical addresses that are
> > MADV_WIPEONFORK. The hypervisor knows about this array and its
> > location through whatever protocol, and before resuming a
> > moved/snapshotted/duplicated VM, it takes the responsibility for
> > memzeroing this memory. The huge pro here would be that this
> > eliminates all races, and reduces complexity quite a bit, because the
> > hypervisor can perfectly synchronize its bringup (and SMP bringup)
> > with this, and it can even optimize things like on-disk memory
> > snapshots to simply not write out those pages to disk.
> >
> > A 4c-like approach seems like it'd be a lot of bang for the buck -- we
> > reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
> > userspace API to deal with, and it'd be race free, and eliminate a lot
> > of kernel complexity.
>
> Clearly this has a chance to break applications, right?
> If there's an app that uses this as a non-system-calls way
> to find out whether there was a fork, it will break
> when wipe triggers without a fork ...
> For example, imagine:
>
> MADV_WIPEONFORK
> copy secret data to MADV_DONTFORK
> fork
>
>
> used to work, with this change it gets 0s instead of the secret data.
>
>
> I am also not sure it's wise to expose each guest process
> to the hypervisor like this. E.g. each process needs a
> guest physical address of its own then. This is a finite resource.
>
>
> The mmap interface proposed here is somewhat baroque, but it is
> certainly simple to implement ...

Wipe of fork/vmgenid/whatever could end up being much more problematic
than it naively appears -- it could be wiped in the middle of a read.
Either the API needs to handle this cleanly, or we need something more
aggressive like signal-on-fork.

--Andy

