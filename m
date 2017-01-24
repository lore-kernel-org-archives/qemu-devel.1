Received: from eggs.gnu.org ([2001:4830:134:3::10]:48247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW1Ja-0001Qu-2N
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW1JZ-0004HJ-7G
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:39:14 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:32907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW1JZ-0004Gz-2q
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:39:13 -0500
Received: by mail-ua0-x233.google.com with SMTP id i68so133696833uad.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 05:39:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Wa6nuLVWc+7TzH+aQ_zg7BszWoYhAZq4Wg+2ZeY+99A@mail.gmail.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
	<CAFEAcA8Wa6nuLVWc+7TzH+aQ_zg7BszWoYhAZq4Wg+2ZeY+99A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 13:38:52 +0000
Message-ID: <CAFEAcA9r+8j==EEvZDQWUaTQk2FTOqMzafJL1dawuHYexfAYYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/13] x86, machine, numa queue (2017-01-23)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 24 January 2017 at 13:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> I get a failure in the docs on OSX:
>   GEN     qemu-doc.txt
>   CC      qapi/qapi-visit-core.o
> /Users/pm215/src/qemu-for-merges/qemu-doc.texi:7: warning:
> unrecognized encoding name `UTF-8'.
>   GEN     trace/generated-tracers.c
> /Users/pm215/src/qemu-for-merges/qemu-doc.texi:1419: Cross reference
> to nonexistent node `bt-hcis' (perhaps incorrect sectioning?).
> makeinfo: Removing output file `qemu-doc.txt' due to errors; use
> --force to preserve.
>
> This is the same error that was happening on the Travis OSX
> builds but not on my personal OSX machine, and leaves me
> suspicious that the qemu-doc.txt stuff is broken but also
> not always being rebuilt correctly (since it's a bit
> hit-and-miss whether particular things hit this.)

The cause of this problem I think is that we added a new
output file qemu-doc.txt, but we forgot to add it to this
dependency rule in Makefile:

qemu-doc.html qemu-doc.info qemu-doc.pdf: \
        qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
        qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
        qemu-monitor-info.texi

So if you do a make with -j8 then make may decide to parallelize
the building of the qemu-doc.txt with the creation of qemu-options.texi,
and then makeinfo can read a half-completed qemu-options.texi.

qemu-doc.txt also seems to have been not added to the rm -f
commands for the distclean target.

Side question: why do we have a rule to create the qemu-doc.pdf
but not actually install it with install-doc ?

thanks
-- PMM
