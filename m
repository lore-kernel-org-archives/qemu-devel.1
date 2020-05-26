Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A83AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3075D20663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nj6z2Y64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3075D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdgWd-0000j9-C9
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 16:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdgVc-0000Do-PP
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:49:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdgVb-0003LV-Lu
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590526150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=toHMQowLWmFgxmuMa/9U/zeMxoA2Lrb2kzmojVe+Hsc=;
 b=Nj6z2Y64z5SkZ3i3qH3wpylKnMjioknH4jhJP8t/1ljcsr7t3ywKiJ/3Yy41uKZjPm/EcV
 BH5+hXraD2EItOBQVnYbflExZQdT0RhyK7Yr706mtxtL6i4evLmxF7SVqtZ3BMe85jjI+W
 rfmu+Wkueb3/8q/DZbtCl1C5hlWVIcE=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-P_ouPT8KPv-wpsNa7aBAPg-1; Tue, 26 May 2020 16:49:08 -0400
X-MC-Unique: P_ouPT8KPv-wpsNa7aBAPg-1
Received: by mail-ua1-f69.google.com with SMTP id j26so8346512uan.22
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 13:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=toHMQowLWmFgxmuMa/9U/zeMxoA2Lrb2kzmojVe+Hsc=;
 b=gQLo0+94RwC1LZ7F2djspawESP5WjKfRrjttMF5c0HXgroqe6mWWQy5UzimrdP7gLF
 ZI7KHudiy64Ien1fZ0R08mBDS2d9iyderjaYqcBKRtCm3+mktK07Nq2/RemuvHEER3tS
 +p3nLp7Lg61hksCEq73UmedAfKsJguFV7uNb1rBnNxAtAcyCLUlPlfCuKi4JDT5yFZ+h
 m/09nhyxpiISkgZbymL4vigNRRmV7QSp+kDC5LzUkgbrwuWrL2iUvLTNfgYrXnUEM/d2
 yYS3Wll/CS8tsvvlDkrURt+VUuRXYFhToQPNtO53XaQAOAXWbpe59CM7LlOeG2vOsJfx
 kONA==
X-Gm-Message-State: AOAM533+/H8oJX9jFZHAqd4VrvISwAtQjtWr2z4z1BVRznx+2cWZ8+jF
 0IJPyoYZ5dCrwDEp5zX2dTw8oD/wiXcw95p9HKMyF1Fy9VngyDxt7lAUOgBRWqAnh20hGYQFyN7
 ef3RXyaCWbSvHpaBlo57rYDXMDg6pK5o=
X-Received: by 2002:a67:87c7:: with SMTP id j190mr2392471vsd.125.1590526148335; 
 Tue, 26 May 2020 13:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgMJOhOKW+eHCJ+7ezp13hd9eEDpMblZ+JQEyNGjlMKVEXp3w/JnTasuE+TBJjH1lHEaji9HIQEUnpEFtsInw=
X-Received: by 2002:a67:87c7:: with SMTP id j190mr2392457vsd.125.1590526148156; 
 Tue, 26 May 2020 13:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <159040554265.2615.8993443700754452381.stgit@pasha-ThinkPad-X280>
 <159040554841.2615.9176706179382687894.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159040554841.2615.9176706179382687894.stgit@pasha-ThinkPad-X280>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 26 May 2020 17:48:57 -0300
Message-ID: <CAKJDGDY6N+SU3n2w3v8xnn5_245mviBWj3D1fgd0tW33h2a+hQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] tests/acceptance: allow console interaction with
 specific VMs
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, Cleber Rosa Junior <crosa@redhat.com>,
 pbonzini@redhat.com, Philippe Mathieu Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 8:20 AM Pavel Dovgalyuk
<Pavel.Dovgaluk@gmail.com> wrote:
>
> Console interaction in avocado scripts was possible only with single
> default VM.
> This patch modifies the function parameters to allow passing a specific
> VM as a parameter to interact with it.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  tests/acceptance/avocado_qemu/__init__.py |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 59e7b4f763..0bbaa8d2a6 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -69,13 +69,15 @@ def pick_default_qemu_bin(arch=None):
>
>
>  def _console_interaction(test, success_message, failure_message,
> -                         send_string, keep_sending=False):
> +                         send_string, keep_sending=False, vm=None):
>      assert not keep_sending or send_string
> -    console = test.vm.console_socket.makefile()
> +    if vm is None:
> +        vm = test.vm
> +    console = vm.console_socket.makefile()
>      console_logger = logging.getLogger('console')
>      while True:
>          if send_string:
> -            test.vm.console_socket.sendall(send_string.encode())
> +            vm.console_socket.sendall(send_string.encode())
>              if not keep_sending:
>                  send_string = None # send only once
>          msg = console.readline().strip()
> @@ -115,7 +117,7 @@ def interrupt_interactive_console_until_pattern(test, success_message,
>      _console_interaction(test, success_message, failure_message,
>                           interrupt_string, True)
>
> -def wait_for_console_pattern(test, success_message, failure_message=None):
> +def wait_for_console_pattern(test, success_message, failure_message=None, vm=None):
>      """
>      Waits for messages to appear on the console, while logging the content
>
> @@ -125,7 +127,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None):
>      :param success_message: if this message appears, test succeeds
>      :param failure_message: if this message appears, test fails
>      """
> -    _console_interaction(test, success_message, failure_message, None)
> +    _console_interaction(test, success_message, failure_message, None, vm=vm)
>
>  def exec_command_and_wait_for_pattern(test, command,
>                                        success_message, failure_message=None):
>
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


