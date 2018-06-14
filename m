Received: from eggs.gnu.org ([2001:4830:134:3::10]:51586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tamiko@kyomu.43-1.org>) id 1fTUQA-00067V-7W
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tamiko@kyomu.43-1.org>) id 1fTUQ5-0001mX-Mn
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:22 -0400
Received: from tsukuyomi.43-1.org ([188.40.248.50]:46757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tamiko@kyomu.43-1.org>)
	id 1fTUQ5-0001mH-Fq
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:17 -0400
From: Matthias Maier <tamiko@43-1.org>
Date: Thu, 14 Jun 2018 10:43:55 -0500
Message-Id: <20180614154357.20132-1-tamiko@43-1.org>
Subject: [Qemu-devel] [PATCH 0/2] Fix compilation with python-3 if
 en_US.UTF-8 is unavailable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi,

This patch series,
 - removes the PYTHON_UTF8 workaround introduced in d4e5ec877ca
 - adds a different workaround that avoids the locale problem altogether by
   opening files in binary read/write mode and setting encoding/decoding
   (in utf-8) explicitly

The problem with setting

  LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8

is that the en_US.UTF-8 locale might not be available. In this case setting
above locales results in build errors even though another UTF-8 locale was
originally set [1].

We propose a different approach to fix the locale dependent encode/decode
problem in common.py utilizing the binary read/write mode [2,3] and
decode/encode with explicit UTF-8 encoding arguments [4].

This approach is preferred over the fix in commit d4e5ec877ca because it is
(a) locale independent, and (b) does not depend on the en_US.UTF_8 locale
to be available.

Best,
Matthias and Arfrever


[1] https://bugs.gentoo.org/657766
[2] https://docs.python.org/3.6/library/stdtypes.html#bytes.decode
[3] https://docs.python.org/3.6/library/stdtypes.html#str.encode
[4] https://docs.python.org/3/howto/unicode.html
