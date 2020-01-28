Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FB2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECE4206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfO6m1+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECE4206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36723 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWnx-0003uj-MW
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwWd1-0000Vs-QL
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwWd0-0001ej-4o
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:34:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwWcz-0001e3-WF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580240065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApMCLCUecuLQYrSqhZdYr0V7EpBvuK4XPA+hsGVgjZE=;
 b=LfO6m1+Sgbp1Mf87Dnc9X9BJztbP38MPXVKJqNMJHEj0+TQNr6oUD6MZWyy1t2FaRfgVI4
 /TBGO4XY3WWeNvdP4K1yjKY1MjyhbdaI48S2Ssa+3slVu1e6XRQgYBC2pU0mLuOvLL7oin
 nxVJ9hJgRwt/hnOF2y/ahlaBPwNC8wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Sg8MMwr5MX-eCkP92xqtzg-1; Tue, 28 Jan 2020 14:34:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 662381800D41;
 Tue, 28 Jan 2020 19:34:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 383F95DA81;
 Tue, 28 Jan 2020 19:34:14 +0000 (UTC)
Subject: Re: [PATCH v4 2/7] Acceptance tests: Extract _console_interaction()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-3-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <b760f6f2-e3f1-45c6-eb23-79e630a3c700@redhat.com>
Date: Tue, 28 Jan 2020 17:34:12 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200120235159.18510-3-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Sg8MMwr5MX-eCkP92xqtzg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/20/20 9:51 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since we are going to re-use the code shared between
> wait_for_console_pattern() and exec_command_and_wait_for_pattern(),
> extract the common part into a local function.
>
> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 31 +++++++++++++----------
>   1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index 6618ea67c1..0a50fcf2be 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -55,19 +55,14 @@ def pick_default_qemu_bin(arch=3DNone):
>           return qemu_bin_from_src_dir_path
>  =20
>  =20
> -def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne):
> -    """
> -    Waits for messages to appear on the console, while logging the conte=
nt
> -
> -    :param test: an Avocado test containing a VM that will have its cons=
ole
> -                 read and probed for a success or failure message
> -    :type test: :class:`avocado_qemu.Test`
> -    :param success_message: if this message appears, test succeeds
> -    :param failure_message: if this message appears, test fails
> -    """
> +def _console_interaction(test, success_message, failure_message,
> +                         send_string):


Why not just add send_string as a parameter? Like:

def wait_for_console_pattern(test, success_message,=20
failure_message=3DNone, send_msg=3DNone)


>       console =3D test.vm.console_socket.makefile()
>       console_logger =3D logging.getLogger('console')
>       while True:
> +        if send_string:
> +            test.vm.console_socket.sendall(send_string.encode())
> +            send_string =3D None # send only once

If it is going to send the message once, then put it before the loop.

>           msg =3D console.readline().strip()
>           if not msg:
>               continue
> @@ -79,6 +74,17 @@ def wait_for_console_pattern(test, success_message, fa=
ilure_message=3DNone):
>               fail =3D 'Failure message found in console: %s' % failure_m=
essage
>               test.fail(fail)
>  =20
> +def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne):
> +    """
> +    Waits for messages to appear on the console, while logging the conte=
nt
> +
> +    :param test: an Avocado test containing a VM that will have its cons=
ole
> +                 read and probed for a success or failure message
> +    :type test: :class:`avocado_qemu.Test`
> +    :param success_message: if this message appears, test succeeds
> +    :param failure_message: if this message appears, test fails
> +    """
> +    _console_interaction(test, success_message, failure_message, None)
>  =20
>   def exec_command_and_wait_for_pattern(test, command,
>                                         success_message, failure_message=
=3DNone):
> @@ -94,10 +100,7 @@ def exec_command_and_wait_for_pattern(test, command,
>       :param success_message: if this message appears, test succeeds
>       :param failure_message: if this message appears, test fails
>       """
> -    command +=3D '\r'
> -    test.vm.console_socket.sendall(command.encode())
> -    wait_for_console_pattern(test, success_message, failure_message)
> -
> +    _console_interaction(test, success_message, failure_message, command=
 + '\r')
>  =20
>   class Test(avocado.Test):
>       def _get_unique_tag_val(self, tag_name):


