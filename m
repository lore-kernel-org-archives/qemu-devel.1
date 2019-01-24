Received: from eggs.gnu.org ([209.51.188.92]:33145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmkAq-0002NY-1S
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmkAo-0003L1-RT
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:56:23 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:45086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmkAo-0003KH-Ld
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:56:22 -0500
Received: by mail-ot1-x334.google.com with SMTP id 32so6169977ota.12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 10:56:22 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 18:56:09 +0000
Message-ID: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] building rst docs with sphinx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

I had another look this afternoon at building our rST docs
with sphinx-build. In particular, we currently have some
docs in rst format, but we're not building them into HTML
or shipping them. (Predictably, this means a few errors and
warnings have crept in...)

I had a play about with adding some makefile runes, but
I'm not sure entirely what I should be aiming for.

(1) configure: My thought is that we should just make
sphinx-build a requirement for the existing --enable-docs
switch (as texinfo and pod2man are currently). The
disadvantage is that we won't support a "build the half
of the docs you have the tools for and leave the others"
setup. The advantage, which I think is significant, is that
distros will naturally be directed to the missing build
dependency (either they're building with --enable-docs
and will get the configure message, or they aren't and
then their build will fail later because of missing docs
files when they try to put the built files into the package).

(2) What do we actually want to ship?
That is, what do we want 'make install-doc' to copy into
the installation directory?
https://wiki.qemu.org/Features/Documentation
has a good suggested breakdown of docs for where we
eventually want to be. I think we probably don't want
to install the "developer's guide" (docs/devel) on
end-user systems. The others are presumably OK.
Currently, we seem to only install manpages and a
few other things in the 'install-doc' makefile target
(we don't install a bunch of plain-text user-facing
docs) so this would be a significant expansion.

(3) Indexes, table-of-contents pages, etc
Are we aiming to ship these?
I think that we probably want to have what from
Sphinx's point of view are multiple separate documents,
so that they each get their own ToC and index. This
means we can for instance ship the ToC/index for
the user docs but not have it contain index entries
for developer docs.

Overall what I'm hoping for is to be able to get some
basic structure/building commands into master so we
have a framework and something we can iterate on to
move forward.

thanks
-- PMM
