Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42139C4CED1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0960920865
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hl9zqnoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0960920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG3qN-0006mB-7J
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 12:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iG3or-0005kq-2p
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 12:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iG3oo-0003a4-Nk
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 12:19:08 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:43718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iG3ol-0003XS-0M
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 12:19:04 -0400
Received: by mail-oi1-x231.google.com with SMTP id t84so3112169oih.10
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g6tzVyOz1bXGvqsFVPdb1+uS9wO1zc6lCSuAxbwa6vk=;
 b=Hl9zqnoE6XzBNbBOpHBZMupZ9CXjiboxXUrVyDlfAYVSCStCD3t4gODHOPtLOXK9Nr
 iiKGmn2oRT234YLntpWDDCpgD3AE3Ok0bEKYqnIy732+sTX7MQuePQ9XoRi/jxRdLZK8
 oquiL6KPzgl8HTHC7O8km8bRV8m/cKKXUq0Xztph5prXPVooSOi3w7CyMD7EZVPKCea8
 AAJ9/P3Ki5VfNRfwgQHjmQULdXArHTxo5z3stgSfI0+0xwbHIsfzxwVY4dm5V+tyScMK
 +lu/nrvmzlHwfiGz/QwXPjNhMbdke/mCYqlUbEJgh/Kwjy1fBnWFqKAHZmwMMgsYUjfs
 cuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g6tzVyOz1bXGvqsFVPdb1+uS9wO1zc6lCSuAxbwa6vk=;
 b=pOyROdLv+Djuzv+zMnymAgeXRnci2i9Qypli28kiGtOPwVsquMDm6yuDdWy+0ZKYbO
 6L4Y2LjS1lEvQEmvY8X+uchmwVRqrcu50QFtu9/OFNAkEwFlvX5vtN8j8EKCDwDGkxDf
 L8hX1WNN8QjILu9LUPN9w8p4K3PTdyz6j1IHLyT8OrDI/YBaN1z8IwtQWQf5jQisJ/cN
 S/WM/A708BYaCMuorerZnF/0robi9ZA2FvLpTjWZN4FO8e8MBgRnyu0GYvGnDlG7e8q3
 GfKT4gJqGFZQEVy1KVyARliF6yVu/XZIBolWFCQrT3J+/x1Csb8gsvC/01mpbNaQEs7u
 JLZg==
X-Gm-Message-State: APjAAAVzFOvaIYYKMKdOSQ4oirWUZlM3Ez8gR6Oruu2sZE7lzebiYzyC
 P9Aj5ZXrsieL9QlzKS+odySd0JAyNhEi0TU0KhelCA==
X-Google-Smtp-Source: APXvYqzm0qcLW52KF7jfMODpzRWN5L/TDxR68R2YgjvWrj5eTOyO1UwHF/QmkVcDMDohaj7NJZ35OblWyMgsSgkFT10=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr3564787oif.98.1570119540912; 
 Thu, 03 Oct 2019 09:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191002161851.1016-1-kwolf@redhat.com>
In-Reply-To: <20191002161851.1016-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2019 17:18:49 +0100
Message-ID: <CAFEAcA9xQQ7cXdzFc1WL9x_aYj=dCcirDUifmb8aSs72Rqs+hQ@mail.gmail.com>
Subject: Re: [PULL v2 0/4] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2 Oct 2019 at 17:18, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 7f21573c822805a8e6be379d9bcf3ad9effef3dc:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-10-01' into staging (2019-10-01 13:13:38 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 352492e5541e293ea8117412ffd171ce1c7ac15d:
>
>   iotests: Remove Python 2 compatibility code (2019-10-02 16:47:23 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Fix internal snapshots with typical -blockdev setups
> - iotests: Require Python 3.6 or later
>
> ----------------------------------------------------------------
> Kevin Wolf (4):
>       block/snapshot: Restrict set of snapshot nodes
>       iotests: Test internal snapshots with -blockdev
>       iotests: Require Python 3.6 or later
>       iotests: Remove Python 2 compatibility code

Hi. This failed on iotest 267 on the ppc build machine I test on,
in the same way that the patchew report for centos7 failed:

--- /home/pm215/qemu/tests/qemu-iotests/267.out 2019-10-03
15:35:50.099974113 +0000
+++ /home/pm215/qemu/build/all/tests/qemu-iotests/267.out.bad
2019-10-03 15:41:46.190579461 +0000
@@ -3,180 +3,770 @@
 === No block devices at all ===

 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Testing:
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-Error: No block device can accept snapshots
-(qemu) info snapshots
-No available block device supports snapshots
-(qemu) loadvm snap0
-Error: No block device supports snapshots
-(qemu) quit
+Usage: sed [OPTION]... {script-only-if-no-other-script} [input-file]...

+  -n, --quiet, --silent
+                 suppress automatic printing of pattern space
+  -e script, --expression=script
+                 add the script to the commands to be executed
[etc]

The machine is running 'sed (GNU sed) 4.2.2'.

It looks like this version of sed doesn't like it if you
specify '-r' twice, as you have done in the _filter_vmstate_size()
function in common.filter in the "iotests: Test internal snapshots
with -blockdev" patch. I think '-r' is supposed to apply to all
scripts in the sed invocation; if that's correct then a command
line like '-re thing1 -re thing2' is confusing and would be better
written '-r -e thing1 -e thing2' even if this older sed didn't
complain about it.

thanks
-- PMM

