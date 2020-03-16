Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B1C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B41620663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJrcJ/z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B41620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDseT-0005ae-Gc
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDqdH-0005bi-I0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDqdB-0003y8-K1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:22:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDqdB-0003v3-Fy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584368533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwcMGbu7t7ONr8JUuRhyhEIBgdDZlOZDihLGevxfioA=;
 b=FJrcJ/z6Kb4yVqEc0gTChaspzXgh6biNXoucgnXkpRQD0vLUWLsJk8HxG3ms1NR0m8UTl1
 58iNcX+3e0dGhdZT+CIoUS3Es6EIfc/zeL6VQey5ySTveE+hLSOQX91eGbUugQZ+iE7Ip9
 TjVGtXESQfeZKx06ZN7V27Soy79Yf+g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-Xqy_etl8NoS-If4ADDqY3Q-1; Mon, 16 Mar 2020 10:22:11 -0400
X-MC-Unique: Xqy_etl8NoS-If4ADDqY3Q-1
Received: by mail-ed1-f72.google.com with SMTP id y23so15296839edt.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 07:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nj40mOwmbOU2SLSTB9dqVS5zqZslCHWqMXMoCmBytNw=;
 b=t4XZ846iV76rRGlp9CKyqkTWiulhcpVvUnXXAl4ILo6LUQh3Y/G6AJOfEGZDrmfmAP
 sZh8CGAwdTvet5QhLNelxEF7j1TleSzuKx2xxifINQAfiw054znqu1ybSYSgkGvfKVZD
 H59PvG3ZU3nExUMddlPrAJRU6IFiFQM6E1oQau/LSBRYScMVzFLzFKED3Rj7blFFVYOp
 vNND/TcnR+5oDo6/WWnpxIk7HWorXwqBgyMl9L9e8IPRPBKFeEurn8eAy3lpumhwlWOT
 Y7Eokz5jF1be26+DzXiPJoPXafGx3iYzn27hvcu4/Fu49F2vHT51JsAaXViopuIq/Z2o
 bTPg==
X-Gm-Message-State: ANhLgQ0R2iM6Ebylr+tR3rsgdwjBJI39OxkE5teY0Fkv2rdW+KlCJWyy
 4ak3GVxNURRhg2iWppa7T6ita4V59xC1VVs/QVtfXgwfBR3Xm15doLjxFvzj/v6DHIYNjmCyg3U
 1R9xRCIfvS/L2m/o=
X-Received: by 2002:a50:9998:: with SMTP id m24mr166457edb.98.1584368529727;
 Mon, 16 Mar 2020 07:22:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuLo5/tnrx87KFuAvaHdYiJYV1D1CmA385B+oQvTkoyufhRYJnmC1QR0KB7HOJz1ooUumjf8A==
X-Received: by 2002:a50:9998:: with SMTP id m24mr166437edb.98.1584368529458;
 Mon, 16 Mar 2020 07:22:09 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id 91sm3149996edq.78.2020.03.16.07.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 07:22:08 -0700 (PDT)
Subject: Re: [PATCH 1/4] tests/vm: write raw console log
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-2-kraxel@redhat.com> <87wo7kjsfp.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <80b6dd22-aae9-268f-21a9-7add0dd3fa51@redhat.com>
Date: Mon, 16 Mar 2020 15:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87wo7kjsfp.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 3:16 PM, Alex Benn=C3=A9e wrote:
>=20
> Gerd Hoffmann <kraxel@redhat.com> writes:
>=20
>> Run "tail -f /var/tmp/*/qemu*console.raw" in another terminal
>> to watch the install console.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> I suspect this is what's breaking "make check-acceptance" so I've
> dropped the series from testing/next for now.
>=20
>    2020-03-11 12:12:30,546 stacktrace       L0039 ERROR|
>    2020-03-11 12:12:30,546 stacktrace       L0042 ERROR| Reproduced trace=
back from: /home/alex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python=
3.6/site-packages/avocado/c\
>    ore/test.py:860
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| Traceback (most =
recent call last):
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/al=
ex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python3.6/site-packages/a=
vocado/core/test.py", line \
>    1456, in test
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     self.error(s=
elf.exception)
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/al=
ex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python3.6/site-packages/a=
vocado/core/test.py", line \
>    1064, in error
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     raise except=
ions.TestError(message)
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| avocado.core.exc=
eptions.TestError: Traceback (most recent call last):
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/usr/lib=
/python3.6/imp.py", line 235, in load_module
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     return load_=
source(name, filename, file)
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/usr/lib=
/python3.6/imp.py", line 172, in load_source
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     module =3D _=
load(spec)
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<frozen =
importlib._bootstrap>", line 684, in _load
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<frozen =
importlib._bootstrap>", line 665, in _load_unlocked
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<frozen =
importlib._bootstrap_external>", line 678, in exec_module
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<frozen =
importlib._bootstrap>", line 219, in _call_with_frames_removed
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/al=
ex.bennee/lsrc/qemu.git/builds/all/tests/acceptance/machine_mips_malta.py",=
 line 15, in <module>
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from avocado=
_qemu import Test
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/al=
ex.bennee/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init__.p=
y", line 22, in <module>
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from qemu.ma=
chine import QEMUMachine
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/al=
ex.bennee/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/../../../p=
ython/qemu/machine.py", lin\
>    e 27, in <module>
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from qemu.co=
nsole_socket import ConsoleSocket
>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| ModuleNotFoundEr=
ror: No module named 'qemu.console_socket'

Cc'ing Wainer/Cleber in case...

>    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|
>    2020-03-11 12:12:30,547 stacktrace       L0046 ERROR|
>    2020-03-11 12:12:30,548 test             L0865 DEBUG| Local variables:
>    2020-03-11 12:12:30,561 test             L0868 DEBUG|  -> self <class =
'avocado.core.test.TestError'>: 1-./tests/acceptance/machine_mips_malta.py:=
MaltaMachineFramebuffer.tes\
>    t_mips_malta_i6400_framebuffer_logo_1core
>=20
>=20
>> ---
>>   tests/vm/basevm.py | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
>> index 8400b0e07f65..c53fd354d955 100644
>> --- a/tests/vm/basevm.py
>> +++ b/tests/vm/basevm.py
>> @@ -213,6 +213,9 @@ class BaseVM(object):
>>       def console_init(self, timeout =3D 120):
>>           vm =3D self._guest
>>           vm.console_socket.settimeout(timeout)
>> +        self.console_raw_path =3D os.path.join(vm._temp_dir,
>> +                                             vm._name + "-console.raw")
>> +        self.console_raw_file =3D open(self.console_raw_path, 'wb')
>>  =20
>>       def console_log(self, text):
>>           for line in re.split("[\r\n]", text):
>> @@ -234,6 +237,9 @@ class BaseVM(object):
>>           while True:
>>               try:
>>                   chars =3D vm.console_socket.recv(1)
>> +                if self.console_raw_file:
>> +                    self.console_raw_file.write(chars)
>> +                    self.console_raw_file.flush()
>>               except socket.timeout:
>>                   sys.stderr.write("console: *** read timeout ***\n")
>>                   sys.stderr.write("console: waiting for: '%s'\n" % expe=
ct)
>=20
>=20


