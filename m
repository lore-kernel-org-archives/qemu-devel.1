Received: from eggs.gnu.org ([2001:4830:134:3::10]:58176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeijE-0004et-V8
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeijD-00007w-JC
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:42:12 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:40849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eeijD-00007T-EI
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:42:11 -0500
Received: by mail-ot0-x22c.google.com with SMTP id x4so6872106otg.7
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 06:42:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122183301.GA31237@localhost.localdomain>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
	<20171209010811.GJ3037@localhost.localdomain>
	<CAFEAcA9oG=+mJ+jSGTM_z54S09gjHoFowDkOvofdkhJd+g3=Cw@mail.gmail.com>
	<20180122183301.GA31237@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 14:41:50 +0000
Message-ID: <CAFEAcA8pGXMs3hMxSs-t7qGfeR__H-CQ1roRVe5NFMCP8R2vjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 22 January 2018 at 18:33, Eduardo Habkost <ehabkost@redhat.com> wrote:
> About QOM type names:
>
> On x86, all CPU models are resolved to "<model>-<suffix>", and
> i386 and x86_64 have different suffixes.  So the QOM type name is
> "max-x86_64-cpu" on qemu-system-x86_64, and "max-i386-cpu" on
> qemu-system-i386.

OK. Looking at the target/arm code we do a similar suffix
trick, but we seem to have cut-n-pasted the handling in
aarch64_cpu_register(), so it uses the TYPE_ARM_CPU as the
suffix, rather the TYPE_AARCH64_CPU.

Am I right in thinking that we can fix this (changing the
QOM type names for all the aarch64 CPUs) without breaking
migration? (I guess I can just test this easily enough.)

If we did that then we'd have, like x86, "max-arm-cpu" in
the qemu-system-arm binary, and "max-aarch64-cpu" in
the qemu-system-aarch64 binary.

Does x86 provide a way to say "give me the max-i386-cpu"
in the qemu-system-x86_64 binary ?

> About how it should behave:
>
> An important expectation about "max" is about the
> query-cpu-model-expansion return value.  Having a property set to
> true on the return value of "query-cpu-model-expansion model=max"
> means the corresponding feature is supported on the current host
> and can be enabled on the command-line.

On Arm when I try to use this I get:
{ "execute": "query-cpu-model-expansion", "arguments": { "type":
"static", "model": { "model": { "name": "max" } } } }
{
    "error": {
        "class": "CommandNotFound",
        "desc": "The command query-cpu-model-expansion has not been found"
    }
}

It looks like we only implement this QMP API for x86 and S390
(via #ifdeffery in monitor.c).

I'm not sure if we actually support command line setting/unsetting
of features for Arm CPUs -- is there a command line option to
get QEMU to print the features it thinks can be set this way?

>> (The code in this patchset makes '-cpu max' give the same
>> QOM type name for both qemu-system-arm and qemu-system-aarch64,
>> with different behaviour depending on the binary. If that means
>> we don't provide the same behaviour as x86 then I can change that,
>> but I'm not sure where the difference is exposed to the user?)
>
> This is not how the QOM names work on x86, but I don't think QOM
> type names choices have important user-visible side-effects
> today.  Choosing unique QOM type names is more important to make
> the code future-proof for when we merge QEMU binaries, than to
> make user-visible behavior consistent.

Good point -- assuming it doesn't break migration I can fix
the aarch64 types to use the right suffix string and then they'll
have different QOM type names.

thanks
-- PMM
