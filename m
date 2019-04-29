Received: from eggs.gnu.org ([209.51.188.92]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKysT-0005ac-5g
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKysS-0004E8-0L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:30:57 -0400
References: <155650963851.10667.10736189532511840020@c2072b67cc0c>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ec0fad50-140c-0bf4-3421-d4e3d2d12dea@redhat.com>
Date: Mon, 29 Apr 2019 07:30:42 +0200
MIME-Version: 1.0
In-Reply-To: <155650963851.10667.10736189532511840020@c2072b67cc0c>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/8] tests/qemu-iotests: Run basic
 iotests during "make check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, emaste@freebsd.org, qemu-block@nongnu.org, philmd@redhat.com, armbru@redhat.com, cfergeau@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, wainersm@redhat.com, lwhsu@freebsd.org

On 29/04/2019 05.47, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190428155451.15653-1-thuth@redhat.com/
> 
> This series failed the asan build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
> The full log is available at
> http://patchew.org/logs/20190428155451.15653-1-thuth@redhat.com/testing.asan/?type=message.

The asan test failed since it could not check out the repository ...
a networking problem?

Anyway, looks like there was a real bug here:

 https://patchew.org/logs/20190428155451.15653-1-thuth@redhat.com/testing.docker-clang@ubuntu/?type=message

Test 162 failed with:

162         - output mismatch (see 162.out.bad)
--- /tmp/qemu-test/src/tests/qemu-iotests/162.out	2019-04-28 16:09:31.000000000 +0000
+++ /tmp/qemu-test/build/tests/qemu-iotests/162.out.bad	2019-04-28 16:24:21.669646149 +0000
@@ -6,7 +6,9 @@
 image: nbd+unix://?socket=42
 
 === SSH ===
+qemu-img: warning: GLib: getpwuid_r(): failed due to unknown user id (1003)
 qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}': Failed to connect socket: Connection refused
+qemu-img: warning: GLib: getpwuid_r(): failed due to unknown user id (1003)
 qemu-img: Could not open 'driver=ssh,host=localhost,port=0,path=/foo': Failed to connect socket: Connection refused
 qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "port": 0.42, "path": "/foo"}': Parameter 'port' expects a number
 qemu-img: Could not open 'driver=ssh,host=localhost,port=0.42,path=/foo': Parameter 'port' expects a number

... I think I'll remove 162 from the "auto" group to avoid this.

 Thomas
