Received: from eggs.gnu.org ([2001:4830:134:3::10]:33600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjqCj-00014U-L7
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjqCi-0004lU-Mp
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:37:17 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjqCi-0004km-ED
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:37:16 -0500
Received: by mail-wr0-x234.google.com with SMTP id u48so77378356wrc.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:37:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8oG+uODONjXpeAWpNxcmWfoxEbK31LksrLUQp5kbupgA@mail.gmail.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
	<CAFEAcA8WXnBXQ-qNmzRw6yD_tuYLQepmSC0be50s8h=-1r-VQw@mail.gmail.com>
	<CAFEAcA8oG+uODONjXpeAWpNxcmWfoxEbK31LksrLUQp5kbupgA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 16:36:54 +0000
Message-ID: <CAFEAcA9sbqvqbe2T+W7HtTkdsnCWTHDf6EqtJ_2GGUjtKz64ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 March 2017 at 16:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> x86-64 Linux host:
>
> QTEST_QEMU_BINARY=cris-softmmu/qemu-system-cris
> QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM %
> 255 + 1))} gtester -k --verbose -m=quick  tests/qmp-test
> tests/device-introspect-test tests/qom-test
> TEST: tests/qmp-test... (pid=31974)
>   /cris/qmp/protocol:
> Broken pipe
> FAIL

Failure is intermittent. QEMU_LOG=1 output, failure case:

e104462:xenial:all$ QTEST_LOG=1
QTEST_QEMU_BINARY=cris-softmmu/qemu-system-cris
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM %
255 + 1))} gtester -k --verbose -m=quick  tests/qmp-test
TEST: tests/qmp-test... (pid=1841)
  /cris/qmp/protocol:
[I 1488558847.011696] OPENED
[R +0.000164] endianness
[S +0.000179] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 8, "major": 2},
"package": " (vfio-updates-20170223.0-593-gde6e31a-dirty)"},
"capabilities": []}}{"execute": "query-version"}

{"error": {"class": "CommandNotFound", "desc": "Expecting capabilities
negotiation with 'qmp_capabilities'"}}null

{"error": {"class": "GenericError", "desc": "QMP input must be a JSON
object"}}{}

{"error": {"class": "GenericError", "desc": "QMP input object lacks
key 'execute'"}}{"execute": true}

{"error": {"class": "GenericError", "desc": "QMP input object member
'execute' must be a string"}}{"execute": "no-such-cmd", "arguments":
[]}

{"error": {"class": "GenericError", "desc": "QMP input object member
'arguments' must be an object"}}{"extra": true, "execute":
"no-such-cmd"}

{"error": {"class": "GenericError", "desc": "QMP input object member
'extra' is unexpected"}}{"execute": "qmp_capabilities"}

Broken pipe
FAIL
GTester: last random seed: R02S7b62b97f8c425a4013400ffd29bcf904
(pid=1846)
FAIL: tests/qmp-test


Success case:
e104462:xenial:all$ QTEST_LOG=1
QTEST_QEMU_BINARY=cris-softmmu/qemu-system-cris
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM %
255 + 1))} gtester -k --verbose -m=quick  tests/qmp-test
TEST: tests/qmp-test... (pid=1836)
  /cris/qmp/protocol:
[I 1488558845.027917] OPENED
[R +0.000181] endianness
[S +0.000186] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 8, "major": 2},
"package": " (vfio-updates-20170223.0-593-gde6e31a-dirty)"},
"capabilities": []}}{"execute": "query-version"}

{"error": {"class": "CommandNotFound", "desc": "Expecting capabilities
negotiation with 'qmp_capabilities'"}}null

{"error": {"class": "GenericError", "desc": "QMP input must be a JSON
object"}}{}

{"error": {"class": "GenericError", "desc": "QMP input object lacks
key 'execute'"}}{"execute": true}

{"error": {"class": "GenericError", "desc": "QMP input object member
'execute' must be a string"}}{"execute": "no-such-cmd", "arguments":
[]}

{"error": {"class": "GenericError", "desc": "QMP input object member
'arguments' must be an object"}}{"extra": true, "execute":
"no-such-cmd"}

{"error": {"class": "GenericError", "desc": "QMP input object member
'extra' is unexpected"}}{"execute": "qmp_capabilities"}

{"return": {}}{"execute": "qmp_capabilities"}

{"error": {"class": "CommandNotFound", "desc": "Capabilities
negotiation is already complete, command ignored"}}{"execute":
"query-version"}

{"return": {"qemu": {"micro": 50, "minor": 8, "major": 2}, "package":
" (vfio-updates-20170223.0-593-gde6e31a-dirty)"}}null

{"error": {"class": "GenericError", "desc": "QMP input must be a JSON
object"}}{}

{"error": {"class": "GenericError", "desc": "QMP input object lacks
key 'execute'"}}{"execute": true}

{"error": {"class": "GenericError", "desc": "QMP input object member
'execute' must be a string"}}{"execute": "no-such-cmd", "arguments":
[]}

{"error": {"class": "GenericError", "desc": "QMP input object member
'arguments' must be an object"}}{"extra": true, "execute":
"no-such-cmd"}

{"error": {"class": "GenericError", "desc": "QMP input object member
'extra' is unexpected"}}{"execute": "query-name", "id": "cookie#1"}

{"return": {}, "id": "cookie#1"}{"execute": "human-monitor-command", "id": 2}

{"id": 2, "error": {"class": "GenericError", "desc": "Parameter
'command-line' is missing"}}[I +0.003521] CLOSED
OK
PASS: tests/qmp-test

thanks
-- PMM
