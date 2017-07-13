Received: from eggs.gnu.org ([2001:4830:134:3::10]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVhym-0005tQ-Ht
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVhyl-000499-Nm
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:32:44 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVhyl-00047r-GO
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:32:43 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 62so30248813wmw.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 10:32:43 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 18:32:21 +0100
Message-ID: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] tests/Makefile.include non-portable use of $RANDOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Currently our test makefile does

   MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))}

This works on bash, but $RANDOM is bash-specific.
On dash, it doesn't do what we want, but it does do something:

$ echo $((RANDOM % 255 + 1))
1

On NetBSD the shell complains:
# echo $((RANDOM % 255 + 1))
-sh: arith: syntax error: "RANDOM % 255 + 1"

and so 'make check' doesn't work.

Any suggestions for something more portable?
https://unix.stackexchange.com/questions/140750/generate-random-numbers-in-specific-range
suggests
  awk 'BEGIN{srand(); print int(1+rand()*256)}'
and of course there are similar things possible with perl et al.

Or we could just have the makefile check whether we have bash,
and if not then set
  RANDOM=4

(thus putting NetBSD into the same boat as all our dash users).

Opinions?

thanks
-- PMM
