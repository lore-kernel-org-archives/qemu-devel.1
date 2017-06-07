Received: from eggs.gnu.org ([2001:4830:134:3::10]:59582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dIZfB-0008PB-9i
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dIZf7-0002db-90
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:02:13 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dIZf7-0002dL-3R
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:02:09 -0400
Received: by mail-wr0-f180.google.com with SMTP id q97so5164453wrb.2
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 05:02:08 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Wed,  7 Jun 2017 14:02:05 +0200
Message-Id: <cover.1496836915.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 0/1] qemu-ga: add guest-get-osinfo command
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

One issue I see with the current implementation is that one is not able
to distinguish between various (non-linux) POSIX systems from the
returned values. That's because without os-release file (which I assume
is not common on non-linux platforms) only kernel-version,
kernel-release and machine-hardware are returned and telling what OS is
running there is a guessing game. Is this a problem?

Also the qapi documentiaton probably need some polishing. Unfortunately,
so far I was unable to get qapi parser satisfied and still include all
the important information.

    Tomas Golembiovsky

Tomáš Golembiovský (1):
  qemu-ga: add guest-get-osinfo command

 configure            |   2 +-
 qga/commands-posix.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  57 +++++++++++++++++
 4 files changed, 388 insertions(+), 1 deletion(-)

-- 
2.13.0
