Received: from eggs.gnu.org ([2001:4830:134:3::10]:48778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exsAZ-000389-EV
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exsAY-0000uk-I4
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:37:35 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:46046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exsAY-0000sg-C0
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:37:34 -0400
Received: by mail-ot0-x234.google.com with SMTP id q5-v6so6157725oth.12
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 03:37:34 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 10:37:12 +0000
Message-ID: <CAFEAcA9u3s=qZWN0Q1irqNu8cpHvBf2p4MsstaAaq-nbNLq1_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qapi escape-too-big test doesn't work if LANG=C ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

I recently tweaked my build scripts to run with LANG=C (trying
to suppress gcc's irritating habit of using smartquotes rather
than plain old ''). This seems to result in an error running
the qapi-schema/escape-too-big test:

PYTHONPATH=/home/petmay01/linaro/qemu-for-merges/scripts python3 -B
/home/petmay01/linaro/qemu-for-merges/tests/qapi-schema/test-qapi.py
/home/petmay01/linaro/qemu-for-merges/tests/qapi-schema/escape-too-big.json
>tests/qapi-schema/escape-too-big.test.out
2>tests/qapi-schema/escape-too-big.test.err; echo $?
>tests/qapi-schema/escape-too-big.test.exit
1c1,10
< tests/qapi-schema/escape-too-big.json:3:14: For now, \u escape only
supports non-zero values up to \u007f
---
> Traceback (most recent call last):
>   File "tests/qapi-schema/test-qapi.py", line 64, in <module>
>     schema = QAPISchema(sys.argv[1])
>   File "scripts/qapi/common.py", line 1492, in __init__
>     parser = QAPISchemaParser(open(fname, 'r'))
>   File "scripts/qapi/common.py", line 264, in __init__
>     self.src = fp.read()
>   File "/usr/lib/python3.5/encodings/ascii.py", line 26, in decode
>     return codecs.ascii_decode(input, self.errors)[0]
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 61: ordinal not in range(128)
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:927:
recipe for target 'check-tests/qapi-schema/escape-too-big.json' failed

thanks
-- PMM
