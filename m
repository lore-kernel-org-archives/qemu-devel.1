Received: from eggs.gnu.org ([2001:4830:134:3::10]:40723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cW3pN-00073T-Pg
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cW3pJ-0001oJ-9J
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:20:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cW3pJ-0001n3-30
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:20:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
	<CAFEAcA8Wa6nuLVWc+7TzH+aQ_zg7BszWoYhAZq4Wg+2ZeY+99A@mail.gmail.com>
	<CAFEAcA9r+8j==EEvZDQWUaTQk2FTOqMzafJL1dawuHYexfAYYQ@mail.gmail.com>
Date: Tue, 24 Jan 2017 17:20:05 +0100
In-Reply-To: <CAFEAcA9r+8j==EEvZDQWUaTQk2FTOqMzafJL1dawuHYexfAYYQ@mail.gmail.com>
	(Peter Maydell's message of "Tue, 24 Jan 2017 13:38:52 +0000")
Message-ID: <87lgu02zwq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/13] x86, machine, numa queue (2017-01-23)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 24 January 2017 at 13:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>> I get a failure in the docs on OSX:
>>   GEN     qemu-doc.txt
>>   CC      qapi/qapi-visit-core.o
>> /Users/pm215/src/qemu-for-merges/qemu-doc.texi:7: warning:
>> unrecognized encoding name `UTF-8'.
>>   GEN     trace/generated-tracers.c
>> /Users/pm215/src/qemu-for-merges/qemu-doc.texi:1419: Cross reference
>> to nonexistent node `bt-hcis' (perhaps incorrect sectioning?).
>> makeinfo: Removing output file `qemu-doc.txt' due to errors; use
>> --force to preserve.
>>
>> This is the same error that was happening on the Travis OSX
>> builds but not on my personal OSX machine, and leaves me
>> suspicious that the qemu-doc.txt stuff is broken but also
>> not always being rebuilt correctly (since it's a bit
>> hit-and-miss whether particular things hit this.)
>
> The cause of this problem I think is that we added a new
> output file qemu-doc.txt, but we forgot to add it to this
> dependency rule in Makefile:
>
> qemu-doc.html qemu-doc.info qemu-doc.pdf: \
>         qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
>         qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
>         qemu-monitor-info.texi
>
> So if you do a make with -j8 then make may decide to parallelize
> the building of the qemu-doc.txt with the creation of qemu-options.texi,
> and then makeinfo can read a half-completed qemu-options.texi.

Good catch!  Now, why didn't I see that myself?  %-}

> qemu-doc.txt also seems to have been not added to the rm -f
> commands for the distclean target.
>
> Side question: why do we have a rule to create the qemu-doc.pdf
> but not actually install it with install-doc ?

I don't know.  Has been that way since the pdf target was added in
commit 20cc999.
