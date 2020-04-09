Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF84EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A569D2082D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaJ1ckvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A569D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMX4r-0001ip-QL
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1jMX2e-000806-Hp
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1jMX2b-0005JH-B8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:16:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33829
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1jMX2b-0005Is-1C
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586438180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRExIM2Z2m5qDrESh7Oi3RNfeWIJhsVi+U/vpkAR0rw=;
 b=SaJ1ckvq+qt3qHRBBg7Kv7pvuYK4Yquf9gF7m5jKgfrjycw0+Z7I6PyCfpicat6ECVdzcn
 v0572XcWxkVSnunO7OgsLX1XJ79m0zftnHU/VH/qrBCVdybAWBf6BK5Ol7FU3Dh6nTR/Cb
 8xOpxhQdgDFzq8nGMlQL/h9acXwOuGg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-5aJPXa-5PG6lRMYPGtfZdA-1; Thu, 09 Apr 2020 09:16:13 -0400
X-MC-Unique: 5aJPXa-5PG6lRMYPGtfZdA-1
Received: by mail-io1-f71.google.com with SMTP id a16so3376133ios.9
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 06:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hr07qM0B92ytmiO12hneByD+ycutNapukJr649WflaQ=;
 b=NN35Ju0O4j8GM/Otz6dO1h80VsaHJ5wwvOkvyaatLHH8Te5eNYTpPgSl1tdxYnVgvF
 JOf18EZk4CZ1jiBFJ6+qF+UoP/kPPyM41E7LC9/yYinn+swkXfAFujvFAnVRuypIAXDS
 jsb5tuCEx7Lze2tIR8i+NOQ9WfXbeF/IS1ElYEAtRXkg1RpErfu5KTggD3PBkmnSWOBZ
 EgoveEQ8Ro89tkMEg1OATB0/UQid+RwX0QWGPu/KtHX+MLIdeWUDMxxcLLFyZc2geSil
 nfKF1RMJoQeXVdxMAtPw3L+e8R7+WKtBT/ohU8XH7XEBCOl2nUt2yrgUbYcB256RFGz9
 qwTg==
X-Gm-Message-State: AGi0PuYQMapTZJAbBk/gyVGsBDPwM5URg+nucwD9TX+MLod61qhPGvnd
 y6xfpXaWnLUsgLVBavzMOSQ2XF7606ZMo0sT4oNSrGkgY1suhwlZS5Rjq063vgfSNX71zGeQKGG
 QvWiFQ+7nEQzP7sdBexRhUbeLEuCiOP4=
X-Received: by 2002:a92:91d6:: with SMTP id e83mr5222831ill.165.1586438173008; 
 Thu, 09 Apr 2020 06:16:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKumHX6pFF+L99C61k7Rtw9tHy9pvrnlMG6E6wd0FWKTuXS4ReUYF2Ue8J9YJ/MyHjuEVt/FCeRCsl1wNeb8kU=
X-Received: by 2002:a92:91d6:: with SMTP id e83mr5222798ill.165.1586438172709; 
 Thu, 09 Apr 2020 06:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200409124601.toh6jpbfcwiwzb6z@r>
In-Reply-To: <20200409124601.toh6jpbfcwiwzb6z@r>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 9 Apr 2020 15:16:01 +0200
Message-ID: <CAMxuvayJjHH_dqyoPCweQDysubzv=bKnJqgp9TxZNcNKnLTJhw@mail.gmail.com>
Subject: Re: Replace GSource with AioContext for chardev
To: Coiby Xu <coiby.xu@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Apr 9, 2020 at 2:46 PM Coiby Xu <coiby.xu@gmail.com> wrote:
>
>
> Hi,
>
> I'm now implementing vhost-user block device backend
> https://patchew.org/QEMU/20200309100342.14921-1-coiby.xu@gmail.com/
> and want to use chardev to help manage vhost-user client connections
> and read socket message. However there are two issues that need to be
> addressed.
>
> Firstly, chardev isn't suitable for the case when exported drive is
> run in an IOThread because for mow chardev use GSource to dispatch
> socket fd events. So I have to specify which IOThread the exported
> drive is using when launching vhost-user block device backend,
> for example, the following syntax will be used,
>
>    -drive file=3Dfile.img,id=3Ddisk -device virtio-blk,drive=3Ddisk,iothr=
ead=3Diothread0 \
>     -object vhost-user-blk-server,node-name=3Ddisk,chardev=3Dmon1,iothrea=
d=3Diothread0 \
>     -object iothread,id=3Diothread0 \
>     -chardev socket,id=3Dmon1,path=3D/tmp/vhost-user-blk_vhost.socket,ser=
ver,nowait
>
> then iothread_get_g_main_context(IOThread *iothread) has to be called
> to run the gcontext in IOThread. If we use AioContext to dispatch socket
> fd events, we needn't to specify IOThread twice. Besides aio_poll is fast=
er
> than g_main_loop_run.
>
> Secondly, socket chardev's async read handler (set through
> qemu_chr_fe_set_handlers) doesn't take the case of socket short read
> into consideration.  I plan to add one which will make use qio_channel_yi=
eld.
>
> According to
> [1] Improving the QEMU Event Loop - Linux Foundation Events
> http://events17.linuxfoundation.org/sites/events/files/slides/Improving%2=
0the%20QEMU%20Event%20Loop%20-%203.pdf
>
> "Convert chardev GSource to aio or an equivalent source" (p.30) should ha=
ve
> been finished. I'm curious why the plan didn't continue. If it's desirabl=
e,
> I'm going to finish the leftover work to resolve the aforementioned two i=
ssues.

Converting all chardevs to Aio might be challenging, and doesn't bring
much benefits imho.

Perhaps a better approach would be to rely on a new chardev API to
steal the chardev underlying fd or QIO... (mostly keeping -chardev for
CLI/QMP compatibility reason - although breaking some chardev features
that imho aren't compatible with all use cases, like replay, muxing,
swapping etc). The chardev should probably be removed after that...


