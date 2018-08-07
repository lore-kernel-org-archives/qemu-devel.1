Received: from eggs.gnu.org ([2001:4830:134:3::10]:49023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn39L-0007g3-OO
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn39K-0006o0-Og
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:39:51 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fn39K-0006nj-Gv
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:39:50 -0400
Received: by mail-oi0-x244.google.com with SMTP id b15-v6so28795799oib.10
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 07:39:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87in4m2qni.fsf@trasno.org>
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
	<CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
	<87in4m2qni.fsf@trasno.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Aug 2018 15:39:29 +0100
Message-ID: <CAFEAcA81Xr6_eUV5247JtZRnN9Ms7fau1iwhHkmW-gnwH9y8JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: Correctly handle subsections
 with no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 7 August 2018 at 15:32, Juan Quintela <quintela@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 7 August 2018 at 14:17, Juan Quintela <quintela@redhat.com> wrote:
>> Also, what prompted me to write this patch was that for 3.0
>> I had to fix several bugs where subsections had been written
>> with no needed function and the migration code was (a)
>> silently ignoring the subsection and (b) silently ignoring
>> any subsection following. If you want to make it a bug to
>
> b) is clearly a bug.
>
> a) ... I am not sure that this should be correct.

I can see these plausible API choices:
 (1) .needed for a subsection VMSD has the same behaviour as
     .needed for a top-level VMSD: if not present, means "always"
 (2) .needed is mandatory for a subsection VMSD, and failure
     to provide it is a bug which we diagnose as early as
     possible

If I understand you correctly you're suggesting
 (3) .needed is not mandatory and if not present means
     "never transfer the subsection"
which I think would be confusing.

I could live with (2) but I would end up writing a lot
of .needed functions like

static bool needed_always(void *opaque)
{
    return true;
}

which seems a bit unnecessary. (I have another patchset
in the works which will have one of these, assuming this
patch doesn't go into master first.)

thanks
-- PMM
