Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF3FC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F412072C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGsa8Twb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F412072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYZrR-0000IB-Fv
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 15:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kYZqr-0008HM-Fp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 15:14:17 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kYZqp-0006mz-OD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 15:14:17 -0400
Received: by mail-pl1-x643.google.com with SMTP id z1so3411771plo.12
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IaR/9cBwNNJPGGsMHuHGLucttMdJ9l0s3AiAYq/Q2Oc=;
 b=oGsa8Twbkd0e7qtqgbLgKM8zmLlulEn7J4Y+VK2awtJEcs7O+H+0qvFE/6ty+LdSmt
 ybIlZYhRpIPZvn5JAiifF6oKpxJ8x5030TjLfjq7YjxV31YV7IpwGEufBkJst7Qw6+Ay
 /F5obIoSd/ZrwZyIxkLVAzQDo85pq3eBZiM4UDWqpi+c1tChAcWzeBZrCpsDVh6INtk2
 RmYeXfV23F2gvgdLdAW1PRijvaAX4fk0woiWZtpLBYxWBLLhhOxq0QEoFfSYrdYKoHzr
 FIB1eyzUzV3iYmomv0w1oAE+mhC36S1PpwrS0YjSnCh4ZAOvgPqhr303aKGptS8j9uyY
 k58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IaR/9cBwNNJPGGsMHuHGLucttMdJ9l0s3AiAYq/Q2Oc=;
 b=dXVTlqkzhtqL8tPbRlfdiG684s1XJPpQoNY/eH9Rh1BZSHX0DVHij7CGyN+s44tHV1
 HdU27MGioBUz4FqNCcRuNzyI4R2PZ5Gs44AM1ZQ1jS8GD2DcdNxOSOy4JnzvaYTMpz7F
 sQ5+K7l52wE+BBQEqEF5ZfGyXet4Upvho1n4Lefc5G27gU7h4+4JQB3xx4LgGw04AxFN
 Iqv2WaLNZxBXyKvhNLL7CBdP8VC9jUgxHRqertTVrg8RS67IyIFXtsGqkhgPxGYkYaSc
 FC7ysweqtCZKpqiZwX+Kdqn3fuzIfCU2QtyO8oUdvQh4Kn7/lBvIrVW0tXsYe4e5ZHlv
 KIZw==
X-Gm-Message-State: AOAM533lpnsnmnqHhc0ii1Zutp+Emss5zIPVXb3w0U2KwK3phr8twGEq
 0kNxwviHLm+aAI73XYCb10Y6tND2I8xMU7R8rj4=
X-Google-Smtp-Source: ABdhPJzFkbRn2TYVf+3qzDu4OPf3UZbAOkDI/LyB0a8gXLFSSQDuZCTtAmhwO29N0k6p3sji/d5bGWAvc9g+MbUkA8o=
X-Received: by 2002:a17:902:59cd:b029:d6:7656:af1 with SMTP id
 d13-20020a17090259cdb02900d676560af1mr10196066plj.43.1604085254262; Fri, 30
 Oct 2020 12:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
 <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200929103743.GB181609@stefanha-x1.localdomain>
 <2E6DF2C2-A3C3-404D-BB2E-B53B3555EB66@oracle.com>
 <20200930142408.GA320669@stefanha-x1.localdomain>
 <E0C4979F-157D-4ADC-9FCF-23A70FB6C931@nutanix.com>
 <20201013093056.GA164611@stefanha-x1.localdomain>
 <A375B06C-FA78-4392-A569-AE494EEF9870@nutanix.com>
In-Reply-To: <A375B06C-FA78-4392-A569-AE494EEF9870@nutanix.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 30 Oct 2020 19:14:02 +0000
Message-ID: <CAJSP0QXx4iqKYTrFnjW=iTmfC=nQ6T6+dS69vwYi2zdW-4riag@mail.gmail.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 2:39 PM Felipe Franciosi <felipe@nutanix.com> wrote:
> > On Oct 13, 2020, at 10:30 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:> >
> > On Fri, Oct 02, 2020 at 10:14:23AM +0000, Felipe Franciosi wrote:
> >>> On Sep 30, 2020, at 3:24 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >>> On Tue, Sep 29, 2020 at 09:21:54AM -0700, John G Johnson wrote:
> >>>>> On Sep 29, 2020, at 3:37 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >>>>>
> >>>>> On Mon, Sep 28, 2020 at 09:58:37AM +0000, Thanos Makatos wrote:
> Per Daniel's response on the other fork of the thread, I think we can
> develop faster if we're not depending on qemu-devel. With the right
> set of maintainers on the project, there's arguably more flexibility
> in working at a restricted set of code. QEMU can then update the
> submodule when a "checkpoint" is ready.

Sure, if you are happy with the submodule approach that's great.

On the QEMU side the device name should have an "x-" prefix so it's
clear that the feature is experimental and subject to change. This way
there is no stability guarantee during development. Both the protocol
and command-line can be changed without introducing feature bits and
keeping backwards compatibility.

Stefan

