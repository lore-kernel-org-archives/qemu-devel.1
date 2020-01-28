Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B171C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB81B20674
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XimOVjcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB81B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwX1Z-0000ax-6C
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwX0d-0008Lc-27
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwX0a-00012L-QB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:58:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwX0a-0000xO-F9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580241527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3rVANDsaJLgqnf1ewTXKAj9UD5/QH9ZelIpYSFIlYA=;
 b=XimOVjcfTEj3yUXQkd2VlHTkp3W/4mLn160ciSjjSgmdkeiONjiz9lStMUXFClJR9MM9xg
 Bjcs2CtYE4Oc2TDs9sqbVDvEYgboNnIFqxv5mpdVWcpI2CE4GMfP0/FpHFQPHc3YKzSI+u
 Uf+rjh1HF6yhj8zIlI55v7mLMJYW5Mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-AlTXG6vjOHGVveTIPU_b1Q-1; Tue, 28 Jan 2020 14:58:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53CC018B5F6A;
 Tue, 28 Jan 2020 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 125238EA09;
 Tue, 28 Jan 2020 19:58:33 +0000 (UTC)
Subject: Re: [PATCH v4 2/7] Acceptance tests: Extract _console_interaction()
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-3-f4bug@amsat.org>
 <b760f6f2-e3f1-45c6-eb23-79e630a3c700@redhat.com>
Message-ID: <5ebfe6ab-2414-1cf8-99dd-c121ae8845ba@redhat.com>
Date: Tue, 28 Jan 2020 17:58:31 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b760f6f2-e3f1-45c6-eb23-79e630a3c700@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: AlTXG6vjOHGVveTIPU_b1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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


On 1/28/20 5:34 PM, Wainer dos Santos Moschetta wrote:
>
> On 1/20/20 9:51 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since we are going to re-use the code shared between
>> wait_for_console_pattern() and exec_command_and_wait_for_pattern(),
>> extract the common part into a local function.
>>
>> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> =C2=A0 tests/acceptance/avocado_qemu/__init__.py | 31 +++++++++++++-----=
-----
>> =C2=A0 1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py=20
>> b/tests/acceptance/avocado_qemu/__init__.py
>> index 6618ea67c1..0a50fcf2be 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -55,19 +55,14 @@ def pick_default_qemu_bin(arch=3DNone):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return qemu_bin_f=
rom_src_dir_path
>> =C2=A0 =C2=A0 -def wait_for_console_pattern(test, success_message,=20
>> failure_message=3DNone):
>> -=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0 Waits for messages to appear on the console, while l=
ogging the=20
>> content
>> -
>> -=C2=A0=C2=A0=C2=A0 :param test: an Avocado test containing a VM that wi=
ll have its=20
>> console
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 read and probed for a success or failure messag=
e
>> -=C2=A0=C2=A0=C2=A0 :type test: :class:`avocado_qemu.Test`
>> -=C2=A0=C2=A0=C2=A0 :param success_message: if this message appears, tes=
t succeeds
>> -=C2=A0=C2=A0=C2=A0 :param failure_message: if this message appears, tes=
t fails
>> -=C2=A0=C2=A0=C2=A0 """
>> +def _console_interaction(test, success_message, failure_message,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 send_string):
>
>
> Why not just add send_string as a parameter? Like:
>
> def wait_for_console_pattern(test, success_message,=20
> failure_message=3DNone, send_msg=3DNone)
>
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console =3D test.vm.console_socket.makefi=
le()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_logger =3D logging.getLogger('con=
sole')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while True:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if send_string:
>> + test.vm.console_socket.sendall(send_string.encode())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send=
_string =3D None # send only once
>
> If it is going to send the message once, then put it before the loop.

OK, now that I read the next patch in this series (patch 03), I=20
understood what you trying to accomplish here. So disregard my comments.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg =3D console.r=
eadline().strip()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not msg:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 continue
>> @@ -79,6 +74,17 @@ def wait_for_console_pattern(test,=20
>> success_message, failure_message=3DNone):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fail =3D 'Failure message found in console: %s' %=20
>> failure_message
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 test.fail(fail)
>> =C2=A0 +def wait_for_console_pattern(test, success_message,=20
>> failure_message=3DNone):
>> +=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0 Waits for messages to appear on the console, while l=
ogging the=20
>> content
>> +
>> +=C2=A0=C2=A0=C2=A0 :param test: an Avocado test containing a VM that wi=
ll have its=20
>> console
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 read and probed for a success or failure messag=
e
>> +=C2=A0=C2=A0=C2=A0 :type test: :class:`avocado_qemu.Test`
>> +=C2=A0=C2=A0=C2=A0 :param success_message: if this message appears, tes=
t succeeds
>> +=C2=A0=C2=A0=C2=A0 :param failure_message: if this message appears, tes=
t fails
>> +=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0 _console_interaction(test, success_message, failure_=
message, None)
>> =C2=A0 =C2=A0 def exec_command_and_wait_for_pattern(test, command,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 success_message,=20
>> failure_message=3DNone):
>> @@ -94,10 +100,7 @@ def exec_command_and_wait_for_pattern(test, command,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param success_message: if this message a=
ppears, test succeeds
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param failure_message: if this message a=
ppears, test fails
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0 command +=3D '\r'
>> -=C2=A0=C2=A0=C2=A0 test.vm.console_socket.sendall(command.encode())
>> -=C2=A0=C2=A0=C2=A0 wait_for_console_pattern(test, success_message, fail=
ure_message)
>> -
>> +=C2=A0=C2=A0=C2=A0 _console_interaction(test, success_message, failure_=
message,=20
>> command + '\r')
>> =C2=A0 =C2=A0 class Test(avocado.Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def _get_unique_tag_val(self, tag_name):
>
>


