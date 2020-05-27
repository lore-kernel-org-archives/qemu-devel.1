Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1428FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DE6207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6LxvMIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DE6207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxH1-0003b6-3u
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdxGD-0002xM-W0
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:42:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22809
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdxGC-0008A8-Kd
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590590543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=os6yuV5bNNR7+IGFcr99NenSG+GPP3/YTAflaQAKvA0=;
 b=P6LxvMIQC51ud09WC0F9oQFvEg1dSLdICoAHjAEMF5fwPR6OXfltWrV5dF4B5QHhJ8Y8+0
 TtG42c3LBHXaDm2KYV9DggPzebzaSjA/TBLcR7TM6TUdfeSbrNXYfceLW61Glfcn7w7ytT
 xDIUHWv2JoVRJSF0y/8StKdDt/xqZzs=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294--43jZvbXPISFukQro0vIyw-1; Wed, 27 May 2020 10:42:21 -0400
X-MC-Unique: -43jZvbXPISFukQro0vIyw-1
Received: by mail-ua1-f70.google.com with SMTP id e23so7215674uan.18
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=os6yuV5bNNR7+IGFcr99NenSG+GPP3/YTAflaQAKvA0=;
 b=TOzPJrjepbqQ7mQNy0tHlEb25stiVkSLGqSoj+OA8k8h/Z14vKZbyNV5MMNNawm2rV
 lVhrSaFoVr2LVU35JLno6MpJDSNB06xDtI4ogPc0oMLL9vggXgeTcyaqNLaWHnBgWN2a
 XlRV5tsCAxZydmkLpkMb+j6IE377JVe2FErEXr63rpUNg5LF3zGlMhSsbXfZkncgeRWK
 AX8e9BfWuoTJ0npW7nE9kWP6HkHvn1D+A0rxruQnqujgkEEdL0jOUOKZSP9WS+Sp3zbb
 zwLzutLdK0thUBGZVfbC2HBMmyVPM8Vz4aolko0s7d/8ZjbG6fMAy0nz/VbmspSkt2Dv
 9yXg==
X-Gm-Message-State: AOAM533gWoUULotmPXF2mKq11kmp0GD82h3pZ9WZPeHE2FRRLsDZafD/
 pqaEvftL32Ow5U1iodbcWAv/L39zI0EIa3MfObOis32jEm562WkORWbc5ZCdu4derCicrd6bRUp
 fXoyzTPxtcDKLg0zsFp69dOt9CNW8+ME=
X-Received: by 2002:a67:d984:: with SMTP id u4mr5225855vsj.33.1590590541148;
 Wed, 27 May 2020 07:42:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtd8WW52YHj94Cy/N2JaHCsJ9ZNLFPd8jimocP37eXPqtEqwYwQy7NxbVQR6ccfPUTMCRwuPRYM6yZ7HmKwSQ=
X-Received: by 2002:a67:d984:: with SMTP id u4mr5225822vsj.33.1590590540785;
 Wed, 27 May 2020 07:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057544414.16818.6329438674514481731.stgit@pasha-ThinkPad-X280>
 <874ks1794a.fsf@linaro.org>
In-Reply-To: <874ks1794a.fsf@linaro.org>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Wed, 27 May 2020 11:42:09 -0300
Message-ID: <CAKJDGDZWVjvA3L6Vxsgkv=4bmFtH4Pupm9CCUu7=+DR664amfw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] tests/acceptance: allow console interaction with
 specific VMs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, Cleber Rosa Junior <crosa@redhat.com>,
 pbonzini@redhat.com, Philippe Mathieu Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 11:20 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
>
> Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:
>
> > Console interaction in avocado scripts was possible only with single
> > default VM.
> > This patch modifies the function parameters to allow passing a specific
> > VM as a parameter to interact with it.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > Reviewed-by: Willian Rampazzo <willianr@redhat.com>
> > ---
> >  0 files changed
> >
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> > index 59e7b4f763..77d1c1d9ff 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -69,13 +69,15 @@ def pick_default_qemu_bin(arch=3DNone):
> >
> >
> >  def _console_interaction(test, success_message, failure_message,
> > -                         send_string, keep_sending=3DFalse):
> > +                         send_string, keep_sending=3DFalse, vm=3DNone)=
:
>
> is it not possible to make vm=3Dtest.vm to avoid having...

This will cause a NameError as `test` is also a parameter here.

>
> >      assert not keep_sending or send_string
> > -    console =3D test.vm.console_socket.makefile()
> > +    if vm is None:
> > +        vm =3D test.vm
>
> to do this here?
>
> > +    console =3D vm.console_socket.makefile()
> >      console_logger =3D logging.getLogger('console')
> >      while True:
> >          if send_string:
> > -            test.vm.console_socket.sendall(send_string.encode())
> > +            vm.console_socket.sendall(send_string.encode())
> >              if not keep_sending:
> >                  send_string =3D None # send only once
> >          msg =3D console.readline().strip()
> > @@ -115,7 +117,8 @@ def interrupt_interactive_console_until_pattern(tes=
t, success_message,
> >      _console_interaction(test, success_message, failure_message,
> >                           interrupt_string, True)
> >
> > -def wait_for_console_pattern(test, success_message, failure_message=3D=
None):
> > +def wait_for_console_pattern(test, success_message, failure_message=3D=
None,
> > +                             vm=3DNone):
> >      """
> >      Waits for messages to appear on the console, while logging the con=
tent
> >
> > @@ -125,7 +128,7 @@ def wait_for_console_pattern(test, success_message,=
 failure_message=3DNone):
> >      :param success_message: if this message appears, test succeeds
> >      :param failure_message: if this message appears, test fails
> >      """
> > -    _console_interaction(test, success_message, failure_message, None)
> > +    _console_interaction(test, success_message, failure_message, None,=
 vm=3Dvm)
> >
> >  def exec_command_and_wait_for_pattern(test, command,
> >                                        success_message, failure_message=
=3DNone):
>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> Alex Benn=C3=A9e
>


