Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B759C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2503721882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lqs4MEAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2503721882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinQt-0003TQ-0J
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hinEc-0005O9-AY
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hinEZ-0003q5-E7
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hinEY-0003nn-6j
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id b2so3185110wrx.11
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=h6u9F/geRa63hpdMCTr8mStUfzXNa8Q4PIsT83eVxoU=;
 b=Lqs4MEANoVn3/RvQE+vfPBGNKmGaGmsVDrv3vcqWq5xInkqPvOsldZkERhzNrbE9+E
 VAXb7kkQr7ECUtCf4KRcFr4DiL/yTOjf8kMbnv/8UUcoy6yBw/gC45Fh2R90SH+YyZPW
 y+duE2eGLKlti+QPtTHARnFTxt+1+HP5jDMxGKhTf2uTqMXt8ED0BJgeWHmmEs9HyS8F
 7VEudp6lVf+YT84IQN7o77O6P2yHdLjnaFXVrqlMv7zdZ/iLJ2Dwps/qMHuy+MJjTQQJ
 URKc1C+NA8wp9UFj5zaC8alWoLqDLlvWBTjm3FOfSZ2l5Ur5hwTgif9LGtmhfHNzMjeA
 UYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=h6u9F/geRa63hpdMCTr8mStUfzXNa8Q4PIsT83eVxoU=;
 b=pemMo+Irpm7lqaJLN/w76MpO6qw87OGGRUq6kOtrcX1649RPzYuZP5iPiw9hR8DVP2
 Y8SzkWJ3fqXC/8VNrqsOS3EyDehC82UJXW9kuEp/7MUBXtsf8QRols6EB+Y0YMsQ0BlS
 cft0Ato4V9Z7nqEwmGhItUFeHOPzGACKM/z9Zwc42LgfidqikOJb7AWqEv3hmsP86FEG
 MtHimTbltdCNqoEMKltqVpKr26yZaa76eb895WoYbM98B06yQaO768iNXp+KyKOmsJSP
 X9JCVOqce0rqUWP9Y+z9+kB8PsD8mkEd1H5tZoai4xXLeIsWsR6DGzhghyXmcqM3x29y
 1uxw==
X-Gm-Message-State: APjAAAVOUm0dc2iIsnL0xrlSnZlTQmtP1sqZVRp4cG6EFCAXe7YkXwH9
 C1+Kk3cYaRCVEHdYO8EyIDggJQ==
X-Google-Smtp-Source: APXvYqyYoWIJ6lSDssVG5XL0AiJBmU/GvMIt+lOJdmpiGRlq8noq+0AEVhd/buNgw6hXA1ulx8l0eg==
X-Received: by 2002:adf:f30e:: with SMTP id i14mr15977184wro.59.1562190966762; 
 Wed, 03 Jul 2019 14:56:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x129sm3218288wmg.44.2019.07.03.14.56.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 14:56:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B31B81FF87;
 Wed,  3 Jul 2019 22:56:05 +0100 (BST)
References: <20190703135411.28436-1-berrange@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190703135411.28436-1-berrange@redhat.com>
Date: Wed, 03 Jul 2019 22:56:05 +0100
Message-ID: <87k1cywznu.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] doc: document that the monitor console is
 a privileged control interface
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, P J P <ppandit@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> A supposed exploit of QEMU was recently announced as CVE-2019-12928
> claiming that the monitor console was insecure because the "migrate"
> comand enabled arbitrary command execution for a remote attacker.
>
> For this to be a flaw the user launching QEMU must have configured
> the monitor in a way that allows for other userrs to access it. The
> exploit report quoted use of the "tcp" character device backend for
> QMP.
>
> This would indeed allow any network user to connect to QEMU and
> execute arbitrary comamnds, however, this is not a flaw in QEMU.
> It is the normal expected behaviour of the monitor console and the
> commands it supports. Given a monitor connection, there are many
> ways to access host filesystem content besides the migrate command.
>
> The reality is that the monitor console (whether QMP or HMP) is
> considered a privileged interface to QEMU and as such must only
> be made available to trusted users. IOW, making it available with
> no authentication over TCP is simply a, very serious, user
> configuration error not a security flaw in QEMU itself.

Is this the sort of thing we should emit warnings for? I guess this is a
philosophical question as QEMU tends to err towards being taciturn on
the command line unless something is actually wrong (and not just
stupid).

I wouldn't expect a warning for -serial mon:stdio but maybe a
non-localhost tcp chardev for o+rw socket might be worth a mention? Of
course this sort of sanitising of the command line options does incur
cost and complexity in our option processing.

>
> The one thing this bogus security report highlights though is that
> we have not clearly documented the security implications around the
> use of the monitor. Add a few paragraphs of text to the security
> docs explaining why the monitor is a privileged interface and making
> a recommendation to only use the UNIX socket character device backend.

However extra clarity is always welcome, modulo typos and grammar
suggestions the others have made:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/security.texi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/docs/security.texi b/docs/security.texi
> index 927764f1e6..5bff01449d 100644
> --- a/docs/security.texi
> +++ b/docs/security.texi
> @@ -129,3 +129,39 @@ those resources that were granted to it.
>  system calls that are not needed by QEMU, thereby reducing the host kern=
el
>  attack surface.
>  @end itemize
> +
> +@section Sensitive configurations
> +
> +There are aspects of QEMU that can have non-obvious security implications
> +which users & management applications must be aware of.
> +
> +@subsection Monitor console (QMP and HMP)
> +
> +The monitor console (whether used with QMP or HMP) provides an RPC inter=
face
> +to dynamically control many aspects of QEMU's runtime operation. Many of=
 the
> +commands exposed will instruct QEMU to access content on the host filesy=
system
> +and/or trigger spawning of external processes.
> +
> +For example, the @code{migrate} command allows for the spawning of arbit=
rary
> +processes for the purpose of tunnelling the migration data stream. The
> +@code{blockdev-add} command instructs QEMU to open arbitrary files, expo=
sing
> +their content to the guest as a virtual disk.
> +
> +Unless QEMU is otherwise confined using technologies such as SELinux, Ap=
pArmor,
> +or Linux namespaces, the monitor console should be considered to have pr=
ivileges
> +equivalent to those of the user account QEMU is running under.
> +
> +It is further important to consider the security of the character device=
 backend
> +over which the monitor console is exposed. It needs to have protection a=
gainst
> +malicious third parties which might try to make unauthorized connections=
, or
> +perform man-in-the-middle attacks. Many of the character device backends=
 do not
> +satisfy this requirement and so must not be used for the monitor console.
> +
> +The general recommendation is that the monitor console should be exposed=
 over
> +a UNIX domain socket backend to the local host only. Use of the TCP based
> +character device backend is inappropriate unless configured to use both =
TLS
> +encryption and authorization control policy on client connections.
> +
> +In summary the monitor console is considered a privileged control interf=
ace to
> +QEMU and as such should only be made accessible to a trusted management
> +application or user.


--
Alex Benn=C3=A9e

