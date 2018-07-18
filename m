Received: from eggs.gnu.org ([2001:4830:134:3::10]:47838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmrK-00060W-EF
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmrE-00078C-4v
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:51:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <7a6766fc-9fac-79a5-d53c-b5209abccaae@amsat.org>
	<20180718072548.GB9812@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <79c7bfce-45b0-18cc-ac56-5c3f8a296762@amsat.org>
Date: Wed, 18 Jul 2018 10:51:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180718072548.GB9812@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] qemu-iotests: workaround to avoid Python3 while
 running tests on Fedora Docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Daniel,

On 07/18/2018 04:25 AM, Daniel P. Berrangé wrote:
> On Tue, Jul 17, 2018 at 08:37:58PM -0300, Philippe Mathieu-Daudé wrote:
>> I noticed this while running "make docker-test-block@fedora":
>>
>> $ make docker-test-block@fedora NETWORK=1
>>   BUILD   fedora
>>     RUN test-block in qemu:fedora
>> Configure options:
>> --enable-werror --prefix=/tmp/qemu-test/install
>> --python=/usr/bin/python3 --target-list=x86_64-softmmu
>> ...
>> python            /usr/bin/python3 -B
>> ...
>>
>> 194         - output mismatch (see 194.out.bad)
>> --- /tmp/qemu-test/src/tests/qemu-iotests/194.out       2018-07-17
>> 22:51:10.000000000 +0000
>> +++ /tmp/qemu-test/build/tests/qemu-iotests/194.out.bad 2018-07-17
>> 22:58:01.646916625 +0000
>> @@ -1,18 +1,18 @@
>>  Launching VMs...
>>  Launching NBD server on destination...
>> -{u'return': {}}
>> -{u'return': {}}
>> +{'return': {}}
>> +{'return': {}}
>>
>> and many more errors, until:
>>
>> Failures: 045 132 148 152 162 169 194 205 208 218 222
>> Failed 11 of 49 tests
>> Test failed: iotests raw
>>
>> All failures are due to Python2 syntax.
>> I started to fix but noticed there are too many and this isn't to
>> correct fix for this release.
> 
> Were they all due to the unicode string prefix, or where there
> difference failures too ?

3 more kinds:

148         [failed, exit status 1] - output mismatch (see 148.out.bad)
--- /tmp/qemu-test/src/tests/qemu-iotests/148.out	2018-07-18
13:20:17.000000000 +0000
+++ /tmp/qemu-test/build/tests/qemu-iotests/148.out.bad	2018-07-18
13:25:58.649302935 +0000
@@ -1,5 +1,8 @@
-..
-----------------------------------------------------------------------
-Ran 2 tests
-
-OK
+Traceback (most recent call last):
+  File "148", line 139, in <module>
+    iotests.verify_quorum()
+  File "/tmp/qemu-test/src/tests/qemu-iotests/iotests.py", line 657, in
verify_quorum
+    if not supports_quorum():
+  File "/tmp/qemu-test/src/tests/qemu-iotests/iotests.py", line 653, in
supports_quorum
+    return 'quorum' in qemu_img_pipe('--help')
+TypeError: a bytes-like object is required, not 'str'

169         [failed, exit status 1] - output mismatch (see 169.out.bad)
--- /tmp/qemu-test/src/tests/qemu-iotests/169.out	2018-07-18
13:20:17.000000000 +0000
+++ /tmp/qemu-test/build/tests/qemu-iotests/169.out.bad	2018-07-18
13:26:49.594192720 +0000
@@ -1,5 +1,4 @@
-................
-----------------------------------------------------------------------
-Ran 16 tests
-
-OK
+Traceback (most recent call last):
+  File "169", line 26, in <module>
+    import new
+ModuleNotFoundError: No module named 'new'

205         [failed, exit status 1] - output mismatch (see 205.out.bad)
--- /tmp/qemu-test/src/tests/qemu-iotests/205.out	2018-07-18
13:20:17.000000000 +0000
+++ /tmp/qemu-test/build/tests/qemu-iotests/205.out.bad	2018-07-18
13:27:46.775187975 +0000
@@ -1,5 +1,97 @@
-.......
+EEEFFFF
+======================================================================
+ERROR: test_connect_after_remove_default (__main__.TestNbdServerRemove)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "205", line 96, in test_connect_after_remove_default
+    self.do_test_connect_after_remove()
+  File "205", line 87, in do_test_connect_after_remove
+    self.assertReadOk(qemu_io(*args))
+  File "205", line 71, in assertReadOk
+    filter_qemu_io(qemu_io_output).strip(),
+  File "/tmp/qemu-test/src/tests/qemu-iotests/iotests.py", line 218, in
filter_qemu_io
+    msg = filter_win32(msg)
+  File "/tmp/qemu-test/src/tests/qemu-iotests/iotests.py", line 214, in
filter_win32
+    return win32_re.sub("", msg)
+TypeError: cannot use a string pattern on a bytes-like object
