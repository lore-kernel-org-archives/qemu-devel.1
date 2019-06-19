Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BCBC31E51
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 03:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878B22082C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 03:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2Dxdj37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878B22082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdRP2-00062q-Ff
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 23:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pranith.foss@gmail.com>) id 1hdRMu-00053M-Pu
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 23:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pranith.foss@gmail.com>) id 1hdRMr-0005um-IH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 23:34:39 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:43000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pranith.foss@gmail.com>)
 id 1hdRMp-0005sf-7Y
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 23:34:35 -0400
Received: by mail-yw1-xc43.google.com with SMTP id s5so7690812ywd.9
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w1jrST3D2wsYWnNM7GCd1R+zZuiIK/PUj4yXwJJavjk=;
 b=q2Dxdj375XMEmgzXCzzX0ZFXj7AshOvSE1jAAZzR0vaI1qzEvik45jd2WUdJw09CHW
 kduzuPswUOOoM9y7lB2VNR5qINmDb6RBPyxXEfeWYPj4mSdNz2FM5J2apwWE+cU3mfzn
 y2i2EVBWGdPuPuGEREyFK9CmFSnsEGm3C55EJ3+bjJuIi8FD1zg0IVTH88TFZV9Uor0T
 2NoP8wZnOM+t90xD6lYKb7k+QcI7vZiNMKBmQkeZT1EL/NFu6TuiDXoe1iYIIkA1AV7V
 Ly+LluMLo0huYsv+r8gtNCDGZVeQjn6DCmTI0LlokHLFi0VcfnQ2zGmSZnJZs9jY7Ows
 kHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w1jrST3D2wsYWnNM7GCd1R+zZuiIK/PUj4yXwJJavjk=;
 b=gX5DOtpiLurjkwgTs6pyM84j5gbU07jtmlRvwPC8GIsn2d7biA1yNmuy194olYS0df
 KqN8p7WhdV5cjnSPBGiQyciRoPyt9NSJUbv4Hrlw82SAO6+PiQ1wv3tVvhvuFkJRbv+d
 4Zj1zHdLSSUxVcJa+22mLrWwALW5ncyNbfPJ3ldjqmBI4obpJ2rXNrb8yesUr36rTPKz
 FjH/kazO6fKYLfnQupHgHnkF8OSBPQNDsVws1AIOZ+FOlEVTSd+c2YV7ou+IOzLJnLHD
 0Xbaz0ZY+X0u6wpjNnViwtXp20Xb/jXcYYhkB53oHhM+LBe6RS1K+cDttxeGdVRIYc8E
 D9zA==
X-Gm-Message-State: APjAAAV/ce/ddD/wGIbtKE4ry8qJInUk41IOItA4dEws4tYY+iJMkzB/
 gB3AZcyk0XUvJf4LMdEIqkDDonCFR8L5DNp1XIg=
X-Google-Smtp-Source: APXvYqypG3j3ewQnmaCsBGuAWLx/6yRG+UxeuddTWaQ8frnskdNsXPU+L/DNWJNp1nWYrRruMKuLO3ueJMkcv+AZ4jg=
X-Received: by 2002:a81:2702:: with SMTP id n2mr57162935ywn.464.1560915271894; 
 Tue, 18 Jun 2019 20:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-6-alex.bennee@linaro.org>
In-Reply-To: <20190614171200.21078-6-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 18 Jun 2019 20:34:20 -0700
Message-ID: <CADYwmhHjfqDi_vXWnp_z9UUr2Lxvw6F8op3KJQqvU3Wog43f_Q@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: Re: [Qemu-devel] [PATCH v3 05/50] docs/devel: add plugins.rst
 design document
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Fri, Jun 14, 2019 at 10:21 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> This is mostly extracted from Emilio's more verbose commit comments
> with some additional verbiage from me.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/index.rst   |  1 +
>  docs/devel/plugins.rst | 99 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 docs/devel/plugins.rst
>
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 2a4ddf40ad..7e6d20c970 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -21,3 +21,4 @@ Contents:
>     testing
>     decodetree
>     secure-coding-practices
> +   plugins
> diff --git a/docs/devel/plugins.rst b/docs/devel/plugins.rst
> new file mode 100644
> index 0000000000..b0c30375ef
> --- /dev/null
> +++ b/docs/devel/plugins.rst
> @@ -0,0 +1,99 @@
> +..
> +   Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
> +   Copyright (c) 2019, Linaro Limited
> +   Written by Emilio Cota and Alex Benn=C3=A9e
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +QEMU TCG Plugins
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU TCG plugins provide a way for users to run experiments taking
> +advantage of the total system control emulation can have over a guest.
> +It provides a mechanism for plugins to subscribe to events during
> +translation and execution and optionally callback into the plugin
> +during these events.
> +
> +API Stability
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This is a new feature for QEMU and it does allow people to develop
> +out-of-tree plugins than can be dynamically linked into a running QEMU

s/than/that/

> +process. However the project reserves the right to change or break the
> +API should it need to do so.
> +
> +Exposure of QEMU internals
> +--------------------------
> +
> +The plugin architecture actively avoids leaking implementation details
> +about how QEMU's translation works to the plugins. While there are
> +conceptions such as translation time and translation blocks the
> +details are opaque to plugins. The plugin is able to query select
> +details of instructions and system configuration only through the
> +exported *qemu_plugin* functions. The types used to describe
> +instructions and events are opaque to the plugins themselves.
> +
> +Usage
> +=3D=3D=3D=3D=3D
> +
> +The QEMU binary needs to be compiled for plugin support:
> +
> +::
> +    configure --enable-plugins
> +
> +Once built a program can be run with multiple plugins loaded each with
> +their own arguments:
> +
> +::
> +    $QEMU $OTHER_QEMU_ARGS \
> +      -plugin tests/plugin/libhowvec.so,arg=3Dinline,arg=3Dhint \
> +      -plugin tests/plugin/libhotblocks.so

I think this might be a good place to describe what these arguments are.

> +
> +Plugin Life cycle
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +First the plugin is loaded and the public qemu_plugin_install function
> +is called. The plugin with then register callbacks for various plugin

s/with/will/

> +events. Generally at least the atexit_cb is registered so the plugin
> +can dump its information at the end of a run.

Is that a hard requirement?

> +
> +When a registered event occurs the plugin callback is called. The

I would prefer 'callback is invoked'.

> +callbacks may provide additional information. In the case of a
> +translation event the plugin has an option to enumerate the
> +instructions in a block of instructions and optionally register
> +callbacks to some or all instructions when they are executed.
> +
> +There is also a facility to add an inline event where code to
> +increment a counter can be directly inlined with the translation.
> +Currently only a simple increment is supported. This is not atomic so
> +the plugin must either keep it's counters separated and indexed by CPU
> +or use a callback which can ensure atomicity.
> +
> +Finally when QEMU exits all the registered atexit callbacks are called

Add period at end of sentence and preferably "s/called/invoked/"

> +
> +Internals
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Locking
> +-------
> +
> +We have to ensure we cannot deadlock, particularly under MTTCG. For
> +this we acquire a lock when called from plugin code. We also keep the
> +list of callbacks under RCU so that we do not have to hold the lock
> +when calling the callbacks. This is also for performance, since some
> +callbacks (e.g. memory access callbacks) might be called very
> +frequently.
> +
> +  * A consequence of this is that we keep our own list of CPUs, so that
> +    we do not have to worry about locking order wrt cpu_list_lock.
> +  * Use a recursive lock, since we can get registration calls from
> +    callbacks.
> +
> +As a result registering/unregistering callbacks is "slow", since it
> +takes a lock. But this is very infrequent; we want performance when
> +calling (or not calling) callbacks, not when registering them. Using
> +RCU is great for this.
> +
> +We support the uninstallation of a plugin at any time (e.g. from plugin
> +callbacks). This means some callbacks might still be called after the un=
install
> +function returns. The plugin isn't completely uninstalled until the
> +safe work has executed while all vCPUs are quiescent.

Isn't this when the atexit callback is invoked? Might add that to make
it clearer.

