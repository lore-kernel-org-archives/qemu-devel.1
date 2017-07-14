Received: from eggs.gnu.org ([2001:4830:134:3::10]:51803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dW1ad-0007JY-VO
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dW1aY-0000Ev-UA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:29:07 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dW1aY-0000EI-NP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:29:02 -0400
Received: by mail-wm0-f47.google.com with SMTP id t70so10181717wmt.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:29:01 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri, 14 Jul 2017 16:28:55 +0200
Message-Id: <cover.1500042528.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 0/3] qemu-ga: add guest-get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

v8:
- not tracking len in ga_parse_osrelease()
- replaced if(ret != TRUE) lines in ga_parse_osrelease()
- removed underscores from schema documentation
- renamed field 'machine-hardware' to 'machine' and clarified it's
  documentation for Windows
- fields kernel_version, kernel_release and machine are also optional
- added fixture_tear_down() in tests

v7:
- fixed incorrect error check in ga_get_win_version()
- added missing test-qga-os-release
- fixed coding style issues

v6:
- fixed the documentation comment in schema
- disguising os-release as key-value file (thanks Marc-André)
- dropped dependency on gio
- improved error handling
- added test

v5:
- fixed build failure with older glib
- fixed coding style issues
- fixed one log string

This is a continuation of the work started by Vinzenz Feenstra in the
threads:

https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg04154.html
https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg04302.html
https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg06262.html

The idea is to report some basic information from uname and from
os-release file, if it is present. On MS Windows, where neither uname
nor os-release exist we fill the values based on the information we can
get from the OS.

The example output on Fedora is:

{
  "return": {
    "kernel-version": "#1 SMP Mon May 8 18:46:06 UTC 2017",
    "kernel-release": "4.10.15-200.fc25.x86_64",
    "machine-hardware": "x86_64",
    "id": "fedora",
    "name": "Fedora",
    "pretty-name": "Fedora 25 (Server Edition)",
    "version": "25 (Server Edition)",
    "variant": "Server Edition",
    "version-id": "25",
    "variant-id": "server"
  }
}

The example output on MS Windows 10 is:

{
  "return": {
    "kernel-version": "10.0",
    "kernel-release": "10240",
    "machine-hardware": "x86_64",
    "id": "mswindows",
    "name": "Microsoft Windows",
    "pretty-name": "Windows 10 Enterprise",
    "version": "Microsoft Windows 10",
    "version-id": "10",
    "variant": "client",
    "variant-id": "client"
  }
}

    Tomas Golembiovsky

Tomáš Golembiovský (3):
  qemu-ga: add guest-get-osinfo command
  test-qga: pass environemnt to qemu-ga
  test-qga: add test for guest-get-osinfo

 qga/commands-posix.c           | 141 +++++++++++++++++++++++++++++++
 qga/commands-win32.c           | 188 +++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json           |  65 ++++++++++++++
 tests/data/test-qga-os-release |   7 ++
 tests/test-qga.c               |  64 +++++++++++++-
 5 files changed, 461 insertions(+), 4 deletions(-)
 create mode 100644 tests/data/test-qga-os-release

-- 
2.13.1
